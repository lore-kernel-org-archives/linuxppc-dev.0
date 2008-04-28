Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id 8BAB0DDFC2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:56:17 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4115318wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 12:56:15 -0700 (PDT)
Message-ID: <fa686aa40804281256y722d8cf6pcae462d68b04e01f@mail.gmail.com>
Date: Mon, 28 Apr 2008 13:56:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428145310.553b8271@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428145310.553b8271@lappy.seanm.ca>
Cc: Sean MacLennan <seanm@seanm.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 12:53 PM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> Ok, here is another version of the patch with Stephen Rothwell's and
>  Grant Likely's suggestions.
>
>  Cheers,
>   Sean

A few more comments below.

Also, it might help to split up the .dts and code changes into 2
separate patches.  That way the .dts can be picked up even if the
actual platform code still needs some revisions.

Finally, since this is a 4xx board port, you need to cc: Josh Boyer on
these patches.

>  diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
>  index b04a52e..d124497 100644
> --- a/arch/powerpc/boot/dts/warp.dts
>  +++ b/arch/powerpc/boot/dts/warp.dts
>  @@ -186,6 +179,16 @@
>                                 reg = <ef600700 14>;
>                                 interrupt-parent = <&UIC0>;
>                                 interrupts = <2 4>;
>  +                               index = <0>;
>  +                               #address-cells = <1>;
>  +                               #size-cells = <0>;
>  +
>  +                               ad7414@4a {
>  +                                       compatible = "adi,ad7414";
>  +                                       reg = <4a>;
>  +                                       interrupts = <19 8>;
>  +                                       interrupt-parent = <&UIC0>;
>  +                               };
>                         };
>
>                         GPIO0: gpio@ef600b00 {
>  @@ -196,8 +199,22 @@
>                         GPIO1: gpio@ef600c00 {
>                                 compatible = "ibm,gpio-440ep";
>                                 reg = <ef600c00 48>;
>  +
>  +                       };

You need to add the gpio-controller and #gpio-cells properties to the
GPIO nodes for the LED's gpios property to work correctly.  Search for
"2) gpio-controller nodes" in
Documentation/powerpc/booting-without-of.txt for details.  #gpio-cells
should probably be '2' for this gpio controller; 1 cell for the gpio
pin and 1 cell for flags.

>  +
>  +                       led@31 {
>
> +                               compatible = "linux,gpio-led";
>  +                               linux,name = "green";
>  +                               gpios = <&GPIO1 31>;
>  +                       };
>  +
>  +                       led@30 {
>  +                               compatible = "linux,gpio-led";
>  +                               linux,name = "red";
>  +                               gpios = <&GPIO1 30>;
>                         };

These should not be children of the soc node (they are not part of the
SoC internal bus).  However, I think it would be perfectly valid to
make them children of the gpio node since they don't have any
connections to other device on the platform.

>
>  +
>                         ZMII0: emac-zmii@ef600d00 {
>                                 compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
>                                 reg = <ef600d00 c>;
>
> diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
>  index 9150318..d293c70 100644
>
> --- a/arch/powerpc/platforms/44x/warp-nand.c
>  +++ b/arch/powerpc/platforms/44x/warp-nand.c
>  @@ -11,8 +11,10 @@
>   #include <linux/mtd/partitions.h>
>   #include <linux/mtd/nand.h>
>   #include <linux/mtd/ndfc.h>
>  +#include <linux/of.h>
>
>
>  #include <asm/machdep.h>
>
>  +
>   #ifdef CONFIG_MTD_NAND_NDFC
>
>   #define CS_NAND_0      1       /* use chip select 1 for NAND device 0 */
>  @@ -35,13 +37,23 @@ static struct mtd_partition nand_parts[] = {
>         {
>                 .name   = "root",
>                 .offset = 0x0200000,
>  -               .size   = 0x3400000
>  +               .size   = 0x3E00000
>  +       },
>  +       {
>  +               .name   = "persistent",
>  +               .offset = 0x4000000,
>  +               .size   = 0x4000000
>         },
>         {
>  -               .name   = "user",
>  -               .offset = 0x3600000,
>  -               .size   = 0x0A00000
>  +               .name   = "persistent1",
>  +               .offset = 0x8000000,
>  +               .size   = 0x4000000
>         },
>  +       {
>  +               .name   = "persistent2",
>  +               .offset = 0xC000000,
>  +               .size   = 0x4000000
>  +       }
>   };

Why is this information in the dts *and* the platform file?  I haven't
been following the flash partition map binding conventions, but having
it in both places looks wrong....

oh, wait... the one in the dts is for NOR and this one is for NAND,
right?  And we don't have a binding yet for NAND partitions yet,
correct?

>
>   struct ndfc_controller_settings warp_ndfc_settings = {
>  @@ -67,19 +79,15 @@ static struct platform_device warp_ndfc_device = {
>         .resource = &warp_ndfc,
>   };
>
>  -static struct nand_ecclayout nand_oob_16 = {
>  -       .eccbytes = 3,
>  -       .eccpos = { 0, 1, 2, 3, 6, 7 },
>  -       .oobfree = { {.offset = 8, .length = 16} }
>  -};
>  -
>  +/* Do NOT set the ecclayout: let it default so it is correct for both
>  + * 64M and 256M flash chips.
>  + */
>   static struct platform_nand_chip warp_nand_chip0 = {
>         .nr_chips = 1,
>         .chip_offset = CS_NAND_0,
>         .nr_partitions = ARRAY_SIZE(nand_parts),
>         .partitions = nand_parts,
>  -       .chip_delay = 50,
>  -       .ecclayout = &nand_oob_16,
>  +       .chip_delay = 20,
>         .priv = &warp_chip0_settings,
>   };
>
>  @@ -96,6 +104,23 @@ static struct platform_device warp_nand_device = {
>
>   static int warp_setup_nand_flash(void)
>   {
>  +       struct device_node *np;
>  +
>  +       /* Try to detect a rev A based on NOR size. */
>  +       np = of_find_compatible_node(NULL, NULL, "cfi-flash");
>  +       if (np) {
>  +               struct property *pp;
>  +
>  +               pp = of_find_property(np, "reg", NULL);
>  +               if (pp && (pp->length == 12)) {
>  +                       u32 *v = pp->value;
>  +                       if (v[2] == 0x4000000)
>  +                               /* Rev A = 64M NAND */
>  +                               warp_nand_chip0.nr_partitions = 2;
>  +               }
>  +               of_node_put(np);
>  +       }
>  +
>         platform_device_register(&warp_ndfc_device);
>         platform_device_register(&warp_nand_device);
>
>  diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
>  index 39cf615..8f7d016 100644
>
> --- a/arch/powerpc/platforms/44x/warp.c
>  +++ b/arch/powerpc/platforms/44x/warp.c
>  @@ -12,6 +12,10 @@
>
>  #include <linux/init.h>
>   #include <linux/of_platform.h>
>   #include <linux/kthread.h>
>  +#include <linux/i2c.h>
>  +#include <linux/interrupt.h>
>  +#include <linux/pika.h>
>  +#include <linux/delay.h>
>
>
>   #include <asm/machdep.h>
>   #include <asm/prom.h>
>  @@ -27,6 +31,18 @@ static __initdata struct of_device_id warp_of_bus[] = {
>
>         {},
>   };
>
>  +static __initdata struct i2c_board_info warp_i2c_info[] = {
>  +       { I2C_BOARD_INFO("ad7414", 0x4a) }
>  +};
>  +
>  +static int __init warp_arch_init(void)
>  +{
>  +       /* This should go away once support is moved to the dts. */
>  +       i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
>  +       return 0;
>  +}
>  +machine_arch_initcall(warp, warp_arch_init);
>  +
>   static int __init warp_device_probe(void)
>   {
>         of_platform_bus_probe(NULL, warp_of_bus, NULL);
>  @@ -52,61 +68,232 @@ define_machine(warp) {
>
>
>  };
>
>
>  -#define LED_GREEN (0x80000000 >> 0)
>  -#define LED_RED   (0x80000000 >> 1)
>  +/* I am not sure this is the best place for this... */
>  +static int __init warp_post_info(void)
>  +{
>  +       struct device_node *np;
>  +       void __iomem *fpga;
>  +       u32 post1, post2;
>  +
>  +       /* Sighhhh... POST information is in the sd area. */
>  +       np = of_find_compatible_node(NULL, NULL, "pika,fpga-sd");
>  +       if (np == NULL)
>  +               return -ENOENT;
>  +
>  +       fpga = of_iomap(np, 0);
>  +       of_node_put(np);
>  +       if (fpga == NULL)
>  +               return -ENOENT;
>  +
>  +       post1 = in_be32(fpga + 0x40);
>  +       post2 = in_be32(fpga + 0x44);
>  +
>  +       iounmap(fpga);
>  +
>  +       if (post1 || post2)
>  +               printk(KERN_INFO "Warp POST %08x %08x\n", post1, post2);
>  +       else
>  +               printk(KERN_INFO "Warp POST OK\n");
>  +
>  +       return 0;
>  +}
>  +machine_late_initcall(warp, warp_post_info);
>  +
>  +
>  +#ifdef CONFIG_SENSORS_AD7414
<snip>
>  +#else /* !CONFIG_SENSORS_AD7414 */
>
> +
>  +int dtm_register_shutdown(void (*func)(void *arg), void *arg)
>  +{
>  +       return 0;
>  +}
>
> +
>  +int dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
>  +{
>  +       return 0;
>  +}
>  +
>   #endif
>  +
>
> +EXPORT_SYMBOL(dtm_register_shutdown);
>
> +EXPORT_SYMBOL(dtm_unregister_shutdown);

When exporting symbols for platform code you should avoid polluting
the global Linux namespace and prefix the functions with your platform
name.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
