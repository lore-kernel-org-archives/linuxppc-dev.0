Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5CECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:35:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD4B2098A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD4B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bVRC0n5TzF3J2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bVNv5hPVzF3Dv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:33:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bVNv57Dvz9s47; Fri, 19 Oct 2018 00:33:19 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bVNv4t9kz9s8r; Fri, 19 Oct 2018 00:33:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Make pte_pgprot return all pte bits
Date: Fri, 19 Oct 2018 00:33:16 +1100
Message-Id: <20181018133316.10073-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

Other archs do the same and instead of adding required pte bits (which
got masked out) in __ioremap_at(), make sure we filter only pfn bits
out.

Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  6 ------
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  8 --------
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |  5 -----
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |  5 -----
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  5 -----
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  5 -----
 arch/powerpc/include/asm/nohash/pgtable.h          |  1 -
 arch/powerpc/include/asm/nohash/pte-book3e.h       |  5 -----
 arch/powerpc/include/asm/pgtable.h                 | 10 ++++++++++
 9 files changed, 10 insertions(+), 40 deletions(-)

Resend so patchwork picks it up.

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 0fbd4c642b51..e61dd3ae5bc0 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -48,11 +48,6 @@ static inline bool pte_user(pte_t pte)
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HASHPTE | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL)
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_RW | _PAGE_DIRTY)
-
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
@@ -396,7 +391,6 @@ static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSE
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline bool pte_exec(pte_t pte)		{ return true; }
-static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 static inline int pte_present(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 9db2b8eba61d..d33421648d39 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -128,13 +128,6 @@
 
 #define H_PTE_PKEY  (H_PTE_PKEY_BIT0 | H_PTE_PKEY_BIT1 | H_PTE_PKEY_BIT2 | \
 		     H_PTE_PKEY_BIT3 | H_PTE_PKEY_BIT4)
-/*
- * Mask of bits returned by pte_pgprot()
- */
-#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
-			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
-			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
-			 _PAGE_SOFT_DIRTY | H_PTE_PKEY)
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
@@ -496,7 +489,6 @@ static inline bool pte_exec(pte_t pte)
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_EXEC));
 }
 
-static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline bool pte_soft_dirty(pte_t pte)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 7a8b3c94592f..661f4599f2fc 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -73,11 +73,6 @@
 /* Until my rework is finished, 40x still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
-
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index 8d6b268a986f..78bc304f750e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -93,11 +93,6 @@
 #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
 #define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
-
 /* TODO: Add large page lowmem mapping support */
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1c57efac089d..6bfe041ef59d 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -55,11 +55,6 @@
 #define _PAGE_KERNEL_RW		(_PAGE_SH | _PAGE_DIRTY)
 #define _PAGE_KERNEL_RWX	(_PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
-			 _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
-			 _PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
-
 #define _PMD_PRESENT	0x0001
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
 #define _PMD_BAD	0x0fd0
diff --git a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
index 1ecf60fe0909..0fc1bd42bb3e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
@@ -39,11 +39,6 @@
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
-
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 04e9f0922ad4..70ff23974b59 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -52,7 +52,6 @@ static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK)
 static inline bool pte_hashpte(pte_t pte)	{ return false; }
 static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
 static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
-static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_NUMA_BALANCING
 /*
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 58eef8cb569d..f95ab6eaf441 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -82,11 +82,6 @@
 #define _PTE_NONE_MASK	0
 #endif
 
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
-
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index fb4b85bba110..9679b7519a35 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -46,6 +46,16 @@ struct mm_struct;
 /* Keep these as a macros to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
+/*
+ * Select all bits except the pfn
+ */
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	unsigned long pte_flags;
+
+	pte_flags = pte_val(pte) & ~PTE_RPN_MASK;
+	return __pgprot(pte_flags);
+}
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
-- 
2.17.2

