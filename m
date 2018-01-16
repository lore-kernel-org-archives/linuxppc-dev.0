Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLkdJ6xzDzF0TC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 08:58:59 +1100 (AEDT)
Date: Tue, 16 Jan 2018 22:58:47 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-gpio@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/6] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180116215847.qlygkbnecni7bzog@latitude>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
 <20180115031401.19577-4-j.neuschaefer@gmx.net>
 <CACRpkdb11jn4HFdoKLuNVmXeTBntpTAjkVctvH1=R-p6989eTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="exhxaxcsmwxhn2ch"
In-Reply-To: <CACRpkdb11jn4HFdoKLuNVmXeTBntpTAjkVctvH1=R-p6989eTg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--exhxaxcsmwxhn2ch
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 10:42:54AM +0100, Linus Walleij wrote:
> On Mon, Jan 15, 2018 at 4:13 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> > This patch is based on code developed by Albert Herranz and the GameCube
> > Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> > available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> > has grown quite dissimilar.
>=20
> I'm impressed by this effort. As with all reverse engineering.
>=20
> > This driver currently uses __raw_readl and __raw_writel to access the
> > GPIO controller's MMIO registers. I wonder if readl/writel plus explicit
> > byte-swapping would be more correct, because it could be independent of
> > the CPU's endianness. That said, this hardware only exists in two
> > big-endian machines (Wii and Wii U).
>=20
> I don't know about PPC but I think you're supposed to use
> ioread32be() and iowrite32be() to do explicit BE access.

Ah, that's the name! I didn't find ioread32*/iowrite32* in the
documentation or source code.

> But when I look at it, I think you can just use the gpio-mmio library
> for this driver and cut down code cosiderably.

I'll look into it. So far it looks good (drivers/gpio/gpio-iop.c has
just 60 lines).

> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> Can't you just save a pointer to struct device *dev in the
> state container and use dev_info(state->dev, ...) etc instead
> of this?

Makes sense. I'll try this out.

> > +#include <linux/of_gpio.h>
>=20
> This include should not be needed.

Okay.

> > +/*
> > + * Update the bit with the given bit offset in the given register to a=
 given
> > + * value
> > + */
> > +static void hlwd_gpio_update_bit(struct gpio_chip *gc, unsigned int re=
g,
> > +               int offset, int value)
> > +{
> > +       struct hlwd_gpio *hlwd =3D gpiochip_get_data(gc);
> > +       unsigned long flags;
> > +       u32 bit =3D 1UL << offset;
>=20
> #include <linux/bitops.h>
>=20
> u32 bit =3D BIT(offset);
>=20
> > +       u32 tmp;
> > +
> > +       spin_lock_irqsave(&hlwd->lock, flags);
> > +       tmp =3D __raw_readl(hlwd->regs + reg);
> > +       if (value)
> > +               __raw_writel(tmp | bit, hlwd->regs + reg);
> > +       else
> > +               __raw_writel(tmp & ~bit, hlwd->regs + reg);
> > +       spin_unlock_irqrestore(&hlwd->lock, flags);
> > +}
>=20
> This looks very much like it is reimplementing the stuff we already
> have in drivers/gpio/gpio-mmio.h.
>=20
> There is even a big endian access flag for the library.
> And you get so much for free with gpio-mmio.
>=20
> select GPIO_GENERIC
> in Kconfig
>=20
> the helpers come in from <linux/gpio/driver.h>
>=20
> Look at other drivers for inspiration:
> git grep bgpio_init
>=20
> If you need IRQ support you should probably have your own file
> for this driver, but it will be just a few lines of wrapper using
> bgpio_init() and BGPIOF_BIG_ENDIAN and/or possibly
> BGPIOF_BIG_ENDIAN_BYTE_ORDER.

Yes, I plan to add IRQ support in a later patch.

>=20
> See the other drivers.

Yep, gpio-mmio looks like a good option, thanks for the pointer!


Thanks,
Jonathan Neusch=C3=A4fer

--exhxaxcsmwxhn2ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaXnWOAAoJEAgwRJqO81/bHKUP/RbV3X1r22TTRalj4CrWEnoU
58cADjxMeqhMM1JswwD7sHIa0ViZCshGaoxKcx9p0wen1X6FW2ky4m6g+vsI7Zwl
MN9hu1aewkk7ilZNcFrQYxFDIV5+vRhkTwTe4s/ZmFYri7bUjMH0yEW92gRXeTNH
fiz9KiF8wtrtahE4hse4ET9yog4+Tj3DEwVMtZ8L0yQ8SmrjJ31z7R1J1tJokCC+
lW8fveywkSoDWACRvzj81G/xfFnFiw+wkrncyXWA81rdPlk6P2ZyhrA9EypV0gPx
8ngP0SpSwnmArz6IWXA2Gj+ef3dhnQvfiPqee2PBGLUGIvQT/7PWyUSbtex6XOAQ
CNejveRGfQcZOZ4tRbr26xnUUkopX8VgotgLinC37k1s6kuMQY3P+JCF56d+C8X1
ouCgs+MnyRa2j2QZ8PrjqJNQbqbGAinC7MwYWxWXNlU4oejmyxG01igqtezvw2Fa
NqIuRumi7XYTuJdvj/K1P30Fks43eKToqoj+TrMei2eyTJQUPsX4foLD29IAms4Y
q2QtyXvxRDg4STCdJDOR0jNa4mGaqWNBAuRtB+sOHjsN5loj6JD14lkqooiV0U98
kZrxHcqmCYomrc8kZiOznWdNp1D6K6WwSaLE9klI9zOaifIxzcorQgVEHPKyuohB
fH806q4e1JYi1PxeyXQu
=UpvS
-----END PGP SIGNATURE-----

--exhxaxcsmwxhn2ch--
