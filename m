Return-Path: <B13201@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EDE591007D6
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2012 20:57:31 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 3/3] KVM: PPC: epapr: install ev_idle hcall for e500 guest
Date: Thu, 5 Jan 2012 17:06:52 +0800
Message-ID: <1325754412-29963-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
References: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
 Liu Yu <yu.liu@freescale.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the guest hypervisor node contains "has-idle" property.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
v2:
1. move the idle code into assembly.
2. move the part that check "has-idle" into epapr code.

 arch/powerpc/include/asm/epapr_hcalls.h |    1 +
 arch/powerpc/include/asm/machdep.h      |    5 +++++
 arch/powerpc/kernel/epapr_para.c        |    4 ++++
 arch/powerpc/kernel/idle_e500.S         |   17 +++++++++++++++++
 arch/powerpc/kernel/kvm.c               |   24 ++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index c4b86e4..566805e 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -150,6 +150,7 @@
 
 extern u32 *epapr_hcall_insts;
 extern int epapr_hcall_insts_len;
+extern bool epapr_hcall_has_idle;
 
 static inline void epapr_get_hcall_insts(u32 **instp, int *lenp)
 {
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 47cacdd..7e56abf 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -255,6 +255,11 @@ extern void power4_idle(void);
 extern void power7_idle(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
+#ifdef CONFIG_KVM_GUEST
+extern void e500_ev_idle(unsigned long *, unsigned long *, unsigned long,
+                         unsigned long (*)(unsigned long *, unsigned long *,
+                                          unsigned long));
+#endif
 
 /*
  * ppc_md contains a copy of the machine description structure for the
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
index 714dcb3..1f37ddf 100644
--- a/arch/powerpc/kernel/epapr_para.c
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -22,6 +22,7 @@
 
 u32 *epapr_hcall_insts;
 int epapr_hcall_insts_len;
+bool epapr_hcall_has_idle;
 
 static int __init epapr_para_init(void)
 {
@@ -39,6 +40,9 @@ static int __init epapr_para_init(void)
 		epapr_hcall_insts_len = len;
 	}
 
+	if (of_get_property(hyper_node, "has-idle", NULL))
+		epapr_hcall_has_idle = true;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 3e2b95c..6ea95f0 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -85,6 +85,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
 2:	b	2b
 #endif /* !E500MC */
 
+#ifdef CONFIG_KVM_GUEST
+/*
+ * r3 contains the pointer to in[8]
+ * r4 contains the pointer to out[8]
+ * r5 contains the hcall vendor and nr
+ * r6 contains the handler which send hcall
+ */
+_GLOBAL(e500_ev_idle)
+	rlwinm	r7,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r8,TI_LOCAL_FLAGS(r7)	/* set napping bit */
+	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
+	stw	r8,TI_LOCAL_FLAGS(r7)	/* it will return to our caller */
+	wrteei	1
+	mtctr	r6
+	bctr
+#endif /* KVM_GUEST */
+
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
  * r2 containing physical address of current.
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 82a9137..8952e12 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -29,6 +29,7 @@
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/machdep.h>
 
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
@@ -578,6 +579,25 @@ static __init void kvm_free_tmp(void)
 	}
 }
 
+static void kvm_hcall_idle(void)
+{
+#ifdef CONFIG_KVM_E500
+	ulong in[8];
+	ulong out[8];
+
+	e500_ev_idle(in, out, HC_VENDOR_EPAPR | HC_EV_IDLE, kvm_hypercall);
+#endif
+}
+
+static bool kvm_para_has_idle(void)
+{
+#ifdef CONFIG_BOOKE
+	return epapr_hcall_has_idle;
+#else
+	return false;
+#endif
+}
+
 static int __init kvm_guest_init(void)
 {
 	if (!kvm_para_available())
@@ -594,6 +614,10 @@ static int __init kvm_guest_init(void)
 	powersave_nap = 1;
 #endif
 
+	/* Install hcall based power_save for guest kernel */
+	if (kvm_para_has_idle())
+		ppc_md.power_save = kvm_hcall_idle;
+
 free_tmp:
 	kvm_free_tmp();
 
-- 
1.6.4
