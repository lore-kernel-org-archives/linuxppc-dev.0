Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82F462BF07
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 05:14:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 19:13:13 +0100
Message-Id: <1103739194.5316.1.camel@gaston>
Mime-Version: 1.0
Subject: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch (which will be send upstream separately by the Alsa folks) fixes
an signed vs. unsigned char problem in Alsa which was the cause of the Oops
people were experiencing on ppc with OSS emulation and possibly other issues.

Index: linux-work/sound/core/pcm_misc.c
===================================================================
--- linux-work.orig/sound/core/pcm_misc.c	2004-11-22 01:51:09.000000000 +0100
+++ linux-work/sound/core/pcm_misc.c	2004-12-22 19:11:26.297518336 +0100
@@ -26,10 +26,10 @@
 #define SND_PCM_FORMAT_UNKNOWN (-1)
 
 struct pcm_format_data {
-	char width;	/* bit width */
-	char phys;	/* physical bit width */
-	char le;	/* 0 = big-endian, 1 = little-endian, -1 = others */
-	char signd;	/* 0 = unsigned, 1 = signed, -1 = others */
+	signed char width;	/* bit width */
+	signed char phys;	/* physical bit width */
+	signed char le;		/* 0 = big-endian, 1 = little-endian, -1 = others */
+	signed char signd;	/* 0 = unsigned, 1 = signed, -1 = others */
 	unsigned char silence[8];	/* silence data to fill */
 };
 
