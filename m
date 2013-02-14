Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68B7C2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:40 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Feb 2013 14:04:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 92B5DE0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:07:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1E8aRRI31981740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:06:27 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1E8aSvg020298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:28 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, phileas-fogg@mail.ru,
 geoff@infradead.org
Subject: [PATCH 2/4] powerpc: Update kernel VSID range
Date: Thu, 14 Feb 2013 14:06:21 +0530
Message-Id: <1360830983-1812-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <a>
 <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This patch change the kernel VSID range so that we limit VSID_BITS to 37.
This enables us to support 64TB with 65 bit VA (37+28). Without this patch
we have boot hangs on platforms that only support 65 bit VA.

With this patch we now have proto vsid generated as below:

We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
from mmu context id and effective segment id of the address.

For user processes max context id is limited to ((1ul << 19) - 6)
for kernel space, we use the top 4 context ids to map address as below
0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |  101 ++++++++++++++-------------------
 arch/powerpc/kernel/exceptions-64s.S  |   17 ++++--
 arch/powerpc/mm/mmu_context_hash64.c  |   11 +---
 arch/powerpc/mm/slb_low.S             |   22 +++++--
 4 files changed, 74 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 5f8c2bd..0e08252 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -343,17 +343,15 @@ extern void slb_set_size(u16 size);
 /*
  * VSID allocation (256MB segment)
  *
- * We first generate a 38-bit "proto-VSID".  For kernel addresses this
- * is equal to the ESID | 1 << 37, for user addresses it is:
- *	(context << USER_ESID_BITS) | (esid & ((1U << USER_ESID_BITS) - 1)
+ * We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
+ * from mmu context id and effective segment id of the address.
  *
- * This splits the proto-VSID into the below range
- *  0 - (2^(CONTEXT_BITS + USER_ESID_BITS) - 1) : User proto-VSID range
- *  2^(CONTEXT_BITS + USER_ESID_BITS) - 2^(VSID_BITS) : Kernel proto-VSID range
- *
- * We also have CONTEXT_BITS + USER_ESID_BITS = VSID_BITS - 1
- * That is, we assign half of the space to user processes and half
- * to the kernel.
+ * For user processes max context id is limited to ((1ul << 19) - 6)
+ * for kernel space, we use the top 4 context ids to map address as below
+ * 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
+ * 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
+ * 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
+ * 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]
  *
  * The proto-VSIDs are then scrambled into real VSIDs with the
  * multiplicative hash:
@@ -363,22 +361,9 @@ extern void slb_set_size(u16 size);
  * VSID_MULTIPLIER is prime, so in particular it is
  * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
  * Because the modulus is 2^n-1 we can compute it efficiently without
- * a divide or extra multiply (see below).
- *
- * This scheme has several advantages over older methods:
- *
- *	- We have VSIDs allocated for every kernel address
- * (i.e. everything above 0xC000000000000000), except the very top
- * segment, which simplifies several things.
- *
- *	- We allow for USER_ESID_BITS significant bits of ESID and
- * CONTEXT_BITS  bits of context for user addresses.
- *  i.e. 64T (46 bits) of address space for up to half a million contexts.
- *
- *	- The scramble function gives robust scattering in the hash
- * table (at least based on some initial results).  The previous
- * method was more susceptible to pathological cases giving excessive
- * hash collisions.
+ * a divide or extra multiply (see below). The scramble function gives
+ * robust scattering in the hash * table (at least based on some initial
+ * results).
  */
 
 #define CONTEXT_BITS		19
@@ -386,15 +371,25 @@ extern void slb_set_size(u16 size);
 #define USER_ESID_BITS_1T	6
 
 /*
+ * 256MB segment
+ * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
+ * available for user + kernel mapping. The top 4 contexts are used for
+ * kernel mapping. Each segment contains 2^28 bytes. Each
+ * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
+ * (19 == 37 + 28 - 46).
+ */
+#define MAX_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 1)
+
+/*
  * This should be computed such that protovosid * vsid_mulitplier
  * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
  */
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS + 1)
+#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS)
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T + 1)
+#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T)
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
 
