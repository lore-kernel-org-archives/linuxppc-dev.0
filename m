Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79A2D2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:35 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:33 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 65E253940058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiPZL47251666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGiT1S020106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 03/10] KVM: PPC: BOOK3S: PR: Emulate instruction counter
Date: Tue, 28 Jan 2014 22:14:08 +0530
Message-Id: <1390927455-3312-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Writing to IC is not allowed in the privileged mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/book3s_emulate.c   | 3 +++
 arch/powerpc/kvm/book3s_pr.c        | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9ebdd12e50a9..e0b13aca98e6 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -509,6 +509,7 @@ struct kvm_vcpu_arch {
 	/* Time base value when we entered the guest */
 	u64 entry_tb;
 	u64 entry_vtb;
+	u64 entry_ic;
 	u32 tcr;
 	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
 	u32 ivor[64];
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 4b58d8a90cb5..abe6f3057e5b 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -531,6 +531,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 	case SPRN_VTB:
 		*spr_val = vcpu->arch.vtb;
 		break;
+	case SPRN_IC:
+		*spr_val = vcpu->arch.ic;
+		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index b5598e9cdd09..51d469f8c9fd 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -121,6 +121,7 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	 */
 	vcpu->arch.entry_tb = get_tb();
 	vcpu->arch.entry_vtb = get_vtb();
+	vcpu->arch.entry_ic = mfspr(SPRN_IC);
 
 }
 
@@ -174,6 +175,7 @@ out:
 	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
+	vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;
 }
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
1.8.5.3
