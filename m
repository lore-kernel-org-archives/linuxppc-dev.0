Return-Path: <marex@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD57A2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:17:49 +1100 (EST)
From: Marek Vasut <marex@denx.de>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
Date: Mon, 18 Feb 2013 13:17:28 +0100
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201302181317.28645.marex@denx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Kevin Hilman <khilman@ti.com>,
 Sonic Zhang <sonic.zhang@analog.com>, linux-arm-kernel@lists.infradead.org,
 Deepak Sikri <deepak.sikri@st.com>, Havard Skinnemoen <hskinnemoen@gmail.com>,
 Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Uwe
 =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <rob.herring@calxeda.com>, uclinux-dist-devel@blackfin.uclinux.org,
 Jean Delvare <khali@linux-fr.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, linux-omap@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Oskar Schirmer <oskar@scara.com>, Fabio Estevam <fabio.estevam@freescale.com>,
 davinci-linux-open-source@linux.davincidsp.com,
 Shawn Guo <shawn.guo@linaro.org>, Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomoya MORINAGA <tomoya.rohm@gmail.com>, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Viresh Kumar <viresh.linux@gmail.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Jiri Kosina <jkosina@suse.cz>,
 STEricsson <STEricsson_nomadik_linux@list.st.com>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Alessandro Rubini <rubini@unipv.it>, linuxppc-dev@lists.ozlabs.org,
 Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Doug Anderson,

> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.
> * I verified that there were no cases where xxx_get_drvdata() was
>   being called in these drivers and checking for / relying on the NULL
>   return value.
> 
> This could be cleaned up kernel-wide but for now just take the baby
> step and remove from the i2c subsystem.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

For

>  drivers/i2c/busses/i2c-mxs.c                | 2 --

[...]

> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 22d8ad3..120f246 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -697,8 +697,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
> 
>  	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
> 
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }

[...]

Add my:
Reviewed-by: Marek Vasut <marex@denx.de>
