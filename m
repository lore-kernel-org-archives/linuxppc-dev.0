Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G46Bj4zDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 12/19] powerpc/mm/hash: Support 68 bit VA
Date: Thu, 30 Mar 2017 23:04:00 +1100
Message-Id: <1490875447-4016-12-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Inorder to support large effective address range (512TB), we want to
increase the virtual address bits to 68. But we do have platforms like
p4 and p5 that can only do 65 bit VA. We support those platforms by
limiting context bits on them to 16.

The protovsid -> vsid conversion is verified to work with both 65 and 68
bit va values. I also documented the restrictions in a table format as
part of code comments.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 127 ++++++++++++++++----------
 arch/powerpc/include/asm/mmu.h                |  19 ++--
 arch/powerpc/kvm/book3s_64_mmu_host.c         |   8 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |   9 +-
 arch/powerpc/mm/slb_low.S                     |  54 +++++++++--
 5 files changed, 152 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 10a34282829e..c68102293a19 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -39,6 +39,7 @@
 
 /* Bits in the SLB VSID word */
 #define SLB_VSID_SHIFT		12
+#define SLB_VSID_SHIFT_256M	SLB_VSID_SHIFT
 #define SLB_VSID_SHIFT_1T	24
 #define SLB_VSID_SSIZE_SHIFT	62
 #define SLB_VSID_B		ASM_CONST(0xc000000000000000)
@@ -521,9 +522,19 @@ extern void slb_set_size(u16 size);
  * because of the modulo operation in vsid scramble.
  */
 
+/*
+ * Max Va bits we support as of now is 68 bits. We want 19 bit
+ * context ID.
+ * Restrictions:
+ * GPU has restrictions of not able to access beyond 128TB
+ * (47 bit effective address). We also cannot do more than 20bit PID.
+ * For p4 and p5 which can only do 65 bit VA, we restrict our CONTEXT_BITS
+ * to 16 bits (ie, we can only have 2^16 pids at the same time).
+ */
+#define VA_BITS			68
 #define CONTEXT_BITS		19
-#define ESID_BITS		18
-#define ESID_BITS_1T		6
+#define ESID_BITS		(VA_BITS - (SID_SHIFT + CONTEXT_BITS))
+#define ESID_BITS_1T		(VA_BITS - (SID_SHIFT_1T + CONTEXT_BITS))
 
 #define ESID_BITS_MASK		((1 << ESID_BITS) - 1)
 #define ESID_BITS_1T_MASK	((1 << ESID_BITS_1T) - 1)
@@ -533,7 +544,7 @@ extern void slb_set_size(u16 size);
  * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
  * available for user + kernel mapping. VSID 0 is reserved as invalid, contexts
  * 1-4 are used for kernel mapping. Each segment contains 2^28 bytes. Each
- * context maps 2^46 bytes (64TB).
+ * context maps 2^49 bytes (512TB).
  *
  * We also need to avoid the last segment of the last context, because that
  * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
