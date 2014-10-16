Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 259531A0373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:12 +1100 (AEDT)
Received: by mail-ie0-f170.google.com with SMTP id rd18so2915193iec.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:11 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 08/11] powerpc: kvm: add a flag in vcore to sync primary with
 secondry hwthread
Date: Thu, 16 Oct 2014 15:29:57 -0400
Message-Id: <1413487800-7162-9-git-send-email-kernelfans@gmail.com>
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

The secondary thread can only jump back to host until primary has set
up the env. Add host_ready field in kvm_vcore to sync this action.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h     |  3 +++
 arch/powerpc/kernel/asm-offsets.c       |  3 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9a3355e..1310e03 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -305,6 +305,9 @@ struct kvmppc_vcore {
 	u32 arch_compat;
 	ulong pcr;
 	ulong dpdes;		/* doorbell state (POWER8) */
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	u8 host_ready;
+#endif
 	void *mpp_buffer; /* Micro Partition Prefetch buffer */
 	bool mpp_buffer_is_valid;
 };
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0faa8fe..9c04ac2 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -562,6 +562,9 @@ int main(void)
 	DEFINE(VCORE_LPCR, offsetof(struct kvmppc_vcore, lpcr));
 	DEFINE(VCORE_PCR, offsetof(struct kvmppc_vcore, pcr));
 	DEFINE(VCORE_DPDES, offsetof(struct kvmppc_vcore, dpdes));
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	DEFINE(VCORE_HOST_READY, offsetof(struct kvmppc_vcore, host_ready));
+#endif
 	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
 	DEFINE(VCPU_SLB_V, offsetof(struct kvmppc_slb, origv));
 	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 254038b..89ea16c 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -351,7 +351,11 @@ kvm_do_nap:
 kvm_secondary_exit_trampoline:
 
 	/* all register is free to use, later kvmppc_secondary_stopper_exit set up them*/
-	//loop-wait for the primary to signal that host env is ready
+	/* wait until the primary to set up host env */
+	ld	r5, HSTATE_KVM_VCORE(r13)
+	ld	r0, VCORE_HOST_READY(r5)
+	cmp	r0,  //primary is ready?
+	bne	kvm_secondary_exit_trampoline
 
 	LOAD_REG_ADDR(r5, kvmppc_secondary_stopper_exit)
 	/* fixme, load msr from lpaca stack */
@@ -1821,6 +1825,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 
+#ifdef PPCKVM_ENABLE_SECONDARY
+	/* signal the secondary that host env is ready */
+	li	r0, 1
+	stb	r0, VCORE_HOST_READY(r5)
+#endif
 	ld	r0, 112+PPC_LR_STKOFF(r1)
 	addi	r1, r1, 112
 	mtlr	r0
-- 
1.8.3.1
