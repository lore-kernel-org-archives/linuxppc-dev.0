Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0083.outbound.protection.outlook.com [104.47.32.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGWB91gVczDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:48 +1000 (AEST)
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC Part1 PATCH v3 12/17] x86/mm: DMA support for SEV memory
 encryption
Date: Mon, 24 Jul 2017 14:07:52 -0500
Message-Id: <20170724190757.11278-13-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-1-brijesh.singh@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Lendacky <thomas.lendacky@amd.com>

DMA access to memory mapped as encrypted while SEV is active can not be
encrypted during device write or decrypted during device read. In order
for DMA to properly work when SEV is active, the SWIOTLB bounce buffers
must be used.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/mm/mem_encrypt.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/swiotlb.c             |  5 +--
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1e4643e..5e5d460 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -191,8 +191,86 @@ void __init sme_early_init(void)
 	/* Update the protection map with memory encryption mask */
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
+
+	if (sev_active())
+		swiotlb_force = SWIOTLB_FORCE;
+}
+
+static void *sme_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		       gfp_t gfp, unsigned long attrs)
+{
+	unsigned long dma_mask;
+	unsigned int order;
+	struct page *page;
+	void *vaddr = NULL;
+
+	dma_mask = dma_alloc_coherent_mask(dev, gfp);
+	order = get_order(size);
+
+	/*
+	 * Memory will be memset to zero after marking decrypted, so don't
+	 * bother clearing it before.
+	 */
+	gfp &= ~__GFP_ZERO;
+
+	page = alloc_pages_node(dev_to_node(dev), gfp, order);
+	if (page) {
+		dma_addr_t addr;
+
+		/*
+		 * Since we will be clearing the encryption bit, check the
+		 * mask with it already cleared.
+		 */
+		addr = __sme_clr(phys_to_dma(dev, page_to_phys(page)));
+		if ((addr + size) > dma_mask) {
+			__free_pages(page, get_order(size));
+		} else {
+			vaddr = page_address(page);
+			*dma_handle = addr;
+		}
+	}
+
+	if (!vaddr)
+		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+
+	if (!vaddr)
+		return NULL;
+
+	/* Clear the SME encryption bit for DMA use if not swiotlb area */
+	if (!is_swiotlb_buffer(dma_to_phys(dev, *dma_handle))) {
+		set_memory_decrypted((unsigned long)vaddr, 1 << order);
+		memset(vaddr, 0, PAGE_SIZE << order);
+		*dma_handle = __sme_clr(*dma_handle);
+	}
+
+	return vaddr;
+}
+
+static void sme_free(struct device *dev, size_t size, void *vaddr,
+		     dma_addr_t dma_handle, unsigned long attrs)
+{
+	/* Set the SME encryption bit for re-use if not swiotlb area */
+	if (!is_swiotlb_buffer(dma_to_phys(dev, dma_handle)))
+		set_memory_encrypted((unsigned long)vaddr,
+				     1 << get_order(size));
+
+	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
 
+static const struct dma_map_ops sme_dma_ops = {
+	.alloc                  = sme_alloc,
+	.free                   = sme_free,
+	.map_page               = swiotlb_map_page,
+	.unmap_page             = swiotlb_unmap_page,
+	.map_sg                 = swiotlb_map_sg_attrs,
+	.unmap_sg               = swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu    = swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu        = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device     = swiotlb_sync_sg_for_device,
+	.mapping_error          = swiotlb_dma_mapping_error,
+};
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void)
 {
@@ -202,6 +280,14 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
+	/*
+	 * With SEV, DMA operations cannot use encryption. New DMA ops
+	 * are required in order to mark the DMA areas as decrypted or
+	 * to use bounce buffers.
+	 */
+	if (sev_active())
+		dma_ops = &sme_dma_ops;
+
 	pr_info("AMD Secure Memory Encryption (SME) active\n");
 }
 
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 8c6c83e..85fed2f 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -507,8 +507,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	if (no_iotlb_memory)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (sme_active())
-		pr_warn_once("SME is active and system is using DMA bounce buffers\n");
+	if (sme_active() || sev_active())
+		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
+			     sme_active() ? "SME" : "SEV");
 
 	mask = dma_get_seg_boundary(hwdev);
 
-- 
2.9.4
