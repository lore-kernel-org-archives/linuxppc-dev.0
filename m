Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 28665687DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 02:02:59 +1100 (EST)
Message-ID: <4381E1A1.1060405@ru.mvista.com>
Date: Mon, 21 Nov 2005 18:02:57 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
References: <1132583169.11785.44.camel@mephisto.spb.rtsoft.ru>
In-Reply-To: <1132583169.11785.44.camel@mephisto.spb.rtsoft.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/3] ppc32: MTD support for Yucca board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guess this should come through MTD community (linux-mtd@lists.infradead.org), rebased to 
the MTD tree of course.

Ruslan V. Sushko wrote:
> Following patch adds MTD support for Yucca embedded memories(Flashes,
> SRAM, FRAM).
> 
> 
> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/arch/ppc/platforms/4xx/yucca.h b/arch/ppc/platforms/4xx/yucca.h
> --- a/arch/ppc/platforms/4xx/yucca.h
> +++ b/arch/ppc/platforms/4xx/yucca.h
> @@ -32,12 +32,88 @@
>  /* External timer clock frequency */
>  #define YUCCA_TMR_CLK		25000000
>  
> +/* System Memory map (physical address, not effective address)
> + * Flash and other devices via EBC.
> + *
> + * This should be the same mapping as done by PIBS in the
> + * (not mandatory but ease code reading between two codes)
> + * xxx/boardlib/ebc.c
> + *
> + * depending of the switch setting off the board, the location of devices
> + * in the address map are not the same:
> + */
> +/* Common definitions */
> +
> +#define BOARD_SMALL_FLASH_SIZE                    0x100000      /* 1M */
> +#define BOARD_FRAM_SIZE			            0x8000
> +#define BOARD_SRAM_SIZE			          0x100000
> +#define BOARD_OPER_FLASH_SIZE                     0x400000      /* 4M */
> +
> +
> +/* Configuration 1:
> + * the small flash and sram are placed on top   (CS0)
> + * the Large flash is placed below              (CS2)
> + * The FPGA and FRAM at the end                 (CS1)
> + *                                        xxxx----xxxx----
> + */
> +#define BOARD_CONF1_SMALL_FLASH         0x00000004FFF00000ull
> +#define BOARD_CONF1_FRAM                0x00000004FF000000ull
> +#define BOARD_CONF1_OPER_FLASH          0x00000004E7C00000ull
> +#define BOARD_CONF1_SRAM                0x00000004E7000000ull
> +
> +/* Configuration 2:
> + * the small flash and sram are placed on top   (CS0)
> + * but now sram before smal flash
> + * the Large flash is placed below (no change)  (CS2)
> + * The FPGA and FRAM stay in same place.        (CS1)
> + *                                        xxxx----xxxx----
> + */
> +#define BOARD_CONF2_OPER_FLASH          0x00000004FFC00000ull
> +#define BOARD_CONF2_SRAM                0x00000004FF000000ull
> +#define BOARD_CONF2_SMALL_FLASH         0x00000004E7F00000ull
> +#define BOARD_CONF2_FRAM                0x00000004E7000000ull
> +
> +/* Configuration 3:
> + * the Large flash is placed on top,            (CS0)
> + * the small flash and sram are placed below.   (CS2)
> + * The FPGA and FRAM stay in same place.        (CS1)
> + *                                        xxxx----xxxx----
> + */
> +#define BOARD_CONF3_SRAM                0x00000004FFF00000ull
> +#define BOARD_CONF3_OPER_FLASH          0x00000004FF000000ull
> +#define BOARD_CONF3_SMALL_FLASH         0x00000004E7F00000ull
> +#define BOARD_CONF3_FRAM                0x00000004E7000000ull
> +
>  /*
>   * FPGA registers
>   */
>  #define YUCCA_FPGA_REG_BASE			0x00000004e2000000ULL
>  #define YUCCA_FPGA_REG_SIZE			0x24
>  
> +#define FPGA_REG10                              0x10 /* Ethernet/Reset/Boot
> +                                                        configs */
> +#define FPGA_REG10_ETH_MODE10                   0x8000
> +#define FPGA_REG10_ETH_MODE100                  0x4000
> +#define FPGA_REG10_ETH_MODE1000                 0x2000
> +#define FPGA_REG10_ETH_FORCE_DUPLEX             0x1000
> +#define FPGA_REG10_LOG_RESET_ETHERNET           0x0800
> +#define FPGA_REG10_ETH_AUTO_NEGO                0x0400
> +#define FPGA_REG10_LOG_INT_ETH                  0x0200
> +#define FPGA_REG10_LOG_RESET_HISR               0x0080
> +#define FPGA_REG10_LOG_RESET_DISPLAY            0x0040
> +#define FPGA_REG10_LOG_RESET_SDRAM              0x0020
> +#define FPGA_REG10_LOG_OPBOOT                   0x0010
> +#define FPGA_REG10_LOG_SRAM_BOOT                0x0008
> +#define FPGA_REG10_LOG_BTBOOT                   0x0004
> +
> +/*Boot configurations */
> +#define BOARD_CONFIG_MASK                       (0x001C)
> +#define BOARD_CONFIG_1                          (0x0018)
> +#define BOARD_CONFIG_2                          (0x000C)
> +#define BOARD_CONFIG_3                          (0x0014)
> +#define BOARD_BOOT_OPER_FLASH(x)       (((x) & BOARD_CONFIG_MASK) == \
> +                                                 BOARD_CONFIG_2)
> +
>  #define FPGA_REG1A				0x1a
>  
>  #define FPGA_REG1A_PE0_GLED			0x8000
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -339,6 +339,14 @@ config MTD_OCOTEA
>  	  Ocotea board. If you have one of these boards and would like to
>  	  use the flash chips on it, say 'Y'.
>  
> +config MTD_YUCCA
> +        tristate "Flash devices mapped on IBM 440SPe Yucca"
> +        depends on MTD_CFI && YUCCA
> +        help
> +          This enables access routines for the flash chips on the IBM 440SPe
> +          Yucca board. If you have one of these boards and would like to
> +          use the flash chips on it, say 'Y'.
> +
>  config MTD_REDWOOD
>  	tristate "CFI Flash devices mapped on IBM Redwood"
>  	depends on MTD_CFI && ( REDWOOD_4 || REDWOOD_5 || REDWOOD_6 )
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NETtel)	+= nettel.o
>  obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
>  obj-$(CONFIG_MTD_EBONY)		+= ebony.o
>  obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
> +obj-$(CONFIG_MTD_YUCCA)         += yucca_flash.o
>  obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
>  obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
>  obj-$(CONFIG_MTD_WALNUT)        += walnut.o
> diff --git a/drivers/mtd/maps/yucca_flash.c b/drivers/mtd/maps/yucca_flash.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/mtd/maps/yucca_flash.c
> @@ -0,0 +1,297 @@
> +/*
> + * Mapping for Yucca user flash
> + *
> + * This was derived from the luan.c
> + *
> + * Ruslan Sushko <rsushko@ru.mvista.com>
> + * Matt Porter <mporter@mvista.com>
> + *
> + * Copyright (C) 2002-2005 MontaVista Software Inc.
> + * (C) Copyright IBM Corp. 2004
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/config.h>
> +#include <linux/version.h>
> +#include <asm/io.h>
> +
> +static struct mtd_info *oper_flash_mtd = NULL;
> +static struct mtd_info *small_flash_mtd = NULL;
> +static struct mtd_info *fram_mtd = NULL;
> +static struct mtd_info *sram_mtd = NULL;
> +
> +static struct map_info yucca_sram_map = {
> +        .name =         "Yucca SRAM",
> +        .size =         BOARD_SRAM_SIZE,
> +        .bankwidth = 2,
> +};
> +
> +static struct map_info yucca_fram_map = {
> +        .name =         "Yucca FRAM",
> +        .size =         BOARD_FRAM_SIZE,
> +        .bankwidth = 1,
> +};
> +
> +static struct map_info yucca_small_map = {
> +        .name =         "Yucca small flash",
> +        .size =         BOARD_SMALL_FLASH_SIZE,
> +        .bankwidth = 1,
> +};
> +
> +static struct map_info yucca_oper_map = {
> +        .name =         "Yucca Operational flash",
> +        .size =         BOARD_OPER_FLASH_SIZE,
> +        .bankwidth = 2,
> +};
> +
> +static struct mtd_partition yucca_sram_partitions[] = {
> +        {
> +                .name =   "SRAM",
> +                .offset = 0x0,
> +                .size =   0x100000,
> +        }
> +};
> +
> +static struct mtd_partition yucca_fram_partitions[] = {
> +        {
> +                .name =   "FRAM",
> +                .offset = 0x0,
> +                .size =   0x8000,
> +        }
> +};
> +
> +static struct mtd_partition yucca_small_partitions[] = {
> +        {
> +                .name =   "U-boot",
> +                .offset = 0x0,
> +                .size =   0x100000,
> +        }
> +};
> +
> +static struct mtd_partition yucca_oper_partitions[] = {
> +        {
> +                .name =   "Linux Kernel",
> +                .offset = 0,
> +                .size =   0x100000,
> +        },
> +        {
> +                .name =   "Free Area",
> +                .offset = 0x100000,
> +                .size =   0x300000,
> +        }
> +};
> +
> +#define NB_OF(x)  (sizeof(x)/sizeof(x[0]))
> +static void cleanup_yucca(void);
> +
> +
> +int __init init_yucca(void)
> +{
> +        u16 fpga10_reg;
> +        volatile u16 *fpga_adr;
> +        unsigned long long small_flash_base, oper_flash_base;
> +        unsigned long long sram_base, fram_base;
> +        int memconfig = 0;
> +        int err = 0;
> +
> +        fpga_adr = ioremap64(YUCCA_FPGA_REG_BASE, YUCCA_FPGA_REG_SIZE);
> +        if (!fpga_adr)
> +                return -ENOMEM;
> +
> +
> +        fpga10_reg = *((u16*)((u32)fpga_adr + FPGA_REG10));
> +        iounmap(fpga_adr);
> +        switch (fpga10_reg & BOARD_CONFIG_MASK) {
> +                default:
> +                        printk("Memory config switches are invalid: "
> +                               "fpga10_reg= %x. Using default configuration\n",
> +                                        fpga10_reg);
> +                case BOARD_CONFIG_1:
> +                        memconfig = 1;
> +                        small_flash_base =      BOARD_CONF1_SMALL_FLASH;
> +                        oper_flash_base =       BOARD_CONF1_OPER_FLASH;
> +		        sram_base =             BOARD_CONF1_SRAM;
> +		        fram_base =             BOARD_CONF1_FRAM;
> +                        break;
> +                case BOARD_CONFIG_2:
> +                        memconfig = 2;
> +                        small_flash_base =      BOARD_CONF2_SMALL_FLASH;
> +                        oper_flash_base =       BOARD_CONF2_OPER_FLASH;
> +		        sram_base =             BOARD_CONF2_SRAM;
> +		        fram_base =             BOARD_CONF3_FRAM;
> +                        break;
> +                case BOARD_CONFIG_3:
> +                        memconfig = 3;
> +                        small_flash_base =      BOARD_CONF3_SMALL_FLASH;
> +                        oper_flash_base =       BOARD_CONF3_OPER_FLASH;
> +		        sram_base =             BOARD_CONF3_SRAM;
> +		        fram_base =             BOARD_CONF3_FRAM;
> +                        break;
> +        }
> +
> +        printk("Using EBC memory configuration #%d\n", memconfig);
> +
> +        yucca_small_map.phys = small_flash_base;
> +        yucca_small_map.virt = ioremap64(small_flash_base,
> +                        yucca_small_map.size);
> +
> +        if (!yucca_small_map.virt) {
> +                printk("Failed to ioremap small flash\n");
> +                err = -EIO;
> +                goto ret_err;
> +        }
> +
> +        simple_map_init(&yucca_small_map);
> +
> +        small_flash_mtd = do_map_probe("map_rom", &yucca_small_map);
> +        if (small_flash_mtd) {
> +                small_flash_mtd->owner = THIS_MODULE;
> +                add_mtd_partitions(small_flash_mtd, yucca_small_partitions,
> +                                        NB_OF(yucca_small_partitions));
> +        } else {
> +                printk("map probe failed for small flash\n");
> +                err = -ENXIO;
> +                goto ret_err;
> +        }
> +
> +        yucca_oper_map.phys = oper_flash_base;
> +        yucca_oper_map.virt = ioremap64(oper_flash_base,
> +                        yucca_oper_map.size);
> +
> +        if (!yucca_oper_map.virt) {
> +                printk("Failed to ioremap oper flash\n");
> +                err = -EIO;
> +                goto ret_err;
> +        }
> +
> +        simple_map_init(&yucca_oper_map);
> +
> +        oper_flash_mtd = do_map_probe("cfi_probe", &yucca_oper_map);
> +        if (oper_flash_mtd) {
> +                oper_flash_mtd->owner = THIS_MODULE;
> +                add_mtd_partitions(oper_flash_mtd, yucca_oper_partitions,
> +                                        NB_OF(yucca_oper_partitions));
> +        } else {
> +                printk("map probe failed for oper flash\n");
> +                err = -ENXIO;
> +                goto ret_err;
> +        }
> +
> +        yucca_sram_map.phys = sram_base;
> +        yucca_sram_map.virt = ioremap64(sram_base,
> +                                 yucca_sram_map.size);
> +
> +        if (!yucca_sram_map.virt) {
> +                printk("Failed to ioremap SRAM\n");
> +                err = -EIO;
> +                goto ret_err;
> +        }
> +
> +        simple_map_init(&yucca_sram_map);
> +
> +        sram_mtd = do_map_probe("map_ram", &yucca_sram_map);
> +        if (sram_mtd) {
> +                sram_mtd->owner = THIS_MODULE;
> +                add_mtd_partitions(sram_mtd, yucca_sram_partitions,
> +                                        NB_OF(yucca_sram_partitions));
> +        } else {
> +                printk("map probe failed for SRAM\n");
> +                err = -ENXIO;
> +                goto ret_err;
> +        }
> +
> +        yucca_fram_map.phys = fram_base;
> +        yucca_fram_map.virt = ioremap64(fram_base,
> +                                 yucca_fram_map.size);
> +
> +        if (!yucca_fram_map.virt) {
> +                printk("Failed to ioremap FRAM\n");
> +                err = -EIO;
> +                goto ret_err;
> +        }
> +
> +        simple_map_init(&yucca_fram_map);
> +
> +        fram_mtd = do_map_probe("map_ram", &yucca_fram_map);
> +        if (fram_mtd) {
> +                fram_mtd->owner = THIS_MODULE;
> +                add_mtd_partitions(fram_mtd, yucca_fram_partitions,
> +                                        NB_OF(yucca_fram_partitions));
> +        } else {
> +                printk("map probe failed for FRAM\n");
> +                err = -ENXIO;
> +                goto ret_err;
> +        }
> +        return 0;
> +ret_err:
> +        cleanup_yucca();
> +        return err;
> +}
> +
> +static void cleanup_yucca(void)
> +{
> +        if (yucca_small_map.virt) {
> +                iounmap((void *)yucca_small_map.virt);
> +                yucca_small_map.virt = 0;
> +        }
> +
> +        if (yucca_oper_map.virt) {
> +                iounmap((void *)yucca_oper_map.virt);
> +                yucca_oper_map.virt = 0;
> +        }
> +
> +	if (yucca_fram_map.virt) {
> +                iounmap((void *)yucca_fram_map.virt);
> +                yucca_fram_map.virt = 0;
> +	}
> +
> +	if (yucca_sram_map.virt) {
> +                iounmap((void *)yucca_sram_map.virt);
> +                yucca_sram_map.virt = 0;
> +	}
> +
> +        if (oper_flash_mtd) {
> +                del_mtd_partitions(oper_flash_mtd);
> +                map_destroy(oper_flash_mtd);
> +        }
> +
> +        if (small_flash_mtd) {
> +                del_mtd_partitions(small_flash_mtd);
> +                map_destroy(small_flash_mtd);
> +        }
> +
> +        if (fram_mtd) {
> +                del_mtd_partitions(fram_mtd);
> +                map_destroy(fram_mtd);
> +        }
> +
> +        if (sram_mtd) {
> +                del_mtd_partitions(sram_mtd);
> +                map_destroy(sram_mtd);
> +        }
> +
> +}
> +
> +static void __exit rem_yucca(void)
> +{
> +        cleanup_yucca();
> +}
> +
> +module_init(init_yucca);
> +module_exit(rem_yucca);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ruslan V. Sushko <rsushko@ru.mvista.com>");
> +MODULE_DESCRIPTION("MTD map and partitions for AMCC 440SPe Yucca board");
> +
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely,
Vitaly
