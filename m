Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89C8967A5C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 05:02:46 +1000 (EST)
Message-Id: <20060528190131.137228000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Date: Sun, 28 May 2006 21:00:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 7/7] snd-aoa: wire up aoa in sound/
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the necessary Kconfig and Makefile hooks to make aoa
buildable inside the kernel tree.

--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -58,6 +58,8 @@ source "sound/pci/Kconfig"
 
 source "sound/ppc/Kconfig"
 
+source "sound/aoa/Kconfig"
+
 source "sound/arm/Kconfig"
 
 source "sound/mips/Kconfig"
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -4,7 +4,7 @@ #
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ aoa/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o

--
