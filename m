Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D683DDDDE0
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 22:50:32 +1100 (EST)
Subject: [PATCH] uninorth agp: don't mark module parameter __devinit
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 03:11:24 +0100
Message-Id: <1225246284.1369.31.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A module parameter can possibly be shown via sysfs, which isn't a good
idea if the section has been removed, so remove the __devinit
annotation.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Also fixes a section mismatch warning.

--- everything.orig/drivers/char/agp/uninorth-agp.c	2008-10-29 03:07:26.000000000 +0100
+++ everything/drivers/char/agp/uninorth-agp.c	2008-10-29 03:08:16.000000000 +0100
@@ -27,7 +27,7 @@
 static int uninorth_rev;
 static int is_u3;
 
-static char __devinitdata *aperture = NULL;
+static char *aperture = NULL;
 
 static int uninorth_fetch_size(void)
 {
