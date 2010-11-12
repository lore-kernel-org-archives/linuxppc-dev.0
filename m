Return-Path: <B21989@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B76CCB70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 19:29:01 +1100 (EST)
Received: from mail51-tx2 (localhost.localdomain [127.0.0.1])	by
	mail51-tx2-R.bigfish.com (Postfix) with ESMTP id 93651184812D	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2010 08:28:56 +0000 (UTC)
Received: from TX2EHSMHS017.bigfish.com (unknown [10.9.14.252])	by
	mail51-tx2.bigfish.com (Postfix) with ESMTP id 342181C60050	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2010 08:28:56 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAC8UAUM009819	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2010 01:30:10 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAC8j0XF014846	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 02:45:00 -0600 (CST)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v3] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Fri, 12 Nov 2010 15:55:20 +0800
Message-ID: <1289548520-24110-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <b21989@freescale.com>, Kumar Gala <kumar.gala@freescale.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaohui Xie <b21989@freescale.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/powerpc/include/asm/rio.h |    5 +++++
 arch/powerpc/kernel/traps.c    |   17 ++++++++++++++++-
 arch/powerpc/sysdev/fsl_rio.c  |   15 +++------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/rio.h b/arch/powerpc/include/asm/rio.h
index 0018bf8..3b16364 100644
--- a/arch/powerpc/include/asm/rio.h
+++ b/arch/powerpc/include/asm/rio.h
@@ -14,5 +14,10 @@
 #define ASM_PPC_RIO_H
 
 extern void platform_rio_init(void);
+#ifdef CONFIG_RAPIDIO
+extern int fsl_rio_mcheck_exception(struct pt_regs *);
+#else
+static inline int fsl_rio_mcheck_exception(struct pt_regs *regs){return 0;}
+#endif
 
 #endif				/* ASM_PPC_RIO_H */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a45a63c..9ab7b97 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -55,6 +55,7 @@
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
+#include <asm/rio.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -425,6 +426,12 @@ int machine_check_e500mc(struct pt_regs *regs)
 	unsigned long reason = mcsr;
 	int recoverable = 1;
 
+	if (reason & MCSR_BUS_RBERR) {
+		recoverable = fsl_rio_mcheck_exception(regs);
+		if (recoverable == 1)
+			goto silent_out;
+	}
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -500,6 +507,7 @@ int machine_check_e500mc(struct pt_regs *regs)
 		       reason & MCSR_MEA ? "Effective" : "Physical", addr);
 	}
 
+silent_out:
 	mtspr(SPRN_MCSR, mcsr);
 	return mfspr(SPRN_MCSR) == 0 && recoverable;
 }
@@ -507,6 +515,13 @@ int machine_check_e500mc(struct pt_regs *regs)
 int machine_check_e500(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
+	int ret = 0;
+
+	if (reason & MCSR_BUS_RBERR) {
+		ret = fsl_rio_mcheck_exception(regs);
+		if (ret == 1)
+			return ret;
+	}
 
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
@@ -536,7 +551,7 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
 
-	return 0;
+	return ret;
 }
 #elif defined(CONFIG_E200)
 int machine_check_e200(struct pt_regs *regs)
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 1143c93..a9bc1e8 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -256,9 +256,7 @@ struct rio_priv {
 static void __iomem *rio_regs_win;
 
 #ifdef CONFIG_E500
-static int (*saved_mcheck_exception)(struct pt_regs *regs);
-
-static int fsl_rio_mcheck_exception(struct pt_regs *regs)
+int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *entry = NULL;
 	unsigned long reason = mfspr(SPRN_MCSR);
@@ -280,11 +278,9 @@ static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 		}
 	}
 
-	if (saved_mcheck_exception)
-		return saved_mcheck_exception(regs);
-	else
-		return cur_cpu_spec->machine_check(regs);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(fsl_rio_mcheck_exception);
 #endif
 
 /**
@@ -1534,11 +1530,6 @@ int fsl_rio_setup(struct platform_device *dev)
 	fsl_rio_doorbell_init(port);
 	fsl_rio_port_write_init(port);
 
-#ifdef CONFIG_E500
-	saved_mcheck_exception = ppc_md.machine_check_exception;
-	ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
-#endif
-
 	return 0;
 err:
 	iounmap(priv->regs_win);
-- 
1.6.4
