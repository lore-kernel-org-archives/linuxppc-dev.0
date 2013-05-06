Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com
 [IPv6:2607:f8b0:4002:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F34FD2C0576
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:27 +1000 (EST)
Received: by mail-yh0-f51.google.com with SMTP id l109so672952yhq.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:25 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc: Prepare to support kernel handling of IOMMU
 map/unmap
Date: Mon,  6 May 2013 17:25:54 +1000
Message-Id: <1367825157-27231-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current VFIO-on-POWER implementation supports only user mode
driven mapping, i.e. QEMU is sending requests to map/unmap pages.
However this approach is really slow, so we want to move that to KVM.
Since H_PUT_TCE can be extremely performance sensitive (especially with
network adapters where each packet needs to be mapped/unmapped) we chose
to implement that as a "fast" hypercall directly in "real
mode" (processor still in the guest context but MMU off).

To be able to do that, we need to provide some facilities to
access the struct page count within that real mode environment as things
like the sparsemem vmemmap mappings aren't accessible.

This adds an API to increment/decrement page counter as
get_user_pages API used for user mode mapping does not work
in the real mode.

CONFIG_SPARSEMEM_VMEMMAP and CONFIG_FLATMEM are supported.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    4 ++
 arch/powerpc/mm/init_64.c                |   77 +++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 0182c20..4c56ede 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -377,6 +377,10 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 }
 #endif /* !CONFIG_HUGETLB_PAGE */
 
+struct page *realmode_pfn_to_page(unsigned long pfn);
+int realmode_get_page(struct page *page);
+int realmode_put_page(struct page *page);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 95a4529..838b8ae 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -297,5 +297,80 @@ int __meminit vmemmap_populate(struct page *start_page,
 
 	return 0;
 }
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+/*
+ * We do not have access to the sparsemem vmemmap, so we fallback to
+ * walking the list of sparsemem blocks which we already maintain for
+ * the sake of crashdump. In the long run, we might want to maintain
+ * a tree if performance of that linear walk becomes a problem.
+ *
+ * Any of realmode_XXXX functions can fail due to:
+ * 1) As real sparsemem blocks do not lay in RAM continously (they
+ * are in virtual address space which is not available in the real mode),
+ * the requested page struct can be split between blocks so get_page/put_page
+ * may fail.
+ * 2) When huge pages are used, the get_page/put_page API will fail
+ * in real mode as the linked addresses in the page struct are virtual
+ * too.
+ * When 1) or 2) takes place, the API returns an error code to cause
+ * an exit to kernel virtual mode where the operation will be completed.
+ */
+struct page *realmode_pfn_to_page(unsigned long pfn)
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
+EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
+
+#elif defined(CONFIG_FLATMEM)
+
+struct page *realmode_pfn_to_page(unsigned long pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	return page;
+}
+EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
+
+#endif /* CONFIG_SPARSEMEM_VMEMMAP/CONFIG_FLATMEM */
+
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_FLATMEM)
+int realmode_get_page(struct page *page)
+{
+	if (PageTail(page))
+		return -EAGAIN;
+
+	get_page(page);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(realmode_get_page);
+
+int realmode_put_page(struct page *page)
+{
+	if (PageCompound(page))
+		return -EAGAIN;
+
+	put_page(page);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(realmode_put_page);
+#endif
-- 
1.7.10.4
