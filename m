Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 9F8321007F6
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 05:02:35 +1100 (EST)
Received: by gxk23 with SMTP id 23so2137848gxk.2
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 10:02:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257175056-26093-1-git-send-email-w.sang@pengutronix.de>
References: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
	<1257175056-26093-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 11:02:10 -0700
Message-ID: <fa686aa40911021002x6d895606s57bca0f9fdd4e81b@mail.gmail.com>
Subject: Re: [PATCH] mpc512x/clocks: initialize CAN clocks
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <hong-jun.chen@freescale.com>,
	John Rigby <jrigby@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

Comments below

On Mon, Nov 2, 2009 at 8:17 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Signed-off-by: John Rigby <jrigby@freescale.com>
> Signed-off-by: Chen Hongjun <hong-jun.chen@freescale.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Should come after the fix for clk_get to be usable for the upcoming CAN d=
river:
> http://patchwork.ozlabs.org/patch/37342/
>
> =A0arch/powerpc/platforms/512x/clock.c | =A0 74 +++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 74 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms=
/512x/clock.c
> index 4168457..2d3a5ef 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -50,6 +50,8 @@ struct clk {
> =A0static LIST_HEAD(clocks);
> =A0static DEFINE_MUTEX(clocks_mutex);
>
> +struct clk mscan_clks[4];
> +

I'd rather not have more globals.  If really needed, should at the
very least be static and prefixed with mpc5121_.

> =A0static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
> =A0{
> =A0 =A0 =A0 =A0struct clk *p, *clk =3D ERR_PTR(-ENOENT);
> @@ -119,6 +121,8 @@ struct mpc512x_clockctl {
> =A0 =A0 =A0 =A0u32 spccr; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* SPDIF Clk Ctrl Re=
g */
> =A0 =A0 =A0 =A0u32 cccr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CFM Clk Ctrl Reg =
*/
> =A0 =A0 =A0 =A0u32 dccr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DIU Clk Cnfg Reg =
*/
> + =A0 =A0 =A0 /* rev2+ only regs */
> + =A0 =A0 =A0 u32 mccr[4]; =A0 =A0 =A0 =A0 =A0 =A0/* MSCAN Clk Ctrl Reg 1=
-4 */
> =A0};
>
> =A0struct mpc512x_clockctl __iomem *clockctl;
> @@ -688,6 +692,72 @@ static void psc_clks_init(void)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +
> +/*
> + * mscan clock rate calculation
> + */
> +static unsigned long mscan_calc_rate(struct device_node *np, int mscannu=
m)
> +{
> + =A0 =A0 =A0 unsigned long mscanclk_src, mscanclk_div;
> + =A0 =A0 =A0 u32 *mccr =3D &clockctl->mccr[mscannum];
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the divider is the reset default of all 1's then
> + =A0 =A0 =A0 =A0* we know u-boot and/or board setup has not
> + =A0 =A0 =A0 =A0* done anything so set up a sane default
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (((in_be32(mccr) >> 17) & 0x7fff) =3D=3D 0x7fff) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(mccr, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* src is sysclk, divider is 4 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(mccr, (0x3 << 17) | 0x10000);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch ((in_be32(mccr) >> 14) & 0x3) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscanclk_src =3D sys_clk.rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscanclk_src =3D ref_clk.rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscanclk_src =3D psc_mclk_in.rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscanclk_src =3D spdif_txclk.rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }

Nit: Table lookup perhaps?

> +
> + =A0 =A0 =A0 mscanclk_src =3D roundup(mscanclk_src, 1000000);
> + =A0 =A0 =A0 mscanclk_div =3D ((in_be32(mccr) >> 17) & 0x7fff) + 1;
> + =A0 =A0 =A0 return mscanclk_src / mscanclk_div;
> +}
> +
> +/*
> + * Find all silicon rev2 mscan nodes in device tree and assign a clock
> + * with name "mscan%d_clk" and dev pointing at the device
> + * returned from of_find_device_by_node
> + */

Comment block doesn't really help me understand what the function does.

> +static void mscan_clks_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 struct of_device *ofdev;
> + =A0 =A0 =A0 const u32 *cell_index;
> +
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-mscan") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell_index =3D of_get_property(np, "cell-in=
dex", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cell_index) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *clk =3D &mscan_=
clks[*cell_index];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->flags =3D CLK_HAS_RATE=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ofdev =3D of_find_device_by=
_node(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->dev =3D &ofdev->dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D mscan_calc_ra=
te(np, *cell_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(clk->name, "mscan%d=
_clk", *cell_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_register(clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}

These clock controllers are 1:1 dedicated to the CAN devices, correct?
 Wouldn't it make more sense to put this code directly into the CAN
bus device driver instead of in common code?  And allocated the clk
structure at driver probe time?  It seems like the only shared bit
seems to be access to the mccr registers.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
