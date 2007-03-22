Return-Path: <root@ganymede.vroon.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.vroon.org", Issuer "*.vroon.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7528DDFEC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 10:31:21 +1100 (EST)
From: Tony Vroon <chainsaw@gentoo.org>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2.6.22] PMU LED whitelisting of PowerMac 7,2 and 7,3
Message-Id: <20070322233108.C10435B80F1@ganymede.vroon.org>
Date: Thu, 22 Mar 2007 23:31:08 +0000 (GMT)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Redone with strcmp as requested by Paul Mackerras.
The necessary IDE-trigger functionality in the libata core has been ack'ed 
by Tejun Heo and will be in the next -mm release.

This allows the PMU LED on both a PowerMac 7,2 (Dual G5 2.0GHz, June 2003) 
and a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) to be controlled.
The physical LED is never off, unlike an iBook/PowerBook LED.
It is rather dim ("off") or very bright ("on").

Signed-off-by: Tony Vroon <chainsaw@gentoo.org>

--- linux-2.6/drivers/macintosh/via-pmu-led.c.orig	2007-03-22 20:16:54.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2007-03-22 20:18:26.000000000 +0000
@@ -124,7 +124,9 @@
 	if (model == NULL)
 		return -ENODEV;
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
-	    strncmp(model, "iBook", strlen("iBook")) != 0) {
+	    strncmp(model, "iBook", strlen("iBook")) != 0 &&
+	    strcmp(model, "PowerMac7,2") != 0 &&
+	    strcmp(model, "PowerMac7,3") != 0) {
 		of_node_put(dt);
 		/* ignore */
 		return -ENODEV;
