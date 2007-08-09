Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 3DDA5DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:42:20 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so711717wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 11:42:18 -0700 (PDT)
Message-ID: <fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
Date: Thu, 9 Aug 2007 12:42:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/6/07, Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> wrote:
> Make support for Xilinx boards more generic, making it easier
> to add new boards.  Add initial support for xupv2p and ml410 boards.
>
> Thanks,
>    Wolfgang
>
>
> Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Comments below...

> ---
>  arch/ppc/boot/simple/Makefile                      |    3 +-
>  arch/ppc/boot/simple/embed_config.c                |    4 +-
>  arch/ppc/platforms/4xx/Kconfig                     |   15 +
>  arch/ppc/platforms/4xx/Makefile                    |    2 +
>  arch/ppc/platforms/4xx/virtex.h                    |    9 +
>  arch/ppc/platforms/4xx/xilinx_generic_ppc.c        |  129 ++++++++
>  arch/ppc/platforms/4xx/xilinx_xupv2p.c             |   43 +++
>  arch/ppc/platforms/4xx/xparameters/xparameters.h   |    4 +
>  .../platforms/4xx/xparameters/xparameters_ml41x.h  |  277 +++++++++++++++++
>  .../platforms/4xx/xparameters/xparameters_xupv2p.h |  327 ++++++++++++++++++++
>  10 files changed, 809 insertions(+), 4 deletions(-)
>  create mode 100644 arch/ppc/platforms/4xx/xilinx_generic_ppc.c
>  create mode 100644 arch/ppc/platforms/4xx/xilinx_xupv2p.c
>  create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h
>  create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h
>
> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
> index 5b87779..05631fe 100644
> --- a/arch/ppc/boot/simple/Makefile
> +++ b/arch/ppc/boot/simple/Makefile
> @@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)    += embed_config.o
>  boot-$(CONFIG_8xx)             += embed_config.o
>  boot-$(CONFIG_8260)            += embed_config.o
>  boot-$(CONFIG_EP405)           += embed_config.o
> -boot-$(CONFIG_XILINX_ML300)    += embed_config.o
> -boot-$(CONFIG_XILINX_ML403)    += embed_config.o
> +boot-$(CONFIG_XILINX_VIRTEX)   += embed_config.o
>  boot-$(CONFIG_BSEIP)           += iic.o
>  boot-$(CONFIG_MBX)             += iic.o pci.o qspan_pci.o
>  boot-$(CONFIG_MV64X60)         += misc-mv64x60.o
> diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
> index 840bff2..e0b8954 100644
> --- a/arch/ppc/boot/simple/embed_config.c
> +++ b/arch/ppc/boot/simple/embed_config.c
> @@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
>  }
>  #endif /* WILLOW */
>
> -#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
> +#if defined(CONFIG_XILINX_VIRTEX)

You need to rebase your patch to mainline.  This change has already been applied

