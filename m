Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E2C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:35:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654FB20673
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654FB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4359nr2yPjzDqpf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:35:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4359F14YwRzDr1c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 19:10:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4359Dx5g6Rz9vGpD;
 Thu, 29 Nov 2018 09:10:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7NM9Bn2yOBBJ; Thu, 29 Nov 2018 09:10:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4359Dx54xNz9vGnx;
 Thu, 29 Nov 2018 09:10:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 867408B892;
 Thu, 29 Nov 2018 09:10:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mN5LjFaJKAZz; Thu, 29 Nov 2018 09:10:26 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 45C4F8B762;
 Thu, 29 Nov 2018 09:10:26 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 02D2C69AEA; Thu, 29 Nov 2018 08:10:25 +0000 (UTC)
Message-Id: <98a51b7ae6e2edf2077195a3ad695566d5b0c5ce.1543478200.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543478199.git.christophe.leroy@c-s.fr>
References: <cover.1543478199.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 11/20] powerpc/mm: fix a warning when a cache is common to
 PGD and hugepages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 08:10:25 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While implementing TLB miss HW assistance on the 8xx, the following
warning was encountered:

[  423.732965] WARNING: CPU: 0 PID: 345 at mm/slub.c:2412 ___slab_alloc.constprop.30+0x26c/0x46c
[  423.733033] CPU: 0 PID: 345 Comm: mmap Not tainted 4.18.0-rc8-00664-g2dfff9121c55 #671
[  423.733075] NIP:  c0108f90 LR: c0109ad0 CTR: 00000004
[  423.733121] REGS: c455bba0 TRAP: 0700   Not tainted  (4.18.0-rc8-00664-g2dfff9121c55)
[  423.733147] MSR:  00021032 <ME,IR,DR,RI>  CR: 24224848  XER: 20000000
[  423.733319]
[  423.733319] GPR00: c0109ad0 c455bc50 c4521910 c60053c0 007080c0 c0011b34 c7fa41e0 c455be30
[  423.733319] GPR08: 00000001 c00103a0 c7fa41e0 c49afcc4 24282842 10018840 c079b37c 00000040
[  423.733319] GPR16: 73f00000 00210d00 00000000 00000001 c455a000 00000100 00000200 c455a000
[  423.733319] GPR24: c60053c0 c0011b34 007080c0 c455a000 c455a000 c7fa41e0 00000000 00009032
[  423.734190] NIP [c0108f90] ___slab_alloc.constprop.30+0x26c/0x46c
[  423.734257] LR [c0109ad0] kmem_cache_alloc+0x210/0x23c
[  423.734283] Call Trace:
[  423.734326] [c455bc50] [00000100] 0x100 (unreliable)
[  423.734430] [c455bcc0] [c0109ad0] kmem_cache_alloc+0x210/0x23c
[  423.734543] [c455bcf0] [c0011b34] huge_pte_alloc+0xc0/0x1dc
[  423.734633] [c455bd20] [c01044dc] hugetlb_fault+0x408/0x48c
[  423.734720] [c455bdb0] [c0104b20] follow_hugetlb_page+0x14c/0x44c
[  423.734826] [c455be10] [c00e8e54] __get_user_pages+0x1c4/0x3dc
[  423.734919] [c455be80] [c00e9924] __mm_populate+0xac/0x140
[  423.735020] [c455bec0] [c00db14c] vm_mmap_pgoff+0xb4/0xb8
[  423.735127] [c455bf00] [c00f27c0] ksys_mmap_pgoff+0xcc/0x1fc
[  423.735222] [c455bf40] [c000e0f8] ret_from_syscall+0x0/0x38
[  423.735271] Instruction dump:
[  423.735321] 7cbf482e 38fd0008 7fa6eb78 7fc4f378 4bfff5dd 7fe3fb78 4bfffe24 81370010
[  423.735536] 71280004 41a2ff88 4840c571 4bffff80 <0fe00000> 4bfffeb8 81340010 712a0004
[  423.735757] ---[ end trace e9b222919a470790 ]---

