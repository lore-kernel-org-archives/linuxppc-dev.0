Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A55E2C0164
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 12:27:21 +1000 (EST)
Date: Thu, 15 Aug 2013 10:18:23 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130815021823.GA1846@MrMyself>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
 <20130814032658.GA16915@S2101-09.ap.freescale.net>
 <20130814053016.GF31651@MrMyself>
 <20130814063931.GB31141@S2101-09.ap.freescale.net>
 <20130814063444.GG31651@MrMyself>
 <20130814081445.GC31141@S2101-09.ap.freescale.net>
 <520BA687.4030905@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <520BA687.4030905@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com,
 broonie@kernel.org, p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 Fabio Estevam <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

On Wed, Aug 14, 2013 at 09:47:19AM -0600, Stephen Warren wrote:
> If the clock source name list is different, then it needs a different
> compatible value, so that each compatible value can specify which clock
> names are required.
> 
> Also, the compatible value itself should always include the exact HW
> that's present (most specific HW version), as well as any other HW it's
> compatible with.
 
Thank you for the comments. Yes, I did so in v1-v3, but after rethinking
about the situation (Actually both the HW version and the clock mux itself
are same, just the clock sources connecting to the mux might be different),
so I decided to do this by abstracting the driver from those source info
and letting DT binding to pass such information. Because I think putting 
the clock sources into the driver differed by compatible value would make
the driver more like SoC-specified, not the ideal way -- SoC-independent,
since the clock sources are based on SoC design, not on itself.

Thank you,
Nicolin Chen
