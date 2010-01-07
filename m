Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 0B7A31007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jan 2010 08:12:14 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 22so2949231eye.33
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Jan 2010 13:12:12 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.OSX.2.00.0911171657290.371@silk.local>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
Date: Thu, 7 Jan 2010 22:12:12 +0100
Message-ID: <10f740e81001071312p451de3c0r93d8d9d2782abde8@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmac-zilog: add platform driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 10:04, Finn Thain <fthain@telegraphics.com.au> wrot=
e:
> Add platform driver to the pmac-zilog driver for mac 68k, putting the
> powermac-specific bits inside #ifdef CONFIG_PPC_PMAC.

> --- linux-2.6.31.orig/drivers/serial/pmac_zilog.c =C2=A0 =C2=A0 =C2=A0 20=
09-11-17 17:07:28.000000000 +1100
> +++ linux-2.6.31/drivers/serial/pmac_zilog.c =C2=A0 =C2=A02009-11-17 17:0=
7:38.000000000 +1100

> +static int pmz_attach(struct platform_device *pdev)

__devinit (or __init, see platform_driver_probe() below)

BTW, the same is true for the PowerMac version.

> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < pmz_ports_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmz_ports[i].node =
=3D=3D pdev)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> +}
> +
> +static int pmz_detach(struct platform_device *pdev)

__devexit (or __exit, see platform_driver_probe() below)

Idem ditto for PowerMac.

> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +#endif /* !CONFIG_PPC_PMAC */

> +static struct platform_driver pmz_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D pmz_a=
ttach,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __devexit_=
p(pmz_detach),
> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D "scc",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D THIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +#endif /* !CONFIG_PPC_PMAC */
> +
> =C2=A0static int __init init_pmz(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc, i;
> @@ -1942,15 +2053,23 @@ static int __init init_pmz(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Then we register the macio driver itself
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return macio_register_driver(&pmz_driver);
> +#else
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&pmz_driver);

Since this device is not hot-pluggable, you could use
platform_driver_probe() instead (and leave pmz_driver.probe() empty).

> --- linux-2.6.31.orig/drivers/serial/pmac_zilog.h =C2=A0 =C2=A0 =C2=A0 20=
09-11-17 17:07:28.000000000 +1100
> +++ linux-2.6.31/drivers/serial/pmac_zilog.h =C2=A0 =C2=A02009-11-17 17:0=
7:38.000000000 +1100
> @@ -1,7 +1,15 @@
> =C2=A0#ifndef __PMAC_ZILOG_H__
> =C2=A0#define __PMAC_ZILOG_H__
>
> +#ifdef CONFIG_PPC_PMAC
> =C2=A0#define pmz_debug(fmt, arg...) dev_dbg(&uap->dev->ofdev.dev, fmt, #=
# arg)
> +#define pmz_error(fmt, arg...) dev_err(&uap->dev->ofdev.dev, fmt, ## arg=
)
> +#define pmz_info(fmt, arg...) =C2=A0dev_info(&uap->dev->ofdev.dev, fmt, =
## arg)
> +#else
> +#define pmz_debug(fmt, arg...) do { } while (0)
> +#define pmz_error(fmt, arg...) printk(KERN_ERR fmt, ## arg)
> +#define pmz_info(fmt, arg...) =C2=A0printk(KERN_INFO fmt, ## arg)

Any chance you can sneak the platform device in and use dev_*()?

Anyway, I'm gonna take it, and feed it upstream if BenH adds his ack. Ben?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
