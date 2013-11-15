Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78A1E2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 17:49:51 +1100 (EST)
Date: Fri, 15 Nov 2013 14:40:09 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx: specify the value of audmux pinctrl
 instead of 0x80000000
Message-ID: <20131115064009.GD745@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-2-git-send-email-b42378@freescale.com>
 <20131115064159.GG11014@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131115064159.GG11014@S2101-09.ap.freescale.net>
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

On Fri, Nov 15, 2013 at 02:42:01PM +0800, Shawn Guo wrote:
> On Thu, Nov 14, 2013 at 07:07:09PM +0800, Nicolin Chen wrote:
> > We must specify the value of audmux pinctrl if we want to use pinctrl_pm().
> > Thus change bypass value 0x80000000 to what we exactly need.
> > 
> > This patch also seperately unset PUE bit for TXD so that IOMUX won't pull
> > up/down the pin after turning into tristate. When we use SSI normal mode to
> > playback monaural audio via I2S signal, there'd be a pulled curve occur to
> > its signal at the second slot if setting PUE bit for TXD. And it will make
> > the second channel to play a constant noise. So by keeping the signal level
> > in the second slot, we can get a constant high level signal (-1) or a low
> > level one (0).
> > 
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> We have moved all pin groups settings into
> arch/arm/boot/dts/imx6qdl-pingrp.h.  I just rebased and applied the
> patch.  Please check my imx/dt branch and ensure I applied the changes
> correctly.

Simply perfect. Thank you.
Nicolin

---