This warning occurs when calling kmem_cache_zalloc() on a
cache having a constructor.

In this case it happens because PGD cache and 512k hugepte cache are
the same size (4k). While a cache with constructor is created for
the PGD, hugepages create cache without constructor and uses
kmem_cache_zalloc(). As both expect a cache with the same size,
the hugepages reuse the cache created for PGD, hence the conflict.

In order to avoid this conflict, this patch:
- modifies pgtable_cache_add() so that a zeroising constructor is
added for any cache size.
- replaces calls to kmem_cache_zalloc() by kmem_cache_alloc()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
see original discussion in https://patchwork.ozlabs.org/patch/957565/

 arch/powerpc/include/asm/pgtable.h |  2 +-
 arch/powerpc/mm/hugetlbpage.c      |  6 ++---
 arch/powerpc/mm/init-common.c      | 46 ++++++++++++++++++++++++++------------
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 734df2210749..74810bba45d2 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -101,7 +101,7 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 /* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+void pgtable_cache_add(unsigned int shift);
 void pgtable_cache_init(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index c4f1263228b8..bc97874d7c74 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -70,7 +70,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		num_hugepd = 1;
 	}
 
-	new = kmem_cache_zalloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
+	new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
 
 	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
 	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
@@ -701,10 +701,10 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift)
-			pgtable_cache_add(pdshift - shift, NULL);
+			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else
-			pgtable_cache_add(PTE_T_ORDER, NULL);
+			pgtable_cache_add(PTE_T_ORDER);
 #endif
 	}
 
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 41190f2b60c2..b7ca03643d0b 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,19 +25,37 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-static void pgd_ctor(void *addr)
-{
-	memset(addr, 0, PGD_TABLE_SIZE);
+#define CTOR(shift) static void ctor_##shift(void *addr) \
+{							\
+	memset(addr, 0, sizeof(void *) << (shift));	\
 }
 
-static void pud_ctor(void *addr)
-{
-	memset(addr, 0, PUD_TABLE_SIZE);
-}
+CTOR(0); CTOR(1); CTOR(2); CTOR(3); CTOR(4); CTOR(5); CTOR(6); CTOR(7);
+CTOR(8); CTOR(9); CTOR(10); CTOR(11); CTOR(12); CTOR(13); CTOR(14); CTOR(15);
 
-static void pmd_ctor(void *addr)
+static inline void (*ctor(int shift))(void *)
 {
-	memset(addr, 0, PMD_TABLE_SIZE);
+	BUILD_BUG_ON(MAX_PGTABLE_INDEX_SIZE != 15);
+
+	switch (shift) {
+	case 0: return ctor_0;
+	case 1: return ctor_1;
+	case 2: return ctor_2;
+	case 3: return ctor_3;
+	case 4: return ctor_4;
+	case 5: return ctor_5;
+	case 6: return ctor_6;
+	case 7: return ctor_7;
+	case 8: return ctor_8;
+	case 9: return ctor_9;
+	case 10: return ctor_10;
+	case 11: return ctor_11;
+	case 12: return ctor_12;
+	case 13: return ctor_13;
+	case 14: return ctor_14;
+	case 15: return ctor_15;
+	}
+	return NULL;
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE + 1];
@@ -50,7 +68,7 @@ EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void pgtable_cache_add(unsigned int shift)
 {
 	char *name;
 	unsigned long table_size = sizeof(void *) << shift;
@@ -78,7 +96,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
@@ -91,15 +109,15 @@ EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
+	pgtable_cache_add(PGD_INDEX_SIZE);
 
 	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
+		pgtable_cache_add(PMD_CACHE_INDEX);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
 	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
-		pgtable_cache_add(PUD_CACHE_INDEX, pud_ctor);
+		pgtable_cache_add(PUD_CACHE_INDEX);
 }
-- 
2.13.3