@@ -422,7 +417,8 @@ extern void slb_set_size(u16 size);
 	srdi	rx,rt,VSID_BITS_##size;					\
 	clrldi	rt,rt,(64-VSID_BITS_##size);				\
 	add	rt,rt,rx;		/* add high and low bits */	\
-	/* Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
+	/* NOTE: explanation based on VSID_BITS_##size = 36		\
+	 * Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
 	 * 2^36-1+2^28-1.  That in particular means that if r3 >=	\
 	 * 2^36-1, then r3+1 has the 2^36 bit set.  So, if r3+1 has	\
 	 * the bit clear, r3 already has the answer we want, if it	\
@@ -514,34 +510,6 @@ typedef struct {
 	})
 #endif /* 1 */
 
-/*
- * This is only valid for addresses >= PAGE_OFFSET
- * The proto-VSID space is divided into two class
- * User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
- * kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1
- *
- * With KERNEL_START at 0xc000000000000000, the proto vsid for
- * the kernel ends up with 0xc00000000 (36 bits). With 64TB
- * support we need to have kernel proto-VSID in the
- * [2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.
- */
-static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
-{
-	unsigned long proto_vsid;
-	/*
-	 * We need to make sure proto_vsid for the kernel is
-	 * >= 2^(CONTEXT_BITS + USER_ESID_BITS[_1T])
-	 */
-	if (ssize == MMU_SEGSIZE_256M) {
-		proto_vsid = ea >> SID_SHIFT;
-		proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS));
-		return vsid_scramble(proto_vsid, 256M);
-	}
-	proto_vsid = ea >> SID_SHIFT_1T;
-	proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T));
-	return vsid_scramble(proto_vsid, 1T);
-}
-
 /* Returns the segment size indicator for a user address */
 static inline int user_segment_size(unsigned long addr)
 {
@@ -551,7 +519,6 @@ static inline int user_segment_size(unsigned long addr)
 	return MMU_SEGSIZE_256M;
 }
 
-/* This is only valid for user addresses (which are below 2^44) */
 static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 				     int ssize)
 {
@@ -562,6 +529,24 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 			     | (ea >> SID_SHIFT_1T), 1T);
 }
 
+/*
+ * This is only valid for addresses >= PAGE_OFFSET
+ *
+ * For kernel space, we use the top 4 context ids to map address as below
+ * 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]
+ * 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
+ * 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
+ * 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]
+ */
+static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
+{
+	unsigned long context;
+	/*
+	 * kernel take the top 4 context from the available range
+	 */
+	context = (MAX_CONTEXT - 4) +  ((ea >> 60) - 0xc);
+	return get_vsid(context, ea, ssize);
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4665e82..d8f6804 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1268,17 +1268,24 @@ do_ste_alloc:
 _GLOBAL(do_stab_bolted)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
+	mfspr	r11,SPRN_DAR			/* ea */
+
+	/*
+	 * Calculate VSID:
+	 * This is the kernel vsid, we take the top for context from
+	 * the range. context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 */
+	srdi	r9,r11,60
+	subi	r9,r9,(0xc + 4 + 1)
+	lis	r10,8
+	add	r9,r9,r10		/* context */
 
 	/* Hash to the primary group */
 	ld	r10,PACASTABVIRT(r13)
-	mfspr	r11,SPRN_DAR
 	srdi	r11,r11,28
 	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
-	/* Calculate VSID */
-	/* This is a kernel address, so protovsid = ESID | 1 << 37 */
-	li	r9,0x1
-	rldimi  r11,r9,(CONTEXT_BITS + USER_ESID_BITS),0
+	rldimi  r11,r9,USER_ESID_BITS,0 /* proto vsid */
 	ASM_VSID_SCRAMBLE(r11, r9, 256M)
 	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 40bc5b0..9c84b16 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -29,15 +29,6 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
-/*
- * 256MB segment
- * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
- * available for user mappings. Each segment contains 2^28 bytes. Each
- * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
- * (19 == 37 + 28 - 46).
- */
-#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
-
 int __init_new_context(void)
 {
 	int index;
@@ -56,7 +47,7 @@ again:
 	else if (err)
 		return err;
 
-	if (index > MAX_CONTEXT) {
+	if (index > (MAX_CONTEXT - 4)) {
 		spin_lock(&mmu_context_lock);
 		ida_remove(&mmu_context_ida, index);
 		spin_unlock(&mmu_context_lock);
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 1a16ca2..487f998 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -56,12 +56,19 @@ _GLOBAL(slb_allocate_realmode)
 	 */
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
-	li	r9,0x1
+	/*
+	 * context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 */
+	srdi	r9,r3,60
+	subi	r9,r9,(0xc + 4 + 1)
+	lis	r10, 8
+	add	r9,r9,r10
+	srdi	r10,r3,28 /* FIXME!! doing it twice */
 	/*
 	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
 	 * the necessary adjustment
 	 */
-	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
+	rldimi  r10,r9,USER_ESID_BITS,0
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
@@ -91,12 +98,19 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	_GLOBAL(slb_miss_kernel_load_io)
 	li	r11,0
 6:
-	li	r9,0x1
+	/*
+	 * context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
+	 */
+	srdi	r9,r3,60
+	subi	r9,r9,(0xc + 4 + 1)
+	lis	r10,8
+	add	r9,r9,r10
+	srdi	r10,r3,28 /* FIXME!! doing it twice */
 	/*
 	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
 	 * the necessary adjustment
 	 */
-	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
+	rldimi  r10,r9,USER_ESID_BITS,0
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-- 
1.7.10
