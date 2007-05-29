Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E995DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 12:37:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4T2bNEJ001803
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 19:37:28 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4T2bLWi007699
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:37:22 -0500 (CDT)
Subject: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1180406209.8139.13.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 29 May 2007 10:36:49 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the e500 v2 core reset bug.
For e500 v2 core, a new reset control register is added to
reset the core.
On 85xx CDS board with e500 v2 core, normal reboot code will 
induce DDR block in u-boot. This patch fixes this bug. It is 
also tested on legacy e500 v1 core. 


Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---

 arch/powerpc/platforms/85xx/misc.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/platforms/85xx/misc.c
index 3e62fcb..886a13f 100644
--- a/arch/powerpc/platforms/85xx/misc.c
+++ b/arch/powerpc/platforms/85xx/misc.c
@@ -13,11 +13,29 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <asm/irq.h>
+#include <asm/io.h>
+#include <sysdev/fsl_soc.h>
+
+static __be32 __iomem *rstcr;
 
 extern void abort(void);
 
+static int __init mpc85xx_rstcr(void)
+{
+	/* map reset control register */
+	rstcr = ioremap(get_immrbase() + 0xE00B0, 0xff);
+	return 0;
+}
+
+arch_initcall(mpc85xx_rstcr);
+
 void mpc85xx_restart(char *cmd)
 {
 	local_irq_disable();
+	if (rstcr)
+		/* set reset control register */
+		out_be32(rstcr, 0x2);	/* HRESET_REQ */
+	else
+		printk (KERN_EMERG "Error: reset control register not mapped, spinning!\n");
 	abort();
 }
-- 
1.5.1
