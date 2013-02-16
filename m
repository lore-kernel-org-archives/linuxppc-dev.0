Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D412A2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 07:35:55 +1100 (EST)
Date: Sat, 16 Feb 2013 20:52:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
Message-ID: <20130216205220.0a4f871c@endymion.delvare>
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Kevin Hilman <khilman@ti.com>,
 Sonic Zhang <sonic.zhang@analog.com>, linux-arm-kernel@lists.infradead.org,
 Deepak Sikri <deepak.sikri@st.com>, Havard Skinnemoen <hskinnemoen@gmail.com>,
 Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>,
 Joe Perches <joe@perches.com>, Lars-Peter Clausen <lars@metafoo.de>,
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
 uclinux-dist-devel@blackfin.uclinux.org,
 Andrew Morton <akpm@linux-foundation.org>, Alessandro Rubini <rubini@unipv.it>,
 linuxppc-dev@lists.ozlabs.org,
 Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Feb 2013 15:18:35 -0800, Doug Anderson wrote:
> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.

I had not noticed this change. Very good news!

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
> ---
> (...)

For i2c-taos-evm:

Reviewed-by: Jean Delvare <khali@linux-fr.org>

Also a note:

> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -595,7 +595,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>  	result = i2c_add_adapter(&i2c->adap);
>  	if (result < 0) {
>  		dev_err(i2c->dev, "failed to add adapter\n");
> -		goto fail_add;
> +		goto out;
>  	}
>  	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
>  
> @@ -603,8 +603,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -fail_add:
> -	platform_set_drvdata(pdev, NULL);
>  out:
>  	return result;
>  };

There no longer is any point in this error path, all gotos in this
function could be changed to returns (in a separate patch, obviously.)

-- 
Jean Delvare
