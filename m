Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49C151FF.1080604@grandegger.com>
References: <49C151FF.1080604@grandegger.com>
Date: Wed, 25 Mar 2009 12:16:54 -0600
Message-ID: <fa686aa40903251116n2b7e8326r6c7cb9de8e101c76@mail.gmail.com>
Subject: Re: [RFC] powerpc: i2c-mpc: make I2C bus speed configurable
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(cc'ing the devicetree-discuss mailing list)

On Wed, Mar 18, 2009 at 1:56 PM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> The I2C driver for the MPC still uses a fixed clock divider hard-coded
> into the driver. This issue has already been discussed twice:
>
> =A0http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21933.html
> =A0http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg26923.html
>
> Let's code speak ;-). The attached RFC patch used the following approach:
>
> - the SOC property "i2c-clock-frequency" defines the frequency of the
> =A0I2C source clock, which could be filled in by U-Boot. This avoids all
> =A0the fiddling with getting the proper source clock frequency for the
> =A0processor or board. I will provide a patch for U-Boot if this proposal
> =A0gets accepted.

I'm not thrilled with this since it depends on u-boot being upgraded
to work.  Actually, since this is an i2c only property, I don't think
it belongs in the parent node at all.  The 'clock-frequency' property
below is sufficient.  Having both seems to be two properties
describing the exact same thing.

> - the I2C node uses the property "clock-frequency" to define the desired
> =A0I2C bus frequency. If 0, the FDR/DFSRR register already set by the
> =A0bootloader will not be touched.

I like the property, but I don't like overloading the definition.  A
value of 0 should be undefined and another property used
("fsl,preserve-clocking" perhaps?) to say that the FDR/DFSRR is
already configured.

> - I use Timur's divider table approach from U-Boot as it's more
> =A0efficient than an appropriate algorithm (less code).

As I commented in the previous thread, I don't like the table approach
and I'd rather see it done programmaticaly.  However, I'm not going to
oppose the patch over this issue.  If it works and it doesn't mess up
the dts binding then I'm happy.

But, it is cleaner and less complex if you use the of_match table
.data element to select the correct setclock function.  Also makes it
easier to handle setclock special cases as needed.

> - If none of the above new properties are defined, the old hard-coded
> =A0FDR/DFSRR register settings are used for backward compatibility.

good

> What do you think? I'm still not happy that the tables and lookup
> function are common code. But for the 82xx/85xx/86xx it's not obvious
> to me where to put it.

I think it is just fine where it is.

Cheers,
g.

>
> Note: I'm aware that this patch is not yet perfect, e.g. the documentatio=
n
> of the new bindings are missing and debug messages need to be removed.
>
> Wolfgang.
>
> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0140 ++++++++++++++++++++++++++++++++=
+++++++----
> =A01 file changed, 128 insertions(+), 12 deletions(-)
>
> Index: linux-2.6.29-rc7/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.29-rc7.orig/drivers/i2c/busses/i2c-mpc.c
> +++ linux-2.6.29-rc7/drivers/i2c/busses/i2c-mpc.c
> @@ -58,6 +58,11 @@ struct mpc_i2c {
> =A0 =A0 =A0 =A0u32 flags;
> =A0};
>
> +struct mpc_i2c_div {
> + =A0 =A0 =A0 u16 divider;
> + =A0 =A0 =A0 u16 fdr; =A0 =A0 =A0 =A0/* including dfsrr */
> +};
> +
> =A0static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
> =A0{
> =A0 =A0 =A0 =A0writeb(x, i2c->base + MPC_I2C_CR);
> @@ -153,16 +158,107 @@ static int i2c_wait(struct mpc_i2c *i2c,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
> +static const struct mpc_i2c_div mpc_i2c_8xxx_divs[] =3D {
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
> +/*
> + * Works for both, MPC5200 rev A and rev B processors. The rev B
> + * processors have 2 more bits, which are not used in the table below.
> + */
> +static const struct mpc_i2c_div mpc_i2c_52xx_divs[] =3D {
> + =A0 =A0 =A0 {20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
> + =A0 =A0 =A0 {28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> + =A0 =A0 =A0 {36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
> + =A0 =A0 =A0 {56, 0x29}, {64, 0x2a}, {68, 0x07}, {72, 0x2b},
> + =A0 =A0 =A0 {80, 0x2c}, {88, 0x09}, {96, 0x2d}, {104, 0x0a},
> + =A0 =A0 =A0 {112, 0x2e}, {128, 0x2f}, {144, 0x0c}, {160, 0x30},
> + =A0 =A0 =A0 {192, 0x31}, {224, 0x32}, {240, 0x0f}, {256, 0x33},
> + =A0 =A0 =A0 {288, 0x10}, {320, 0x34}, {384, 0x35}, {448, 0x36},
> + =A0 =A0 =A0 {480, 0x13}, {512, 0x37}, {576, 0x14}, {640, 0x38},
> + =A0 =A0 =A0 {768, 0x39}, {896, 0x3a}, {960, 0x17}, {1024, 0x3b},
> + =A0 =A0 =A0 {1152, 0x18}, {1280, 0x3c}, {1536, 0x3d}, {1792, 0x3e},
> + =A0 =A0 =A0 {1920, 0x1b}, {2048, 0x3f}, {2304, 0x1c}, {2560, 0x1d},
> + =A0 =A0 =A0 {3072, 0x1e}, {3840, 0x1f}
> +};
> +
> +static u16 mpc_i2c_get_fdr(const struct mpc_i2c_div *divs, int count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 divider)
> =A0{
> - =A0 =A0 =A0 /* Set clock and filters */
> - =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x31, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x10, i2c->base + MPC_I2C_DFSRR);
> - =A0 =A0 =A0 } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x3f, i2c->base + MPC_I2C_FDR);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(0x1031, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 const struct mpc_i2c_div *div =3D NULL;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We want to choose an FDR/DFSR that generates an I2C bu=
s speed that
> + =A0 =A0 =A0 =A0* is equal to or lower than the requested speed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D &divs[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (div->divider >=3D divider)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return div ? div->fdr : 0;
> +}
> +
> +static void mpc_i2c_setclock(struct mpc_i2c *i2c, u32 src_clock, u32 clo=
ck)
> +{
> + =A0 =A0 =A0 u32 divider;
> + =A0 =A0 =A0 u16 fdr;
> +
> + =A0 =A0 =A0 if (src_clock && !clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return; /* clock already configured by boot=
loader */
> +
> + =A0 =A0 =A0 divider =3D (src_clock && clock) ? src_clock / clock : 0;
> +
> + =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_CLOCK_5200) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: old fdr=3D%d\n", readb(i2c->ba=
se + MPC_I2C_FDR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (divider)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D mpc_i2c_get_fdr(mpc=
_i2c_52xx_divs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ARRAY_SIZE(mpc_i2c_52xx_divs),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 divider);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x3f; /* backward c=
ompatibility */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(fdr, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: clock %d Hz (fdr=3D%d)\n", clo=
ck, fdr);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (divider)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D mpc_i2c_get_fdr(mpc=
_i2c_8xxx_divs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ARRAY_SIZE(mpc_i2c_8xxx_divs),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 divider);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x1031; /* backward=
 compatibility */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: old dfsrr=3D%d=
 fdr=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readb(i2c->b=
ase + MPC_I2C_DFSRR),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readb(i2c->b=
ase + MPC_I2C_FDR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(fdr & 0xff, i2c->bas=
e + MPC_I2C_FDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(fdr >> 8, i2c->base =
+ MPC_I2C_DFSRR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: clock %d Hz (d=
fsrr=3D%d fdr=3D%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock, fdr >=
> 8, fdr & 0xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: old fdr=3D%d\n=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readl(i2c->b=
ase + MPC_I2C_FDR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(fdr, i2c->base + MPC=
_I2C_FDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("I2C: clock %d Hz (f=
dr=3D%d)\n", clock, fdr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void mpc_i2c_start(struct mpc_i2c *i2c)
> @@ -316,13 +412,33 @@ static struct i2c_adapter mpc_ops =3D {
>
> =A0static int __devinit fsl_i2c_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0{
> - =A0 =A0 =A0 int result =3D 0;
> + =A0 =A0 =A0 struct device_node *parent;
> =A0 =A0 =A0 =A0struct mpc_i2c *i2c;
> + =A0 =A0 =A0 const u32 *prop;
> + =A0 =A0 =A0 u32 src_clock, clock;
> + =A0 =A0 =A0 int result =3D 0;
> + =A0 =A0 =A0 int plen;
> +
> + =A0 =A0 =A0 parent =3D of_get_parent(op->node);
> + =A0 =A0 =A0 if (!parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> + =A0 =A0 =A0 prop =3D of_get_property(parent, "i2c-clock-frequency", &pl=
en);
> + =A0 =A0 =A0 if (prop && plen =3D=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_clock =3D *prop;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_clock =3D 0;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(op->node, "clock-frequency", &plen=
);
> + =A0 =A0 =A0 if (prop && plen =3D=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D *prop;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D 0;
> +
> =A0 =A0 =A0 =A0if (of_get_property(op->node, "dfsrr", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR=
;
>
> @@ -348,8 +464,8 @@ static int __devinit fsl_i2c_probe(struc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_request;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 mpc_i2c_setclock(i2c);
> +
> + =A0 =A0 =A0 mpc_i2c_setclock(i2c, src_clock, clock);
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
