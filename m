Return-Path: <tnt@246tNt.com>
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.2.69]) by ozlabs.org (Postfix) with ESMTP id B825E67A79
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 09:47:53 +1000 (EST)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2QNledE028520
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Mar 2005 00:47:41 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <1.20050327_004704.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20050327_004704.tnt@patchsend.246tNt.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
Date: Sun, 27 Mar 2005 00:45:13 +0100 (CET)
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/6] ppc32: Remove unnecessary test in MPC52xx reset code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Remove unnecessary test in MPC52xx reset code

That test is part of an old version of the code and
erroneously made it to mainstream.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:55:53 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:55:53 +01:00
@@ -46,11 +46,8 @@
 
 	/* Turn on the watchdog and wait for it to expire. It effectively
 	  does a reset */
-	if (gpt0 != NULL) {
-		out_be32(&gpt0->count, 0x000000ff);
-		out_be32(&gpt0->mode, 0x00009004);
-	} else
-		printk(KERN_ERR "mpc52xx_restart: Unable to ioremap GPT0 registers, -> looping ...");
+	out_be32(&gpt0->count, 0x000000ff);
+	out_be32(&gpt0->mode, 0x00009004);
 
 	while (1);
 }
