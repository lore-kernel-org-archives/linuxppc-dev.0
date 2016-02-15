Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCA881A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:26 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:56:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 713D92BB0064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1u6Yd39321630
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1tg6Q006483
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:55:42 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 1/7] powerpc: Make vmalloc_to_phys() public
Date: Mon, 15 Feb 2016 12:55:03 +1100
Message-Id: <1455501309-47200-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes vmalloc_to_phys() public as there will be another user
(KVM in-kernel VFIO acceleration) for it soon. As this new user
can be compiled as a module, this exports the symbol.

As a little optimization, this changes the helper to call
vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
struct page may not be power-of-two aligned which will make gcc use
multiply instructions instead of shifts.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---

Changes:
v2:
* extended commit log with a note about exporting
---
 arch/powerpc/include/asm/pgtable.h | 3 +++
 arch/powerpc/mm/pgtable.c          | 8 ++++++++
 arch/powerpc/perf/hv-24x7.c        | 8 --------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index ac9fb11..47897a3 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -78,6 +78,9 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 	}
 	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
 }
+
+unsigned long vmalloc_to_phys(void *vmalloc_addr);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 83dfd79..de37ff4 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -243,3 +243,11 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 }
 #endif /* CONFIG_DEBUG_VM */
 
+unsigned long vmalloc_to_phys(void *va)
+{
+	unsigned long pfn = vmalloc_to_pfn(va);
+
+	BUG_ON(!pfn);
+	return __pa(pfn_to_kaddr(pfn)) + offset_in_page(va);
+}
+EXPORT_SYMBOL_GPL(vmalloc_to_phys);
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9f9dfda..3b09ecf 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -493,14 +493,6 @@ static size_t event_to_attr_ct(struct hv_24x7_event_data *event)
 	}
 }
 
-static unsigned long vmalloc_to_phys(void *v)
-{
-	struct page *p = vmalloc_to_page(v);
-
-	BUG_ON(!p);
-	return page_to_phys(p) + offset_in_page(v);
-}
-
 /* */
 struct event_uniq {
 	struct rb_node node;
-- 
2.5.0.rc3
