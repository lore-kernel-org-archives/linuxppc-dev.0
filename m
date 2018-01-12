Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHn7D6fm6zDr53
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:41:12 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 5/6] powerpc/kvm/xive: Make xive_pushed a byte, not a word
Date: Fri, 12 Jan 2018 13:37:15 +1100
Message-Id: <20180112023716.9963-5-benh@kernel.crashing.org>
In-Reply-To: <20180112023716.9963-1-benh@kernel.crashing.org>
References: <20180112023716.9963-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/kvm_host.h     | 2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bfe51356af5e..0c44fa67608d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -739,7 +739,7 @@ struct kvm_vcpu_arch {
 	struct kvmppc_icp *icp; /* XICS presentation controller */
 	struct kvmppc_xive_vcpu *xive_vcpu; /* XIVE virtual CPU data */
 	__be32 xive_cam_word;    /* Cooked W2 in proper endian with valid bit */
-	u32 xive_pushed;	 /* Is the VP pushed on the physical CPU ? */
+	u8 xive_pushed;		 /* Is the VP pushed on the physical CPU ? */
 	union xive_tma_w01 xive_saved_state; /* W0..1 of XIVE thread state */
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 506a1c775370..46dc250d072a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1031,7 +1031,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	li	r9, TM_QW1_OS + TM_WORD2
 	stwcix	r11,r9,r10
 	li	r9, 1
-	stw	r9, VCPU_XIVE_PUSHED(r4)
+	stb	r9, VCPU_XIVE_PUSHED(r4)
 	eieio
 
 	/*
@@ -1436,7 +1436,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 #ifdef CONFIG_KVM_XICS
 	/* We are exiting, pull the VP from the XIVE */
-	lwz	r0, VCPU_XIVE_PUSHED(r9)
+	lbz	r0, VCPU_XIVE_PUSHED(r9)
 	cmpwi	cr0, r0, 0
 	beq	1f
 	li	r7, TM_SPC_PULL_OS_CTX
@@ -1465,7 +1465,7 @@ guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	/* Fixup some of the state for the next load */
 	li	r10, 0
 	li	r0, 0xff
-	stw	r10, VCPU_XIVE_PUSHED(r9)
+	stb	r10, VCPU_XIVE_PUSHED(r9)
 	stb	r10, (VCPU_XIVE_SAVED_STATE+3)(r9)
 	stb	r0, (VCPU_XIVE_SAVED_STATE+4)(r9)
 	eieio
-- 
2.14.3
