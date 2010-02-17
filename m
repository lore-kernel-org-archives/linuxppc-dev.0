Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 4218CB6F08
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 07:10:47 +1100 (EST)
Received: by yxe8 with SMTP id 8so10860764yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 12:10:46 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1266433154.2322.0@antares>
References: <1266433154.2322.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Feb 2010 13:10:25 -0700
Message-ID: <fa686aa41002171210i3899fcbepe2fcc620a55a1e34@mail.gmail.com>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 11:59 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> This patch improves the recovery of the MPC's I2C bus from errors like bu=
s
> hangs resulting in timeouts:
> 1. make the bus timeout configurable, as it depends on the bus clock and
> =A0 the attached slave chip(s); default is still 1 second;
> 2. detect any of the cases indicated by the CF, BB and RXAK MSR flags if =
a
> =A0 timeout occurs, and add a missing (required) MAL reset;
> 3. use a more reliable method to fixup the bus if a hang has been detecte=
d.
> =A0 The sequence is sent 9 times which seems to be necessary if a slave
> =A0 "misses" more than one clock cycle. =A0For 400 kHz bus speed, the fix=
up is
> =A0 also ~70us (81us vs. 150us) faster.
>
> Tested on a custom Lite5200b derived board, with a Dallas RTC, AD sensors
> and NXP IO expander chips attached to the i2c.
>
> Changes vs. v1:
> - use improved bus fixup sequence for all chips (not only the 5200)
> - calculate real clock from defaults if no clock is given in the device t=
ree
> - better description (I hope) of the changes.
>
> I didn't split the changes in this file into three parts as recommended b=
y
> Grant, as they actually belong together (i.e. they address one single
> problem, just in three places of one single source file).
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> ---
>
> Note about the reset sequence: I verified the waveforms for 18.4kHz, 85.9=
kHz
> and 375kHz (drop me a note if you want to see scope screen shots). =A0Not
> verified on other mpc chips yet.
> @Ira: thanks in advance for giving it a try on your box!
>
>
> --- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A02009-12-03
> 04:51:21.000000000 +0100
> +++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c =A0 2010-02-17
> 16:23:11.000000000 +0100
> @@ -59,6 +59,7 @@ struct mpc_i2c {
> =A0 =A0 =A0 =A0wait_queue_head_t queue;
> =A0 =A0 =A0 =A0struct i2c_adapter adap;
> =A0 =A0 =A0 =A0int irq;
> + =A0 =A0 =A0 u32 real_clk;
> =A0};
>
> =A0struct mpc_i2c_divider {
> @@ -93,20 +94,23 @@ static irqreturn_t mpc_i2c_isr(int irq,
> =A0/* Sometimes 9th clock pulse isn't generated, and slave doesn't releas=
e
> =A0* the bus, because it wants to send ACK.
> =A0* Following sequence of enabling/disabling and sending start/stop gene=
rates
> - * the pulse, so it's all OK.
> + * the 9 pulses, so it's all OK.
> =A0*/
> =A0static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> =A0{
> - =A0 =A0 =A0 writeccr(i2c, 0);
> - =A0 =A0 =A0 udelay(30);
> - =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> - =A0 =A0 =A0 udelay(30);
> - =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX);
> - =A0 =A0 =A0 udelay(30);
> - =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> - =A0 =A0 =A0 udelay(30);
> - =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> - =A0 =A0 =A0 udelay(30);
> + =A0 =A0 =A0 int k;
> + =A0 =A0 =A0 u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> +
> + =A0 =A0 =A0 if (delay_val < 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay_val =3D 2;
> +
> + =A0 =A0 =A0 for (k =3D 9; k; k--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay_val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay_val << 1);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing=
)
> @@ -186,15 +190,19 @@ static const struct mpc_i2c_divider mpc_
> =A0 =A0 =A0 =A0{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
> =A0};
>
> -int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int
> prescaler)
> +int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int
> prescaler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 *real_clk)
> =A0{
> =A0 =A0 =A0 =A0const struct mpc_i2c_divider *div =3D NULL;
> =A0 =A0 =A0 =A0unsigned int pvr =3D mfspr(SPRN_PVR);
> =A0 =A0 =A0 =A0u32 divider;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (!clock)
> + =A0 =A0 =A0 if (!clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* see below - default fdr =3D 0x3f -> div =
=3D 2048 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *real_clk =3D mpc5xxx_get_bus_frequency(nod=
e) / 2048;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Determine divider value */
> =A0 =A0 =A0 =A0divider =3D mpc5xxx_get_bus_frequency(node) / clock;
> @@ -212,7 +220,8 @@ int mpc_i2c_get_fdr_52xx(struct device_n
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return div ? (int)div->fdr : -EINVAL;
> + =A0 =A0 =A0 *real_clk =3D mpc5xxx_get_bus_frequency(node) / div->divide=
r;
> + =A0 =A0 =A0 return (int)div->fdr;
> =A0}
>
> =A0static void mpc_i2c_setclock_52xx(struct device_node *node,
> @@ -221,13 +230,14 @@ static void mpc_i2c_setclock_52xx(struct
> =A0{
> =A0 =A0 =A0 =A0int ret, fdr;
>
> - =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
> + =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler, &i2c->=
real_clk);
> =A0 =A0 =A0 =A0fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibili=
ty */
>
> =A0 =A0 =A0 =A0writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>
> =A0 =A0 =A0 =A0if (ret >=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\=
n", clock, fdr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(i2c->dev, "clock %u Hz (fdr=3D%d)\=
n", i2c->real_clk,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fdr);
> =A0}
> =A0#else /* !CONFIG_PPC_MPC52xx */
> =A0static void mpc_i2c_setclock_52xx(struct device_node *node,
> @@ -287,14 +297,18 @@ u32 mpc_i2c_get_sec_cfg_8xxx(void)
> =A0 =A0 =A0 =A0return val;
> =A0}
>
> -int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32
> prescaler)
> +int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32
> prescaler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 *real_clk)
> =A0{
> =A0 =A0 =A0 =A0const struct mpc_i2c_divider *div =3D NULL;
> =A0 =A0 =A0 =A0u32 divider;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (!clock)
> + =A0 =A0 =A0 if (!clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* see below - default fdr =3D 0x1031 -> di=
v =3D 16 * 3072 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *real_clk =3D fsl_get_sys_freq() / prescale=
r / (16 * 3072);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Determine proper divider value */
> =A0 =A0 =A0 =A0if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
> @@ -317,6 +331,7 @@ int mpc_i2c_get_fdr_8xxx(struct device_n
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 *real_clk =3D fsl_get_sys_freq() / prescaler / div->divider=
;
> =A0 =A0 =A0 =A0return div ? (int)div->fdr : -EINVAL;
> =A0}
>
> @@ -326,7 +341,7 @@ static void mpc_i2c_setclock_8xxx(struct
> =A0{
> =A0 =A0 =A0 =A0int ret, fdr;
>
> - =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
> + =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler, &i2c->=
real_clk);
> =A0 =A0 =A0 =A0fdr =3D (ret >=3D 0) ? ret : 0x1031; /* backward compatibi=
lity */
>
> =A0 =A0 =A0 =A0writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
> @@ -334,7 +349,7 @@ static void mpc_i2c_setclock_8xxx(struct
>
> =A0 =A0 =A0 =A0if (ret >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(i2c->dev, "clock %d Hz (dfsrr=3D%=
d fdr=3D%d)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock, fdr >> 8, fdr & 0=
xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->real_clk, fdr >> 8,=
 fdr & 0xff);
> =A0}
>
> =A0#else /* !CONFIG_FSL_SOC */
> @@ -446,10 +461,14 @@ static int mpc_xfer(struct i2c_adapter *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINTR;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, orig_jiffies + HZ)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 status =3D readb(i2c->ba=
se + MPC_I2C_SR);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(i2c->dev, "timeout=
\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (readb(i2c->base + MPC_I=
2C_SR) =3D=3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (CSR_MCF | CSR_MBB =
| CSR_RXAK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((status & (CSR_MCF | CS=
R_MBB | CSR_RXAK)) !=3D 0)
> {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(stat=
us & ~CSR_MAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0i2c->base + MPC_I2C_SR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc_i2c_fi=
xup(i2c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> @@ -540,6 +559,14 @@ static int __devinit fsl_i2c_probe(struc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 prop =3D of_get_property(op->node, "fsl,timeout", &plen);
> + =A0 =A0 =A0 if (prop && plen =3D=3D sizeof(u32)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_ops.timeout =3D *prop * HZ / 1000000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc_ops.timeout < 5)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_ops.timeout =3D 5;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 100=
0000 /
> HZ);
> +
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
>
> =A0 =A0 =A0 =A0i2c->adap =3D mpc_ops;
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
