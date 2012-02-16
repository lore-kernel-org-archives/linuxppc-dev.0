Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C539A101334
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 20:31:06 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v4 3/3] KVM: PPC: epapr: install ev_idle hcall for e500 guest
Date: Thu, 16 Feb 2012 17:26:02 +0800
Message-ID: <1329384365-4028-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>,
 B07421@freescale.com
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
v4:
1. discard the CONFIG_E500 to make code for all powerpc platform
2. code cleanup

 arch/powerpc/kernel/epapr.S      |   29 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/epapr_para.c |   13 ++++++++++++-
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/epapr.S b/arch/powerpc/kernel/epapr.S
index 697b390..f06d636 100644
--- a/arch/powerpc/kernel/epapr.S
+++ b/arch/powerpc/kernel/epapr.S
@@ -15,6 +15,35 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
+#define HC_VENDOR_EPAPR		(1 << 16)
+#define HC_EV_IDLE		16
+
+_GLOBAL(epapr_ev_idle)
+epapr_ev_idle:
+	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
+	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+
+	wrteei	1
+
+idle_loop:
+	LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)
+
+.global epapr_ev_idle_start
+epapr_ev_idle_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+
+	/*
+	 * Guard against spurious wakeups (e.g. from a hypervisor) --
+	 * any real interrupt will cause us to return to LR due to
+	 * _TLF_NAPPING.
+	 */
+	b	idle_loop
+
 /* Hypercall entry point. Will be patched with device tree instructions. */
 .global epapr_hypercall_start
 epapr_hypercall_start:
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
index ea13cac..adee4f1 100644
--- a/arch/powerpc/kernel/epapr_para.c
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -20,6 +20,10 @@
 #include <linux/of.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/cacheflush.h>
+#include <asm/machdep.h>
+
+extern void epapr_ev_idle(void);
+extern u32 epapr_ev_idle_start[];
 
 bool epapr_para_enabled = false;
 
@@ -35,10 +39,17 @@ static int __init epapr_para_init(void)
 
 	insts = of_get_property(hyper_node, "hcall-instructions", &len);
 	if (!(len % 4) && (len >= (4 * 4))) {
-		for (i = 0; i < (len / 4); i++)
+		for (i = 0; i < (len / 4); i++) {
 			epapr_hypercall_start[i] = insts[i];
+			epapr_ev_idle_start[i] = insts[i];
+		}
 		flush_icache_range((ulong)epapr_hypercall_start,
 		                   (ulong)epapr_hypercall_start + len);
+		flush_icache_range((ulong)epapr_ev_idle_start,
+		                   (ulong)epapr_ev_idle_start + len);
+
+		if (of_get_property(hyper_node, "has-idle", NULL))
+			ppc_md.power_save = epapr_ev_idle;
 
 		epapr_para_enabled = true;
 	}
-- 
1.7.0.4
