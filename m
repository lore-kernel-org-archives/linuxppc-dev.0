Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4D0B1A056D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:07 +1100 (AEDT)
Received: by mail-pd0-f170.google.com with SMTP id p10so2768767pdj.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:06 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 07/11] powerpc: kvm: the stopper func to cease secondary hwthread
Date: Thu, 16 Oct 2014 15:29:56 -0400
Message-Id: <1413487800-7162-8-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To enter guest, primary hwtherad schedules the stopper func on
secondary threads and force them into NAP mode.
When exit to host,secondary threads hardcode to restore the stack,
then switch back to the stopper func, i.e host.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c            | 15 +++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ba258c8..4348abd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1486,6 +1486,21 @@ static void kvmppc_remove_runnable(struct kvmppc_vcore *vc,
 	list_del(&vcpu->arch.run_list);
 }
 
+#ifdef KVMPPC_ENABLE_SECONDARY
+
+extern void kvmppc_secondary_stopper_enter();
+
+static int kvmppc_secondary_stopper(void *data)
+{
+	int cpu =smp_processor_id();
+	struct paca_struct *lpaca = get_paca();
+	BUG_ON(!(cpu%thread_per_core));
+
+	kvmppc_secondary_stopper_enter();
+}
+
+#endif
+
 static int kvmppc_grab_hwthread(int cpu)
 {
 	struct paca_struct *tpaca;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index d5594b0..254038b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -349,7 +349,41 @@ kvm_do_nap:
 
 #ifdef PPCKVM_ENABLE_SECONDARY
 kvm_secondary_exit_trampoline:
+
+	/* all register is free to use, later kvmppc_secondary_stopper_exit set up them*/
+	//loop-wait for the primary to signal that host env is ready
+
+	LOAD_REG_ADDR(r5, kvmppc_secondary_stopper_exit)
+	/* fixme, load msr from lpaca stack */
+	li	r6, MSR_IR | MSR_DR
+	mtsrr0	r5
+	mtsrr1	r6
+	RFI
+
+_GLOBAL_TOC(kvmppc_secondary_stopper_enter)
+	mflr	r0
+	std	r0, PPC_LR_STKOFF(r1)
+	stdu	r1, -112(r1)
+
+	/* fixme: store other register such as msr */
+
+	/* prevent us to enter kernel */
+	li	r0, 1
+	stb	r0, HSTATE_HWTHREAD_REQ(r13)
+	/* tell the primary that we are ready */
+        li      r0,KVM_HWTHREAD_IN_KERNEL
+        stb     r0,HSTATE_HWTHREAD_STATE(r13)
+	nap
 	b	.
+
+/* enter with vmode */
+kvmppc_secondary_stopper_exit:
+	/* fixme, restore the stack which we store on lpaca */
+
+	ld	r0, 112+PPC_LR_STKOFF(r1)
+	addi	r1, r1, 112
+	mtlr	r0
+	blr
 #endif
 
 /******************************************************************************
-- 
1.8.3.1
