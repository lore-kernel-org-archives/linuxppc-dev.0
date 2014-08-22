Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CA8F1A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 18:57:41 +1000 (EST)
Message-ID: <1408697829.3118.28.camel@paszta.hi.pengutronix.de>
Subject: Re: [RFC PATCH 5/6] rtc: rtc-isl12022: Change vendor prefix for
 Intersil Corporation to isil
From: Philipp Zabel <p.zabel@pengutronix.de>
To: devicetree@vger.kernel.org
Date: Fri, 22 Aug 2014 10:57:09 +0200
In-Reply-To: <1408524184-31928-6-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-6-git-send-email-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, den 20.08.2014, 10:43 +0200 schrieb Philipp Zabel:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
> Patch db04d6284e2a added device tree support using the then
> documented isl vendor prefix, so we keep that around for
> backwards compatibility.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/rtc/rtc-isl12022.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index aa55f08..df20f18 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
>  
>  #ifdef CONFIG_OF
>  static struct of_device_id isl12022_dt_match[] = {
> -	{ .compatible = "isl,isl12022" },
> +	{ .compatible = "isil,isl12022" },
> +	{ .compatible = "isl,isl12022" }, /* for backwards compatibility */

Actually, is it even necessary to keep this around in here?
If of_driver_match_device fails, i2c_device_match will continue to try
i2c_match_id if driver->id_table is set, which matches against the
result of of_modalias_node (dropping the vendor prefix altogether).

regards
Philipp
