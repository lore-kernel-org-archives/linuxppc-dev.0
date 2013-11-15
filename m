Return-Path: <qemulist@gmail.com>
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com
 [IPv6:2607:f8b0:4003:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A7C92C016A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 19:34:28 +1100 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o6so3618519oag.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 00:34:25 -0800 (PST)
From: Liu Ping Fan <qemulist@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2] powerpc: kvm: optimize "sc 1" as fast return
Date: Fri, 15 Nov 2013 16:35:01 +0800
Message-Id: <1384504501-19348-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some scene, e.g openstack CI, PR guest can trigger "sc 1" frequently,
this patch optimizes the path by directly delivering BOOK3S_INTERRUPT_SYSCALL
to HV guest, so powernv can return to HV guest without heavy exit, i.e,
no need to swap TLB, HTAB,.. etc

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c            |  6 ------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 62a2b5a..73dc852 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -628,12 +628,6 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* hcall - punt to userspace */
 		int i;
 
-		if (vcpu->arch.shregs.msr & MSR_PR) {
-			/* sc 1 from userspace - reflect to guest syscall */
-			kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_SYSCALL);
-			r = RESUME_GUEST;
-			break;
-		}
 		run->papr_hcall.nr = kvmppc_get_gpr(vcpu, 3);
 		for (i = 0; i < 9; ++i)
 			run->papr_hcall.args[i] = kvmppc_get_gpr(vcpu, 4 + i);
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c71103b..a463f08 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1388,7 +1388,8 @@ kvmppc_hisi:
 hcall_try_real_mode:
 	ld	r3,VCPU_GPR(R3)(r9)
 	andi.	r0,r11,MSR_PR
-	bne	guest_exit_cont
+	/* sc 1 from userspace - reflect to guest syscall */
+	bne	sc_1_fast_return
 	clrrdi	r3,r3,2
 	cmpldi	r3,hcall_real_table_end - hcall_real_table
 	bge	guest_exit_cont
@@ -1409,6 +1410,14 @@ hcall_try_real_mode:
 	ld	r11,VCPU_MSR(r4)
 	b	fast_guest_return
 
+sc_1_fast_return:
+	mtspr	SPRN_SRR0,r10
+	mtspr	SPRN_SRR1,r11
+	li	r10, BOOK3S_INTERRUPT_SYSCALL
+	li      r11, (MSR_ME << 1) | 1  /* synthesize MSR_SF | MSR_ME */
+	rotldi  r11, r11, 63
+	b	fast_guest_return
+
 	/* We've attempted a real mode hcall, but it's punted it back
 	 * to userspace.  We need to restore some clobbered volatiles
 	 * before resuming the pass-it-to-qemu path */
-- 
1.8.1.4
