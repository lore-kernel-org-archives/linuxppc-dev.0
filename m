Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnK2bzbzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 33/46] powerpc/configs: Update for CONFIG_SND changes
Date: Wed, 23 Aug 2017 15:37:53 +1000
Message-Id: <1503466686-10932-34-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit eb3b705aaed9 ("ALSA: Make CONFIG_SND_OSSEMUL user-selectable")
means we need to set CONFIG_SND_OSSEMUL in our configs, otherwise we
lose some of the SND symbols.

And commit 0181307abc1d ("ALSA: seq: Reorganize kconfig and build")
reorganised things, which causes the churn.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/g5_defconfig       | 5 +++--
 arch/powerpc/configs/gamecube_defconfig | 5 +++--
 arch/powerpc/configs/pasemi_defconfig   | 3 ++-
 arch/powerpc/configs/pmac32_defconfig   | 7 ++++---
 arch/powerpc/configs/ppc64_defconfig    | 7 ++++---
 arch/powerpc/configs/ppc64e_defconfig   | 7 ++++---
 arch/powerpc/configs/ppc6xx_defconfig   | 7 ++++---
 arch/powerpc/configs/wii_defconfig      | 5 +++--
 8 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index e084fa548d73..063817fee61c 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -138,10 +138,11 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQUENCER_OSS=m
 CONFIG_SND_POWERMAC=m
 CONFIG_SND_AOA=m
 CONFIG_SND_AOA_FABRIC_LAYOUT=m
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index 79bbc8238b32..805b0f87653c 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -64,11 +64,12 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_CLUT224 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
-CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_SND_VERBOSE_PROCFS is not set
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 8cf4a46bef86..6daa56f8895c 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -115,9 +115,10 @@ CONFIG_VGACON_SOFT_SCROLLBACK=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
+CONFIG_SND_SEQUENCER=y
 CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_USB_AUDIO=y
 CONFIG_SND_USB_USX2Y=y
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 8e798b1fbc99..1aab9a62a681 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -227,11 +227,12 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_SEQUENCER_OSS=m
 CONFIG_SND_DUMMY=m
 CONFIG_SND_POWERMAC=m
 CONFIG_SND_AOA=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 3a1697f97fef..8b8ee9e83010 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -220,11 +220,12 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_SEQUENCER_OSS=m
 CONFIG_SND_POWERMAC=m
 CONFIG_SND_AOA=m
 CONFIG_SND_AOA_FABRIC_LAYOUT=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index d0fe0f8f77c2..41d85cb3c9a2 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -141,11 +141,12 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_SEQUENCER_OSS=m
 CONFIG_HID_DRAGONRISE=y
 CONFIG_HID_GYRATION=y
 CONFIG_HID_TWINHAN=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index ef817c7e83d4..60ccfa966ea9 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -793,17 +793,18 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_DYNAMIC_MINORS=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_DEBUG_VERBOSE=y
 CONFIG_SND_PCM_XRUN_DEBUG=y
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_SEQUENCER_OSS=m
 CONFIG_SND_DUMMY=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_MTPAV=m
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index aef41b17a8bc..9c7400a19e9d 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -79,11 +79,12 @@ CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
-CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_SND_VERBOSE_PROCFS is not set
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
-- 
2.7.4
