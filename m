Return-Path: <Bob.Burke@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2CB36B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 23:45:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] PowerPC 440EPx: Sequoia bootwrapper 
Date: Tue, 21 Jul 2009 09:33:20 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC2B@hermes.terascala.com>
From: "Bob Burke" <Bob.Burke@terascala.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The system clock frequency on the Sequoia board is 33.000000 MHz not
33.333333 MHz; this causes the system time to drift more than 30 seconds
per hour.

diff -ruN a/arch/powerpc/boot/cuboot-sequoia.c
b/arch/powerpc/boot/cuboot-sequoia.c
--- a/arch/powerpc/boot/cuboot-sequoia.c        2009-05-18
19:52:34.000000000 -0400
+++ b/arch/powerpc/boot/cuboot-sequoia.c        2009-07-21
09:13:13.000000000 -0400
@@ -37,7 +37,7 @@

 static void sequoia_fixups(void)
 {
-       unsigned long sysclk =3D 33333333;
+       unsigned long sysclk =3D 33000000;

        ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
        ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
