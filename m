Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264685141-26391-3-git-send-email-wg@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<1264685141-26391-3-git-send-email-wg@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:45:27 -0700
Message-ID: <fa686aa41002090945m4de77ba0j625289c1b6ccca71@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
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
> The "setclock" initialization functions have been renamed to "setup"
> because I2C interrupts must be enabled for the MPC512x. This requires
> to handle "fsl,preserve-clocking" in a slighly different way. Also,
> the old settings are now reported calling dev_dbg(). For the MPC512x
> the clock setup function of the MPC52xx can be re-used. Furthermore,
> the Kconfig help has been updated and corrected.

Please split the rename portion into a separate patch.

Otherwise this looks pretty okay.
g.

>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> ---
> =A0drivers/i2c/busses/Kconfig =A0 | =A0 =A07 +-
> =A0drivers/i2c/busses/i2c-mpc.c | =A0127 ++++++++++++++++++++++++++++++--=
----------
> =A02 files changed, 94 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 5f318ce..5477e41 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -418,13 +418,12 @@ config I2C_IXP2000
> =A0 =A0 =A0 =A0 =A0instead.
>
> =A0config I2C_MPC
> - =A0 =A0 =A0 tristate "MPC107/824x/85xx/52xx/86xx"
> + =A0 =A0 =A0 tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
> =A0 =A0 =A0 =A0depends on PPC32
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be include=
d for the
> - =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC=
8245 and
> - =A0 =A0 =A0 =A0 MPC85xx/MPC8641 family processors. The driver may also =
work on 52xx
> - =A0 =A0 =A0 =A0 family processors, though interrupts are known not to w=
ork.
> + =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107, Tsi107, MPC512x, =
MPC52xx,
> + =A0 =A0 =A0 =A0 MPC8240, MPC8245, MPC83xx, MPC85xx and MPC8641 family p=
rocessors.
>
> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, t=
he module
> =A0 =A0 =A0 =A0 =A0will be called i2c-mpc.
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 275ebe6..1af0730 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -31,6 +31,9 @@
>
> =A0#define DRV_NAME "mpc-i2c"
>
> +#define MPC_I2C_CLOCK_SAFE =A0 =A0 0
> +#define MPC_I2C_CLOCK_PRESERVE (~0U)
> +
> =A0#define MPC_I2C_FDR =A0 0x04
> =A0#define MPC_I2C_CR =A0 =A00x08
> =A0#define MPC_I2C_SR =A0 =A00x0c
> @@ -67,9 +70,8 @@ struct mpc_i2c_divider {
> =A0};
>
> =A0struct mpc_i2c_data {
> - =A0 =A0 =A0 void (*setclock)(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mpc_i2c *i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 clock, u32 prescaler=
);
> + =A0 =A0 =A0 void (*setup)(struct device_node *node, struct mpc_i2c *i2c=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clock, u32 prescaler);
> =A0 =A0 =A0 =A0u32 prescaler;
> =A0};
>
> @@ -164,7 +166,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned tim=
eout, int writing)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -#ifdef CONFIG_PPC_MPC52xx
> +#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
> =A0static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52x=
x[] =3D {
> =A0 =A0 =A0 =A0{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
> =A0 =A0 =A0 =A0{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> @@ -216,12 +218,18 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct de=
vice_node *node, u32 clock,
> =A0 =A0 =A0 =A0return div ? (int)div->fdr : -EINVAL;
> =A0}
>
> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct mpc_i2c *i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> =A0{
> =A0 =A0 =A0 =A0int ret, fdr;
>
> + =A0 =A0 =A0 if (clock =3D=3D MPC_I2C_CLOCK_PRESERVE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "using fdr %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c->base + MPC_I2C_F=
DR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
> =A0 =A0 =A0 =A0fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibili=
ty */
>
> @@ -230,13 +238,49 @@ static void __devinit mpc_i2c_setclock_52xx(struct =
device_node *node,
> =A0 =A0 =A0 =A0if (ret >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)=
\n", clock, fdr);
> =A0}
> -#else /* !CONFIG_PPC_MPC52xx */
> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct mpc_i2c *i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 u32 clock, u32 prescaler)
> +#else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> +{
> +}
> +#endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
> +
> +#ifdef CONFIG_PPC_MPC512x
> +static void __devinit mpc_i2c_setup_512x(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> +{
> + =A0 =A0 =A0 struct device_node *node_ctrl;
> + =A0 =A0 =A0 void __iomem *ctrl;
> + =A0 =A0 =A0 const u32 *pval;
> + =A0 =A0 =A0 u32 idx;
> +
> + =A0 =A0 =A0 /* Enable I2C interrupts for mpc5121 */
> + =A0 =A0 =A0 node_ctrl =3D of_find_compatible_node(NULL, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "fsl,mpc5121-i2c-ctrl");
> + =A0 =A0 =A0 if (node_ctrl) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D of_iomap(node_ctrl, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctrl) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Interrupt enable bits fo=
r i2c-0/1/2: bit 24/26/28 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pval =3D of_get_property(no=
de, "reg", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D (*pval & 0xff) / 0x=
20;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(ctrl, 1 << (24 + =
idx * 2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(ctrl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node_ctrl);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* The clock setup for the 52xx works also fine for the 512=
x */
> + =A0 =A0 =A0 mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
> +}
> +#else /* CONFIG_PPC_MPC512x */
> +static void __devinit mpc_i2c_setup_512x(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> =A0{
> =A0}
> -#endif /* CONFIG_PPC_MPC52xx*/
> +#endif /* CONFIG_PPC_MPC512x */
>
> =A0#ifdef CONFIG_FSL_SOC
> =A0static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_8xx=
x[] =3D {
> @@ -322,12 +366,19 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct de=
vice_node *node, u32 clock,
> =A0 =A0 =A0 =A0return div ? (int)div->fdr : -EINVAL;
> =A0}
>
> -static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct mpc_i2c *i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> =A0{
> =A0 =A0 =A0 =A0int ret, fdr;
>
> + =A0 =A0 =A0 if (clock =3D=3D MPC_I2C_CLOCK_PRESERVE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "using dfsrr %d, fdr %d\n=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c->base + MPC_I2C_D=
FSRR),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c->base + MPC_I2C_F=
DR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
> =A0 =A0 =A0 =A0fdr =3D (ret >=3D 0) ? ret : 0x1031; /* backward compatibi=
lity */
>
> @@ -340,9 +391,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct de=
vice_node *node,
> =A0}
>
> =A0#else /* !CONFIG_FSL_SOC */
> -static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct mpc_i2c *i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 u32 clock, u32 prescaler)
> +static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 clock, u32 prescaler)
> =A0{
> =A0}
> =A0#endif /* CONFIG_FSL_SOC */
> @@ -496,7 +547,7 @@ static int __devinit fsl_i2c_probe(struct of_device *=
op,
> =A0{
> =A0 =A0 =A0 =A0struct mpc_i2c *i2c;
> =A0 =A0 =A0 =A0const u32 *prop;
> - =A0 =A0 =A0 u32 clock =3D 0;
> + =A0 =A0 =A0 u32 clock =3D MPC_I2C_CLOCK_SAFE;
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0int plen;
>
> @@ -525,21 +576,21 @@ static int __devinit fsl_i2c_probe(struct of_device=
 *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!of_get_property(op->node, "fsl,preserve-clocking", NUL=
L)) {
> + =A0 =A0 =A0 if (of_get_property(op->node, "fsl,preserve-clocking", NULL=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D MPC_I2C_CLOCK_PRESERVE;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prop =3D of_get_property(op->node, "clock-=
frequency", &plen);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prop && plen =3D=3D sizeof(u32))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock =3D *prop;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (match->data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc_i2c_data *data =
=3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct mpc=
_i2c_data *)match->data;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->setclock(op->node, i2=
c, clock, data->prescaler);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Backwards compatibility =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->nod=
e, "dfsrr", NULL))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_i2c_set=
clock_8xxx(op->node, i2c,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (match->data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc_i2c_data *data =3D match->data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->setup(op->node, i2c, clock, data->pre=
scaler);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Backwards compatibility */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->node, "dfsrr", NULL=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_i2c_setup_8xxx(op->node=
, i2c, clock, 0);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
> @@ -584,21 +635,25 @@ static int __devexit fsl_i2c_remove(struct of_devic=
e *op)
> =A0 =A0 =A0 =A0return 0;
> =A0};
>
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_512x =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_512x,
> +};
> +
> =A0static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx =3D {
> - =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_52xx,
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_52xx,
> =A0};
>
> =A0static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 =3D {
> - =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> =A0};
>
> =A0static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 =3D {
> - =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> =A0 =A0 =A0 =A0.prescaler =3D 2,
> =A0};
>
> =A0static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 =3D {
> - =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> =A0 =A0 =A0 =A0.prescaler =3D 3,
> =A0};
>
> @@ -606,6 +661,7 @@ static const struct of_device_id mpc_i2c_of_match[] =
=3D {
> =A0 =A0 =A0 =A0{.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data_52=
xx, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c_da=
ta_52xx, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_dat=
a_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5121-i2c", .data =3D &mpc_i2c_data=
_512x, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_dat=
a_8313, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_dat=
a_8543, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_dat=
a_8544, },
> @@ -615,7 +671,6 @@ static const struct of_device_id mpc_i2c_of_match[] =
=3D {
> =A0};
> =A0MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>
> -
> =A0/* Structure for a device driver */
> =A0static struct of_platform_driver mpc_i2c_driver =3D {
> =A0 =A0 =A0 =A0.match_table =A0 =A0=3D mpc_i2c_of_match,
> @@ -648,5 +703,5 @@ module_exit(fsl_i2c_exit);
>
> =A0MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
> =A0MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"MPC824x/85xx/52xx processors");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"MPC824x/85xx/512x/52xx processors")=
;
> =A0MODULE_LICENSE("GPL");
> --
> 1.6.2.5
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
