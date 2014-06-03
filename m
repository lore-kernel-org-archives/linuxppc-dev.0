Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ABC11A0041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 22:49:03 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Jun 2014 18:18:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 462D83940A03
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 17:47:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s53CIHok21627054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jun 2014 17:48:17 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s53CGXIv026646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jun 2014 17:46:34 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR emulation
Date: Tue,  3 Jun 2014 17:46:11 +0530
Message-Id: <1401797771-25606-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We use time base for PURR and SPURR emulation with PR KVM since we
are emulating a single threaded core. When using time base
we need to make sure that we don't accumulate time spent in the host
in PURR and SPURR value.

Also we don't need to emulate mtspr because both the registers are
hypervisor resource.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 --
 arch/powerpc/include/asm/kvm_host.h   |  4 ++--
 arch/powerpc/kvm/book3s_emulate.c     | 16 ++++++++--------
 arch/powerpc/kvm/book3s_pr.c          | 10 ++++++++++
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index f52f65694527..a20cc0bbd048 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -83,8 +83,6 @@ struct kvmppc_vcpu_book3s {
 	u64 sdr1;
 	u64 hior;
 	u64 msr_mask;
-	u64 purr_offset;
-	u64 spurr_offset;
 #ifdef CONFIG_PPC_BOOK3S_32
 	u32 vsid_pool[VSID_POOL_SIZE];
 	u32 vsid_next;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bb66d8b8efdf..4a58731a0a72 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -503,8 +503,8 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_BOOKE
 	u32 decar;
 #endif
-	u32 tbl;
-	u32 tbu;
+	/* Time base value when we entered the guest */
+	u64 entry_tb;
 	u32 tcr;
 	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
 	u32 ivor[64];
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 3f295269af37..3565e775b61b 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -439,12 +439,6 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		    (mfmsr() & MSR_HV))
 			vcpu->arch.hflags |= BOOK3S_HFLAG_DCBZ32;
 		break;
-	case SPRN_PURR:
-		to_book3s(vcpu)->purr_offset = spr_val - get_tb();
-		break;
-	case SPRN_SPURR:
-		to_book3s(vcpu)->spurr_offset = spr_val - get_tb();
-		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
@@ -572,10 +566,16 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		*spr_val = 0;
 		break;
 	case SPRN_PURR:
-		*spr_val = get_tb() + to_book3s(vcpu)->purr_offset;
+		/*
+		 * On exit we would have updated purr
+		 */
+		*spr_val = vcpu->arch.purr;
 		break;
 	case SPRN_SPURR:
-		*spr_val = get_tb() + to_book3s(vcpu)->purr_offset;
+		/*
+		 * On exit we would have updated spurr
+		 */
+		*spr_val = vcpu->arch.spurr;
 		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 23367a7e44c3..c71ce784a72f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -121,6 +121,11 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	svcpu->shadow_fscr = vcpu->arch.shadow_fscr;
 #endif
 	svcpu->in_use = true;
+	/*
+	 * Now also save the current time base value. We use this
+	 * to find the guest purr and spurr value.
+	 */
+	vcpu->arch.entry_tb = get_tb();
 }
 
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
@@ -170,6 +175,11 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 
 out:
 	preempt_enable();
+	/*
+	 * Update purr and spurr using time base
+	 */
+	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
+	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
 }
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
1.9.1
