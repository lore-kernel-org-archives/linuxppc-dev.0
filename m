Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 826AD1A0387
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:03 +1100 (AEDT)
Received: by mail-ie0-f170.google.com with SMTP id rd18so2915011iec.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:01 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 06/11] powerpc: kvm: introduce online in paca to indicate
 whether cpu is needed by host
Date: Thu, 16 Oct 2014 15:29:55 -0400
Message-Id: <1413487800-7162-7-git-send-email-kernelfans@gmail.com>
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

Nowadays, powerKVM runs with secondary hwthread offline. Although
we can make all secondary hwthread online later, we still preserve
this behavior for dedicated KVM env. Achieve this by setting
paca->online as false.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h         |  3 +++
 arch/powerpc/kernel/asm-offsets.c       |  3 +++
 arch/powerpc/kernel/smp.c               |  3 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 12 ++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index a5139ea..67c2500 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -84,6 +84,9 @@ struct paca_struct {
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
 	u8 kexec_state;		/* set when kexec down has irqs off */
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	u8 online;
+#endif
 #ifdef CONFIG_PPC_STD_MMU_64
 	struct slb_shadow *slb_shadow_ptr;
 	struct dtl_entry *dispatch_log;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9d7dede..0faa8fe 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -182,6 +182,9 @@ int main(void)
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
 	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	DEFINE(PACAONLINE, offsetof(struct paca_struct, online));
+#endif
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
 	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a0738af..4c3843e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -736,6 +736,9 @@ void start_secondary(void *unused)
 
 	cpu_startup_entry(CPUHP_ONLINE);
 
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	get_paca()->online = true;
+#endif 
 	BUG();
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f0c4db7..d5594b0 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -322,6 +322,13 @@ kvm_no_guest:
 	li	r0, KVM_HWTHREAD_IN_NAP
 	stb	r0, HSTATE_HWTHREAD_STATE(r13)
 kvm_do_nap:
+#ifdef PPCKVM_ENABLE_SECONDARY
+	/* check the cpu is needed by host or not */
+	ld      r2, PACAONLINE(r13)
+	ld      r3, 0
+	cmp     r2, r3
+	bne     kvm_secondary_exit_trampoline
+#endif
 	/* Clear the runlatch bit before napping */
 	mfspr	r2, SPRN_CTRLF
 	clrrdi	r2, r2, 1
@@ -340,6 +347,11 @@ kvm_do_nap:
 	nap
 	b	.
 
+#ifdef PPCKVM_ENABLE_SECONDARY
+kvm_secondary_exit_trampoline:
+	b	.
+#endif
+
 /******************************************************************************
  *                                                                            *
  *                               Entry code                                   *
-- 
1.8.3.1
