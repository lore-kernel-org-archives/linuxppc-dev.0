Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116]) by ozlabs.org (Postfix) with ESMTP id 851C767A86
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 10:09:44 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LN9dnj018760
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:09:39 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (72.155-200-80.adsl.skynet.be
	[80.200.155.72])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LN9Wju018726
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:09:32 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from localhost.localdomain (246tNt-laptop.lan.ayanami.246tNt.com
	[10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 1FF32110E1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 00:07:17 +0100 (CET)
Message-ID: <1.20050322_000905.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20050322_000905.tnt@patchsend.246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
Date: Tue, 22 Mar 2005 00:07:17 +0100 (CET)
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
---
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-21 20:09:24 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-21 20:09:24 +01:00
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
