Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD87C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:05:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD63E2082F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD63E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435RmM5hRBzDrHj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 06:05:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435Rfn6fB6zDrFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 06:00:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435Rfk6ckGz9vGy1;
 Thu, 29 Nov 2018 20:00:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4fXUZT6_JJ3R; Thu, 29 Nov 2018 20:00:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435Rfk62frz9vGpM;
 Thu, 29 Nov 2018 20:00:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0144C8B8C8;
 Thu, 29 Nov 2018 20:00:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Ne59rJb5mpow; Thu, 29 Nov 2018 20:00:13 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7053A8B8EB;
 Thu, 29 Nov 2018 20:00:12 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4517A69B59; Thu, 29 Nov 2018 19:00:12 +0000 (UTC)
Message-Id: <bd1fea9fee5fb5c4050fd5f8940c0104bcd8aa16.1543517818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543517818.git.christophe.leroy@c-s.fr>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 01/13] powerpc/mm: add exec protection on powerpc 603
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 29 Nov 2018 19:00:12 +0000 (UTC)
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

The 603 doesn't have a HASH table, TLB misses are handled by
software. It is then possible to generate page fault when
_PAGE_EXEC is not set like in nohash/32.

There is one "reserved" PTE bit available, this patch uses
it for _PAGE_EXEC.

In order to support it, set_pte_filter() and
set_access_flags_filter() are made common, and the handling
is made dependent on MMU_FTR_HPTE_TABLE

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/hash.h      |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h   | 18 +++++++++---------
 arch/powerpc/include/asm/cputable.h            |  8 ++++----
 arch/powerpc/kernel/head_32.S                  |  2 +-
 arch/powerpc/mm/dump_linuxpagetables-generic.c |  2 --
 arch/powerpc/mm/pgtable.c                      | 20 +++++++++++---------
 6 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
index f2892c7ab73e..2a0a467d2985 100644
--- a/arch/powerpc/include/asm/book3s/32/hash.h
+++ b/arch/powerpc/include/asm/book3s/32/hash.h
@@ -26,6 +26,7 @@
 #define _PAGE_WRITETHRU	0x040	/* W: cache write-through */
 #define _PAGE_DIRTY	0x080	/* C: page changed */
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
+#define _PAGE_EXEC	0x200	/* software: exec allowed */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
 #define _PAGE_SPECIAL	0x800	/* software: Special page */
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c21d33704633..cf844fed4527 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -10,9 +10,9 @@
 /* And here we include common definitions */
 
 #define _PAGE_KERNEL_RO		0
-#define _PAGE_KERNEL_ROX	0
+#define _PAGE_KERNEL_ROX	(_PAGE_EXEC)
 #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
-#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
 
 #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
 
@@ -66,11 +66,11 @@ static inline bool pte_user(pte_t pte)
  */
 #define PAGE_NONE	__pgprot(_PAGE_BASE)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
 #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
@@ -318,7 +318,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   int psize)
 {
 	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
 	pte_update(ptep, 0, set);
 
@@ -384,7 +384,7 @@ static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY);
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
-static inline bool pte_exec(pte_t pte)		{ return true; }
+static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
 
 static inline int pte_present(pte_t pte)
 {
@@ -451,7 +451,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 static inline pte_t pte_exprotect(pte_t pte)
 {
-	return pte;
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -466,7 +466,7 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_mkexec(pte_t pte)
 {
-	return pte;
+	return __pte(pte_val(pte) | _PAGE_EXEC);
 }
 
 static inline pte_t pte_mkpte(pte_t pte)
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 29f49a35d6ee..a0395ccbbe9e 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -296,7 +296,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_USE_RTC)
 #define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_604	(CPU_FTR_COMMON | CPU_FTR_PPC_LE)
 #define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_L2CR | \
@@ -367,15 +367,15 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
-#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE)
+#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_MAYBE_CAN_NAP)
 #define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_COMMON)
+	    CPU_FTR_COMMON  | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
+	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE  | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON)
 #define CPU_FTRS_8XX	(CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_40X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..d1c39b5ccfd6 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -499,7 +499,7 @@ InstructionTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG_THREAD
-	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
+	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
diff --git a/arch/powerpc/mm/dump_linuxpagetables-generic.c b/arch/powerpc/mm/dump_linuxpagetables-generic.c
index 1e3829ec1348..3fe98a0974c6 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-generic.c
+++ b/arch/powerpc/mm/dump_linuxpagetables-generic.c
@@ -21,13 +21,11 @@ static const struct flag_info flag_array[] = {
 		.set	= "rw",
 		.clear	= "r ",
 	}, {
-#ifndef CONFIG_PPC_BOOK3S_32
 		.mask	= _PAGE_EXEC,
 		.val	= _PAGE_EXEC,
 		.set	= " X ",
 		.clear	= "   ",
 	}, {
-#endif
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
 		.set	= "present",
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 1e33dccbd176..d3d61d29b4f1 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -74,7 +74,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
  * support falls into the same category.
  */
 
-static pte_t set_pte_filter(pte_t pte)
+static pte_t set_pte_filter_hash(pte_t pte)
 {
 	if (radix_enabled())
 		return pte;
@@ -93,14 +93,12 @@ static pte_t set_pte_filter(pte_t pte)
 	return pte;
 }
 
-static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
-				     int dirty)
-{
-	return pte;
-}
-
 #else /* CONFIG_PPC_BOOK3S */
 
+static pte_t set_pte_filter_hash(pte_t pte) { return pte; }
+
+#endif /* CONFIG_PPC_BOOK3S */
+
 /* Embedded type MMU with HW exec support. This is a bit more complicated
  * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
  * instead we "filter out" the exec permission for non clean pages.
@@ -109,6 +107,9 @@ static pte_t set_pte_filter(pte_t pte)
 {
 	struct page *pg;
 
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		return set_pte_filter_hash(pte);
+
 	/* No exec permission in the first place, move on */
 	if (!pte_exec(pte) || !pte_looks_normal(pte))
 		return pte;
@@ -138,6 +139,9 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 {
 	struct page *pg;
 
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		return pte;
+
 	/* So here, we only care about exec faults, as we use them
 	 * to recover lost _PAGE_EXEC and perform I$/D$ coherency
 	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
@@ -172,8 +176,6 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return pte_mkexec(pte);
 }
 
-#endif /* CONFIG_PPC_BOOK3S */
-
 /*
  * set_pte stores a linux PTE into the linux page table.
  */
-- 
2.13.3

