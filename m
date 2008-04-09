Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 37ADCDDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:13:01 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id ABAC0130D7E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 00:12:58 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3+oo6YUsFB1 for <linuxppc-dev@ozlabs.org>;
	Thu, 10 Apr 2008 00:12:56 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id DF26F130CFD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 00:12:56 +0200 (CEST)
Date: Thu, 10 Apr 2008 00:12:56 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc8540 : Fix restart
Message-ID: <20080409221256.GA927@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

	Previously, with the arch/ppc tree, mpc8540 boards could reboot.
	Now with the arch/powerpc tree, they can not anymore.
	Fix that.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

--- a/arch/powerpc/sysdev/fsl_soc.c	2008-03-21 14:53:41.000000000 +0000
+++ b/arch/powerpc/sysdev/fsl_soc.c	2008-03-26 12:08:25.000000000 +0000
@@ -1428,13 +1433,17 @@
 
 arch_initcall(setup_rstcr);
 
+extern void abort(void);
+
 void fsl_rstcr_restart(char *cmd)
 {
 	local_irq_disable();
 	if (rstcr)
 		/* set reset control register */
 		out_be32(rstcr, 0x2);	/* HRESET_REQ */
-
+	else
+		abort();
 	while (1) ;
+
 }
 #endif
