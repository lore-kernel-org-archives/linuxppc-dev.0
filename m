Return-Path: <msampath@alphion.com>
Received: from mx1.alphion.com (mx1.alphion.com [71.168.162.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 553111A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 00:07:02 +1100 (AEDT)
From: Murali Sampath <MSampath@alphion.com>
To: Denis Kirjanov <kda@linux-powerpc.org>, Alessio Igor Bogani
 <alessio.bogani@elettra.eu>
CC: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Consolidate common platform code
Date: Thu, 11 Feb 2016 13:01:26 +0000
Message-ID: <20160211130125.5955729.57908.27393@alphion.com>
References: <1455177651-6686-1-git-send-email-alessio.bogani@elettra.eu>,
 <CAOJe8K2TFtppS4ni=ZCL=p853jO=ewjp3i+wOAQpVeSb7BFkUw@mail.gmail.com>
In-Reply-To: <CAOJe8K2TFtppS4ni=ZCL=p853jO=ewjp3i+wOAQpVeSb7BFkUw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



  Original Message
From: Denis Kirjanov
Sent: Thursday, February 11, 2016 4:22 AM
To: Alessio Igor Bogani
Cc: Scott Wood; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Consolidate common platform code


On 2/11/16, Alessio Igor Bogani <alessio.bogani@elettra.eu> wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
> v1 -> v2
>       Use appropriate [PATCH] prefix
>
>  arch/powerpc/platforms/86xx/Makefile       |  2 +-
>  arch/powerpc/platforms/86xx/common.c       | 42
> ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/86xx/gef_ppc9a.c    | 32 +----------------------
>  arch/powerpc/platforms/86xx/gef_sbc310.c   | 32 +----------------------
>  arch/powerpc/platforms/86xx/gef_sbc610.c   | 32 +----------------------
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c | 20 ++------------
>  arch/powerpc/platforms/86xx/mpc86xx.h      |  2 ++
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 21 +--------------
>  arch/powerpc/platforms/86xx/sbc8641d.c     | 32 +----------------------
>  9 files changed, 52 insertions(+), 163 deletions(-)
>  create mode 100644 arch/powerpc/platforms/86xx/common.c
>
> diff --git a/arch/powerpc/platforms/86xx/Makefile
> b/arch/powerpc/platforms/86xx/Makefile
> index ede815d..2d889ad 100644
> --- a/arch/powerpc/platforms/86xx/Makefile
> +++ b/arch/powerpc/platforms/86xx/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for the PowerPC 86xx linux kernel.
>  #
>
> -obj-y                                :=3D pic.o
> +obj-y                                :=3D pic.o common.o
>  obj-$(CONFIG_SMP)            +=3D mpc86xx_smp.o
>  obj-$(CONFIG_MPC8641_HPCN)   +=3D mpc86xx_hpcn.o
>  obj-$(CONFIG_SBC8641D)               +=3D sbc8641d.o
> diff --git a/arch/powerpc/platforms/86xx/common.c
> b/arch/powerpc/platforms/86xx/common.c
> new file mode 100644
> index 0000000..bee3177
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/common.c
> @@ -0,0 +1,42 @@
> +/*
> + * Routines common to most mpc86xx-based boards.
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_platform.h>
> +
> +#include "mpc86xx.h"
> +
> +static const struct of_device_id mpc86xx_common_ids[] __initconst =3D {
> +     { .type =3D "soc", },
> +     { .compatible =3D "soc", },
> +     { .compatible =3D "simple-bus", },
> +     { .name =3D "localbus", },
> +     { .compatible =3D "gianfar", },
> +     { .compatible =3D "fsl,mpc8641-pcie", },
> +     {},
> +};
> +
> +int __init mpc86xx_common_publish_devices(void)
> +{
> +     return of_platform_bus_probe(NULL, mpc86xx_common_ids, NULL);
> +}
> +
> +long __init mpc86xx_time_init(void)
> +{
> +     unsigned int temp;
> +
> +     /* Set the time base to zero */
> +     mtspr(SPRN_TBWL, 0);
> +     mtspr(SPRN_TBWU, 0);
> +
> +     temp =3D mfspr(SPRN_HID0);
> +     temp |=3D HID0_TBEN;
> +     mtspr(SPRN_HID0, temp);
> +     asm volatile("isync");
While we're here you could just use isync()

> +
> +     return 0;
> +}
> diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c
> b/arch/powerpc/platforms/86xx/gef_ppc9a.c
> index bf17933..8e63b75 100644
> --- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
> +++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
> @@ -197,37 +197,7 @@ static int __init gef_ppc9a_probe(void)
>       return 0;
>  }
>
> -static long __init mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
> -static const struct of_device_id of_bus_ids[] __initconst =3D {
> -     { .compatible =3D "simple-bus", },
> -     { .compatible =3D "gianfar", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
> -     {},
> -};
> -
> -static int __init declare_of_platform_devices(void)
> -{
> -     printk(KERN_DEBUG "Probe platform devices\n");
> -     of_platform_bus_probe(NULL, of_bus_ids, NULL);
> -
> -     return 0;
> -}
> -machine_arch_initcall(gef_ppc9a, declare_of_platform_devices);
> +machine_arch_initcall(gef_ppc9a, mpc86xx_common_publish_devices);
>
>  define_machine(gef_ppc9a) {
>       .name                   =3D "GE PPC9A",
> diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c
> b/arch/powerpc/platforms/86xx/gef_sbc310.c
> index 8facf58..0e0be94 100644
> --- a/arch/powerpc/platforms/86xx/gef_sbc310.c
> +++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
> @@ -184,37 +184,7 @@ static int __init gef_sbc310_probe(void)
>       return 0;
>  }
>
> -static long __init mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
> -static const struct of_device_id of_bus_ids[] __initconst =3D {
> -     { .compatible =3D "simple-bus", },
> -     { .compatible =3D "gianfar", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
> -     {},
> -};
> -
> -static int __init declare_of_platform_devices(void)
> -{
> -     printk(KERN_DEBUG "Probe platform devices\n");
> -     of_platform_bus_probe(NULL, of_bus_ids, NULL);
> -
> -     return 0;
> -}
> -machine_arch_initcall(gef_sbc310, declare_of_platform_devices);
> +machine_arch_initcall(gef_sbc310, mpc86xx_common_publish_devices);
>
>  define_machine(gef_sbc310) {
>       .name                   =3D "GE SBC310",
> diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c
> b/arch/powerpc/platforms/86xx/gef_sbc610.c
> index 8c9058d..e8292b4 100644
> --- a/arch/powerpc/platforms/86xx/gef_sbc610.c
> +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> @@ -174,37 +174,7 @@ static int __init gef_sbc610_probe(void)
>       return 0;
>  }
>
> -static long __init mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
> -static const struct of_device_id of_bus_ids[] __initconst =3D {
> -     { .compatible =3D "simple-bus", },
> -     { .compatible =3D "gianfar", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
> -     {},
> -};
> -
> -static int __init declare_of_platform_devices(void)
> -{
> -     printk(KERN_DEBUG "Probe platform devices\n");
> -     of_platform_bus_probe(NULL, of_bus_ids, NULL);
> -
> -     return 0;
> -}
> -machine_arch_initcall(gef_sbc610, declare_of_platform_devices);
> +machine_arch_initcall(gef_sbc610, mpc86xx_common_publish_devices);
>
>  define_machine(gef_sbc610) {
>       .name                   =3D "GE SBC610",
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> index 437a9c3..957473e 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -88,12 +88,10 @@ static inline void mpc8610_suspend_init(void) { }
>  static const struct of_device_id mpc8610_ids[] __initconst =3D {
>       { .compatible =3D "fsl,mpc8610-immr", },
>       { .compatible =3D "fsl,mpc8610-guts", },
> -     { .compatible =3D "simple-bus", },
>       /* So that the DMA channel nodes can be probed individually: */
>       { .compatible =3D "fsl,eloplus-dma", },
>       /* PCI controllers */
>       { .compatible =3D "fsl,mpc8610-pci", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
>       {}
>  };
>
> @@ -105,6 +103,8 @@ static int __init
> mpc8610_declare_of_platform_devices(void)
>       /* Enable wakeup on PIXIS' event IRQ. */
>       mpc8610_suspend_init();
>
> +     mpc86xx_common_publish_devices();
> +
>       /* Without this call, the SSI device driver won't get probed. */
>       of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>
> @@ -327,22 +327,6 @@ static int __init mpc86xx_hpcd_probe(void)
>       return 0;
>  }
>
> -static long __init mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
>  define_machine(mpc86xx_hpcd) {
>       .name                   =3D "MPC86xx HPCD",
>       .probe                  =3D mpc86xx_hpcd_probe,
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h
> b/arch/powerpc/platforms/86xx/mpc86xx.h
> index 08efb57..53500db 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx.h
> +++ b/arch/powerpc/platforms/86xx/mpc86xx.h
> @@ -17,5 +17,7 @@
>
>  extern void mpc86xx_smp_init(void);
>  extern void mpc86xx_init_irq(void);
> +extern long mpc86xx_time_init(void);
> +extern int mpc86xx_common_publish_devices(void);
>
>  #endif       /* __MPC86XX_H__ */
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> index 07ccb1b..e508481 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -110,33 +110,14 @@ static int __init mpc86xx_hpcn_probe(void)
>       return 0;
>  }
>
> -static long __init
> -mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
>  static const struct of_device_id of_bus_ids[] __initconst =3D {
> -     { .compatible =3D "simple-bus", },
>       { .compatible =3D "fsl,srio", },
> -     { .compatible =3D "gianfar", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
>       {},
>  };
>
>  static int __init declare_of_platform_devices(void)
>  {
> +     mpc86xx_common_publish_devices();
>       of_platform_bus_probe(NULL, of_bus_ids, NULL);
>
>       return 0;
> diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c
> b/arch/powerpc/platforms/86xx/sbc8641d.c
> index 6810b71..2a9cf27 100644
> --- a/arch/powerpc/platforms/86xx/sbc8641d.c
> +++ b/arch/powerpc/platforms/86xx/sbc8641d.c
> @@ -75,37 +75,7 @@ static int __init sbc8641_probe(void)
>       return 0;
>  }
>
> -static long __init
> -mpc86xx_time_init(void)
> -{
> -     unsigned int temp;
> -
> -     /* Set the time base to zero */
> -     mtspr(SPRN_TBWL, 0);
> -     mtspr(SPRN_TBWU, 0);
> -
> -     temp =3D mfspr(SPRN_HID0);
> -     temp |=3D HID0_TBEN;
> -     mtspr(SPRN_HID0, temp);
> -     asm volatile("isync");
> -
> -     return 0;
> -}
> -
> -static const struct of_device_id of_bus_ids[] __initconst =3D {
> -     { .compatible =3D "simple-bus", },
> -     { .compatible =3D "gianfar", },
> -     { .compatible =3D "fsl,mpc8641-pcie", },
> -     {},
> -};
> -
> -static int __init declare_of_platform_devices(void)
> -{
> -     of_platform_bus_probe(NULL, of_bus_ids, NULL);
> -
> -     return 0;
> -}
> -machine_arch_initcall(sbc8641, declare_of_platform_devices);
> +machine_arch_initcall(sbc8641, mpc86xx_common_publish_devices);
>
>  define_machine(sbc8641) {
>       .name                   =3D "SBC8641D",
> --
> 2.7.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
