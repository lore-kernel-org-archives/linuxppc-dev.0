Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E2F267B41
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 23:06:05 +1000 (EST)
Message-Id: <20060601115850.518169000@sipsolutions.net>
References: <20060601115844.343214000@sipsolutions.net>
Date: Thu, 01 Jun 2006 13:58:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 7/8] snd-aoa: add Kconfig and Makefile
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

This patch adds the simple Kconfig and Makefile files for aoa.

--- /dev/null
+++ b/sound/aoa/Kconfig
@@ -0,0 +1,17 @@
+menu "Apple Onboard Audio driver"
+	depends on SND != n && PPC
+
+config SND_AOA
+	tristate "Apple Onboard Audio driver"
+	depends on SOUND && SND_PCM && EXPERIMENTAL
+	---help---
+	This option enables the new driver for the various
+	Apple Onboard Audio components.
+
+source "sound/aoa/fabrics/Kconfig"
+
+source "sound/aoa/codecs/Kconfig"
+
+source "sound/aoa/soundbus/Kconfig"
+
+endmenu
--- /dev/null
+++ b/sound/aoa/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_SND_AOA) += core/
+obj-$(CONFIG_SND_AOA) += codecs/
+obj-$(CONFIG_SND_AOA) += fabrics/
+obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/

--