@@ -546,53 +557,45 @@ extern void slb_set_size(u16 size);
 #define KERNEL_REGION_CONTEXT_OFFSET	(0xc - 1)
 
 /*
+ * For platforms that support on 65bit VA we limit the context bits
+ */
+#define MAX_USER_CONTEXT_65BIT_VA ((ASM_CONST(1) << (65 - (SID_SHIFT + ESID_BITS))) - 2)
+
+/*
  * This should be computed such that protovosid * vsid_mulitplier
- * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
+ * doesn't overflow 64 bits. The vsid_mutliplier should also be
+ * co-prime to vsid_modulus. We also need to make sure that number
+ * of bits in multiplied result (dividend) is less than twice the number of
+ * protovsid bits for our modulus optmization to work.
+ *
+ * The below table shows the current values used.
+ * |-------+------------+----------------------+------------+-------------------|
+ * |       | Prime Bits | proto VSID_BITS_65VA | Total Bits | 2* prot VSID_BITS |
+ * |-------+------------+----------------------+------------+-------------------|
+ * | 1T    |         24 |                   25 |         49 |                50 |
+ * |-------+------------+----------------------+------------+-------------------|
+ * | 256MB |         24 |                   37 |         61 |                74 |
+ * |-------+------------+----------------------+------------+-------------------|
+ *
+ * |-------+------------+----------------------+------------+--------------------|
+ * |       | Prime Bits | proto VSID_BITS_68VA | Total Bits | 2* proto VSID_BITS |
+ * |-------+------------+----------------------+------------+--------------------|
+ * | 1T    |         24 |                   28 |         52 |                 56 |
+ * |-------+------------+----------------------+------------+--------------------|
+ * | 256MB |         24 |                   40 |         64 |                 80 |
+ * |-------+------------+----------------------+------------+--------------------|
+ *
  */
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_256M		(CONTEXT_BITS + ESID_BITS)
-#define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
+#define VSID_BITS_256M		(VA_BITS - SID_SHIFT)
+#define VSID_BITS_65_256M	(65 - SID_SHIFT)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		(CONTEXT_BITS + ESID_BITS_1T)
-#define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
-
+#define VSID_BITS_1T		(VA_BITS - SID_SHIFT_1T)
+#define VSID_BITS_65_1T		(65 - SID_SHIFT_1T)
 
 #define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
 
