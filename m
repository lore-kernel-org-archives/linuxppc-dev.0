Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w3Wy10nmkzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:04:57 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
Subject: [PATCH kernel] KVM: PPC: Align the table size to system page size
Date: Thu, 13 Apr 2017 17:04:20 +1000
Message-Id: <20170413070420.16927-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the userspace can request a table smaller than a page size
and this value will be stored as kvmppc_spapr_tce_table::size.
However the actual allocated size will still be aligned to the system
page size as alloc_page() is used there.

This aligns the table size up to the system page size. It should not
change the existing behaviour but when in-kernel TCE acceleration patchset
reaches the upstream kernel, this will allow small TCE tables be
accelerated as well: PCI IODA iommu_table allocator already aligns
the size and, without this patch, an IOMMU group won't attach to LIOBN
due to the mismatching table size.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

For sake of bisectability (otherwise in-kernel acceleration won't work
hugepages braking DMA completely), this is better be put before
[PATCH kernel v11 00/10] powerpc/kvm/vfio: Enable in-kernel acceleration

---
 arch/powerpc/kvm/book3s_64_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index aea3a5b74fb6..45941af9c6d7 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -333,7 +333,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			return -EBUSY;
 	}
 
-	size = args->size;
+	size = _ALIGN_UP(args->size, PAGE_SIZE >> 3);
 	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
 	if (ret) {
-- 
2.11.0
