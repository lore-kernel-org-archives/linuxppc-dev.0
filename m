Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6084DDF81
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:14:24 +1000 (EST)
Subject: [PATCH] remove awacs dmasound
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 07:39:29 +0200
Message-Id: <1178084369.13233.20.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch kills the obsolete awacs dmasound because it is in
the way of doing power management improvements since it uses
ancient API.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adrian Bunk <bunk@stusta.de>

---
This patch contains only the patch for the first two files here, please
remove the other ones manually:

git rm -- sound/oss/dmasound/awacs_defs.h
git rm -- sound/oss/dmasound/dac3550a.c
git rm -- sound/oss/dmasound/dmasound_awacs.c
git rm -- sound/oss/dmasound/tas3001c.c
git rm -- sound/oss/dmasound/tas3001c.h
git rm -- sound/oss/dmasound/tas3001c_tables.c
git rm -- sound/oss/dmasound/tas3004.c
git rm -- sound/oss/dmasound/tas3004.h
git rm -- sound/oss/dmasound/tas3004_tables.c
git rm -- sound/oss/dmasound/tas_common.c
git rm -- sound/oss/dmasound/tas_common.h
git rm -- sound/oss/dmasound/tas_eq_prefs.h
git rm -- sound/oss/dmasound/tas_ioctl.h
git rm -- sound/oss/dmasound/trans_16.c

 sound/oss/dmasound/Kconfig           |   14 
 sound/oss/dmasound/Makefile          |    6 
 sound/oss/dmasound/awacs_defs.h      |  251 --
 sound/oss/dmasound/dac3550a.c        |  209 --
 sound/oss/dmasound/dmasound_awacs.c  | 3215 -----------------------------------
 sound/oss/dmasound/tas3001c.c        |  849 ---------
 sound/oss/dmasound/tas3001c.h        |   64 
 sound/oss/dmasound/tas3001c_tables.c |  375 ----
 sound/oss/dmasound/tas3004.c         | 1138 ------------
 sound/oss/dmasound/tas3004.h         |   77 
 sound/oss/dmasound/tas3004_tables.c  |  301 ---
 sound/oss/dmasound/tas_common.c      |  214 --
 sound/oss/dmasound/tas_common.h      |  284 ---
 sound/oss/dmasound/tas_eq_prefs.h    |   24 
 sound/oss/dmasound/tas_ioctl.h       |   24 
 sound/oss/dmasound/trans_16.c        |  898 ---------
 16 files changed, 7943 deletions(-)


--- wireless-dev.orig/sound/oss/dmasound/Makefile	2007-05-01 11:35:44.664734191 +0200
+++ wireless-dev/sound/oss/dmasound/Makefile	2007-05-01 11:36:26.054734191 +0200
@@ -2,12 +2,6 @@
 # Makefile for the DMA sound driver
 #
 
-dmasound_pmac-y			+= dmasound_awacs.o \
-				   trans_16.o dac3550a.o tas_common.o \
-				   tas3001c.o tas3001c_tables.o \
-				   tas3004.o tas3004_tables.o
-
 obj-$(CONFIG_DMASOUND_ATARI)	+= dmasound_core.o dmasound_atari.o
-obj-$(CONFIG_DMASOUND_PMAC)	+= dmasound_core.o dmasound_pmac.o
 obj-$(CONFIG_DMASOUND_PAULA)	+= dmasound_core.o dmasound_paula.o
 obj-$(CONFIG_DMASOUND_Q40)	+= dmasound_core.o dmasound_q40.o
--- wireless-dev.orig/sound/oss/dmasound/Kconfig	2007-05-01 11:35:45.144734191 +0200
+++ wireless-dev/sound/oss/dmasound/Kconfig	2007-05-01 11:36:26.094734191 +0200
@@ -12,20 +12,6 @@ config DMASOUND_ATARI
 	  want). If you want to compile it as a module, say M here and read
 	  <file:Documentation/kbuild/modules.txt>.
 
-config DMASOUND_PMAC
-	tristate "PowerMac DMA sound support"
-	depends on PPC32 && PPC_PMAC && SOUND && I2C && OBSOLETE_OSS
- 	select DMASOUND
-	help
-	  If you want to use the internal audio of your PowerMac in Linux,
-	  answer Y to this question. This will provide a Sun-like /dev/audio,
-	  compatible with the Linux/i386 sound system. Otherwise, say N.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/kbuild/modules.txt>.
-
 config DMASOUND_PAULA
 	tristate "Amiga DMA sound support"
 	depends on (AMIGA || APUS) && SOUND
