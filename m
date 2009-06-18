Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 172E3B7223
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 23:10:39 +1000 (EST)
Date: Thu, 18 Jun 2009 17:09:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Rini van Zetten <rini@arvoo.nl>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
Message-ID: <20090618130955.GA1369@oksana.dev.rtsoft.ru>
References: <4A39DC80.7030906@arvoo.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4A39DC80.7030906@arvoo.nl>
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 08:19:44AM +0200, Rini van Zetten wrote:
> This patch adds the possibility to have a spi device without a cs.
>
> For example, the dts file should look something like this:
>
> spi-controller {
>        gpios = <&pio1 1 0      /* cs0 */
>                 0              /* cs1, no GPIO */
>                 &pio2 2 0>;    /* cs2 */
>

Interesting scheme. I guess this is for eSPI controllers that can
do their own chip-selects, but we want GPIO chip selects in addition
(or in place of built-in ones), correct?

> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---
> Changes :
> 	patch against 2.6.30-rc8-mm1

I assume this is v2 already, and I overlooked v1, sorry.

Technically the patch looks OK, but please fix some cosmetics issues.

checkpatch reports:

WARNING: patch prefix 'drivers' exists, appears to be a -p0 patch

WARNING: line over 80 characters
#131: FILE: spi/spi_mpc8xxx.c:714:
+                               dev_err(dev, "can't request gpio #%d: %d\n", i, ret);

WARNING: line over 80 characters
#141: FILE: spi/spi_mpc8xxx.c:724:
+                               dev_err(dev, "can't set output direction for gpio "

> --- drivers/spi/spi_mpc8xxx.c.org	2009-06-12 10:45:21.000000000 +0200
> +++ drivers/spi/spi_mpc8xxx.c	2009-06-12 10:54:48.000000000 +0200
> @@ -666,9 +666,10 @@ static void mpc8xxx_spi_cs_control(struc
>  	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
>  	u16 cs = spi->chip_select;
>  	int gpio = pinfo->gpios[cs];
> -	bool alow = pinfo->alow_flags[cs];
> -
> -	gpio_set_value(gpio, on ^ alow);
> +	if (gpio != -EEXIST) {
> +		bool alow = pinfo->alow_flags[cs];
> +		gpio_set_value(gpio, on ^ alow);

Please put an empty line after variable declaration.


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
