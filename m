Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 116CD2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:25:27 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 4/5] arch/powerpc/boot/dts pcm030 add mpc5200-soc-audio node
Date: Tue, 11 Sep 2012 22:14:48 -0400
Message-Id: <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Describe the audio codec on the pcm030 baseboard.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 arch/powerpc/boot/dts/pcm030.dts |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 9e35499..e9475e9 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -59,7 +59,7 @@
 			#gpio-cells = <2>;
 		};
 
-		psc@2000 { /* PSC1 in ac97 mode */
+		audio_platform: psc@2000 { /* PSC1 in ac97 mode */
 			compatible = "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
 			cell-index = <0>;
 		};
@@ -134,4 +134,25 @@
 	localbus {
 		status = "disabled";
 	};
+
+	sound {
+		compatible = "fsl,mpc5200b-soc-audio","fsl,mpc5200-soc-audio";
+		card-name = "pcm030";
+		audio-platform = <&audio_platform>;
+		number-of-dais = <2>;
+
+		analog@0 {
+			stream-name = "AC97 Analog";
+			codec-name = "wm9712-codec.0";
+			codec-dai-name = "wm9712-hifi";
+			cpu-dai-name = "mpc5200-psc-ac97.0";
+		};
+
+		digital@1 {
+			stream-name = "AC97 IEC958";
+			codec-name = "wm9712-codec.0";
+			codec-dai-name = "wm9712-aux";
+			cpu-dai-name = "mpc5200-psc-ac97.0";
+		};
+	};
 };
-- 
1.7.2.5
