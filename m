To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Permedia2 fb on PPC
Reply-To: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 05 Dec 2001 11:29:18 +0100
Message-ID: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I'm forwarding this from linux-kernel, per Tom Rini request. Could
anyone with a previously working Permedia2 test this patch and tell me
if this breaks something. You can also scream if it works ;-)]

Hi all,

The following patchlet allows the Permedia2 framebuffer to work
properly on power-pc (instead of crashing the machine...).

This has been tested with a PCI Formac Promedia3D (aka formacGA8) on a
PowerMac 7500 (with a G3 card, if that matters...).

Patch is against 2.4.16, but should apply to any recent 2.[45] kernel.

        M.

--- drivers/video/pm2fb.c.orig	Fri Sep 14 22:44:49 2001
+++ drivers/video/pm2fb.c	Tue Dec  4 20:44:18 2001
@@ -48,7 +48,7 @@
 #error	"The endianness of the target host has not been defined."
 #endif

-#if defined(__BIG_ENDIAN) && !defined(__sparc__)
+#if defined(__BIG_ENDIAN) && !defined(__sparc__) && (!defined(CONFIG_PPC) || defined(CONFIG_FB_PM2_CVPPC))
 #define PM2FB_BE_APERTURE
 #endif


--
Places change, faces change. Life is so very strange.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
