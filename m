Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 47C7BDE0DC
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 05:53:49 +1100 (EST)
Date: Thu, 4 Jan 2007 19:53:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] schedule obsolete OSS drivers for removal, 3rd round
Message-ID: <20070104185353.GI20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, sailer@ife.ee.ethz.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch schedules obsolete OSS drivers (with ALSA drivers that support
the same hardware) for removal.

A rationale of the patch is in
  http://lkml.org/lkml/2006/12/18/305

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-By: Thomas Sailer <sailer@ife.ee.ethz.ch>

---

 Documentation/feature-removal-schedule.txt |    7 +++++++
 sound/oss/Kconfig                          |   16 +++++++++++++++-
 sound/oss/dmasound/Kconfig                 |    2 +-
 3 files changed, 23 insertions(+), 2 deletions(-)

--- linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt.old	2007-01-04 19:02:33.000000000 +0100
+++ linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt	2007-01-04 19:04:46.000000000 +0100
@@ -221,3 +221,10 @@
 Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
+
+What:  drivers depending on OBSOLETE_OSS
+When:  options in 2.6.22, code in 2.6.24
+Why:   OSS drivers with ALSA replacements
+Who:   Adrian Bunk <bunk@stusta.de>
+
+---------------------------
--- linux-2.6.20-rc2-mm1/sound/oss/Kconfig.old	2007-01-04 19:04:58.000000000 +0100
+++ linux-2.6.20-rc2-mm1/sound/oss/Kconfig	2007-01-04 19:07:30.000000000 +0100
@@ -5,6 +5,20 @@
 #
 # Prompt user for primary drivers.
 
+config OBSOLETE_OSS
+	bool "Obsolete OSS drivers"
+	depends on SOUND_PRIME
+	help
+	  This option enables support for obsolete OSS drivers that
+	  are scheduled for removal in the near future since there
+	  are ALSA drivers for the same hardware.
+
+	  Please contact Adrian Bunk <bunk@stusta.de> if you had to
+	  say Y here because your soundcard is not properly supported
+	  by ALSA.
+
+	  If unsure, say N.
+
 config SOUND_BT878
 	tristate "BT878 audio dma"
 	depends on SOUND_PRIME && PCI
@@ -33,7 +47,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
--- linux-2.6.20-rc2-mm1/sound/oss/dmasound/Kconfig.old	2007-01-04 19:07:04.000000000 +0100
+++ linux-2.6.20-rc2-mm1/sound/oss/dmasound/Kconfig	2007-01-04 19:07:28.000000000 +0100
@@ -14,7 +14,7 @@
 
 config DMASOUND_PMAC
 	tristate "PowerMac DMA sound support"
-	depends on PPC32 && PPC_PMAC && SOUND && I2C
+	depends on PPC32 && PPC_PMAC && SOUND && I2C && OBSOLETE_OSS
  	select DMASOUND
 	help
 	  If you want to use the internal audio of your PowerMac in Linux,
