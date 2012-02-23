Return-Path: <B13201@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F3D5B6FD4
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 20:27:57 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v6 3/4] KVM: PPC: epapr: install ev_idle hcall for e500 guest
Date: Thu, 23 Feb 2012 17:22:21 +0800
Message-ID: <1329988942-19610-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329988942-19610-2-git-send-email-yu.liu@freescale.com>
References: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
 <1329988942-19610-2-git-send-email-yu.liu@freescale.com>
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
v6:
reuse the EV_IDLE definition

 arch/powerpc/include/asm/epapr_hcalls.h |   11 ++++++-----
 arch/powerpc/kernel/epapr_hcalls.S      |   27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/epapr_paravirt.c    |   11 ++++++++++-
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index 2173d4c..78460ac 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -50,10 +50,6 @@
 #ifndef _EPAPR_HCALLS_H
 #define _EPAPR_HCALLS_H
 
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <asm/byteorder.h>
-
 #define EV_BYTE_CHANNEL_SEND		1
 #define EV_BYTE_CHANNEL_RECEIVE		2
 #define EV_BYTE_CHANNEL_POLL		3
@@ -108,6 +104,11 @@
 #define EV_UNIMPLEMENTED	12	/* Unimplemented hypercall */
 #define EV_BUFFER_OVERFLOW	13	/* Caller-supplied buffer too small */
 
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/byteorder.h>
+
 /*
  * Hypercall register clobber list
  *
@@ -500,5 +501,5 @@ static inline unsigned int ev_idle(void)
 
 	return r3;
 }
-
+#endif /* !__ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 697b390..bf643ed 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -8,6 +8,7 @@
  */
 
 #include <linux/threads.h>
+#include <asm/epapr_hcalls.h>
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/cputable.h>
@@ -15,6 +16,32 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
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
+	LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
+
+.global epapr_ev_idle_start
+epapr_ev_idle_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+
+	/*
+	 * Guard against spurious wakeups from a hypervisor --
+	 * only interrupt will cause us to return to LR due to
+	 * _TLF_NAPPING.
+	 */
+	b	idle_loop
+
 /* Hypercall entry point. Will be patched with device tree instructions. */
 .global epapr_hypercall_start
 epapr_hypercall_start:
diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index 45eb439..c3e6e25 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -21,6 +21,10 @@
 #include <asm/epapr_hcalls.h>
 #include <asm/cacheflush.h>
 #include <asm/code-patching.h>
+#include <asm/machdep.h>
+
+extern void epapr_ev_idle(void);
+extern u32 epapr_ev_idle_start[];
 
 bool epapr_paravirt_enabled;
 
@@ -39,8 +43,13 @@ static int __init epapr_paravirt_init(void)
 		return 0;
 
 	if (!(len % 4) && len <= (4 * 4)) {
-		for (i = 0; i < (len / 4); i++)
+		for (i = 0; i < (len / 4); i++) {
 			patch_instruction(epapr_hypercall_start + i, insts[i]);
+			patch_instruction(epapr_ev_idle_start + i, insts[i]);
+		}
+
+		if (of_get_property(hyper_node, "has-idle", NULL))
+			ppc_md.power_save = epapr_ev_idle;
 
 		epapr_paravirt_enabled = true;
 	} else {
-- 
1.7.0.4
