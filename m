Return-Path: <B21989@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0C951007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 21:08:21 +1100 (EST)
Received: from mail68-am1 (localhost.localdomain [127.0.0.1])	by
	mail68-am1-R.bigfish.com (Postfix) with ESMTP id A33A51AF023C	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2010 10:08:18 +0000 (UTC)
Received: from AM1EHSMHS008.bigfish.com (unknown [10.3.201.248])	by
	mail68-am1.bigfish.com (Postfix) with ESMTP id 4AB181C88050	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2010 10:08:18 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oA3A8ED9014012	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 3 Nov 2010 03:08:14 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oA3APBuK004222	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 3 Nov 2010 05:25:12 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <akpm@linux-foundation.org>
Subject: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Wed, 3 Nov 2010 17:36:58 +0800
Message-ID: <1288777018-24259-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <b21989@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>, linux-kernel@vger.kernel.org,
	Alexandre Bounine <alexandre.bounine@idt.com>
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
 arch/powerpc/kernel/traps.c   |   14 +++++++++++++-
 arch/powerpc/sysdev/fsl_rio.c |   15 +++------------
 include/linux/rio.h           |    1 +
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a45a63c..2a5fb9d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -55,6 +55,7 @@
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
+#include <linux/rio.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -500,6 +501,13 @@ int machine_check_e500mc(struct pt_regs *regs)
 		       reason & MCSR_MEA ? "Effective" : "Physical", addr);
 	}
 
+	if (reason & MCSR_BUS_RBERR) {
+		printk("Bus - Read Data Bus Error\n");
+#ifdef CONFIG_RAPIDIO
+		recoverable = fsl_rio_mcheck_exception(regs);
+#endif
+	}
+
 	mtspr(SPRN_MCSR, mcsr);
 	return mfspr(SPRN_MCSR) == 0 && recoverable;
 }
@@ -527,8 +535,12 @@ int machine_check_e500(struct pt_regs *regs)
 		printk("Bus - Write Address Error\n");
 	if (reason & MCSR_BUS_IBERR)
 		printk("Bus - Instruction Data Error\n");
-	if (reason & MCSR_BUS_RBERR)
+	if (reason & MCSR_BUS_RBERR) {
 		printk("Bus - Read Data Bus Error\n");
+#ifdef CONFIG_RAPIDIO
+		fsl_rio_mcheck_exception(regs);
+#endif
+	}
 	if (reason & MCSR_BUS_WBERR)
 		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
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
diff --git a/include/linux/rio.h b/include/linux/rio.h
index bd6eb0e..685b18f 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -365,5 +365,6 @@ extern int rio_open_inb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_inb_mbox(struct rio_mport *, int);
 extern int rio_open_outb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_outb_mbox(struct rio_mport *, int);
+extern int fsl_rio_mcheck_exception(struct pt_regs *);
 
 #endif				/* LINUX_RIO_H */
-- 
1.6.4
