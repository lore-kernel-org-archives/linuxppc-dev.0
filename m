Return-Path: <jdelvare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spzss4nY9zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Oct 2016 02:17:21 +1100 (AEDT)
Date: Wed, 5 Oct 2016 17:17:04 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare
 <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches
 <ludovic.desroches@atmel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Florian Fainelli
 <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, Brian Norris
 <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, =?UTF-8?B?U8O2cmVu?= Brinkmann
 <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>, Sekhar
 Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>, Seth Heasley <seth.heasley@intel.com>, Neil
 Horman <nhorman@tuxdriver.com>, Joachim Eastwood <manabian@gmail.com>,
 Carlo Caione <carlo@caione.org>, Alessandro Rubini <rubini@unipv.it>, Linus
 Walleij <linus.walleij@linaro.org>, Peter Korsgaard <jacmet@sunsite.dk>,
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Guan Xuetao
 <gxt@mprc.pku.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Barry Song
 <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Laxman
 Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot
 <gnurou@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tony
 Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@stlinux.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Message-ID: <20161005171704.18fe1b9f@endymion>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  9 Aug 2016 13:36:17 +0200, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-amd756.c         | 5 +----
>  drivers/i2c/busses/i2c-at91.c           | 2 --
>  drivers/i2c/busses/i2c-axxia.c          | 8 +-------
>  drivers/i2c/busses/i2c-bcm-iproc.c      | 8 +-------
>  drivers/i2c/busses/i2c-bcm-kona.c       | 4 +---
>  drivers/i2c/busses/i2c-bfin-twi.c       | 4 +---
>  drivers/i2c/busses/i2c-brcmstb.c        | 4 +---
>  drivers/i2c/busses/i2c-cadence.c        | 4 +---
>  drivers/i2c/busses/i2c-cpm.c            | 4 +---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 +---
>  drivers/i2c/busses/i2c-davinci.c        | 4 +---
>  drivers/i2c/busses/i2c-diolan-u2c.c     | 4 +---
>  drivers/i2c/busses/i2c-dln2.c           | 4 +---
>  drivers/i2c/busses/i2c-efm32.c          | 1 -
>  drivers/i2c/busses/i2c-exynos5.c        | 4 +---
>  drivers/i2c/busses/i2c-hix5hd2.c        | 4 +---
>  drivers/i2c/busses/i2c-i801.c           | 1 -
>  drivers/i2c/busses/i2c-ibm_iic.c        | 4 +---
>  drivers/i2c/busses/i2c-img-scb.c        | 4 +---
>  drivers/i2c/busses/i2c-imx.c            | 4 +---
>  drivers/i2c/busses/i2c-isch.c           | 4 +---
>  drivers/i2c/busses/i2c-ismt.c           | 4 +---
>  drivers/i2c/busses/i2c-jz4780.c         | 4 +---
>  drivers/i2c/busses/i2c-lpc2k.c          | 4 +---
>  drivers/i2c/busses/i2c-meson.c          | 1 -
>  drivers/i2c/busses/i2c-mpc.c            | 4 +---
>  drivers/i2c/busses/i2c-mt65xx.c         | 4 +---
>  drivers/i2c/busses/i2c-mxs.c            | 1 -
>  drivers/i2c/busses/i2c-nforce2.c        | 1 -
>  drivers/i2c/busses/i2c-nomadik.c        | 4 +---
>  drivers/i2c/busses/i2c-ocores.c         | 4 +---
>  drivers/i2c/busses/i2c-octeon.c         | 4 +---
>  drivers/i2c/busses/i2c-omap.c           | 4 +---
>  drivers/i2c/busses/i2c-piix4.c          | 1 -
>  drivers/i2c/busses/i2c-pmcmsp.c         | 4 +---
>  drivers/i2c/busses/i2c-pnx.c            | 4 +---
>  drivers/i2c/busses/i2c-puv3.c           | 5 +----
>  drivers/i2c/busses/i2c-pxa.c            | 4 +---
>  drivers/i2c/busses/i2c-rcar.c           | 4 +---
>  drivers/i2c/busses/i2c-riic.c           | 4 +---
>  drivers/i2c/busses/i2c-rk3x.c           | 4 +---
>  drivers/i2c/busses/i2c-s3c2410.c        | 1 -
>  drivers/i2c/busses/i2c-sh7760.c         | 4 +---
>  drivers/i2c/busses/i2c-sh_mobile.c      | 1 -
>  drivers/i2c/busses/i2c-sirf.c           | 4 +---
>  drivers/i2c/busses/i2c-st.c             | 4 +---
>  drivers/i2c/busses/i2c-stu300.c         | 5 +----
>  drivers/i2c/busses/i2c-tegra.c          | 4 +---
>  drivers/i2c/busses/i2c-uniphier-f.c     | 7 +------
>  drivers/i2c/busses/i2c-uniphier.c       | 7 +------
>  drivers/i2c/busses/i2c-wmt.c            | 4 +---
>  drivers/i2c/busses/i2c-xgene-slimpro.c  | 1 -
>  drivers/i2c/busses/i2c-xiic.c           | 1 -
>  drivers/i2c/busses/i2c-xlp9xx.c         | 4 +---
>  drivers/i2c/busses/i2c-xlr.c            | 4 +---
>  55 files changed, 44 insertions(+), 161 deletions(-)
> (...)

I like the idea.

For i2c-amd756, i2c-diolan-u2c, i2c-i801, i2c-isch, i2c-ismt,
i2c-nforce and i2c-piix4:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
