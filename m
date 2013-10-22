Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5462F2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 03:57:16 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 22:27:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E14C93942968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:14 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBVPcF11993340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:01:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSXDZ023036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:34 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 2/9] powerpc: Free up _PAGE_COHERENCE for numa fault use
 later
Date: Tue, 22 Oct 2013 16:58:13 +0530
Message-Id: <1382441300-1513-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Set  memory coherence always on hash64 config. If
a platform cannot have memory coherence always set they
can infer that from _PAGE_NO_CACHE and _PAGE_WRITETHRU
like in lpar. So we dont' really need a separate bit
for tracking _PAGE_COHERENCE.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64.h |  2 +-
 arch/powerpc/mm/hash_low_64.S         | 15 ++++++++++++---
 arch/powerpc/mm/hash_utils_64.c       |  7 ++++---
 arch/powerpc/mm/hugepage-hash64.c     |  6 +++++-
 arch/powerpc/mm/hugetlbpage-hash64.c  |  4 ++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-hash64.h b/arch/powerpc/include/asm/pte-hash64.h
index 0419eeb..55aea0c 100644
--- a/arch/powerpc/include/asm/pte-hash64.h
+++ b/arch/powerpc/include/asm/pte-hash64.h
@@ -19,7 +19,7 @@
 #define _PAGE_FILE		0x0002 /* (!present only) software: pte holds file offset */
 #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
 #define _PAGE_GUARDED		0x0008
-#define _PAGE_COHERENT		0x0010 /* M: enforce memory coherence (SMP systems) */
+/* We can derive Memory coherence from _PAGE_NO_CACHE */
 #define _PAGE_NO_CACHE		0x0020 /* I: cache inhibit */
 #define _PAGE_WRITETHRU		0x0040 /* W: cache write-through */
 #define _PAGE_DIRTY		0x0080 /* C: page changed */
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index d3cbda6..1136d26 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -148,7 +148,10 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
-	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
+	/*
+	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 */
+	ori	r3,r3,HPTE_R_C | HPTE_R_M
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...) 
@@ -457,7 +460,10 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r3,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
-	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
+	/*
+	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 */
+	ori	r3,r3,HPTE_R_C | HPTE_R_M
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...)
@@ -795,7 +801,10 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
-	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
+	/*
+	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 */
+	ori	r3,r3,HPTE_R_C | HPTE_R_M
 
 	/* We eventually do the icache sync here (maybe inline that
 	 * code rather than call a C function...)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bde8b55..fb176e9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -169,9 +169,10 @@ static unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	if ((pteflags & _PAGE_USER) && !((pteflags & _PAGE_RW) &&
 					 (pteflags & _PAGE_DIRTY)))
 		rflags |= 1;
-
-	/* Always add C */
-	return rflags | HPTE_R_C;
+	/*
+	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 */
+	return rflags | HPTE_R_C | HPTE_R_M;
 }
 
 int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 34de9e0..826893f 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -127,7 +127,11 @@ repeat:
 
 		/* Add in WIMG bits */
 		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				      _PAGE_COHERENT | _PAGE_GUARDED));
+				      _PAGE_GUARDED));
+		/*
+		 * enable the memory coherence always
+		 */
+		rflags |= HPTE_R_M;
 
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 0b7fb67..a5bcf93 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -99,6 +99,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* Add in WIMG bits */
 		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
+		/*
+		 * enable the memory coherence always
+		 */
+		rflags |= HPTE_R_M;
 
 		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
 					     mmu_psize, ssize);
-- 
1.8.3.2
