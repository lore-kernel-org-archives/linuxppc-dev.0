Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1D4E2BF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 05:35:56 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1103739194.5316.1.camel@gaston>
References: <1103739194.5316.1.camel@gaston>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 19:35:13 +0100
Message-Id: <1103740513.29974.0.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-12-22 at 19:13 +0100, Benjamin Herrenschmidt wrote:
> This patch (which will be send upstream separately by the Alsa folks) fixes
> an signed vs. unsigned char problem in Alsa which was the cause of the Oops
> people were experiencing on ppc with OSS emulation and possibly other issues.

Ok, actually, the one that will be commited upstream is a bit different,
here it is:


Summary: [ALSA] Fix the wrong sign of format data entries

Fix suggested by Benjamin Herrenschmidt <benh@kernel.crashing.org>

On architectures like PPC, char is handled as "unsigned char", thus the
pcm_format_data table entries with -1 give a positive 255.  This causes
Oops with OSS-emulation on such architectures.

The patch simply adds the right signed/unsigned prefix to fix this problem.


Signed-off-by: Takashi Iwai <tiwai@suse.de>


--- linux/sound/core/pcm_misc.c 8 Jun 2004 16:57:28 -0000       1.12
+++ linux/sound/core/pcm_misc.c 22 Dec 2004 18:07:29 -0000      1.14
@@ -25,11 +25,14 @@
 #include <sound/pcm.h>
 #define SND_PCM_FORMAT_UNKNOWN (-1)
 
+/* NOTE: "signed" prefix must be given below since the default char is
+ *       unsigned on some architectures!
+ */
 struct pcm_format_data {
-       char width;     /* bit width */
-       char phys;      /* physical bit width */
-       char le;        /* 0 = big-endian, 1 = little-endian, -1 = others */
-       char signd;     /* 0 = unsigned, 1 = signed, -1 = others */
+       unsigned char width;    /* bit width */
+       unsigned char phys;     /* physical bit width */
+       signed char le; /* 0 = big-endian, 1 = little-endian, -1 = others */
+       signed char signd;      /* 0 = unsigned, 1 = signed, -1 = others */
        unsigned char silence[8];       /* silence data to fill */
 };
