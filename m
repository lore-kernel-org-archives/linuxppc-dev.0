Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49D2767E.4080607@grandegger.com>
References: <49D2767E.4080607@grandegger.com>
Date: Tue, 31 Mar 2009 14:24:01 -0600
Message-ID: <fa686aa40903311324s162f5da0m9dc2f45d1f8155df@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: i2c-mpc: preserve I2C clocking
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 2:01 PM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> The i2c node property "fsl,preserve-clocking" allows to overtake the
> clock settings from the boot loader avoiding the hard-coded settings.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 =A02 ++
> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 20 +++++++++++---------
> =A02 files changed, 13 insertions(+), 9 deletions(-)
>
> Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c 2009-03-31 13:25:08.00000=
0000 +0200
> +++ linux-2.6/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A02009-03-31 21:29:21=
.615721143 +0200
> @@ -323,13 +323,6 @@
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 if (of_get_property(op->node, "dfsrr", NULL))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
> -
> - =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_device_is_compatible(op-=
>node, "mpc5200-i2c"))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
> -
> =A0 =A0 =A0 =A0init_waitqueue_head(&i2c->queue);
>
> =A0 =A0 =A0 =A0i2c->base =3D of_iomap(op->node, 0);
> @@ -348,8 +341,17 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_request;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 mpc_i2c_setclock(i2c);
> +
> + =A0 =A0 =A0 if (!of_get_property(op->node, "fsl,preserve-clocking", NUL=
L)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->node, "dfsrr", NULL=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV=
_SEPARATE_DFSRR;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,=
mpc5200-i2c") ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_device_is_compatible(op->node, "=
mpc5200-i2c"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV=
_CLOCK_5200;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_i2c_setclock(i2c);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
>
> Index: linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt =A0 =A0=
 =A0 2009-03-17 10:28:07.000000000 +0100
> +++ linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt =A0 =A02009-=
03-31 21:35:51.527901532 +0200
> @@ -20,6 +20,8 @@
> =A0 =A0a digital filter sampling rate register
> =A0- fsl5200-clocking : boolean; if defined, indicated that this device
> =A0 =A0uses the FSL 5200 clocking mechanism.
> + - fsl,preserve-clocking : boolean; if defined, the clock settings
> + =A0 from the bootloader are preserved (not touched).
>
> =A0Example :
> =A0 =A0 =A0 =A0i2c@3000 {
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
