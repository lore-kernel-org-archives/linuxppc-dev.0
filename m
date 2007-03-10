Return-Path: <root@ganymede.vroon.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.vroon.org", Issuer "*.vroon.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DFB95DDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 11:12:56 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by ganymede.vroon.org (Postfix) with ESMTP id 0BB8D5B810B
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 00:01:30 +0000 (GMT)
From: Tony Vroon <chainsaw@gentoo.org>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Allow PMU LED control on PowerMac 7,3
Message-Id: <20070310000123.69D7D5B810D@ganymede.vroon.org>
Date: Sat, 10 Mar 2007 00:01:23 +0000 (GMT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows the PMU LED on a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) to be 
controlled. The physical LED is never off, unlike an iBook/PowerBook LED.
It is rather dim ("off") or very bright ("on").
Unfortunately the SATA controller in this machine does not (currently?) 
work with the IDE trigger of the LED subsystem, but that is not a PMU problem.

Signed-off-by: Tony Vroon <chainsaw@gentoo.org>

--- linux-2.6/drivers/macintosh/via-pmu-led.c.orig	2007-03-09 22:38:31.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2007-03-09 23:01:21.000000000 +0000
@@ -124,7 +124,8 @@
 	if (model == NULL)
 		return -ENODEV;
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
-	    strncmp(model, "iBook", strlen("iBook")) != 0) {
+	    strncmp(model, "iBook", strlen("iBook")) != 0 &&
+	    strncmp(model, "PowerMac7,3", strlen("PowerMac7,3")) != 0) {
 		of_node_put(dt);
 		/* ignore */
 		return -ENODEV;
