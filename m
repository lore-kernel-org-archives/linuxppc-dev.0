Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4C052C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 22:07:25 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>
Subject: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
Date: Thu, 14 Nov 2013 19:07:08 +0800
Message-ID: <1384427230-979-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux@arm.linux.org.uk, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lgirdwood@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches need to be applied into one single tree because
the second patch depends on the first one. Without it, SSI would playback
constant noise to the right channel when playback monaural audio files on
i.MX6 Series board.

We might also need to apply the iomux change to the other i.MX platforms,
just currently I don't have those boards so I drop their changes for now.

Nicolin Chen (2):
  ARM: dts: imx: specify the value of audmux pinctrl instead of
    0x80000000
  ASoC: fsl_ssi: Add monaural audio support for non-ac97 interface

 arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
 sound/soc/fsl/fsl_ssi.c        | 22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
1.8.4
