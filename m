Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 81D53DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 04:45:29 +1000 (EST)
Subject: Re: [PATCH] [ML403-AC97CR] Fix (device/driver) name registered
	with platform bus
From: Joachim Foerster <mls.JOFT@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1186849433.20835.33.camel@localhost>
References: <1186655810.7420.26.camel@localhost>
	<s5hsl6sws0s.wl%tiwai@suse.de>  <1186849433.20835.33.camel@localhost>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 20:45:22 +0200
Message-Id: <1187203522.1376.18.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

below, you'll find a very small patch: In the current state, platform
bus _never_ activates (= calls probe() callback on) the driver, because
the driver's name has a dash and the device's name has an underscore. I
made this horrible change _after_ I tested the final patch, which I
posted on Saturday. Sorry.

From: Joachim Foerster <JOFT@gmx.de>

Names inside struct platform_device and struct platform_driver seem to
need underscores instead of dashes.

(Patch for Linus' master branch, date 2007/08/08 _including_ my patches
sent on Saturday)

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 arch/ppc/syslib/virtex_devices.c |    2 +-
 sound/drivers/ml403-ac97cr.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index d0b04d6..9fa10b1 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -122,7 +122,7 @@
 }
 
 #define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
-	.name = "ml403-ac97cr", \
+	.name = "ml403_ac97cr", \
 	.id = num, \
 	.num_resources = 3, \
 	.resource = (struct resource[]) { \
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 2222315..2636249 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -66,7 +66,7 @@
 #include "pcm-indirect2.h"
 
 
-#define SND_ML403_AC97CR_DRIVER "ml403-ac97cr"
+#define SND_ML403_AC97CR_DRIVER "ml403_ac97cr"
 
 MODULE_AUTHOR("Joachim Foerster <JOFT@gmx.de>");
 MODULE_DESCRIPTION("Xilinx ML403 AC97 Controller Reference");
-- 
1.5.2.4
