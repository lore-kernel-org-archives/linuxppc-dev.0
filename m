Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPt4hVVzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:38:26 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T7uc062904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:16 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vjtmau-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:16 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:38:13 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 14/17] powerpc/mm/hash: Skip using reserved virtual address
 range
Date: Wed, 22 Mar 2017 09:07:00 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we use all the available virtual address range, we need to make sure
we don't generate VSID such that it overlaps with the reserved vsid range.
Reserved vsid range include the virtual address range used by the adjunct
partition and also the VRMA virtual segment. We find the context value that
can result in generating such a VSID and reserve it early in boot.

We don't look at the adjunct range, because for now we disable the adjunct usage
in a Linux LPAR via CAS interface.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  7 ++++
 arch/powerpc/include/asm/kvm_book3s_64.h      |  2 -
 arch/powerpc/include/asm/mmu_context.h        |  1 +
 arch/powerpc/mm/hash_utils_64.c               | 58 +++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_context_book3s64.c        | 26 ++++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index c99ea6bbd82c..ac987e08ce63 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -578,11 +578,18 @@ extern void slb_set_size(u16 size);
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
index 8fe1ba1808d3..757d4a9e1a1c 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -51,6 +51,7 @@ static inline void switch_mmu_context(struct mm_struct *prev,
 	return switch_slb(tsk, next);
 }
 
+extern void hash__resv_context(int context_id);
 extern int hash__get_new_context(void);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 04523052ad8e..81db182225fb 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1846,4 +1846,62 @@ static int __init hash64_debugfs(void)
 }
 machine_device_initcall(pseries, hash64_debugfs);
 
+/*
+ * if modinv is the modular multiplicate inverse of (x % vsid_modulus) and
+ * vsid = (protovsid * x) % vsid_modulus, then we say
+ *
+ * provosid = (vsid * modinv) % vsid_modulus
+ */
+static unsigned long vsid_unscramble(unsigned long vsid, int ssize)
+{
+	unsigned long protovsid;
+	unsigned long va_bits = VA_BITS;
+	unsigned long modinv, vsid_modulus;
+	unsigned long max_mod_inv, tmp_modinv;
+
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
+	/*
+	 * vsid outside our range.
+	 */
+	if (vsid >= vsid_modulus)
+		return 0;
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
+	return protovsid;
+}
+
+static int __init hash_init_reserved_context(void)
+{
+	unsigned long protovsid;
+
+	/*
+	 * VRMA_VSID to skip list. We don't bother about
+	 * ibm,adjunct-virtual-addresses because we disable
+	 * via ibm,client-architecture-support interface.
+	 */
+	protovsid = vsid_unscramble(VRMA_VSID, MMU_SEGSIZE_1T);
+	hash__resv_context(protovsid >> ESID_BITS_1T);
+	return 0;
+}
+machine_device_initcall(pseries, hash_init_reserved_context);
+
 #endif /* CONFIG_DEBUG_FS */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 9ab6cd2923be..8ca0e50d8703 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -30,6 +30,32 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
+void hash__resv_context(int context)
+{
+	int index = 0, err;
+
+	/*
+	 * context zero is always valid. We can't reserve it
+	 */
+	if (!context)
+		return;
+again:
+	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
+		goto error_out;
+
+	spin_lock(&mmu_context_lock);
+	err = ida_get_new_above(&mmu_context_ida, context, &index);
+	spin_unlock(&mmu_context_lock);
+
+	if (err == -EAGAIN)
+		goto again;
+error_out:
+	if (index != context)
+		WARN(1, "Failed to resv context %d (got %d)\n", context, index);
+	else
+		pr_info("Reserving context %d\n", context);
+}
+
 int hash__get_new_context(void)
 {
 	int index, err;
-- 
2.7.4
