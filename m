Return-Path: <shawn.guo@linaro.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FBC12C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 14:01:38 +1100 (EST)
Date: Fri, 15 Nov 2013 11:02:49 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
Message-ID: <20131115030247.GC11014@S2101-09.ap.freescale.net>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1384427230-979-1-git-send-email-b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux@arm.linux.org.uk, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, swarren@wwwdotorg.org,
 timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 14, 2013 at 07:07:08PM +0800, Nicolin Chen wrote:
> This series of patches need to be applied into one single tree because
> the second patch depends on the first one. Without it, SSI would playback
> constant noise to the right channel when playback monaural audio files on
> i.MX6 Series board.

Let me try to understand if the dependency is true.

Saying I apply the DTS patch on IMX tree while Mark apply the fsl_ssi
patch on his tree, will there be any regression on either IMX tree or
Mark's tree?  The monaural playback on imx6qdl never worked, so it's not
a regression.  If there is no regression on either tree, there is no
dependency to maintain.

Shawn

> 
> We might also need to apply the iomux change to the other i.MX platforms,
> just currently I don't have those boards so I drop their changes for now.
> 
> Nicolin Chen (2):
>   ARM: dts: imx: specify the value of audmux pinctrl instead of
>     0x80000000
>   ASoC: fsl_ssi: Add monaural audio support for non-ac97 interface
> 
>  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
>  sound/soc/fsl/fsl_ssi.c        | 22 +++++++++++++++++++---
>  2 files changed, 30 insertions(+), 14 deletions(-)
> 
> -- 
> 1.8.4
> 
> 
