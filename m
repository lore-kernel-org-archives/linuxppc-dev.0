Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id A4110DE00C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:19:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so953566wri.3
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 07:19:06 -0700 (PDT)
Message-ID: <fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
Date: Mon, 21 Apr 2008 08:19:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
In-Reply-To: <20080418190959.GD4407@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 1:09 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> This is needed to access QE GPIOs via Linux GPIO API.
>
>  Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>  ---
>  diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>  index 827b630..5c9cfab 100644
>  --- a/Documentation/powerpc/booting-without-of.txt
>  +++ b/Documentation/powerpc/booting-without-of.txt
>  @@ -1721,24 +1721,32 @@ platforms are moved over to use the flattened-device-tree model.
>     information.
>
>     Required properties:
>  -   - device_type : should be "par_io".
>  +   - #gpio-cells : should be "2".
>  +   - compatible : should be "fsl,qe-pario-bank-<bank>", "fsl,qe-pario-bank"

Once again; I don't like the generic compatible values.  Please
include the exact chip name in the string.  ie: "fsl,<chip>-qe-pario".

"fsl,qe-pario-bank" is not a real thing.  If you want a common
compatible string that the driver can bind against, then choose one
real part and add it to the compatible list for all the other parts.

Also, why is <bank> encoded in compatible?  Do the different banks
have different register interfaces?

>     - reg : offset to the register set and its length.
>  -   - num-ports : number of Parallel I/O ports
>  +   - gpio-controller : node to identify gpio controllers.
>
>  -   Example:
>  -       par_io@1400 {
>  -               reg = <1400 100>;
>  -               #address-cells = <1>;
>  -               #size-cells = <0>;
>  -               device_type = "par_io";
>  -               num-ports = <7>;
>  -               ucc_pin@01 {
>  -                       ......
>  -               };
>  +   For example, two QE Par I/O banks:
>  +       qe_pio_a: gpio-controller@1400 {
>  +               #gpio-cells = <2>;
>  +               compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
>  +               reg = <0x1400 0x18>;
>  +               gpio-controller;
>  +       };
>
>  +       qe_pio_e: gpio-controller@1460 {
>  +               #gpio-cells = <2>;
>  +               compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
>  +               reg = <0x1460 0x18>;
>  +               gpio-controller;
>  +       };
>
>     vi) Pin configuration nodes
>
>  +   NOTE: pin configuration nodes are obsolete. Usually, their existance
>  +         is an evidence of the firmware shortcomings. Such fixups are
>  +         better handled by the Linux board file, not the device tree.
>  +
>     Required properties:
>     - linux,phandle : phandle of this node; likely referenced by a QE
>       device.
>  diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
>  index f38c50b..f6eecd1 100644
>  --- a/arch/powerpc/platforms/Kconfig
>  +++ b/arch/powerpc/platforms/Kconfig
>  @@ -270,6 +270,8 @@ config QUICC_ENGINE
>         bool
>         select PPC_LIB_RHEAP
>         select CRC32
>  +       select GENERIC_GPIO
>  +       select HAVE_GPIO_LIB
>         help
>           The QUICC Engine (QE) is a new generation of communications
>           coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
>  diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>  index bbd2834..cee56f9 100644
>  --- a/drivers/gpio/Kconfig
>  +++ b/drivers/gpio/Kconfig
>  @@ -25,6 +25,15 @@ config DEBUG_GPIO
>
>   # put expanders in the right section, in alphabetical order
>
>  +comment "On-chip GPIOs:"
>  +
>  +config GPIO_QE
>  +       bool "QUICC Engine GPIOs"
>  +       depends on QUICC_ENGINE
>  +       help
>  +         Say Y here to use GPIOs on the Freescale PowerPC CPUs with
>  +         QUICC Engine block.
>  +
>   comment "I2C GPIO expanders:"
>
>   config GPIO_PCA953X
>  diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>  index fdde992..fd0a41f 100644
>  --- a/drivers/gpio/Makefile
>  +++ b/drivers/gpio/Makefile
>  @@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_GPIO_LIB)     += gpiolib.o
>   obj-$(CONFIG_GPIO_MCP23S08)    += mcp23s08.o
>   obj-$(CONFIG_GPIO_PCA953X)     += pca953x.o
>   obj-$(CONFIG_GPIO_PCF857X)     += pcf857x.o
>  +obj-$(CONFIG_GPIO_QE)          += qe.o

Since this isn't an of_platform or a platform driver; I'd put it into
arch/powerpc instead.

>  diff --git a/drivers/gpio/qe.c b/drivers/gpio/qe.c
>  new file mode 100644
>  index 0000000..474bc44
>  --- /dev/null
>  +++ b/drivers/gpio/qe.c
>  +static int __init qe_add_gpiochips(void)
>  +{
>  +       int ret;
>  +       struct device_node *np;
>  +
>  +       for_each_compatible_node(np, NULL, "fsl,qe-pario-bank") {
>  +               struct qe_gpio_chip *qe_gc;
>  +               struct of_mm_gpio_chip *mm_gc;
>  +               struct of_gpio_chip *of_gc;
>  +               struct gpio_chip *gc;
>  +
>  +               qe_gc = kzalloc(sizeof(*qe_gc), GFP_KERNEL);
>  +               if (!qe_gc) {
>  +                       ret = -ENOMEM;
>  +                       goto err;
>  +               }
>  +
>  +               spin_lock_init(&qe_gc->lock);
>  +
>  +               mm_gc = &qe_gc->mm_gc;
>  +               of_gc = &mm_gc->of_gc;
>  +               gc = &of_gc->gc;
>  +
>  +               mm_gc->save_regs = qe_gpio_save_regs;
>  +               of_gc->gpio_cells = 2;
>  +               gc->ngpio = QE_PIO_PINS;
>  +               gc->direction_input = qe_gpio_dir_in;
>  +               gc->direction_output = qe_gpio_dir_out;
>  +               gc->get = qe_gpio_get;
>  +               gc->set = qe_gpio_set;
>  +
>  +               ret = of_mm_gpiochip_add(np, mm_gc);
>  +               if (ret)
>  +                       goto err;
>  +       }
>  +
>  +       return 0;
>  +err:
>  +       pr_err("%s: registration failed with status %d\n", np->full_name, ret);
>  +       of_node_put(np);
>  +       return ret;
>  +}
>  +arch_initcall(qe_add_gpiochips);

Should this really be a arch_initcall()?  Would it be better for
platforms needing it to call it explicitly from one of the platform's
machine_arch_initcall()?  Otherwise it gets called for all platforms
in a multiplatform kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
