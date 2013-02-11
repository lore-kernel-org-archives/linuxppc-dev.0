Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-x22c.google.com (mail-ia0-x22c.google.com
 [IPv6:2607:f8b0:4001:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FEB02C02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 23:13:35 +1100 (EST)
Received: by mail-ia0-f172.google.com with SMTP id u8so6390997iag.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 04:13:32 -0800 (PST)
From: aik@ozlabs.ru
To: 
Subject: [PATCH 3/4] powerpc: preparing to support real mode optimization
Date: Mon, 11 Feb 2013 23:12:42 +1100
Message-Id: <5118e069.22ca320a.1f08.ffffe2f0@mx.google.com>
In-Reply-To: <1360584763-21988-1-git-send-email-a>
References: <1360584763-21988-1-git-send-email-a>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

he current VFIO-on-POWER implementation supports only user mode
driven mapping, i.e. QEMU is sending requests to map/unmap pages.
However this approach is really slow in really fast hardware so
it is better to be moved to the real mode.

The patch adds an API to increment/decrement page counter as
get_user_pages API used for user mode mapping does not work
in the real mode.

CONFIG_SPARSEMEM_VMEMMAP and CONFIG_FLATMEN are supported.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    3 ++
 arch/powerpc/mm/init_64.c                |   56 +++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index ddcc898..b7a1fb2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -377,6 +377,9 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 }
 #endif /* !CONFIG_HUGETLB_PAGE */
 
+struct page *vmemmap_pfn_to_page(unsigned long pfn);
+long vmemmap_get_page(struct page *page);
+long vmemmap_put_page(struct page *page);
 pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
 		int writing, unsigned long *pte_sizep);
 
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 95a4529..068e9e9 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -297,5 +297,59 @@ int __meminit vmemmap_populate(struct page *start_page,
 
 	return 0;
 }
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+struct page *vmemmap_pfn_to_page(unsigned long pfn)
+{
+	struct vmemmap_backing *vmem_back;
+	struct page *page;
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+	unsigned long pg_va = (unsigned long) pfn_to_page(pfn);
+
+	for (vmem_back = vmemmap_list; vmem_back; vmem_back = vmem_back->list) {
+		if (pg_va < vmem_back->virt_addr)
+			continue;
+
+		/* Check that page struct is not split between real pages */
+		if ((pg_va + sizeof(struct page)) >
+				(vmem_back->virt_addr + page_size))
+			return NULL;
+
+		page = (struct page *) (vmem_back->phys + pg_va -
+				vmem_back->virt_addr);
+		return page;
+	}
+
+	return NULL;
+}
+
+#elif defined(CONFIG_FLATMEM)
+
+struct page *vmemmap_pfn_to_page(unsigned long pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	return page;
+}
+
+#endif /* CONFIG_SPARSEMEM_VMEMMAP/CONFIG_FLATMEM */
+
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_FLATMEM)
+long vmemmap_get_page(struct page *page)
+{
+	if (PageTail(page))
+		return -EAGAIN;
+
+	get_page(page);
+
+	return 0;
+}
+
+long vmemmap_put_page(struct page *page)
+{
+	if (PageCompound(page))
+		return -EAGAIN;
+
+	put_page(page);
+
+	return 0;
+}
+#endif
-- 
1.7.10.4
