Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 682F42C0385
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 19:02:44 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Sep 2012 14:32:41 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8492bFm47251504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2012 14:32:37 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8492YVM031629
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2012 19:02:35 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V7 11/12] arch/powerpc: Add 64TB support
Date: Tue,  4 Sep 2012 14:31:28 +0530
Message-Id: <1346749289-16986-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1346749289-16986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1346749289-16986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Increase max addressable range to 64TB. This is not tested on
real hardware yet.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h        |   42 ++++++++++++++++++++------
 arch/powerpc/include/asm/pgtable-ppc64-4k.h  |    2 +-
 arch/powerpc/include/asm/pgtable-ppc64-64k.h |    2 +-
 arch/powerpc/include/asm/processor.h         |    4 +--
 arch/powerpc/include/asm/sparsemem.h         |    4 +--
 arch/powerpc/kernel/exceptions-64s.S         |    4 ++-
 arch/powerpc/mm/slb_low.S                    |   12 ++++++++
 7 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 8c5c5a4..5c52691 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -374,17 +374,21 @@ extern void slb_set_size(u16 size);
  * (head.S) and ASM_VSID_SCRAMBLE (below) are changed accordingly.
  */
 
-#define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
-#define VSID_BITS_256M		36
+/*
+ * This should be computed such that protovosid * vsid_mulitplier
+ * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
+ */
+#define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
+#define VSID_BITS_256M		38
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		24
+#define VSID_BITS_1T		26
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
 #define CONTEXT_BITS		19
-#define USER_ESID_BITS		16
-#define USER_ESID_BITS_1T	4
+#define USER_ESID_BITS		18
+#define USER_ESID_BITS_1T	6
 
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
 
@@ -507,12 +511,32 @@ typedef struct {
 	})
 #endif /* 1 */
 
-/* This is only valid for addresses >= PAGE_OFFSET */
+/*
+ * This is only valid for addresses >= PAGE_OFFSET
+ * The proto-VSID space is divided into two class
+ * User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
+ * kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1
+ *
+ * With KERNEL_START at 0xc000000000000000, the proto vsid for
+ * the kernel ends up with 0xc00000000 (36 bits). With 64TB
+ * support we need to have kernel proto-VSID in the
+ * [2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.
+ */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble(ea >> SID_SHIFT, 256M);
-	return vsid_scramble(ea >> SID_SHIFT_1T, 1T);
+	unsigned long proto_vsid;
+	/*
+	 * We need to make sure proto_vsid for the kernel is
+	 * >= 2^(CONTEXT_BITS + USER_ESID_BITS[_1T])
+	 */
+	if (ssize == MMU_SEGSIZE_256M) {
+		proto_vsid = ea >> SID_SHIFT;
+		proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS));
+		return vsid_scramble(proto_vsid, 256M);
+	}
+	proto_vsid = ea >> SID_SHIFT_1T;
+	proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T));
+	return vsid_scramble(proto_vsid, 1T);
 }
 
 /* Returns the segment size indicator for a user address */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 6eefdcf..b3eccf2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -7,7 +7,7 @@
  */
 #define PTE_INDEX_SIZE  9
 #define PMD_INDEX_SIZE  7
-#define PUD_INDEX_SIZE  7
+#define PUD_INDEX_SIZE  9
 #define PGD_INDEX_SIZE  9
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index 90533dd..be4e287 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -7,7 +7,7 @@
 #define PTE_INDEX_SIZE  12
 #define PMD_INDEX_SIZE  12
 #define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  4
+#define PGD_INDEX_SIZE  6
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 53b6dfa..00bda2f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -97,8 +97,8 @@ extern struct task_struct *last_task_used_spe;
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 44-bits (16TB user VM) */
-#define TASK_SIZE_USER64 (0x0000100000000000UL)
+/* 64-bit user address space is 46-bits (64TB user VM) */
+#define TASK_SIZE_USER64 (0x0000400000000000UL)
 
 /* 
  * 32-bit user address space is 4GB - 1 page 
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 0c5fa31..f6fc0ee 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -10,8 +10,8 @@
  */
 #define SECTION_SIZE_BITS       24
 
-#define MAX_PHYSADDR_BITS       44
-#define MAX_PHYSMEM_BITS        44
+#define MAX_PHYSADDR_BITS       46
+#define MAX_PHYSMEM_BITS        46
 
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e894515..d980818 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -959,7 +959,9 @@ _GLOBAL(do_stab_bolted)
 	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
 	/* Calculate VSID */
-	/* This is a kernel address, so protovsid = ESID */
+	/* This is a kernel address, so protovsid = ESID | 1 << 37 */
+	li	r9,0x1
+	rldimi  r11,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	ASM_VSID_SCRAMBLE(r11, r9, 256M)
 	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index f6a2625..1a16ca2 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -56,6 +56,12 @@ _GLOBAL(slb_allocate_realmode)
 	 */
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
+	li	r9,0x1
+	/*
+	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
+	 * the necessary adjustment
+	 */
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
@@ -85,6 +91,12 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	_GLOBAL(slb_miss_kernel_load_io)
 	li	r11,0
 6:
+	li	r9,0x1
+	/*
+	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
+	 * the necessary adjustment
+	 */
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-- 
1.7.10
