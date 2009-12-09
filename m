Return-Path: <torfl@t-online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by ozlabs.org (Postfix) with ESMTP id 57819B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 07:04:51 +1100 (EST)
Resent-Message-ID: <200912092015.47885.glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912091649.19380.to-fleischer@t-online.de>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091126190101.GA19404@oksana.dev.rtsoft.ru>
	<fa686aa40911261117y4744e56bmf4d1d8260c7a51d0@mail.gmail.com>
	<200912091649.19380.to-fleischer@t-online.de>
From: "Grant Likely" <torfl@t-online.de>
Date: Wed, 9 Dec 2009 10:46:51 -0700
Message-ID: <fa686aa40912090946m12fe293cg2efb043cb7a7f573@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: Torsten Fleischer <to-fleischer@t-online.de>
Content-Type: text/plain;
  charset=ISO-8859-1
Cc: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 8:49 AM, Torsten Fleischer
<to-fleischer@t-online.de> wrote:
> On Thu, Nov 26, 2009 at 20:17:35, =A0Grant Likely wrote:
> [...]
>> spi-cs-high is definitely not a complete solution, but it isn't
>> actively evil either. =A0Plus it is documented and (presumably) in
>> active use. so support for it should not be dropped.
>>
>> Regardless, there needs to be a library function for parsing all the
>> SPI child nodes and returning the active state for each GPIO chip
>> select. =A0All the code for parsing the old spi-cs-high properties can
>> be contained in the same place as a new yet-to-be-defined bus node cs
>> polarity property. =A0The rework to the driver itself is not ugly.
>>
>
> The following patch adds a function to get the active state of the chip s=
elect
> of a SPI device by looking for the 'spi-cs-high' property in the associat=
ed device
> tree node.
> This function is used by the spi_mpc8xxx driver to set a proper initial v=
alue
> to the associated GPIOs.
>
>
> Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>

I like this better.  See comments below.

> ---
>
> diff -ruN linux-2.6.32_orig//drivers/of/of_spi.c linux-2.6.32/drivers/of/=
of_spi.c
> --- linux-2.6.32_orig//drivers/of/of_spi.c =A0 =A0 =A02009-12-03 04:51:21=
.000000000 +0100
> +++ linux-2.6.32/drivers/of/of_spi.c =A0 =A02009-12-09 12:37:01.000000000=
 +0100
> @@ -10,6 +10,49 @@
> =A0#include <linux/device.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/of_spi.h>
> +#include <linux/errno.h>
> +
> +/**
> + * of_get_spi_cs_active_state - Gets the chip select's active state of a=
 SPI
> + * child devices.
> + * @np: =A0 =A0 =A0 =A0parent node of the SPI device nodes
> + * @index: =A0 =A0 index/address of the SPI device (refers to the 'reg' =
property)
> + * @cs_active: pointer to return the chip select's active state
> + * =A0 =A0 =A0 =A0 =A0 =A0 (true =3D active high; false =3D active low)
> + *
> + * Returns 0 on success; negative errno on failure
> + */
> +int of_get_spi_cs_active_state(struct device_node *np, int index, bool *=
cs_active)
> +{
> + =A0 =A0 =A0 struct device_node *child;
> + =A0 =A0 =A0 const int *prop;
> + =A0 =A0 =A0 int len;
> + =A0 =A0 =A0 bool active =3D 0;
> +
> + =A0 =A0 =A0 /* search for the matching SPI device */
> + =A0 =A0 =A0 for_each_child_of_node(np, child) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(child, "reg", &len=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prop || len < sizeof(*prop)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* property 'reg' not avail=
able (not an error) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( *prop =3D=3D index ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* matching device found */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_find_property(child,=
 "spi-cs-high", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 active =3D =
1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cs_active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cs_active =
=3D active;

A little odd.  If cs_active is NULL, then this routine does nothing,
and the caller is entirely defective.  Either test at the top of the
function or not at all.  Then *cs_active can be assigned directly.
But even then, this function will probably need to be reworked (see
comments below).

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +EXPORT_SYMBOL(of_get_spi_cs_active_state);
> +
>
> =A0/**
> =A0* of_register_spi_devices - Register child devices onto the SPI bus
> diff -ruN linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.32/drive=
rs/spi/spi_mpc8xxx.c
> --- linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c =A0 =A0 =A0 =A02009-12-0=
3 04:51:21.000000000 +0100
> +++ linux-2.6.32/drivers/spi/spi_mpc8xxx.c =A0 =A0 =A02009-12-09 12:50:36=
.000000000 +0100
> @@ -705,6 +705,7 @@
> =A0 =A0 =A0 =A0for (; i < ngpios; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int gpio;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum of_gpio_flags flags;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool astate;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio =3D of_get_gpio_flags(np, i, &flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!gpio_is_valid(gpio)) {
> @@ -721,8 +722,15 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pinfo->gpios[i] =3D gpio;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pinfo->alow_flags[i] =3D flags & OF_GPIO_A=
CTIVE_LOW;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_get_spi_cs_active_state(np, i, &=
astate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "can't get cs =
active state of device "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "#%d: %d\n"=
, i, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_loop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

This is a bit heavy handed in that it expects the device tree to be
fully populated with all SPI devices which isn't always a given.  For
example a board that has some unpopulated SPI devices could have some
gaps in the GPIO CS layout.  If a node can't be found, then just
ignore it silently and move on to the next.  I'd do something like
this:

+               astate =3D of_get_spi_cs_active_state(np, i);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D gpio_direction_output(pinfo->gpios[i=
],
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 pinfo->alow_flags[i]);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 pinfo->alow_flags[i] ^ !astate);

BTW, why the xor?  The usage is non-obvious enough that I'd like to
see a comment describing the use case.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
