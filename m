Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G93cCqzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 17/19] powerpc/pseries: Skip using reserved virtual address
 range
Date: Thu, 30 Mar 2017 23:04:05 +1100
Message-Id: <1490875447-4016-17-git-send-email-mpe@ellerman.id.au>
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

Now that we use all the available virtual address range, we need to make
sure we don't generate VSID such that it overlaps with the reserved vsid
range. Reserved vsid range include the virtual address range used by the
adjunct partition and also the VRMA virtual segment. We find the context
value that can result in generating such a VSID and reserve it early in
boot.

We don't look at the adjunct range, because for now we disable the
adjunct usage in a Linux LPAR via CAS interface.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Rewrite hash__reserve_context_id(), move the rest into pseries]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  7 +++
 arch/powerpc/include/asm/kvm_book3s_64.h      |  2 -
 arch/powerpc/include/asm/mmu_context.h        |  1 +
 arch/powerpc/mm/hash_utils_64.c               |  1 -
 arch/powerpc/mm/mmu_context_book3s64.c        | 16 +++++++
 arch/powerpc/platforms/pseries/lpar.c         | 61 +++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 5961b0d65a79..6d56974adf28 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -589,11 +589,18 @@ extern void slb_set_size(u16 size);
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
 #define VSID_BITS_256M		(VA_BITS - SID_SHIFT)
 #define VSID_BITS_65_256M	(65 - SID_SHIFT)
+/*
+ * Modular multiplicative inverse of VSID_MULTIPLIER under modulo VSID_MODULUS
+ */
+#define VSID_MULINV_256M	ASM_CONST(665548017062)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
 #define VSID_BITS_1T		(VA_BITS - SID_SHIFT_1T)
 #define VSID_BITS_65_1T		(65 - SID_SHIFT_1T)
+#define VSID_MULINV_1T		ASM_CONST(209034062)
 
+/* 1TB VSID reserved for VRMA */
+#define VRMA_VSID	0x1ffffffUL
 #define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
 
 /* 4 bits per slice and we have one slice per 1TB */
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index d9b48f5bb606..d55c7f881ce7 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -49,8 +49,6 @@ static inline bool kvm_is_radix(struct kvm *kvm)
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
 
-#define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
-
 /*
  * We use a lock bit in HPTE dword 0 to synchronize updates and
  * accesses to each HPTE, and another bit to indicate non-present
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7d721101ec78..78803a7ebdd9 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -52,6 +52,7 @@ static inline void switch_mmu_context(struct mm_struct *prev,
 }
 
 extern int hash__alloc_context_id(void);
+extern void hash__reserve_context_id(int id);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 716255f88bbd..8848fec51ce9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1868,5 +1868,4 @@ static int __init hash64_debugfs(void)
 	return 0;
 }
 machine_device_initcall(pseries, hash64_debugfs);
-
 #endif /* CONFIG_DEBUG_FS */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index fd0bc6db2dcd..7bc5b63034db 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -57,6 +57,22 @@ static int alloc_context_id(int min_id, int max_id)
 	return index;
 }
 
+void hash__reserve_context_id(int id)
+{
+	int rc, result = 0;
+
+	do {
+		if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
+			break;
+
+		spin_lock(&mmu_context_lock);
+		rc = ida_get_new_above(&mmu_context_ida, id, &result);
+		spin_unlock(&mmu_context_lock);
+	} while (rc == -EAGAIN);
+
+	WARN(result != id, "mmu: Failed to reserve context id %d (rc %d)\n", id, result);
+}
+
 int hash__alloc_context_id(void)
 {
 	unsigned long max;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8b1fe895daa3..6541d0b03e4c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -958,3 +958,64 @@ int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data)
 
 	return rc;
 }
+
+static unsigned long vsid_unscramble(unsigned long vsid, int ssize)
+{
+	unsigned long protovsid;
+	unsigned long va_bits = VA_BITS;
+	unsigned long modinv, vsid_modulus;
+	unsigned long max_mod_inv, tmp_modinv;
+
+	if (!mmu_has_feature(MMU_FTR_68_BIT_VA))
+		va_bits = 65;
+
+	if (ssize == MMU_SEGSIZE_256M) {
+		modinv = VSID_MULINV_256M;
+		vsid_modulus = ((1UL << (va_bits - SID_SHIFT)) - 1);
+	} else {
+		modinv = VSID_MULINV_1T;
+		vsid_modulus = ((1UL << (va_bits - SID_SHIFT_1T)) - 1);
+	}
+
+	/*
+	 * vsid outside our range.
+	 */
+	if (vsid >= vsid_modulus)
+		return 0;
+
+	/*
+	 * If modinv is the modular multiplicate inverse of (x % vsid_modulus)
+	 * and vsid = (protovsid * x) % vsid_modulus, then we say:
+	 *   protovsid = (vsid * modinv) % vsid_modulus
+	 */
+
+	/* Check if (vsid * modinv) overflow (63 bits) */
+	max_mod_inv = 0x7fffffffffffffffull / vsid;
+	if (modinv < max_mod_inv)
+		return (vsid * modinv) % vsid_modulus;
+
+	tmp_modinv = modinv/max_mod_inv;
+	modinv %= max_mod_inv;
+
+	protovsid = (((vsid * max_mod_inv) % vsid_modulus) * tmp_modinv) % vsid_modulus;
+	protovsid = (protovsid + vsid * modinv) % vsid_modulus;
+
+	return protovsid;
+}
+
+static int __init reserve_vrma_context_id(void)
+{
+	unsigned long protovsid;
+
+	/*
+	 * Reserve context ids which map to reserved virtual addresses. For now
+	 * we only reserve the context id which maps to the VRMA VSID. We ignore
+	 * the addresses in "ibm,adjunct-virtual-addresses" because we don't
+	 * enable adjunct support via the "ibm,client-architecture-support"
+	 * interface.
+	 */
+	protovsid = vsid_unscramble(VRMA_VSID, MMU_SEGSIZE_1T);
+	hash__reserve_context_id(protovsid >> ESID_BITS_1T);
+	return 0;
+}
+machine_device_initcall(pseries, reserve_vrma_context_id);
-- 
2.7.4
