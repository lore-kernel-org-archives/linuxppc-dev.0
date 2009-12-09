Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C88D4B6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 08:16:51 +1100 (EST)
Subject: Re: [RFC PATCH 2/5] mcu_mpc8349emitx: port to new of gpio interface
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1258472546-31343-3-git-send-email-dbaryshkov@gmail.com>
Date: Wed, 9 Dec 2009 15:16:37 -0600
Message-Id: <6C061449-ACBE-4C51-9101-007DFD285F55@kernel.crashing.org>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-3-git-send-email-dbaryshkov@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2009, at 9:42 AM, Dmitry Eremin-Solenikov wrote:

> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   11 +++++------
> 1 files changed, 5 insertions(+), 6 deletions(-)

Minding reviewing for me.

- k

>=20
> diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c =
b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> index 82a9bcb..4ba8b16 100644
> --- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> +++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> @@ -36,7 +36,7 @@ struct mcu {
> 	struct mutex lock;
> 	struct device_node *np;
> 	struct i2c_client *client;
> -	struct of_gpio_chip of_gc;
> +	struct gpio_chip gc;
> 	u8 reg_ctrl;
> };
>=20
> @@ -55,8 +55,7 @@ static void mcu_power_off(void)
>=20
> static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int =
val)
> {
> -	struct of_gpio_chip *of_gc =3D to_of_gpio_chip(gc);
> -	struct mcu *mcu =3D container_of(of_gc, struct mcu, of_gc);
> +	struct mcu *mcu =3D container_of(gc, struct mcu, gc);
> 	u8 bit =3D 1 << (4 + gpio);
>=20
> 	mutex_lock(&mcu->lock);
> @@ -78,8 +77,8 @@ static int mcu_gpio_dir_out(struct gpio_chip *gc, =
unsigned int gpio, int val)
> static int mcu_gpiochip_add(struct mcu *mcu)
> {
> 	struct device_node *np;
> -	struct of_gpio_chip *of_gc =3D &mcu->of_gc;
> -	struct gpio_chip *gc =3D &of_gc->gc;
> +	struct gpio_chip *gc =3D &mcu->gc;
> +	struct of_gpio_chip *of_gc =3D &gc->of_gc;
> 	int ret;
>=20
> 	np =3D of_find_compatible_node(NULL, NULL, =
"fsl,mcu-mpc8349emitx");
> @@ -113,7 +112,7 @@ static int mcu_gpiochip_remove(struct mcu *mcu)
> {
> 	int ret;
>=20
> -	ret =3D gpiochip_remove(&mcu->of_gc.gc);
> +	ret =3D gpiochip_remove(&mcu->gc);
> 	if (ret)
> 		return ret;
> 	of_node_put(mcu->np);
> --=20
> 1.6.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
