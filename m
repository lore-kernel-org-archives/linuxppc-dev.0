Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090407082231.500525932@denx.de>
References: <20090407082052.477328750@denx.de>
	<20090407082231.500525932@denx.de>
Date: Tue, 7 Apr 2009 08:36:05 -0700
Message-ID: <fa686aa40904070836g9e803c8o83b6799ed289c8d5@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] i2c: i2c-mpc: make I2C bus speed configurable
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger <wg@grandegger.com> wro=
te:
> This patch makes the I2C bus speed configurable by using the I2C node
> property "clock-frequency". If the property is not defined, the old
> fixed clock settings will be used for backward comptibility.
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
> relevant pre-scaler for the I2C source clock frequency.
>
> It uses arch-specific tables and functions to determine resonable
> Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
> MPC5200 and MPC5200B.
>
> The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
> have been removed as they are obsolete.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

I haven't tested it, but it looks good and I trust Wolfgang.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0262 ++++++++++++++++++++++++++++++++=
+++++++----
> =A01 file changed, 242 insertions(+), 20 deletions(-)
>
> Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c =A0 2009-04-07 10:0=
9:14.012720756 +0200
> +++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A02009-04-0=
7 10:09:14.581719146 +0200
> @@ -26,6 +26,9 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/delay.h>
>
> +#include <asm/mpc52xx.h>
> +#include <sysdev/fsl_soc.h>
> +
> =A0#define DRV_NAME "mpc-i2c"
>
> =A0#define MPC_I2C_FDR =A0 0x04
> @@ -56,7 +59,18 @@
> =A0 =A0 =A0 =A0wait_queue_head_t queue;
> =A0 =A0 =A0 =A0struct i2c_adapter adap;
> =A0 =A0 =A0 =A0int irq;
> - =A0 =A0 =A0 u32 flags;
> +};
> +
> +struct mpc_i2c_divider {
> + =A0 =A0 =A0 u16 divider;
> + =A0 =A0 =A0 u16 fdr; =A0 =A0 =A0 =A0/* including dfsrr */
> +};
> +
> +struct mpc_i2c_match_data {
> + =A0 =A0 =A0 void (*setclock)(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 clock, u32 prescaler=
);
> + =A0 =A0 =A0 u32 prescaler;
> =A0};
>
> =A0static inline void writeccr(struct mpc_i2c *i2c, u32 x)
> @@ -150,17 +164,180 @@
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
> +#ifdef CONFIG_PPC_52xx
> +static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] =3D {
> + =A0 =A0 =A0 {20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
> + =A0 =A0 =A0 {28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> + =A0 =A0 =A0 {36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
> + =A0 =A0 =A0 {52, 0x63}, {56, 0x29}, {60, 0x41}, {64, 0x2a},
> + =A0 =A0 =A0 {68, 0x07}, {72, 0x2b}, {80, 0x2c}, {88, 0x09},
> + =A0 =A0 =A0 {96, 0x2d}, {104, 0x0a}, {112, 0x2e}, {120, 0x81},
> + =A0 =A0 =A0 {128, 0x2f}, {136, 0x47}, {144, 0x0c}, {160, 0x30},
> + =A0 =A0 =A0 {176, 0x49}, {192, 0x31}, {208, 0x4a}, {224, 0x32},
> + =A0 =A0 =A0 {240, 0x0f}, {256, 0x33}, {272, 0x87}, {288, 0x10},
> + =A0 =A0 =A0 {320, 0x34}, {352, 0x89}, {384, 0x35}, {416, 0x8a},
> + =A0 =A0 =A0 {448, 0x36}, {480, 0x13}, {512, 0x37}, {576, 0x14},
> + =A0 =A0 =A0 {640, 0x38}, {768, 0x39}, {896, 0x3a}, {960, 0x17},
> + =A0 =A0 =A0 {1024, 0x3b}, {1152, 0x18}, {1280, 0x3c}, {1536, 0x3d},
> + =A0 =A0 =A0 {1792, 0x3e}, {1920, 0x1b}, {2048, 0x3f}, {2304, 0x1c},
> + =A0 =A0 =A0 {2560, 0x1d}, {3072, 0x1e}, {3584, 0x7e}, {3840, 0x1f},
> + =A0 =A0 =A0 {4096, 0x7f}, {4608, 0x5c}, {5120, 0x5d}, {6144, 0x5e},
> + =A0 =A0 =A0 {7168, 0xbe}, {7680, 0x5f}, {8192, 0xbf}, {9216, 0x9c},
> + =A0 =A0 =A0 {10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
> +};
> +
> +int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int presca=
ler)
> +{
> + =A0 =A0 =A0 const struct mpc52xx_i2c_divider *div =3D NULL;
> + =A0 =A0 =A0 unsigned int pvr =3D mfspr(SPRN_PVR);
> + =A0 =A0 =A0 u32 divider;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* Determine divider value */
> + =A0 =A0 =A0 divider =3D mpc52xx_find_ipb_freq(node) / clock;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We want to choose an FDR/DFSR that generates an I2C bu=
s speed that
> + =A0 =A0 =A0 =A0* is equal to or lower than the requested speed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(mpc52xx_i2c_dividers); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D &mpc_i2c_dividers_52xx[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Old MPC5200 rev A CPUs do not support th=
e high bits */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (div->fdr & 0xc0 && pvr =3D=3D 0x8082201=
1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (div->divider >=3D divider)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return div ? (int)div->fdr : -EINVAL;
> +}
> +
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
> +#else /* !CONFIG_PPC_52xx */
> +static void mpc_i2c_setclock_52xx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clo=
ck, u32 prescaler)
> +{
> +}
> +#endif /* CONFIG_PPC_52xx*/
> +
> +#ifdef CONFIG_FSL_SOC
> +static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] =3D {
> + =A0 =A0 =A0 {160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
> + =A0 =A0 =A0 {288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
> + =A0 =A0 =A0 {416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
> + =A0 =A0 =A0 {544, 0x0b03}, {576, 0x0104}, {608, 0x1603}, {640, 0x0105},
> + =A0 =A0 =A0 {672, 0x2003}, {704, 0x0b05}, {736, 0x2b03}, {768, 0x0106},
> + =A0 =A0 =A0 {800, 0x3603}, {832, 0x0b06}, {896, 0x012a}, {960, 0x0107},
> + =A0 =A0 =A0 {1024, 0x012b}, {1088, 0x1607}, {1152, 0x0108}, {1216, 0x2b=
07},
> + =A0 =A0 =A0 {1280, 0x0109}, {1408, 0x1609}, {1536, 0x010a}, {1664, 0x16=
0a},
> + =A0 =A0 =A0 {1792, 0x012e}, {1920, 0x010b}, {2048, 0x012f}, {2176, 0x2b=
0b},
> + =A0 =A0 =A0 {2304, 0x010c}, {2560, 0x010d}, {2816, 0x2b0d}, {3072, 0x01=
0e},
> + =A0 =A0 =A0 {3328, 0x2b0e}, {3584, 0x0132}, {3840, 0x010f}, {4096, 0x01=
33},
> + =A0 =A0 =A0 {4608, 0x0110}, {5120, 0x0111}, {6144, 0x0112}, {7168, 0x01=
36},
> + =A0 =A0 =A0 {7680, 0x0113}, {8192, 0x0137}, {9216, 0x0114}, {10240, 0x0=
115},
> + =A0 =A0 =A0 {12288, 0x0116}, {14336, 0x013a}, {15360, 0x0117}, {16384, =
0x013b},
> + =A0 =A0 =A0 {18432, 0x0118}, {20480, 0x0119}, {24576, 0x011a}, {28672, =
0x013e},
> + =A0 =A0 =A0 {30720, 0x011b}, {32768, 0x013f}, {36864, 0x011c}, {40960, =
0x011d},
> + =A0 =A0 =A0 {49152, 0x011e}, {61440, 0x011f}
> +};
> +
> +u32 mpc_i2c_get_sec_cfg_8xxx(void)
> +{
> + =A0 =A0 =A0 struct device_node *node =3D NULL;
> + =A0 =A0 =A0 u32 __iomem *reg;
> + =A0 =A0 =A0 u32 val =3D 0;
> +
> + =A0 =A0 =A0 node =3D of_find_node_by_name(NULL, "global-utilities");
> + =A0 =A0 =A0 if (node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *prop =3D of_get_property(node, "=
reg", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Map and check POR Devi=
ce Status Register 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (PORDEVSR2) at 0xE0014
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D ioremap(get_immrbas=
e() + *prop + 0x14, 0x4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_ERR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"Error: couldn't map PORDEVSR2\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D in_=
be32(reg) & 0x00000080; /* sec-cfg */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> +
> + =A0 =A0 =A0 return val;
> +}
> +
> +int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 presca=
ler)
> +{
> + =A0 =A0 =A0 const struct mpc_i2c_divider *div =3D NULL;
> + =A0 =A0 =A0 u32 divider;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* Determine proper divider value */
> + =A0 =A0 =A0 if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler =3D mpc_i2c_get_sec_cfg_8xxx() ? =
3 : 2;
> + =A0 =A0 =A0 if (!prescaler)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler =3D 1;
> +
> + =A0 =A0 =A0 divider =3D fsl_get_sys_freq() / clock / prescaler;
> +
> + =A0 =A0 =A0 pr_debug("I2C: src_clock=3D%d clock=3D%d divider=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl_get_sys_freq(), clock, divider);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We want to choose an FDR/DFSR that generates an I2C bu=
s speed that
> + =A0 =A0 =A0 =A0* is equal to or lower than the requested speed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(mpc_i2c_dividers_8xxx); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D &mpc_i2c_dividers_8xxx[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (div->divider >=3D divider)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return div ? (int)div->fdr : -EINVAL;
> +}
> +
> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clo=
ck, u32 prescaler)
> +{
> + =A0 =A0 =A0 int fdr =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
> +
> + =A0 =A0 =A0 if (fdr < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x1031; /* backward compatibility *=
/
> + =A0 =A0 =A0 writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
> + =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (dfsrr=3D%d fdr=3D%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock, fdr >> 8, fdr & 0xff);
> +}
> +
> +#else /* !CONFIG_FSL_SOC */
> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mpc_i2c *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clo=
ck, u32 prescaler)
> =A0{
> - =A0 =A0 =A0 /* Set clock and filters */
> - =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x31, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x10, i2c->base + MPC_I2C_DFSRR);
> - =A0 =A0 =A0 } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x3f, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(0x1031, i2c->base + MPC_I2C_FDR);
> =A0}
> +#endif /* CONFIG_FSL_SOC */
>
> =A0static void mpc_i2c_start(struct mpc_i2c *i2c)
> =A0{
> @@ -315,8 +492,11 @@
> =A0static int __devinit fsl_i2c_probe(struct of_device *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
 struct of_device_id *match)
> =A0{
> - =A0 =A0 =A0 int result =3D 0;
> =A0 =A0 =A0 =A0struct mpc_i2c *i2c;
> + =A0 =A0 =A0 const u32 *prop;
> + =A0 =A0 =A0 u32 clock =3D 0;
> + =A0 =A0 =A0 int result =3D 0;
> + =A0 =A0 =A0 int plen;
>
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> @@ -324,13 +504,6 @@
>
> =A0 =A0 =A0 =A0i2c->dev =3D &op->dev; /* for debug and error output */
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
> @@ -350,7 +523,22 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mpc_i2c_setclock(i2c);
> + =A0 =A0 =A0 if (!of_get_property(op->node, "fsl,preserve-clocking", NUL=
L)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(op->node, "clock-f=
requency", &plen);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop && plen =3D=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D *prop;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (match->data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc_i2c_match_data *=
data =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct mpc=
_i2c_match_data *)match->data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->setclock(op->node, i2=
c, clock, data->prescaler);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Backwards compatibility =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->nod=
e, "dfsrr", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_i2c_set=
clock_8xxx(op->node, i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
>
> @@ -395,9 +583,43 @@
> =A0};
>
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {
> - =A0 =A0 =A0 {.compatible =3D "fsl-i2c",},
> + =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_52xx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c",
> + =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_setcl=
ock_8xxx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 /* Backward compatibility */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "fsl-i2c", },
> =A0 =A0 =A0 =A0{},
> =A0};
> +
> =A0MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
