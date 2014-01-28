Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCFE72C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:33 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C125C1258054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:16:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiOH72097616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGiS8u020066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:28 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 02/10] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
Date: Tue, 28 Jan 2014 22:14:07 +0530
Message-Id: <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

virtual time base register is a per vm register and need to saved
and restored on vm exit and entry. Writing to VTB is not allowed
in the privileged mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/include/asm/reg.h      |  7 +++++++
 arch/powerpc/include/asm/time.h     | 12 ++++++++++++
 arch/powerpc/kvm/book3s_emulate.c   |  3 +++
 arch/powerpc/kvm/book3s_pr.c        |  3 +++
 5 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0a3785271f34..9ebdd12e50a9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -508,6 +508,7 @@ struct kvm_vcpu_arch {
 #endif
 	/* Time base value when we entered the guest */
 	u64 entry_tb;
+	u64 entry_vtb;
 	u32 tcr;
 	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
 	u32 ivor[64];
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e789f76c9bc2..6c649355b1e9 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1161,6 +1161,13 @@
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
+#ifdef CONFIG_PPC_BOOK3S_64
+#define mfvtb()		({unsigned long rval;				\
+			asm volatile("mfspr %0, %1" :			\
+				     "=r" (rval) : "i" (SPRN_VTB)); rval;})
+#else
+#define mfvtb() BUG()
+#endif
 
 #ifdef __powerpc64__
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c1f267694acb..1e89dbc665d9 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -101,6 +101,18 @@ static inline u64 get_rtc(void)
 	return (u64)hi * 1000000000 + lo;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline u64 get_vtb(void)
+{
+	return mfvtb();
+}
+#else
+static inline u64 get_vtb(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PPC64
 static inline u64 get_tb(void)
 {
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index e1f1e5e16449..4b58d8a90cb5 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -528,6 +528,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		 */
 		*spr_val = vcpu->arch.spurr;
 		break;
+	case SPRN_VTB:
+		*spr_val = vcpu->arch.vtb;
+		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 02231f5193c2..b5598e9cdd09 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -120,6 +120,8 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	 * to find the guest purr and spurr value.
 	 */
 	vcpu->arch.entry_tb = get_tb();
+	vcpu->arch.entry_vtb = get_vtb();
+
 }
 
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
@@ -171,6 +173,7 @@ out:
 	 */
 	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
+	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
 }
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
1.8.5.3
