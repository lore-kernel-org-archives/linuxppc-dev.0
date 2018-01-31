Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWc7f0hg4zDqnq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 19:37:32 +1100 (AEDT)
Date: Wed, 31 Jan 2018 09:37:17 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180131083717.xhwaepwd6qxeqncv@latitude>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
 <CAHp75VcWshngZFuUp4hzYdD43HF7TZ1sRE3Dh+HckB5do1=gGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4afc2a2wktuivren"
In-Reply-To: <CAHp75VcWshngZFuUp4hzYdD43HF7TZ1sRE3Dh+HckB5do1=gGw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4afc2a2wktuivren
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 28, 2018 at 07:31:58PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 7:04 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> Style issues below.
>=20
> > +#define HW_GPIO_OWNER          0x3c
> > +
> > +
> > +struct hlwd_gpio {
>=20
> No need extra empty line in between.

Ok.

> > +       struct gpio_chip gpioc;
> > +       void __iomem *regs;
> > +       struct device *dev;
> > +};
> > +
> > +static int hlwd_gpio_probe(struct platform_device *pdev)
> > +{
> > +       struct hlwd_gpio *hlwd;
> > +       struct resource *regs_resource;
> > +       u32 ngpios;
> > +       int res;
> > +
> > +       hlwd =3D devm_kzalloc(&pdev->dev, sizeof(*hlwd), GFP_KERNEL);
> > +       if (!hlwd)
> > +               return -ENOMEM;
> > +
>=20
> > +       /* Save the struct device pointer so dev_info, etc. can be used=
=2E */
>=20
> Useless.

Ok

> > +       hlwd->dev =3D &pdev->dev;
> > +
>=20
> > +       regs_resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>=20
> > +       if (IS_ERR(regs_resource))
> > +               return PTR_ERR(regs_resource);
> > +
>=20
> This is redundant. Below does it for ya.

devm_ioremap_resource does not check if the resource argument is a
negative error (which is what I'm trying to catch in the above code).
But it seems that platform_get_resource can't return a negative error,
so you're right. Thanks.

>=20
> > +       hlwd->regs =3D devm_ioremap_resource(&pdev->dev, regs_resource);
> > +       if (IS_ERR(hlwd->regs))
> > +               return PTR_ERR(hlwd->regs);
>=20
>=20
> > +       res =3D bgpio_init(&hlwd->gpioc, &pdev->dev, 4,
> > +                       hlwd->regs + HW_GPIOB_IN, hlwd->regs + HW_GPIOB=
_OUT,
> > +                       NULL, hlwd->regs + HW_GPIOB_DIR, NULL,
> > +                       BGPIOF_BIG_ENDIAN_BYTE_ORDER);
>=20
> > +
>=20
> Remove this extra line.

Ok.

>=20
> > +       if (res < 0) {
> > +               dev_warn(hlwd->dev, "bgpio_init failed: %d\n", res);
> > +               return res;
> > +       }
>=20
> > +       if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios))
> > +               ngpios =3D 32;
>=20
> A nit: I would rather go with
> res =3D of_property_read(...);
> if (res)
>   ngpios =3D 32;

Ok, I have no strong opinion on this, so I'll do what you suggest.


Thanks,
Jonathan Neusch=C3=A4fer

--4afc2a2wktuivren
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJacYAtAAoJEAgwRJqO81/bVJgQAL1/2rgESM4tkvX4NJOLl1yv
g01sSRRpfTSazmyCfLillW1n+cYVx2PVG0RWtwWUIqFUjqhQvkLETQGAhL2OUaWW
1K3UmpGnlJy2Yp/lqunk5VVKUt8N5CAxl3uABoiq9voryacDoA5qC7YoOwaGvpAl
6xGdL9HtHsRgziuSJrSl+bszeZnI2Q1k740t9TSwl14xGwUre3xjSDiXERlRupOM
yQq6WvS/RsWkpW+AaYqMGacSuozT0dR3zIVGOGTc/onCNkDKLSasbzyY2/qmyx79
zWINWza/AJnqWTuIZcUJPiODvYzBy9pg3l9hFJxrYwTpknbSC1vwFF9s3lh2Q9LI
isyl5u/UKu1nuuSetNF7FHBMKooVakWKPyS1fJ4LDSv3qgSxWkqTC6PbYKsdgy4B
oR7wy59l2hZLoShrpuF0ftTYeZ20Y7iBHG4o/Zu9PYBrKCS/sSLPBASV5ClfTyyd
WrRmw84ovfMMLuYjoyumAaLCUzBurpt5VHjkKtIpkrNtc8TEoZvMqW5mjLeRD8Rg
LMWfXi9jY8CAPsGfMU87jrd2Pdf1+QEOsROiFWIC7XpGs5wASEWySCI1+nylJkBE
GKg3NVdIbHU1XdPH6LKXAwjpr/yUtqYCHF8dmzDtHCenf6VXETaZ5qq7HpdAzyGT
21yVh2djBZ2XNXaucN+I
=K7YI
-----END PGP SIGNATURE-----

--4afc2a2wktuivren--
