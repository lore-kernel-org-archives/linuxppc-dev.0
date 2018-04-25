Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJY20lqxzF24t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:17 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id e12so13166941pgn.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:17 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 05/11] KVM: PPC: add GPR RA update skeleton for MMIO emulation
Date: Wed, 25 Apr 2018 19:54:38 +0800
Message-Id: <1524657284-16706-6-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

To optimize kvm emulation code with analyse_instr, adds new
mmio_update_ra flag to aid with GPR RA update.

This patch arms RA update at load/store emulation path for both
qemu mmio emulation or coalesced mmio emulation.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h  |  2 ++
 arch/powerpc/kvm/emulate_loadstore.c |  1 +
 arch/powerpc/kvm/powerpc.c           | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d87768..1c7da00 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -673,6 +673,8 @@ struct kvm_vcpu_arch {
 	u8 mmio_sign_extend;
 	/* conversion between single and double precision */
 	u8 mmio_sp64_extend;
+	u8 mmio_ra; /* GPR as ra to be updated with EA */
+	u8 mmio_update_ra;
 	/*
 	 * Number of simulations for vsx.
 	 * If we use 2*8bytes to simulate 1*16bytes,
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index b8a3aef..90b9692 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -111,6 +111,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_sp64_extend = 0;
 	vcpu->arch.mmio_sign_extend = 0;
 	vcpu->arch.mmio_vmx_copy_nums = 0;
+	vcpu->arch.mmio_update_ra = 0;
 	vcpu->arch.mmio_host_swabbed = 0;
 
 	switch (get_op(inst)) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index bef27b1..f7fd68f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1111,6 +1111,12 @@ static int __kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	if (!ret) {
 		kvmppc_complete_mmio_load(vcpu, run);
+		if (vcpu->arch.mmio_update_ra) {
+			kvmppc_set_gpr(vcpu, vcpu->arch.mmio_ra,
+					vcpu->arch.vaddr_accessed);
+			vcpu->arch.mmio_update_ra = 0;
+		}
+
 		vcpu->mmio_needed = 0;
 		return EMULATE_DONE;
 	}
@@ -1215,6 +1221,12 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	if (!ret) {
 		vcpu->mmio_needed = 0;
+		if (vcpu->arch.mmio_update_ra) {
+			kvmppc_set_gpr(vcpu, vcpu->arch.mmio_ra,
+					vcpu->arch.vaddr_accessed);
+			vcpu->arch.mmio_update_ra = 0;
+		}
+
 		return EMULATE_DONE;
 	}
 
@@ -1581,6 +1593,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			}
 		}
 #endif
+		if (vcpu->arch.mmio_update_ra) {
+			kvmppc_set_gpr(vcpu, vcpu->arch.mmio_ra,
+					vcpu->arch.vaddr_accessed);
+			vcpu->arch.mmio_update_ra = 0;
+		}
 	} else if (vcpu->arch.osi_needed) {
 		u64 *gprs = run->osi.gprs;
 		int i;
-- 
1.8.3.1