>  void
>  embed_config(bd_t ** bdp)
>  {
> @@ -781,7 +781,7 @@ embed_config(bd_t ** bdp)
>         timebase_period_ns = 1000000000 / bd->bi_tbfreq;
>         /* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
>  }
> -#endif /* CONFIG_XILINX_ML300 || CONFIG_XILINX_ML403 */
> +#endif /* CONFIG_XILINX_VIRTEX */

ditto

>
>  #ifdef CONFIG_IBM_OPENBIOS
>  /* This could possibly work for all treeboot roms.
> diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
> index d7db7e4..56965cb 100644
> --- a/arch/ppc/platforms/4xx/Kconfig
> +++ b/arch/ppc/platforms/4xx/Kconfig
> @@ -60,12 +60,27 @@ config XILINX_ML300
>         help
>           This option enables support for the Xilinx ML300 evaluation board.
>
> +config XILINX_XUPV2P
> +       bool "Xilinx-XUPV2P"
> +       select XILINX_VIRTEX_II_PRO
> +       select EMBEDDEDBOOT
> +       help
> +         This option enables support for the Xilinx University Program (XUP) Virtex 2 Pro board.
> +
>  config XILINX_ML403
>         bool "Xilinx-ML403"
>         select XILINX_VIRTEX_4_FX
>         select EMBEDDEDBOOT
>         help
>           This option enables support for the Xilinx ML403 evaluation board.
> +
> +config XILINX_ML41x
> +       bool "Xilinx-ML41x"
> +       select XILINX_VIRTEX_4_FX
> +       select EMBEDDEDBOOT
> +       help
> +         This option enables support for the Xilinx ML410/411 evaluation boards.
> +
>  endchoice
>
>  choice
> diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
> index 723ad79..bcf1a63 100644
> --- a/arch/ppc/platforms/4xx/Makefile
> +++ b/arch/ppc/platforms/4xx/Makefile
> @@ -15,7 +15,9 @@ obj-$(CONFIG_SYCAMORE)                += sycamore.o
>  obj-$(CONFIG_TAISHAN)          += taishan.o
>  obj-$(CONFIG_WALNUT)           += walnut.o
>  obj-$(CONFIG_XILINX_ML300)     += xilinx_ml300.o
> +obj-$(CONFIG_XILINX_XUPV2P)    += xilinx_generic_ppc.o xilinx_xupv2p.o
>  obj-$(CONFIG_XILINX_ML403)     += xilinx_ml403.o
> +obj-$(CONFIG_XILINX_ML41x)     += xilinx_generic_ppc.o
>
>  obj-$(CONFIG_405GP)            += ibm405gp.o
>  obj-$(CONFIG_REDWOOD_5)                += ibmstb4.o
> diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
> index 7382804..47f67b3 100644
> --- a/arch/ppc/platforms/4xx/virtex.h
> +++ b/arch/ppc/platforms/4xx/virtex.h
> @@ -31,5 +31,14 @@ extern const char* virtex_machine_name;
>  #define PPC4xx_ONB_IO_VADDR    0u
>  #define PPC4xx_ONB_IO_SIZE     0u
>
> +
> +#if defined(CONFIG_XILINX_VIRTEX_II_PRO)
> +#define XILINX_ARCH "Virtex-II Pro"
> +#elif defined(CONFIG_XILINX_VIRTEX_4_FX)
> +#define XILINX_ARCH "Virtex-4 FX"
> +#else
> +#error "No Xilinx Architecture recognized."
> +#endif
> +

XILINX_ARCH is used in exactly *one* place; I wouldn't add it to the
header file.

>  #endif                         /* __ASM_VIRTEX_H__ */
>  #endif                         /* __KERNEL__ */
> diff --git a/arch/ppc/platforms/4xx/xilinx_generic_ppc.c b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c

This is a clone of arch/ppc/platforms/4xx/xilinx_ml300.c and
xilinx_ml403.c; yet you don't remove the old files or consolidate
ml300 and ml403 to use them.  You should separate this change into a
separate patch that just consolidates the xilinx_ml300 & xilinx_ml403,
and then add the other boards in a second patch.

BTW, if you do so, you should add '__attribute ((weak))' to the
definition of platform_init so it can be overridden when needed.

> new file mode 100644
> index 0000000..103e762
> --- /dev/null
> +++ b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c
> @@ -0,0 +1,129 @@
> +/*
> + * Xilinx Generic PPC evaluation board initialization
> + *
> + * Author: MontaVista Software, Inc.
> + *         source@mvista.com
> + *
> + * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
> + * terms of the GNU General Public License version 2.  This program is licensed
> + * "as is" without any warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serialP.h>
> +#include <linux/io.h>
> +#include <asm/machdep.h>
> +
> +#include <syslib/gen550.h>
> +#include <syslib/virtex_devices.h>
> +#include <platforms/4xx/xparameters/xparameters.h>
> +
> +/*
> + * As an overview of how the following functions (platform_init,
> + * xilinx_generic_ppc_map_io, xilinx_generic_ppc_setup_arch and xilinx_generic_ppc_init_IRQ) fit into the
> + * kernel startup procedure, here's a call tree:
> + *
> + * start_here                                  arch/ppc/kernel/head_4xx.S
> + *  early_init                                 arch/ppc/kernel/setup.c
> + *  machine_init                               arch/ppc/kernel/setup.c
> + *    platform_init                            this file
> + *      ppc4xx_init                            arch/ppc/syslib/ppc4xx_setup.c
> + *        parse_bootinfo
> + *          find_bootinfo
> + *        "setup some default ppc_md pointers"
> + *  MMU_init                                   arch/ppc/mm/init.c
> + *    *ppc_md.setup_io_mappings == xilinx_generic_ppc_map_io   this file
> + *      ppc4xx_map_io                          arch/ppc/syslib/ppc4xx_setup.c
> + *  start_kernel                               init/main.c
> + *    setup_arch                               arch/ppc/kernel/setup.c
> + * #if defined(CONFIG_KGDB)
> + *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
> + * #endif
> + *      *ppc_md.setup_arch == xilinx_generic_ppc_setup_arch    this file
> + *        ppc4xx_setup_arch                    arch/ppc/syslib/ppc4xx_setup.c
> + *          ppc4xx_find_bridges                        arch/ppc/syslib/ppc405_pci.c
> + *    init_IRQ                                 arch/ppc/kernel/irq.c
> + *      *ppc_md.init_IRQ == xilinx_generic_ppc_init_IRQ        this file
> + *        ppc4xx_init_IRQ                      arch/ppc/syslib/ppc4xx_setup.c
> + *          ppc4xx_pic_init                    arch/ppc/syslib/xilinx_pic.c
> + */
> +
> +#if defined(CONFIG_XILINX_ML300)
> +const char *virtex_machine_name = "Xilinx ML300";
> +#elif defined(CONFIG_XILINX_XUPV2P)
> +const char *virtex_machine_name = "Xilinx XUPV2P";
> +#elif defined(CONFIG_XILINX_ML40x)
> +const char *virtex_machine_name = "Xilinx ML40x";
> +#elif defined(CONFIG_XILINX_ML41x)
> +const char *virtex_machine_name = "Xilinx ML41x";
> +#else
> +const char *virtex_machine_name = "Unknown Xilinx with PowerPC";
> +#endif
> +
> +
> +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> +static volatile unsigned *powerdown_base =
> +    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
> +
> +static void
> +xilinx_power_off(void)
> +{
> +       local_irq_disable();
> +       out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
> +       while (1) ;
> +}
> +#endif
> +
> +void __init
> +xilinx_generic_ppc_map_io(void)
> +{
> +       ppc4xx_map_io();
> +
> +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> +       powerdown_base = ioremap((unsigned long) powerdown_base,
> +                                XPAR_POWER_0_POWERDOWN_HIGHADDR -
> +                                XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
> +#endif
> +}
> +
> +void __init
> +xilinx_generic_ppc_setup_arch(void)
> +{
> +       virtex_early_serial_map();
> +       ppc4xx_setup_arch();    /* calls ppc4xx_find_bridges() */
> +
> +       /* Identify the system */
> +       printk(KERN_INFO "Xilinx Generic PowerPC board support package (%s) (%s)\n", PPC4xx_MACHINE_NAME, XILINX_ARCH);
> +}
> +
> +/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
> +void __init
> +xilinx_generic_ppc_init_irq(void)
> +{
> +       ppc4xx_init_IRQ();
> +}
> +
> +void __init
> +platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +        unsigned long r6, unsigned long r7)
> +{
> +       ppc4xx_init(r3, r4, r5, r6, r7);
> +
> +       ppc_md.setup_arch = xilinx_generic_ppc_setup_arch;
> +       ppc_md.setup_io_mappings = xilinx_generic_ppc_map_io;
> +       ppc_md.init_IRQ = xilinx_generic_ppc_init_irq;
> +
> +#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
> +       ppc_md.power_off = xilinx_power_off;
> +#endif
> +
> +#ifdef CONFIG_KGDB
> +       ppc_md.early_serial_map = virtex_early_serial_map;
> +#endif
> +}
> +
> diff --git a/arch/ppc/platforms/4xx/xilinx_xupv2p.c b/arch/ppc/platforms/4xx/xilinx_xupv2p.c
> new file mode 100644
> index 0000000..aa2d890
> --- /dev/null
> +++ b/arch/ppc/platforms/4xx/xilinx_xupv2p.c
> @@ -0,0 +1,43 @@
> +/*
> + * Xilinx XUPV2P board initialization
> + *
> + * Author: Stephen.Neuendorffer@xilinx.com
> + *
> + * 2007 (c) Xilinx, Inc.  This file is licensed under the
> + * terms of the GNU General Public License version 2.  This program is licensed
> + * "as is" without any warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/xilinx_devices.h>
> +#include <platforms/4xx/xparameters/xparameters.h>
> +
> +int virtex_device_fixup(struct platform_device *dev)
> +{
> + int i;

If XPAR_ONEWIRE_0_BASEADDR is not set, then the unused 'int i' will
generate a warning.

> +#ifdef XPAR_ONEWIRE_0_BASEADDR
> + /* Use the Silicon Serial ID attached on the onewire bus to */
> + /* generate sensible MAC addresses. */
> + unsigned char *pOnewire = ioremap(XPAR_ONEWIRE_0_BASEADDR, 6);

Don't use CamelCase variable names.
ioremap() with no matching iounmap()

> + struct xemac_platform_data *pdata = dev->dev.platform_data;
> + if (strcmp(dev->name, "xilinx_emac") == 0) {
> +  printk(KERN_INFO "Fixup MAC address for %s:%d\n",
> +    dev->name, dev->id);
> +  /* FIXME.. this doesn't seem to return data that is consistent */
> +  /* with the self test... why not? */

Is this ready to be committed?

> +  pdata->mac_addr[0] = 0x00;
> +  pdata->mac_addr[1] = 0x0A;
> +  pdata->mac_addr[2] = 0x35;
> +  pdata->mac_addr[3] = dev->id;
> +  pdata->mac_addr[4] = pOnewire[4];
> +  pdata->mac_addr[5] = pOnewire[5];
> +  printk(KERN_INFO "MAC address is now %2x:%2x:%2x:%2x:%2x:%2x\n",
> +   pdata->mac_addr[0],
> +   pdata->mac_addr[1],
> +   pdata->mac_addr[2],
> +   pdata->mac_addr[3],
> +   pdata->mac_addr[4],
> +   pdata->mac_addr[5]);

The printk is ambiguous because it doesn't specify which device the
MAC addr is assigned to.  I'd drop the printk (or change it to a
pr_debug) and print the MAC addr in the Eth device driver itself.
Once you're in the driver, you know which 'eth#' will be assigned.

> + }
> +#endif
> + return 0;
> +}

whitespace problems here

> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
> index 01aa043..34d9844 100644
> --- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
> +++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
> @@ -15,8 +15,12 @@
>
>  #if defined(CONFIG_XILINX_ML300)
>    #include "xparameters_ml300.h"
> +#elif defined(CONFIG_XILINX_XUPV2P)
> +  #include "xparameters_xupv2p.h"
>  #elif defined(CONFIG_XILINX_ML403)
>    #include "xparameters_ml403.h"
> +#elif defined(CONFIG_XILINX_ML41x)
> +  #include "xparameters_ml41x.h"
>  #else
>    /* Add other board xparameter includes here before the #else */
>    #error No xparameters_*.h file included


> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h b/arch/ppc/platforms/4xx/xparameters/xparameters_ml41x.h
> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h b/arch/ppc/platforms/4xx/xparameters/xparameters_xupv2p.h

Split the addition of new xparams files into a separate patch.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
