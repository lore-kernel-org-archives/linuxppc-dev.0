Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49D36885.9070806@grandegger.com>
References: <49D36885.9070806@grandegger.com>
Date: Wed, 1 Apr 2009 07:44:59 -0600
Message-ID: <fa686aa40904010644t1c111c05ka7349869eb155429@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: i2c-mpc: make I2C bus speed configurable
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

On Wed, Apr 1, 2009 at 7:13 AM, Wolfgang Grandegger <wg@grandegger.com> wro=
te:
> This patch makes the I2C bus speed configurable by using the I2C node
> property "clock-frequency". If the property is not defined, the old
> fixed clock settings will be used for backward compatibility.
>
> The generic I2C clock properties, especially the CPU-specific source
> clock pre-scaler are defined via the OF match table:
>
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8543-i2c",
> =A0 =A0 =A0 =A0 .data =3D &(struct fsl_i2c_match_data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.setclock =3D mpc_i2c_setc=
lock_8xxx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.prescaler =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
>
> The "data" field defines the relevant I2C setclock function and the
> relevant prescaler for the I2C source clock frequency.
>
> It uses arch-specific tables and functions to determine resonable
> Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
> MPC5200 and MPC5200B.
>
> The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
> have been removed as they are obsolete.
>
> Furthermore dev_dbg() and dev_info() are now used to profit from a more
> comprehensive output.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c =A0 | =A0 57 ++++++++++
> =A0arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 90 ++++++++++++++++
> =A0arch/powerpc/sysdev/fsl_soc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 ++
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I mostly like this patch.  However, as I mentioned in my other reply,
I'm going to NAK it because the divisor tables are not common code and
do not belong in common code files.

Other than that, I like this version of the patch and I think it is
almost finished.  More comments below.

> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
> -{
> - =A0 =A0 =A0 /* Set clock and filters */
> - =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x31, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x10, i2c->base + MPC_I2C_DFSRR);
> - =A0 =A0 =A0 } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x3f, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(0x1031, i2c->base + MPC_I2C_FDR);
> +static void mpc_i2c_setclock_52xx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clo=
ck, u32 prescaler)
> +{
> + =A0 =A0 =A0 int fdr =3D mpc52xx_i2c_get_fdr(node, clock, prescaler);
> +
> + =A0 =A0 =A0 if (fdr < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x3f; /* backward compatibility */
> + =A0 =A0 =A0 writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\n", clock, fdr);
> +}
> +
> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clo=
ck, u32 prescaler)
> +{
> + =A0 =A0 =A0 int fdr =3D fsl_i2c_get_fdr(node, clock, prescaler);
> +
> + =A0 =A0 =A0 if (fdr < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x1031; /* backward compatibility *=
/
> + =A0 =A0 =A0 writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
> + =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (dfsrr=3D%d fdr=3D%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock, fdr >> 8, fdr & 0xff);
> =A0}

Very neat and tidy indeed.  I like this.

> Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A02009-03-3=
1 21:27:52.000000000 +0200
> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 2009-04-01 12:09:18.7=
96719327 +0200
> @@ -39,7 +39,7 @@
> =A0#include <sysdev/fsl_soc.h>
> =A0#include <mm/mmu_decl.h>
> =A0#include <asm/cpm2.h>
> -
> +#define DEBUG
  ^^^^^^^^^^^^^^^^^^^^^^^  oops?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
