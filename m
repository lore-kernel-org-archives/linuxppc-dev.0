Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264685141-26391-2-git-send-email-wg@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:41:39 -0700
Message-ID: <fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Dooks <ben-linux@fluff.org>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> From: Wolfgang Grandegger <wg@denx.de>
>
> "__devinit[data]" has not yet been used for all initialization functions
> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
> been renamed to "mpc_i2c_data", which is even the better name.
>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Several comments below.

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0103 +++++++++++++++++++-------------=
---------
> =A01 files changed, 48 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index f627001..275ebe6 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -66,7 +66,7 @@ struct mpc_i2c_divider {
> =A0 =A0 =A0 =A0u16 fdr; =A0 =A0 =A0 =A0/* including dfsrr */
> =A0};
>
> -struct mpc_i2c_match_data {
> +struct mpc_i2c_data {
> =A0 =A0 =A0 =A0void (*setclock)(struct device_node *node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc_i2c *i2c,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clock, u32 prescaler)=
;
> @@ -165,7 +165,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned tim=
eout, int writing)
> =A0}
>
> =A0#ifdef CONFIG_PPC_MPC52xx
> -static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] =3D {
> +static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52xx[=
] =3D {

__devinitdata goes at the end, immediately before the '=3D'.  Ditto
throughout the file.

> =A0 =A0 =A0 =A0{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
> =A0 =A0 =A0 =A0{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> =A0 =A0 =A0 =A0{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
> @@ -582,44 +584,35 @@ static int __devexit fsl_i2c_remove(struct of_devic=
e *op)
> =A0 =A0 =A0 =A0return 0;
> =A0};
>
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_52xx,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 2,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 3,
> +};
> +
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {

You can make this __devinitdata too.

> - =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data_52x=
x, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c_dat=
a_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_data=
_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_data=
_8313, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_data=
_8543, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_data=
_8544, },
> =A0 =A0 =A0 =A0/* Backward compatibility */
> - =A0 =A0 =A0 },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl-i2c", },
> =A0 =A0 =A0 =A0{},
> =A0};
> -
> =A0MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>
>
> @@ -634,7 +627,7 @@ static struct of_platform_driver mpc_i2c_driver =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -static int __init fsl_i2c_init(void)
> +static int __devinit fsl_i2c_init(void)

No, __init was correct.  This is called as a module_init() not as a .probe =
hook.

> =A0{
> =A0 =A0 =A0 =A0int rv;
>
> @@ -645,7 +638,7 @@ static int __init fsl_i2c_init(void)
> =A0 =A0 =A0 =A0return rv;
> =A0}
>
> -static void __exit fsl_i2c_exit(void)
> +static void __devexit fsl_i2c_exit(void)

Same here for __exit.

> =A0{
> =A0 =A0 =A0 =A0of_unregister_platform_driver(&mpc_i2c_driver);
> =A0}
> --
> 1.6.2.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
