Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f41.google.com (mail-gw0-f41.google.com [74.125.83.41])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A703B6F68
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2011 02:33:09 +1000 (EST)
Received: by gwaa12 with SMTP id a12so2500308gwa.0
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 09:33:06 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 21 Sep 2011 10:33:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 1/2] gpio: move mpc8xxx/512x gpio driver to drivers/gpio
Message-ID: <20110921163301.GZ7781@ponder.secretlab.ca>
References: <1316602161-12546-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316602161-12546-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2011 at 12:49:20PM +0200, Wolfram Sang wrote:
> Move the driver to the place where it is expected to be nowadays. Also
> rename its CONFIG-name to match the rest and adapt the defconfigs.
> Finally, move selection of REQUIRE_GPIOLIB or WANTS_OPTIONAL_GPIOLIB to
> the platforms, because this option is per-platform and not per-driver.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> I'd think this should go via ppc, so it is in sync with the defconfig update of
> patch 2/2.
> 
> Changes since V1: Use -C in format-patch to show the rename.

Nit: I prefer to see the changelog before the s-o-b lines so that it
gets included in the final commit text.  Helps when trying to identify
exactly which version of a patch got merged.

> 
>  arch/powerpc/configs/85xx/p1023rds_defconfig       |    2 +-
>  arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    2 +-
>  arch/powerpc/configs/mpc85xx_defconfig             |    2 +-
>  arch/powerpc/configs/mpc85xx_smp_defconfig         |    2 +-
>  arch/powerpc/configs/ppc6xx_defconfig              |    2 +-
>  arch/powerpc/platforms/512x/Kconfig                |    1 +
>  arch/powerpc/platforms/83xx/Kconfig                |    9 ++++++---
>  arch/powerpc/platforms/85xx/Kconfig                |   12 ++++++++----
>  arch/powerpc/platforms/86xx/Kconfig                |    1 +
>  arch/powerpc/platforms/Kconfig                     |   10 ----------
>  arch/powerpc/sysdev/Makefile                       |    1 -
>  drivers/gpio/Kconfig                               |    8 ++++++++
>  drivers/gpio/Makefile                              |    1 +
>  .../mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c  |    0
>  14 files changed, 30 insertions(+), 23 deletions(-)
>  rename arch/powerpc/sysdev/mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c (100%)

Looks good to me.  Acked-by: Grant Likely <grant.likely@secretlab.ca>

Yes, it probably should go via the ppc tree.  I don't foresee any conflict
issues with the gpio tree.

g.