-/*
- * This macro generates asm code to compute the VSID scramble
- * function.  Used in slb_allocate() and do_stab_bolted.  The function
- * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
- *
- *	rt = register containing the proto-VSID and into which the
- *		VSID will be stored
- *	rx = scratch register (clobbered)
- *
- * 	- rt and rx must be different registers
- * 	- The answer will end up in the low VSID_BITS bits of rt.  The higher
- * 	  bits may contain other garbage, so you may need to mask the
- * 	  result.
- */
-#define ASM_VSID_SCRAMBLE(rt, rx, size)					\
-	lis	rx,VSID_MULTIPLIER_##size@h;				\
-	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
-	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
-									\
-	srdi	rx,rt,VSID_BITS_##size;					\
-	clrldi	rt,rt,(64-VSID_BITS_##size);				\
-	add	rt,rt,rx;		/* add high and low bits */	\
-	/* NOTE: explanation based on VSID_BITS_##size = 36		\
-	 * Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
-	 * 2^36-1+2^28-1.  That in particular means that if r3 >=	\
-	 * 2^36-1, then r3+1 has the 2^36 bit set.  So, if r3+1 has	\
-	 * the bit clear, r3 already has the answer we want, if it	\
-	 * doesn't, the answer is the low 36 bits of r3+1.  So in all	\
-	 * cases the answer is the low 36 bits of (r3 + ((r3+1) >> 36))*/\
-	addi	rx,rt,1;						\
-	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
-	add	rt,rt,rx
-
 /* 4 bits per slice and we have one slice per 1TB */
 #define SLICE_ARRAY_SIZE  (H_PGTABLE_RANGE >> 41)
 
@@ -640,7 +643,7 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 #define vsid_scramble(protovsid, size) \
 	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
 
-#else /* 1 */
+/* simplified form avoiding mod operation */
 #define vsid_scramble(protovsid, size) \
 	({								 \
 		unsigned long x;					 \
@@ -648,6 +651,21 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 		x = (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
 		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
 	})
+
+#else /* 1 */
+static inline unsigned long vsid_scramble(unsigned long protovsid,
+				  unsigned long vsid_multiplier, int vsid_bits)
+{
+	unsigned long vsid;
+	unsigned long vsid_modulus = ((1UL << vsid_bits) - 1);
+	/*
+	 * We have same multipler for both 256 and 1T segements now
+	 */
+	vsid = protovsid * vsid_multiplier;
+	vsid = (vsid >> vsid_bits) + (vsid & vsid_modulus);
+	return (vsid + ((vsid + 1) >> vsid_bits)) & vsid_modulus;
+}
+
 #endif /* 1 */
 
 /* Returns the segment size indicator for a user address */
@@ -662,17 +680,30 @@ static inline int user_segment_size(unsigned long addr)
 static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 				     int ssize)
 {
+	unsigned long va_bits = VA_BITS;
+	unsigned long vsid_bits;
+	unsigned long protovsid;
+
 	/*
 	 * Bad address. We return VSID 0 for that
 	 */
 	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
 		return 0;
 
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble((context << ESID_BITS)
-				     | ((ea >> SID_SHIFT) & ESID_BITS_MASK), 256M);
-	return vsid_scramble((context << ESID_BITS_1T)
-			     | ((ea >> SID_SHIFT_1T) & ESID_BITS_1T_MASK), 1T);
+	if (!mmu_has_feature(MMU_FTR_68_BIT_VA))
+		va_bits = 65;
+
+	if (ssize == MMU_SEGSIZE_256M) {
+		vsid_bits = va_bits - SID_SHIFT;
+		protovsid = (context << ESID_BITS) |
+			((ea >> SID_SHIFT) & ESID_BITS_MASK);
+		return vsid_scramble(protovsid, VSID_MULTIPLIER_256M, vsid_bits);
+	}
+	/* 1T segment */
+	vsid_bits = va_bits - SID_SHIFT_1T;
+	protovsid = (context << ESID_BITS_1T) |
+		((ea >> SID_SHIFT_1T) & ESID_BITS_1T_MASK);
+	return vsid_scramble(protovsid, VSID_MULTIPLIER_1T, vsid_bits);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 065e762fae85..78260409dc9c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -29,6 +29,10 @@
  */
 
 /*
+ * Support for 68 bit VA space. We added that from ISA 2.05
+ */
+#define MMU_FTR_68_BIT_VA		ASM_CONST(0x00002000)
+/*
  * Kernel read only support.
  * We added the ppp value 0b110 in ISA 2.04.
  */
@@ -109,10 +113,10 @@
 #define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
 #define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
-#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
-#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
-#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER6		MMU_FTRS_POWER5 | MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA
+#define MMU_FTRS_POWER7		MMU_FTRS_POWER6
+#define MMU_FTRS_POWER8		MMU_FTRS_POWER6
+#define MMU_FTRS_POWER9		MMU_FTRS_POWER6
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
@@ -136,7 +140,7 @@ enum {
 		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
-		MMU_FTR_KERNEL_RO |
+		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_TYPE_RADIX |
 #endif
@@ -290,7 +294,10 @@ static inline bool early_radix_enabled(void)
 #define MMU_PAGE_16G	14
 #define MMU_PAGE_64G	15
 
-/* N.B. we need to change the type of hpte_page_sizes if this gets to be > 16 */
+/*
+ * N.B. we need to change the type of hpte_page_sizes if this gets to be > 16
+ * Also we need to change he type of mm_context.low/high_slices_psize.
+ */
 #define MMU_PAGE_COUNT	16
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index b35f44c98d1f..74b0153780e3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -229,6 +229,7 @@ void kvmppc_mmu_unmap_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 
 static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 {
+	unsigned long vsid_bits = VSID_BITS_65_256M;
 	struct kvmppc_sid_map *map;
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	u16 sid_map_mask;
@@ -257,7 +258,12 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 		kvmppc_mmu_pte_flush(vcpu, 0, 0);
 		kvmppc_mmu_flush_segments(vcpu);
 	}
-	map->host_vsid = vsid_scramble(vcpu_book3s->proto_vsid_next++, 256M);
+
+	if (mmu_has_feature(MMU_FTR_68_BIT_VA))
+		vsid_bits = VSID_BITS_256M;
+
+	map->host_vsid = vsid_scramble(vcpu_book3s->proto_vsid_next++,
+				       VSID_MULTIPLIER_256M, vsid_bits);
 
 	map->guest_vsid = gvsid;
 	map->valid = true;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index a10e972221c4..e5fde156e11d 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -59,7 +59,14 @@ static int alloc_context_id(int min_id, int max_id)
 
 int hash__alloc_context_id(void)
 {
-	return alloc_context_id(MIN_USER_CONTEXT, MAX_USER_CONTEXT);
+	unsigned long max;
+
+	if (mmu_has_feature(MMU_FTR_68_BIT_VA))
+		max = MAX_USER_CONTEXT;
+	else
+		max = MAX_USER_CONTEXT_65BIT_VA;
+
+	return alloc_context_id(MIN_USER_CONTEXT, max);
 }
 EXPORT_SYMBOL_GPL(hash__alloc_context_id);
 
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index ba1f8696c338..1c503d07e0fb 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -23,6 +23,48 @@
 #include <asm/pgtable.h>
 #include <asm/firmware.h>
 
+/*
+ * This macro generates asm code to compute the VSID scramble
+ * function.  Used in slb_allocate() and do_stab_bolted.  The function
+ * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
+ *
+ *	rt = register containing the proto-VSID and into which the
+ *		VSID will be stored
+ *	rx = scratch register (clobbered)
+ *	rf = flags
+ *
+ *	- rt and rx must be different registers
+ *	- The answer will end up in the low VSID_BITS bits of rt.  The higher
+ *	  bits may contain other garbage, so you may need to mask the
+ *	  result.
+ */
+#define ASM_VSID_SCRAMBLE(rt, rx, rf, size)				\
+	lis	rx,VSID_MULTIPLIER_##size@h;				\
+	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
+	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
+/*									\
+ * powermac get slb fault before feature fixup, so make 65 bit part     \
+ * the default part of feature fixup					\
+ */									\
+BEGIN_MMU_FTR_SECTION							\
+	srdi	rx,rt,VSID_BITS_65_##size;				\
+	clrldi	rt,rt,(64-VSID_BITS_65_##size);				\
+	add	rt,rt,rx;						\
+	addi	rx,rt,1;						\
+	srdi	rx,rx,VSID_BITS_65_##size;				\
+	add	rt,rt,rx;						\
+	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_65_##size)); \
+MMU_FTR_SECTION_ELSE							\
+	srdi	rx,rt,VSID_BITS_##size;					\
+	clrldi	rt,rt,(64-VSID_BITS_##size);				\
+	add	rt,rt,rx;		/* add high and low bits */	\
+	addi	rx,rt,1;						\
+	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
+	add	rt,rt,rx;						\
+	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_##size)); \
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
+
+
 /* void slb_allocate_realmode(unsigned long ea);
  *
  * Create an SLB entry for the given EA (user or kernel).
@@ -179,13 +221,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
  */
 .Lslb_finish_load:
 	rldimi  r10,r9,ESID_BITS,0
-	ASM_VSID_SCRAMBLE(r10,r9,256M)
-	/*
-	 * bits above VSID_BITS_256M need to be ignored from r10
-	 * also combine VSID and flags
-	 */
-	rldimi	r11,r10,SLB_VSID_SHIFT,(64 - (SLB_VSID_SHIFT + VSID_BITS_256M))
-
+	ASM_VSID_SCRAMBLE(r10,r9,r11,256M)
 	/* r3 = EA, r11 = VSID data */
 	/*
 	 * Find a slot, round robin. Previously we tried to find a
@@ -249,12 +285,12 @@ slb_compare_rr_to_size:
 .Lslb_finish_load_1T:
 	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
 	rldimi  r10,r9,ESID_BITS_1T,0
-	ASM_VSID_SCRAMBLE(r10,r9,1T)
+	ASM_VSID_SCRAMBLE(r10,r9,r11,1T)
 	/*
 	 * bits above VSID_BITS_1T need to be ignored from r10
 	 * also combine VSID and flags
 	 */
-	rldimi	r11,r10,SLB_VSID_SHIFT_1T,(64 - (SLB_VSID_SHIFT_1T + VSID_BITS_1T))
+
 	li	r10,MMU_SEGSIZE_1T
 	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
 
-- 
2.7.4
