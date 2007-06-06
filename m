Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 8C05ADDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:15:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8349ea Random Device Generator driver
Date: Wed, 6 Jun 2007 16:15:10 +0200
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
In-Reply-To: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706061615.11380.arnd@arndb.de>
Cc: sl@powerlinux.fr, Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 June 2007, Philippe Lachenal wrote:
> I've made a driver for the MPC8349ea Random Device Generator, and I=20
> therefore submit it to your impartial judgment.. ;)

Looks good from the point of integration into the driver framework.
I can't judge the hwrng specific parts, but don't see anything
fundamentally wrong there.

> +static int __init mpc834x_itx_declare_of_platform_devices(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0if (!machine_is(mpc834x_itx)){
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk("__init mpc834x_itx_=
declare_of_platform_devices error\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +=A0=A0=A0=A0=A0=A0=A0}

I would think that it's not strictly an error to be running on some other
hardware than yours ;-)

Just remove the printk here.

> +=A0=A0=A0=A0=A0=A0=A0err =3D of_address_to_resource(rng_np, 0, &res);
> +=A0=A0=A0=A0=A0=A0=A0if (err)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;=A0
> +=A0=A0=A0=A0=A0=A0=A0rng_regs =3D ioremap(res.start, (res.end - res.star=
t));

This can be done in one step with the new 'of_iomap' function.

> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "Registering Talitos RNG\n");
> +
> +=A0=A0=A0=A0=A0=A0=A0err =3D hwrng_register(&talitos_rng);
> +=A0=A0=A0=A0=A0=A0=A0if (err){
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(".............. fail=
ure\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iounmap(rng_regs);
> +=A0=A0=A0=A0=A0=A0=A0}

This printk should have a KERN_ERROR or similar level.
Ideally, replace all instances of printk in your driver with 'dev_err',
'dev_info' or similar calls from <linux/device.h>.

	Arnd <><
