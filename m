Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 108CCDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 17:04:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9B358.CF7555FA"
Subject: RE: /dev/random on PPC40EXr
Date: Wed, 1 Apr 2009 22:59:46 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0534AB72@SDCEXCHANGE01.ad.amcc.com>
References: <22824979.post@talk.nabble.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C071F4A5D@SDCEXCHANGE01.ad.amcc.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Tirumala Reddy Marri" <tmarri@amcc.com>,
	"Felix Radensky" <felix@embedded-sol.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9B358.CF7555FA"


------_=_NextPart_002_01C9B358.CF7555FA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here I am copy pasting the files and also attaching.
--------------trng4xx.c-------------
/************************************************************************=
*******

*

* Copyright (c) 2008 Loc Ho <lho@amcc.com>

*

* This program is free software; you can redistribute it and/or modify

* it under the terms of the GNU General Public License as published by

* the Free Software Foundation; either version 2 of the License, or

* (at your option) any later version.

*

* This program is distributed in the hope that it will be useful,

* but WITHOUT ANY WARRANTY; without even the implied warranty of

* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the

* GNU General Public License for more details.

*

*

* Detail Description:

* This file defines ioctl structures for the Linux CryptoAPI interface. =
It

* provides user space applications accesss into the Linux CryptoAPI

* functionalities.

*

* @file trng4xx.c

*

* This file provides access to the AMCC PPC4XX TRNG for Linux.

*

*************************************************************************=
******

*/

#include <linux/version.h>

#include <linux/module.h>

#include <linux/kernel.h>

#include <linux/platform_device.h>

#include <linux/hw_random.h>

#include <linux/interrupt.h>

#include <asm/of_platform.h>

#include <asm/io.h>

#include "trng4xx.h"

#define TRNG4XX_VER_STR "0.1"

#define PFX KBUILD_MODNAME ": "

struct trng4xx_dev {

struct resource res;

u32 irq;

volatile char __iomem *csr;

struct semaphore access_prot;

u32 datum;

};

struct hal_config {

struct of_device *ofdev;

};

static struct trng4xx_dev trng4xx_dev;

static int trng4xx_irq_handler(int irq, void * id);

static void trng4xx_chk_overflow(void);

int trng4xx_config_set(struct hal_config *cfg)

{

struct device_node *rng_np =3D cfg->ofdev->node;

int rc =3D 0;

rc =3D of_address_to_resource(rng_np, 0, &trng4xx_dev.res);

if (rc)

return -ENODEV;

trng4xx_dev.csr =3D ioremap(trng4xx_dev.res.start,

trng4xx_dev.res.end - trng4xx_dev.res.start + 1);

if (trng4xx_dev.csr =3D=3D NULL) {

printk(KERN_ERR PFX "unable to ioremap 0x%02X_%08X size %d\n",

(u32) (trng4xx_dev.res.start >> 32),

(u32) trng4xx_dev.res.start,

(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1));

return -ENOMEM;

}

#if 0

printk("TRNG1 0x%02X_%08X size %d\n",

(u32) (trng4xx_dev.res.start >> 32),

(u32) trng4xx_dev.res.start,

(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1));

#endif

trng4xx_dev.irq =3D of_irq_to_resource(rng_np, 0, NULL);=20

printk ("TRNG IRQ =3D %d\n",trng4xx_dev.irq);=20

if (trng4xx_dev.irq =3D=3D NO_IRQ) {

/* Un-map CSR */

iounmap(trng4xx_dev.csr);

trng4xx_dev.csr =3D NULL;

return -EINVAL;

}

return 0;

}

int trng4xx_pka_config_clear(void)

{

iounmap(trng4xx_dev.csr);

return 0;

}

inline int trng4xx_hw_read32(u32 reg_addr, u32 *data_val)

{

*data_val =3D in_be32((volatile unsigned __iomem *)

(trng4xx_dev.csr + reg_addr));

return 0;

}

inline int trng4xx_hw_write32(u32 reg_addr, u32 data_val)

{

out_be32((volatile unsigned __iomem *) (trng4xx_dev.csr + reg_addr),

data_val);

return 0;

}

int trng4xx_hw_init(void)

{

int rc;

rc =3D request_irq(trng4xx_dev.irq, trng4xx_irq_handler,

0, "TRNG", NULL);

if (rc !=3D 0) {

printk(KERN_ERR PFX "failed to register interrupt IRQ %d\n",

trng4xx_dev.irq);

return rc;

}

return 0;

}

int trng4xx_hw_deinit(void)

{

free_irq(trng4xx_dev.irq, NULL);

return 0;

}

static int trng4xx_irq_handler(int irq, void * id)

{

/* TRNG Alarm Counter overflow */

trng4xx_chk_overflow();

return 0;

}

/************************************************************************=
*******

* TRNG Functions

*************************************************************************=
******

*/

static void trng4xx_chk_overflow(void)

{

/* TRNG Alarm Counter overflow */

int rc;

u32 val;

struct trng4xx_cfg {

u32 ring1_delay_sel : 3;

u32 ring2_delay_sel : 3;

u32 reset_cnt : 6;

} __attribute__((packed));

=20

rc =3D trng4xx_hw_write32(TRNG4XX_ALARMCNT_ADDR, val);

if (rc !=3D 0)

return;

if (val > 128) {

struct trng4xx_cfg *trng4xx_cfg;

/* Alarm count is half, reset it */

rc =3D trng4xx_hw_read32(TRNG4XX_CFG_ADDR, &val);

if (rc !=3D 0)

return;

trng4xx_cfg =3D (struct trng4xx_cfg *) &val;

++trng4xx_cfg->ring1_delay_sel;

trng4xx_cfg->ring2_delay_sel =3D (~trng4xx_cfg->ring1_delay_sel) & 0x07;

rc =3D trng4xx_hw_write32(TRNG4XX_CFG_ADDR, val);

if (rc !=3D 0)

return;

trng4xx_hw_write32(TRNG4XX_ALARMCNT_ADDR, 0x00000000);

if (rc !=3D 0)

return;

}

}

int trng4xx_random(u32 *rand_val)

{

u32 val =3D 0;

int rc;

#define MAX_TRY 3

u16 try_cnt =3D 0;

down(&trng4xx_dev.access_prot);

do {

rc =3D trng4xx_hw_read32(TRNG4XX_STATUS_ADDR, &val);

if (rc !=3D 0)

goto err;

} while((val & TRNG4XX_STATUS_BUSY) && ++try_cnt <=3D MAX_TRY);

if (val & TRNG4XX_STATUS_BUSY) {

rc =3D -EINPROGRESS;

goto err;

}

rc =3D trng4xx_hw_read32(TRNG4XX_OUTPUT_ADDR, rand_val);

=20

err:

//printk("status busy\n");

up(&trng4xx_dev.access_prot);

return rc;

}

EXPORT_SYMBOL_GPL(trng4xx_random);

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)

static int trng4xx_data_present(struct hwrng *rng)

#else

static int trng4xx_data_present(struct hwrng *rng, int wait)

#endif

{

struct trng4xx_dev *dev =3D (struct trng4xx_dev *) rng->priv;

int i;

u32 val;

printk("inside %s:\n", __FUNCTION__);

down(&trng4xx_dev.access_prot);

/* We should not take more than 200??? us */

for (i =3D 0; i < 20; i++) {

trng4xx_hw_read32(TRNG4XX_STATUS_ADDR, &val);

if (!(val & TRNG4XX_STATUS_BUSY)) {

trng4xx_hw_read32(TRNG4XX_OUTPUT_ADDR, &dev->datum);

break;

}

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)

break;

#else

if (!wait)

break;

udelay(10);

#endif

}

up(&trng4xx_dev.access_prot);

return (val & TRNG4XX_STATUS_BUSY) ? 0 : 1;

}

static int trng4xx_data_read(struct hwrng *rng, u32 *data)

{

struct trng4xx_dev *dev =3D (struct trng4xx_dev *) rng->priv;

*data =3D dev->datum;

printk("data read =3D %u\n", *data);=20

return 0;

}

static int trng4xx_init(struct hwrng *rng)

{

return trng4xx_hw_init();

}

static void trng4xx_cleanup(struct hwrng *rng)

{

trng4xx_hw_deinit();

}

static struct hwrng trng4xx_func =3D {

.name =3D "ppc4xx-trng",

.init =3D trng4xx_init,

.cleanup =3D trng4xx_cleanup,

.data_present =3D trng4xx_data_present,

.data_read =3D trng4xx_data_read,

.priv =3D (unsigned long) &trng4xx_dev,

};

/************************************************************************=
*******

*

* Setup Driver with platform registration

*

*************************************************************************=
******

*/

static int __devinit trng4xx_probe(struct of_device *ofdev,

const struct of_device_id *match)

{

struct hal_config hw_cfg;

int rc;

u32 value, value2;

u32 ctrl_val, control_value;

hw_cfg.ofdev =3D ofdev;

rc =3D trng4xx_config_set(&hw_cfg);

if (rc !=3D 0)

return rc;

#if 1

printk( "AMCC 4xx TRNG v%s @0x%02X_%08X size %d IRQ %d\n",

TRNG4XX_VER_STR,

(u32) (trng4xx_dev.res.start >> 32),

(u32) trng4xx_dev.res.start,

(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1),

trng4xx_dev.irq);

#endif

init_MUTEX(&trng4xx_dev.access_prot);

rc =3D hwrng_register(&trng4xx_func);

if (rc) {

printk(KERN_ERR PFX

"AMCC 4xx TRNG registering failed error %d\n", rc);

goto err;

}

trng4xx_hw_read32(TRNG4XX_CNTL_ADDR, &ctrl_val);

//printk ("cntl value =3D 0x%x\n", ctrl_val);

value =3D ctrl_val | TRNG4XX_CNTL_TST_ALARM;

//printk ("value to write =3D 0x%x\n", value);

/*rc =3D trng4xx_hw_write32(TRNG4XX_CNTL_ADDR, value);

if (rc !=3D 0)

printk ("ERROR: writing\n");

=20

trng4xx_hw_read32(TRNG4XX_CNTL_ADDR, &control_value);

printk ("control value =3D 0x%x\n", control_value);*/

/*value =3D 0;

printk ("checking random value register\n");

rc =3D trng4xx_random (&value);

printk ("checking random value register\n");

rc =3D trng4xx_random (&value2);*/

return rc;

err:

trng4xx_pka_config_clear();

return rc;

}

static int __devexit trng4xx_remove(struct of_device *dev)

{

hwrng_unregister(&trng4xx_func);

trng4xx_pka_config_clear();

return 0;

}

static struct of_device_id trng4xx_match[] =3D {

{ .compatible =3D "ppc4xx-trng", },

{ .compatible =3D "amcc,ppc4xx-trng", },

{ },

};

static struct of_platform_driver trng4xx_driver =3D {

.name =3D "ppc4xx-trng",

.match_table =3D trng4xx_match,

.probe =3D trng4xx_probe,

.remove =3D trng4xx_remove,

};

static int __init mod_init(void)

{

printk("entered mod_init\n");=20

return of_register_platform_driver(&trng4xx_driver);

}

static void __exit mod_exit(void)

{

of_unregister_platform_driver(&trng4xx_driver);

}

module_init(mod_init);

module_exit(mod_exit);

MODULE_DESCRIPTION("AMCC 4xx True Random Number Generator");

MODULE_LICENSE("GPL");

=20
------------trng4xx.h -------------------=20
=20
/************************************************************************=
*******

*

* Copyright (c) 2008 Loc Ho <lho@amcc.com>

*

* This program is free software; you can redistribute it and/or modify

* it under the terms of the GNU General Public License as published by

* the Free Software Foundation; either version 2 of the License, or

* (at your option) any later version.

*

* This program is distributed in the hope that it will be useful,

* but WITHOUT ANY WARRANTY; without even the implied warranty of

* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the

* GNU General Public License for more details.

*

*

* Detail Description:

* This file defines ioctl structures for the Linux CryptoAPI interface. =
It

* provides user space applications accesss into the Linux CryptoAPI

* functionalities.

*

* @file trng4xx.h

*

* This file provides access to the AMCC SoC TRNG.

*

*************************************************************************=
******

*/

#ifndef __TRNG4XX_H__

#define __TRNG4XX_H__

/************************************************************************=
*******

* TRNG Register and bit Definitions

*************************************************************************=
******

*/

/* Register TRNG4XX_STATUS bit definition */

#define TRNG4XX_STATUS_BUSY 0x00000001

/* Register TRNG4XX_CNTL bit definition */

#define TRNG4XX_CNTL_TST_RING_OUT 0x00000001

#define TRNG4XX_CNTL_TST_MODE 0x00000002

#define TRNG4XX_CNTL_TST_RUN 0x00000004

#define TRNG4XX_CNTL_TST_EN1 0x00000008

#define TRNG4XX_CNTL_TST_EN2 0x00000010

#define TRNG4XX_CNTL_DISABLE_ALARM 0x00000020

#define TRNG4XX_CNTL_CLOCK_ON 0x00000040

#define TRNG4XX_CNTL_SHORT_CYCLE 0x00000080

#define TRNG4XX_CNTL_TST_ALARM 0x00000100

#define TRNG4XX_CNTL_TST_LFSR 0x00000200

#define TRNG4XX_CNTL_RESET_LFSR 0x00000400

#define TRNG4XX_CNTL_BYPASS_TRNG 0x00000800

#define TRNG4XX_CNTL_POST_PROC_EN 0x00001000

/* Register TRNG4XX_CFG bit definition */

#define TRNG4XX_CFG_RING1_DELAY_SEL_SHIFT 0

#define TRNG4XX_CFG_RING1_DELAY_SEL_MASK (7)

#define TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT 3

#define TRNG4XX_CFG_RING2_DELAY_SEL_MASK (7 << =
TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT)

#define TRNG4XX_CFG_RESET_CNT_SHIFT 6

#define TRNG4XX_CFG_RESET_CNT_SHIFT_MASK (0x3F << =
TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT)

/* TRNG Register definition */

#define TRNG4XX_OUTPUT_ADDR 0x0000

#define TRNG4XX_STATUS_ADDR 0x0004

#define TRNG4XX_CNTL_ADDR 0x0008

#define TRNG4XX_CFG_ADDR 0x000C

#define TRNG4XX_ALARMCNT_ADDR 0x0010

#define TRNG4XX_AREG_ADDR 0x0014

#define TRNG4XX_BREG_ADDR 0x0018

#define TRNG4XX_XREG_0_ADDR 0x001C

#define TRNG4XX_XREG_1_ADDR 0x0020

#define TRNG4XX_XREG_2_ADDR 0x0024

#define TRNG4XX_LFSR1_L_ADDR 0x0028

#define TRNG4XX_LFSR1_H_ADDR 0x002C

#define TRNG4XX_LFSR2_L_ADDR 0x0030

#define TRNG4XX_LFSR2_H_ADDR 0x0034

#define TRNG4XX_KEY0_L_ADDR 0x0038

#define TRNG4XX_KEY0_H_ADDR 0x003C

#define TRNG4XX_KEY1_L_ADDR 0x0040

#define TRNG4XX_KEY1_H_ADDR 0x0044

#define TRNG4XX_IV_L_ADDR 0x0048

#define TRNG4XX_IV_H_ADDR 0x004C

struct hal_config;

/**

* @brief This function MUSTs be called to initialize the HW

* access function.

* @param amcc_hal_cfg HW access configuration. If NULL,

* default will be used.

* @return PPRO_RC_OK or PPRO_RC_FATAL

* @note To load all access functions from HAL with default initial

* map address, pass a NULL as its parameter.

* @n To load all access functions from HAL with default runtime

* map address, initialize an amcc_hal_config_t struct

* with valid HAL signature and set

* amcc_hal_config->flags |=3D PPRO_HAL_FLAG_LOADINIT;

*

*************************************************************************=
******

*/

int trng4xx_config_set(struct hal_config *cfg);

/**

* @brief This function MUSTs be called to de-initialize the HW

* access function.

* @return PPRO_RC_OK or PPRO_RC_FATAL

*

*************************************************************************=
******

*/

int trng4xx_config_clear(void);

/**

* @brief This functions reads from the TRNG registers.

* @param reg_addr Device register offset

* @param data_val An DWORD pointer to store the returned value

* @return PPRO_RC_OK or PPRO_RC_FATAL

*

*************************************************************************=
******

*/

inline int trng4xx_hw_read32(u32 reg_addr, u32 *data_val);

/**

* @brief This functions writes to the TRNG registers.

* @param reg_addr Device register offset

* @param data_val An DWORD value to write

* @return PPRO_RC_OK or PPRO_RC_FATAL

*

*************************************************************************=
******

*/

inline int trng4xx_hw_write32(u32 reg_addr, u32 data_val);

/**

* @brief This functions initializes the TRNG for operation.

* @return PPRO_RC_OK or PPRO_RC_FATAL

*

*************************************************************************=
******

*/

int trng4xx_hw_init(void);

/**

* @brief This functions de-initializes the TRNG.

* @return PPRO_RC_OK or PPRO_RC_FATAL

*

*************************************************************************=
******

*/

int trng4xx_hw_deinit(void);

/**

* @brief This functions retrieves an true random number.

* @param rand_val A pointer to a DWORD to store the value

* @return PPRO_RC_OK if successfull. PPRO_RC_EINPROGRESS if failed. This

* should not happen as this means the hardware still busy.

*

*************************************************************************=
******

*/

int trng4xx_random(u32 *rand_val);

#endif

=20

------------------------- DTS file ---------------

/*

* Device Tree Source for AMCC Canyonlands (460EX)

*

* Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>

*

* This file is licensed under the terms of the GNU General Public

* License version 2. This program is licensed "as is" without

* any warranty of any kind, whether express or implied.

*/

/ {

#address-cells =3D <2>;

#size-cells =3D <1>;

model =3D "amcc,canyonlands";

compatible =3D "amcc,canyonlands";

dcr-parent =3D <&/cpus/cpu@0>;

aliases {

ethernet0 =3D &EMAC0;

ethernet1 =3D &EMAC1;

serial0 =3D &UART0;

serial1 =3D &UART1;

};

cpus {

#address-cells =3D <1>;

#size-cells =3D <0>;

cpu@0 {

device_type =3D "cpu";

model =3D "PowerPC,460EX";

reg =3D <0>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

timebase-frequency =3D <0>; /* Filled in by U-Boot */

i-cache-line-size =3D <20>;

d-cache-line-size =3D <20>;

i-cache-size =3D <8000>;

d-cache-size =3D <8000>;

dcr-controller;

dcr-access-method =3D "native";

};

};

memory {

device_type =3D "memory";

reg =3D <0 0 0>; /* Filled in by U-Boot */

};

UIC0: interrupt-controller0 {

compatible =3D "ibm,uic-460ex","ibm,uic";

interrupt-controller;

cell-index =3D <0>;

dcr-reg =3D <0c0 009>;

#address-cells =3D <0>;

#size-cells =3D <0>;

#interrupt-cells =3D <2>;

};

UIC1: interrupt-controller1 {

compatible =3D "ibm,uic-460ex","ibm,uic";

interrupt-controller;

cell-index =3D <1>;

dcr-reg =3D <0d0 009>;

#address-cells =3D <0>;

#size-cells =3D <0>;

#interrupt-cells =3D <2>;

interrupts =3D <1e 4 1f 4>; /* cascade */

interrupt-parent =3D <&UIC0>;

};

UIC2: interrupt-controller2 {

compatible =3D "ibm,uic-460ex","ibm,uic";

interrupt-controller;

cell-index =3D <2>;

dcr-reg =3D <0e0 009>;

#address-cells =3D <0>;

#size-cells =3D <0>;

#interrupt-cells =3D <2>;

interrupts =3D <a 4 b 4>; /* cascade */

interrupt-parent =3D <&UIC0>;

};

UIC3: interrupt-controller3 {

compatible =3D "ibm,uic-460ex","ibm,uic";

interrupt-controller;

cell-index =3D <3>;

dcr-reg =3D <0f0 009>;

#address-cells =3D <0>;

#size-cells =3D <0>;

#interrupt-cells =3D <2>;

interrupts =3D <10 4 11 4>; /* cascade */

interrupt-parent =3D <&UIC0>;

};

SDR0: sdr {

compatible =3D "ibm,sdr-460ex";

dcr-reg =3D <00e 002>;

};

CPR0: cpr {

compatible =3D "ibm,cpr-460ex";

dcr-reg =3D <00c 002>;

};

L2C0: l2c {

compatible =3D "ibm,l2-cache-460ex", "ibm,l2-cache";

dcr-reg =3D <20 8 /* Internal SRAM DCR's */

30 8>; /* L2 cache DCR's */

cache-line-size =3D <20>; /* 32 bytes */

cache-size =3D <40000>; /* L2, 256K */

interrupt-parent =3D <&UIC2>;

interrupts =3D <17 1>;

};

plb {

compatible =3D "ibm,plb-460ex", "ibm,plb4";

#address-cells =3D <2>;

#size-cells =3D <1>;

ranges;

clock-frequency =3D <0>; /* Filled in by U-Boot */

SDRAM0: sdram {

compatible =3D "ibm,sdram-460ex", "ibm,sdram-405gp";

dcr-reg =3D <010 2>;

};

MAL0: mcmal {

compatible =3D "ibm,mcmal-460ex", "ibm,mcmal2";

dcr-reg =3D <180 62>;

num-tx-chans =3D <2>;

num-rx-chans =3D <10>;

#address-cells =3D <0>;

#size-cells =3D <0>;

interrupt-parent =3D <&UIC2>;

interrupts =3D < /*TXEOB*/ 6 4

/*RXEOB*/ 7 4

/*SERR*/ 3 4

/*TXDE*/ 4 4

/*RXDE*/ 5 4>;

};

USB0: ehci@bffd0400 {

compatible =3D "ibm,usb-ehci-460ex", "usb-ehci";

interrupt-parent =3D <&UIC2>;

interrupts =3D <1d 4>;

reg =3D <4 bffd0400 90 4 bffd0490 70>;

};

USB1: usb@bffd0000 {

compatible =3D "ohci-le";

reg =3D <4 bffd0000 60>;

interrupt-parent =3D <&UIC2>;

interrupts =3D <1e 4>;

};

USBOTG0: usbotg@bff80000 {

compatible =3D "amcc,usb-otg-460ex";

reg =3D <4 bff80000 10000>;

interrupt-parent =3D <&USBOTG0>;

interrupts =3D <0 1 2>;

#interrupt-cells =3D <1>;

#address-cells =3D <0>;

#size-cells =3D <0>;

interrupt-map =3D </* USB-OTG */ 0 &UIC2 1c 4

/* HIGH-POWER */ 1 &UIC1 1a 8

/* DMA */ 2 &UIC0 c 4>;

interrupt-map-mask =3D <ffffffff>;

};

CRYPTO: crypto@180000 {

compatible =3D "amcc,ppc460ex-crypto", "amcc,ppc4xx-crypto";

reg =3D <4 00180000 84000>;

interrupt-parent =3D <&UIC0>;

interrupts =3D <1d 4>;

};

TRNG: trng@110000 {

device_type =3D "trng";

compatible =3D "ppc4xx-trng", "amcc, ppc4xx-trng";

reg =3D <4 00110000 100>;

interrupt-parent =3D <&UIC1>;

interrupts =3D <3 2>;

};

PKA: pka@114000 {

device_type =3D "pka";

compatible =3D "ppc4xx-pka", "amcc, ppc4xx-pka";

reg =3D <4 00114000 4000>;

interrupt-parent =3D <&UIC0>;

interrupts =3D <14 2>;

};

POB0: opb {

compatible =3D "ibm,opb-460ex", "ibm,opb";

#address-cells =3D <1>;

#size-cells =3D <1>;

ranges =3D <b0000000 4 b0000000 50000000>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

EBC0: ebc {

compatible =3D "ibm,ebc-460ex", "ibm,ebc";

dcr-reg =3D <012 2>;

#address-cells =3D <2>;

#size-cells =3D <1>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

/* ranges property is supplied by U-Boot */

interrupts =3D <6 4>;

interrupt-parent =3D <&UIC1>;

nor_flash@0,0 {

compatible =3D "amd,s29gl512n", "cfi-flash";

bank-width =3D <2>;

reg =3D <0 000000 4000000>;

#address-cells =3D <1>;

#size-cells =3D <1>;

partition@0 {

label =3D "kernel";

reg =3D <0 1e0000>;

};

partition@1e0000 {

label =3D "dtb";

reg =3D <1e0000 20000>;

};

partition@200000 {

label =3D "ramdisk";

reg =3D <200000 1400000>;

};

partition@1600000 {

label =3D "jffs2";

reg =3D <1600000 400000>;

};

partition@1a00000 {

label =3D "user";

reg =3D <1a00000 2560000>;

};

partition@3f60000 {

label =3D "env";

reg =3D <3f60000 40000>;

};

partition@3fa0000 {

label =3D "u-boot";

reg =3D <3fa0000 60000>;

};

};

};

UART0: serial@ef600300 {

device_type =3D "serial";

compatible =3D "ns16550";

reg =3D <ef600300 8>;

virtual-reg =3D <ef600300>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

current-speed =3D <0>; /* Filled in by U-Boot */

interrupt-parent =3D <&UIC1>;

interrupts =3D <1 4>;

};

UART1: serial@ef600400 {

device_type =3D "serial";

compatible =3D "ns16550";

reg =3D <ef600400 8>;

virtual-reg =3D <ef600400>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

current-speed =3D <0>; /* Filled in by U-Boot */

interrupt-parent =3D <&UIC0>;

interrupts =3D <1 4>;

};

UART2: serial@ef600500 {

device_type =3D "serial";

compatible =3D "ns16550";

reg =3D <ef600500 8>;

virtual-reg =3D <ef600500>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

current-speed =3D <0>; /* Filled in by U-Boot */

interrupt-parent =3D <&UIC1>;

interrupts =3D <1d 4>;

};

UART3: serial@ef600600 {

device_type =3D "serial";

compatible =3D "ns16550";

reg =3D <ef600600 8>;

virtual-reg =3D <ef600600>;

clock-frequency =3D <0>; /* Filled in by U-Boot */

current-speed =3D <0>; /* Filled in by U-Boot */

interrupt-parent =3D <&UIC1>;

interrupts =3D <1e 4>;

};

=20

IIC0: i2c@ef600700 {

compatible =3D "ibm,iic-460ex", "ibm,iic";

reg =3D <ef600700 14>;

interrupt-parent =3D <&UIC0>;

interrupts =3D <2 4>;

#address-cells =3D <1>;

#size-cells =3D <0>;

rtc@68 {

compatible =3D "stm,m41t80";

reg =3D <68>;

};

};

=20

=20

IIC1: i2c@ef600800 {

compatible =3D "ibm,iic-460ex", "ibm,iic";

reg =3D <ef600800 14>;

interrupt-parent =3D <&UIC0>;

interrupts =3D <3 4>;

};

ZMII0: emac-zmii@ef600d00 {

compatible =3D "ibm,zmii-460ex", "ibm,zmii";

reg =3D <ef600d00 c>;

};

RGMII0: emac-rgmii@ef601500 {

compatible =3D "ibm,rgmii-460ex", "ibm,rgmii";

reg =3D <ef601500 8>;

has-mdio;

};

TAH0: emac-tah@ef601350 {

compatible =3D "ibm,tah-460ex", "ibm,tah";

reg =3D <ef601350 30>;

};

TAH1: emac-tah@ef601450 {

compatible =3D "ibm,tah-460ex", "ibm,tah";

reg =3D <ef601450 30>;

};

EMAC0: ethernet@ef600e00 {

device_type =3D "network";

compatible =3D "ibm,emac-460ex", "ibm,emac4";

interrupt-parent =3D <&EMAC0>;

interrupts =3D <0 1>;

#interrupt-cells =3D <1>;

#address-cells =3D <0>;

#size-cells =3D <0>;

interrupt-map =3D </*Status*/ 0 &UIC2 10 4

/*Wake*/ 1 &UIC2 14 4>;

reg =3D <ef600e00 70>;

local-mac-address =3D [000000000000]; /* Filled in by U-Boot */

mal-device =3D <&MAL0>;

mal-tx-channel =3D <0>;

mal-rx-channel =3D <0>;

cell-index =3D <0>;

max-frame-size =3D <2328>;

rx-fifo-size =3D <1000>;

tx-fifo-size =3D <800>;

phy-mode =3D "rgmii";

phy-map =3D <00000000>;

rgmii-device =3D <&RGMII0>;

rgmii-channel =3D <0>;

tah-device =3D <&TAH0>;

tah-channel =3D <0>;

has-inverted-stacr-oc;

has-new-stacr-staopc;

};

EMAC1: ethernet@ef600f00 {

device_type =3D "network";

compatible =3D "ibm,emac-460ex", "ibm,emac4";

interrupt-parent =3D <&EMAC1>;

interrupts =3D <0 1>;

#interrupt-cells =3D <1>;

#address-cells =3D <0>;

#size-cells =3D <0>;

interrupt-map =3D </*Status*/ 0 &UIC2 11 4

/*Wake*/ 1 &UIC2 15 4>;

reg =3D <ef600f00 70>;

local-mac-address =3D [000000000000]; /* Filled in by U-Boot */

mal-device =3D <&MAL0>;

mal-tx-channel =3D <1>;

mal-rx-channel =3D <8>;

cell-index =3D <1>;

max-frame-size =3D <2328>;

rx-fifo-size =3D <1000>;

tx-fifo-size =3D <800>;

phy-mode =3D "rgmii";

phy-map =3D <00000000>;

rgmii-device =3D <&RGMII0>;

rgmii-channel =3D <1>;

tah-device =3D <&TAH1>;

tah-channel =3D <1>;

has-inverted-stacr-oc;

has-new-stacr-staopc;

mdio-device =3D <&EMAC0>;

};

};

PCIX0: pci@c0ec00000 {

device_type =3D "pci";

#interrupt-cells =3D <1>;

#size-cells =3D <2>;

#address-cells =3D <3>;

compatible =3D "ibm,plb-pcix-460ex", "ibm,plb-pcix";

primary;

large-inbound-windows;

enable-msi-hole;

reg =3D <c 0ec00000 8 /* Config space access */

0 0 0 /* no IACK cycles */

c 0ed00000 4 /* Special cycles */

c 0ec80000 100 /* Internal registers */

c 0ec80100 fc>; /* Internal messaging registers */

/* Outbound ranges, one memory and one IO,

* later cannot be changed

*/

ranges =3D <02000000 0 80000000 0000000d 80000000 0 80000000

01000000 0 00000000 0000000c 08000000 0 00010000>;

/* Inbound 2GB range starting at 0 */

dma-ranges =3D <42000000 0 0 0 0 0 80000000>;

/* This drives busses 0 to 0x3f */

bus-range =3D <0 3f>;

/* All PCI interrupts are routed to ext IRQ 2 -> UIC1-0 */

interrupt-map-mask =3D <0000 0 0 0>;

interrupt-map =3D < 0000 0 0 0 &UIC1 0 8 >;

};

PCIE0: pciex@d00000000 {

device_type =3D "pci";

#interrupt-cells =3D <1>;

#size-cells =3D <2>;

#address-cells =3D <3>;

compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";

primary;

port =3D <0>; /* port number */

reg =3D <d 00000000 20000000 /* Config space access */

c 08010000 00001000>; /* Registers */

dcr-reg =3D <100 020>;

sdr-base =3D <300>;

/* Outbound ranges, one memory and one IO,

* later cannot be changed

*/

ranges =3D <02000000 0 80000000 0000000e 00000000 0 80000000

01000000 0 00000000 0000000f 80000000 0 00010000>;

/* Inbound 2GB range starting at 0 */

dma-ranges =3D <42000000 0 0 0 0 0 80000000>;

/* This drives busses 40 to 0x7f */

bus-range =3D <40 7f>;

/* Legacy interrupts (note the weird polarity, the bridge seems

* to invert PCIe legacy interrupts).

* We are de-swizzling here because the numbers are actually for

* port of the root complex virtual P2P bridge. But I want

* to avoid putting a node for it in the tree, so the numbers

* below are basically de-swizzled numbers.

* The real slot is on idsel 0, so the swizzling is 1:1

*/

interrupt-map-mask =3D <0000 0 0 7>;

interrupt-map =3D <

0000 0 0 1 &UIC3 c 4 /* swizzled int A */

0000 0 0 2 &UIC3 d 4 /* swizzled int B */

0000 0 0 3 &UIC3 e 4 /* swizzled int C */

0000 0 0 4 &UIC3 f 4 /* swizzled int D */>;

};

PCIE1: pciex@d20000000 {

device_type =3D "pci";

#interrupt-cells =3D <1>;

#size-cells =3D <2>;

#address-cells =3D <3>;

compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";

primary;

port =3D <1>; /* port number */

reg =3D <d 20000000 20000000 /* Config space access */

c 08011000 00001000>; /* Registers */

dcr-reg =3D <120 020>;

sdr-base =3D <340>;

/* Outbound ranges, one memory and one IO,

* later cannot be changed

*/

ranges =3D <02000000 0 80000000 0000000e 80000000 0 80000000

01000000 0 00000000 0000000f 80010000 0 00010000>;

/* Inbound 2GB range starting at 0 */

dma-ranges =3D <42000000 0 0 0 0 0 80000000>;

/* This drives busses 80 to 0xbf */

bus-range =3D <80 bf>;

/* Legacy interrupts (note the weird polarity, the bridge seems

* to invert PCIe legacy interrupts).

* We are de-swizzling here because the numbers are actually for

* port of the root complex virtual P2P bridge. But I want

* to avoid putting a node for it in the tree, so the numbers

* below are basically de-swizzled numbers.

* The real slot is on idsel 0, so the swizzling is 1:1

*/

interrupt-map-mask =3D <0000 0 0 7>;

interrupt-map =3D <

0000 0 0 1 &UIC3 10 4 /* swizzled int A */

0000 0 0 2 &UIC3 11 4 /* swizzled int B */

0000 0 0 3 &UIC3 12 4 /* swizzled int C */

0000 0 0 4 &UIC3 13 4 /* swizzled int D */>;

};

};

};

=20
-------------------- Kconfig ----------
#

# Hardware Random Number Generator (RNG) configuration

#

config HW_RANDOM

tristate "Hardware Random Number Generator Core support"

default m

---help---

Hardware Random Number Generator Core infrastructure.

To compile this driver as a module, choose M here: the

module will be called rng-core. This provides a device

that's usually called /dev/hw_random, and which exposes one

of possibly several hardware random number generators.

These hardware random number generators do not feed directly

into the kernel's random number generator. That is usually

handled by the "rngd" daemon. Documentation/hw_random.txt

has more information.

If unsure, say Y.

config HW_RANDOM_INTEL

tristate "Intel HW Random Number Generator support"

depends on HW_RANDOM && (X86 || IA64) && PCI

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on Intel i8xx-based motherboards.

To compile this driver as a module, choose M here: the

module will be called intel-rng.

If unsure, say Y.

config HW_RANDOM_AMD

tristate "AMD HW Random Number Generator support"

depends on HW_RANDOM && X86 && PCI

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on AMD 76x-based motherboards.

To compile this driver as a module, choose M here: the

module will be called amd-rng.

If unsure, say Y.

config HW_RANDOM_GEODE

tristate "AMD Geode HW Random Number Generator support"

depends on HW_RANDOM && X86_32 && PCI

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on the AMD Geode LX.

To compile this driver as a module, choose M here: the

module will be called geode-rng.

If unsure, say Y.

config HW_RANDOM_VIA

tristate "VIA HW Random Number Generator support"

depends on HW_RANDOM && X86_32

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on VIA based motherboards.

To compile this driver as a module, choose M here: the

module will be called via-rng.

If unsure, say Y.

config HW_RANDOM_IXP4XX

tristate "Intel IXP4xx NPU HW Random Number Generator support"

depends on HW_RANDOM && ARCH_IXP4XX

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random

Number Generator hardware found on the Intel IXP4xx NPU.

To compile this driver as a module, choose M here: the

module will be called ixp4xx-rng.

If unsure, say Y.

config HW_RANDOM_OMAP

tristate "OMAP Random Number Generator support"

depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP24XX)

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on OMAP16xx and OMAP24xx multimedia

processors.

To compile this driver as a module, choose M here: the

module will be called omap-rng.

If unsure, say Y.

config HW_RANDOM_PASEMI

tristate "PA Semi HW Random Number Generator support"

depends on HW_RANDOM && PPC_PASEMI

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on PA Semi PWRficient SoCs.

To compile this driver as a module, choose M here: the

module will be called pasemi-rng.

If unsure, say Y.

config HW_RANDOM_TRNG4xx

tristate "AMCC 4xx TRNG True Random Number Generator support"

depends on HW_RANDOM && PPC

default HW_RANDOM

---help---

This driver provides kernel-side support for the Random Number

Generator hardware found on PA Semi PWRficient SoCs.

To compile this driver as a module, choose M here: the

module will be called pasemi-rng.

If unsure, say Y.

----------------------------------------Makefile --------------------
#

# Makefile for HW Random Number Generator (RNG) device drivers.

#

obj-$(CONFIG_HW_RANDOM) +=3D rng-core.o

rng-core-y :=3D core.o

obj-$(CONFIG_HW_RANDOM_INTEL) +=3D intel-rng.o

obj-$(CONFIG_HW_RANDOM_AMD) +=3D amd-rng.o

obj-$(CONFIG_HW_RANDOM_GEODE) +=3D geode-rng.o

obj-$(CONFIG_HW_RANDOM_VIA) +=3D via-rng.o

obj-$(CONFIG_HW_RANDOM_IXP4XX) +=3D ixp4xx-rng.o

obj-$(CONFIG_HW_RANDOM_OMAP) +=3D omap-rng.o

obj-$(CONFIG_HW_RANDOM_PASEMI) +=3D pasemi-rng.o

obj-$(CONFIG_HW_RANDOM_TRNG4xx) +=3D trng4xx.o


________________________________

From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of =
Tirumala Reddy Marri
Sent: Wed 4/1/2009 10:05 AM
To: Felix Radensky; linuxppc-dev@ozlabs.org
Subject: RE: /dev/random on PPC40EXr



There is PKA/TRNG driver for sure. Let me check if it was accepted in
opensource yet. Otherwise I will forward you the driver which may not be
there in opensource yet.


-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] On Behalf Of
Felix Radensky
Sent: Wednesday, April 01, 2009 5:00 AM
To: linuxppc-dev@ozlabs.org
Subject: /dev/random on PPC40EXr


Hi,

On my custom board based on 405EXr /dev/random produces no output
at all, and /dev/urandom is not random enough for our purposes. Saving
entropy pool between reboots doesn't help much.

What can be done to increase the entropy of the system ?
I was thinking of adding IRQF_SAMPLE_RANDOM to network driver,
but since not too many drivers implement it, I don't know whether
it's a good idea or not.

Is there any work in progress to develop hw_random driver for 4xx
TRNG ?

Thanks a lot.

Felix.
--
View this message in context:
http://www.nabble.com/-dev-random-on-PPC40EXr-tp22824979p22824979.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_002_01C9B358.CF7555FA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>RE: /dev/random on PPC40EXr</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText9283 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Here I am =
copy pasting the files and also attaching.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial =
size=3D2>--------------trng4xx.c-------------</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>=0A=
<P>/*********************************************************************=
**********</P>=0A=
<P>*</P>=0A=
<P>* Copyright (c) 2008 Loc Ho &lt;lho@amcc.com&gt;</P>=0A=
<P>*</P>=0A=
<P>* This program is free software; you can redistribute it and/or =
modify</P>=0A=
<P>* it under the terms of the GNU General Public License as published =
by</P>=0A=
<P>* the Free Software Foundation; either version 2 of the License, =
or</P>=0A=
<P>* (at your option) any later version.</P>=0A=
<P>*</P>=0A=
<P>* This program is distributed in the hope that it will be useful,</P>=0A=
<P>* but WITHOUT ANY WARRANTY; without even the implied warranty of</P>=0A=
<P>* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the</P>=0A=
<P>* GNU General Public License for more details.</P>=0A=
<P>*</P>=0A=
<P>*</P>=0A=
<P>* Detail Description:</P>=0A=
<P>* This file defines ioctl structures for the Linux CryptoAPI =
interface. It</P>=0A=
<P>* provides user space applications accesss into the Linux =
CryptoAPI</P>=0A=
<P>* functionalities.</P>=0A=
<P>*</P>=0A=
<P>* @file trng4xx.c</P>=0A=
<P>*</P>=0A=
<P>* This file provides access to the AMCC PPC4XX TRNG for Linux.</P>=0A=
<P>*</P>=0A=
<P>**********************************************************************=
*********</P>=0A=
<P>*/</P>=0A=
<P>#include &lt;linux/version.h&gt;</P>=0A=
<P>#include &lt;linux/module.h&gt;</P>=0A=
<P>#include &lt;linux/kernel.h&gt;</P>=0A=
<P>#include &lt;linux/platform_device.h&gt;</P>=0A=
<P>#include &lt;linux/hw_random.h&gt;</P>=0A=
<P>#include &lt;linux/interrupt.h&gt;</P>=0A=
<P>#include &lt;asm/of_platform.h&gt;</P>=0A=
<P>#include &lt;asm/io.h&gt;</P>=0A=
<P>#include "trng4xx.h"</P>=0A=
<P>#define TRNG4XX_VER_STR "0.1"</P>=0A=
<P>#define PFX KBUILD_MODNAME ": "</P>=0A=
<P>struct trng4xx_dev {</P>=0A=
<P>struct resource res;</P>=0A=
<P>u32 irq;</P>=0A=
<P>volatile char __iomem *csr;</P>=0A=
<P>struct semaphore access_prot;</P>=0A=
<P>u32 datum;</P>=0A=
<P>};</P>=0A=
<P>struct hal_config {</P>=0A=
<P>struct of_device *ofdev;</P>=0A=
<P>};</P>=0A=
<P>static struct trng4xx_dev trng4xx_dev;</P>=0A=
<P>static int trng4xx_irq_handler(int irq, void * id);</P>=0A=
<P>static void trng4xx_chk_overflow(void);</P>=0A=
<P>int trng4xx_config_set(struct hal_config *cfg)</P>=0A=
<P>{</P>=0A=
<P>struct device_node *rng_np =3D cfg-&gt;ofdev-&gt;node;</P>=0A=
<P>int rc =3D 0;</P>=0A=
<P>rc =3D of_address_to_resource(rng_np, 0, &amp;trng4xx_dev.res);</P>=0A=
<P>if (rc)</P>=0A=
<P>return -ENODEV;</P>=0A=
<P>trng4xx_dev.csr =3D ioremap(trng4xx_dev.res.start,</P>=0A=
<P>trng4xx_dev.res.end - trng4xx_dev.res.start + 1);</P>=0A=
<P>if (trng4xx_dev.csr =3D=3D NULL) {</P>=0A=
<P>printk(KERN_ERR PFX "unable to ioremap 0x%02X_%08X size %d\n",</P>=0A=
<P>(u32) (trng4xx_dev.res.start &gt;&gt; 32),</P>=0A=
<P>(u32) trng4xx_dev.res.start,</P>=0A=
<P>(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1));</P>=0A=
<P>return -ENOMEM;</P>=0A=
<P>}</P>=0A=
<P>#if 0</P>=0A=
<P>printk("TRNG1 0x%02X_%08X size %d\n",</P>=0A=
<P>(u32) (trng4xx_dev.res.start &gt;&gt; 32),</P>=0A=
<P>(u32) trng4xx_dev.res.start,</P>=0A=
<P>(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1));</P>=0A=
<P>#endif</P>=0A=
<P>trng4xx_dev.irq =3D of_irq_to_resource(rng_np, 0, NULL); </P>=0A=
<P>printk ("TRNG IRQ =3D %d\n",trng4xx_dev.irq); </P>=0A=
<P>if (trng4xx_dev.irq =3D=3D NO_IRQ) {</P>=0A=
<P>/* Un-map CSR */</P>=0A=
<P>iounmap(trng4xx_dev.csr);</P>=0A=
<P>trng4xx_dev.csr =3D NULL;</P>=0A=
<P>return -EINVAL;</P>=0A=
<P>}</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>int trng4xx_pka_config_clear(void)</P>=0A=
<P>{</P>=0A=
<P>iounmap(trng4xx_dev.csr);</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>inline int trng4xx_hw_read32(u32 reg_addr, u32 *data_val)</P>=0A=
<P>{</P>=0A=
<P>*data_val =3D in_be32((volatile unsigned __iomem *)</P>=0A=
<P>(trng4xx_dev.csr + reg_addr));</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>inline int trng4xx_hw_write32(u32 reg_addr, u32 data_val)</P>=0A=
<P>{</P>=0A=
<P>out_be32((volatile unsigned __iomem *) (trng4xx_dev.csr + =
reg_addr),</P>=0A=
<P>data_val);</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>int trng4xx_hw_init(void)</P>=0A=
<P>{</P>=0A=
<P>int rc;</P>=0A=
<P>rc =3D request_irq(trng4xx_dev.irq, trng4xx_irq_handler,</P>=0A=
<P>0, "TRNG", NULL);</P>=0A=
<P>if (rc !=3D 0) {</P>=0A=
<P>printk(KERN_ERR PFX "failed to register interrupt IRQ %d\n",</P>=0A=
<P>trng4xx_dev.irq);</P>=0A=
<P>return rc;</P>=0A=
<P>}</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>int trng4xx_hw_deinit(void)</P>=0A=
<P>{</P>=0A=
<P>free_irq(trng4xx_dev.irq, NULL);</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>static int trng4xx_irq_handler(int irq, void * id)</P>=0A=
<P>{</P>=0A=
<P>/* TRNG Alarm Counter overflow */</P>=0A=
<P>trng4xx_chk_overflow();</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>/*********************************************************************=
**********</P>=0A=
<P>* TRNG Functions</P>=0A=
<P>**********************************************************************=
*********</P>=0A=
<P>*/</P>=0A=
<P>static void trng4xx_chk_overflow(void)</P>=0A=
<P>{</P>=0A=
<P>/* TRNG Alarm Counter overflow */</P>=0A=
<P>int rc;</P>=0A=
<P>u32 val;</P>=0A=
<P>struct trng4xx_cfg {</P>=0A=
<P>u32 ring1_delay_sel : 3;</P>=0A=
<P>u32 ring2_delay_sel : 3;</P>=0A=
<P>u32 reset_cnt : 6;</P>=0A=
<P>} __attribute__((packed));</P>=0A=
<P>&nbsp;</P>=0A=
<P>rc =3D trng4xx_hw_write32(TRNG4XX_ALARMCNT_ADDR, val);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>return;</P>=0A=
<P>if (val &gt; 128) {</P>=0A=
<P>struct trng4xx_cfg *trng4xx_cfg;</P>=0A=
<P>/* Alarm count is half, reset it */</P>=0A=
<P>rc =3D trng4xx_hw_read32(TRNG4XX_CFG_ADDR, &amp;val);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>return;</P>=0A=
<P>trng4xx_cfg =3D (struct trng4xx_cfg *) &amp;val;</P>=0A=
<P>++trng4xx_cfg-&gt;ring1_delay_sel;</P>=0A=
<P>trng4xx_cfg-&gt;ring2_delay_sel =3D =
(~trng4xx_cfg-&gt;ring1_delay_sel) &amp; 0x07;</P>=0A=
<P>rc =3D trng4xx_hw_write32(TRNG4XX_CFG_ADDR, val);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>return;</P>=0A=
<P>trng4xx_hw_write32(TRNG4XX_ALARMCNT_ADDR, 0x00000000);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>return;</P>=0A=
<P>}</P>=0A=
<P>}</P>=0A=
<P>int trng4xx_random(u32 *rand_val)</P>=0A=
<P>{</P>=0A=
<P>u32 val =3D 0;</P>=0A=
<P>int rc;</P>=0A=
<P>#define MAX_TRY 3</P>=0A=
<P>u16 try_cnt =3D 0;</P>=0A=
<P>down(&amp;trng4xx_dev.access_prot);</P>=0A=
<P>do {</P>=0A=
<P>rc =3D trng4xx_hw_read32(TRNG4XX_STATUS_ADDR, &amp;val);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>goto err;</P>=0A=
<P>} while((val &amp; TRNG4XX_STATUS_BUSY) &amp;&amp; ++try_cnt &lt;=3D =
MAX_TRY);</P>=0A=
<P>if (val &amp; TRNG4XX_STATUS_BUSY) {</P>=0A=
<P>rc =3D -EINPROGRESS;</P>=0A=
<P>goto err;</P>=0A=
<P>}</P>=0A=
<P></P>=0A=
<P>rc =3D trng4xx_hw_read32(TRNG4XX_OUTPUT_ADDR, rand_val);</P>=0A=
<P>&nbsp;</P>=0A=
<P>err:</P>=0A=
<P>//printk("status busy\n");</P>=0A=
<P>up(&amp;trng4xx_dev.access_prot);</P>=0A=
<P>return rc;</P>=0A=
<P>}</P>=0A=
<P>EXPORT_SYMBOL_GPL(trng4xx_random);</P>=0A=
<P>#if LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,6,25)</P>=0A=
<P>static int trng4xx_data_present(struct hwrng *rng)</P>=0A=
<P>#else</P>=0A=
<P>static int trng4xx_data_present(struct hwrng *rng, int wait)</P>=0A=
<P>#endif</P>=0A=
<P>{</P>=0A=
<P>struct trng4xx_dev *dev =3D (struct trng4xx_dev *) rng-&gt;priv;</P>=0A=
<P>int i;</P>=0A=
<P>u32 val;</P>=0A=
<P>printk("inside %s:\n", __FUNCTION__);</P>=0A=
<P>down(&amp;trng4xx_dev.access_prot);</P>=0A=
<P>/* We should not take more than 200??? us */</P>=0A=
<P>for (i =3D 0; i &lt; 20; i++) {</P>=0A=
<P>trng4xx_hw_read32(TRNG4XX_STATUS_ADDR, &amp;val);</P>=0A=
<P>if (!(val &amp; TRNG4XX_STATUS_BUSY)) {</P>=0A=
<P>trng4xx_hw_read32(TRNG4XX_OUTPUT_ADDR, &amp;dev-&gt;datum);</P>=0A=
<P>break;</P>=0A=
<P>}</P>=0A=
<P>#if LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,6,25)</P>=0A=
<P>break;</P>=0A=
<P>#else</P>=0A=
<P>if (!wait)</P>=0A=
<P>break;</P>=0A=
<P>udelay(10);</P>=0A=
<P>#endif</P>=0A=
<P>}</P>=0A=
<P>up(&amp;trng4xx_dev.access_prot);</P>=0A=
<P>return (val &amp; TRNG4XX_STATUS_BUSY) ? 0 : 1;</P>=0A=
<P>}</P>=0A=
<P>static int trng4xx_data_read(struct hwrng *rng, u32 *data)</P>=0A=
<P>{</P>=0A=
<P>struct trng4xx_dev *dev =3D (struct trng4xx_dev *) rng-&gt;priv;</P>=0A=
<P>*data =3D dev-&gt;datum;</P>=0A=
<P>printk("data read =3D %u\n", *data); </P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>static int trng4xx_init(struct hwrng *rng)</P>=0A=
<P>{</P>=0A=
<P>return trng4xx_hw_init();</P>=0A=
<P>}</P>=0A=
<P>static void trng4xx_cleanup(struct hwrng *rng)</P>=0A=
<P>{</P>=0A=
<P></P>=0A=
<P>trng4xx_hw_deinit();</P>=0A=
<P>}</P>=0A=
<P>static struct hwrng trng4xx_func =3D {</P>=0A=
<P>.name =3D "ppc4xx-trng",</P>=0A=
<P>.init =3D trng4xx_init,</P>=0A=
<P>.cleanup =3D trng4xx_cleanup,</P>=0A=
<P>.data_present =3D trng4xx_data_present,</P>=0A=
<P>.data_read =3D trng4xx_data_read,</P>=0A=
<P>.priv =3D (unsigned long) &amp;trng4xx_dev,</P>=0A=
<P>};</P>=0A=
<P>/*********************************************************************=
**********</P>=0A=
<P>*</P>=0A=
<P>* Setup Driver with platform registration</P>=0A=
<P>*</P>=0A=
<P>**********************************************************************=
*********</P>=0A=
<P>*/</P>=0A=
<P>static int __devinit trng4xx_probe(struct of_device *ofdev,</P>=0A=
<P>const struct of_device_id *match)</P>=0A=
<P>{</P>=0A=
<P>struct hal_config hw_cfg;</P>=0A=
<P>int rc;</P>=0A=
<P>u32 value, value2;</P>=0A=
<P>u32 ctrl_val, control_value;</P>=0A=
<P>hw_cfg.ofdev =3D ofdev;</P>=0A=
<P>rc =3D trng4xx_config_set(&amp;hw_cfg);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>return rc;</P>=0A=
<P>#if 1</P>=0A=
<P>printk( "AMCC 4xx TRNG v%s @0x%02X_%08X size %d IRQ %d\n",</P>=0A=
<P>TRNG4XX_VER_STR,</P>=0A=
<P>(u32) (trng4xx_dev.res.start &gt;&gt; 32),</P>=0A=
<P>(u32) trng4xx_dev.res.start,</P>=0A=
<P>(u32) (trng4xx_dev.res.end - trng4xx_dev.res.start + 1),</P>=0A=
<P>trng4xx_dev.irq);</P>=0A=
<P>#endif</P>=0A=
<P>init_MUTEX(&amp;trng4xx_dev.access_prot);</P>=0A=
<P>rc =3D hwrng_register(&amp;trng4xx_func);</P>=0A=
<P>if (rc) {</P>=0A=
<P>printk(KERN_ERR PFX</P>=0A=
<P>"AMCC 4xx TRNG registering failed error %d\n", rc);</P>=0A=
<P>goto err;</P>=0A=
<P>}</P>=0A=
<P></P>=0A=
<P>trng4xx_hw_read32(TRNG4XX_CNTL_ADDR, &amp;ctrl_val);</P>=0A=
<P>//printk ("cntl value =3D 0x%x\n", ctrl_val);</P>=0A=
<P>value =3D ctrl_val | TRNG4XX_CNTL_TST_ALARM;</P>=0A=
<P>//printk ("value to write =3D 0x%x\n", value);</P>=0A=
<P>/*rc =3D trng4xx_hw_write32(TRNG4XX_CNTL_ADDR, value);</P>=0A=
<P>if (rc !=3D 0)</P>=0A=
<P>printk ("ERROR: writing\n");</P>=0A=
<P>&nbsp;</P>=0A=
<P>trng4xx_hw_read32(TRNG4XX_CNTL_ADDR, &amp;control_value);</P>=0A=
<P>printk ("control value =3D 0x%x\n", control_value);*/</P>=0A=
<P></P>=0A=
<P>/*value =3D 0;</P>=0A=
<P>printk ("checking random value register\n");</P>=0A=
<P>rc =3D trng4xx_random (&amp;value);</P>=0A=
<P></P>=0A=
<P></P>=0A=
<P>printk ("checking random value register\n");</P>=0A=
<P>rc =3D trng4xx_random (&amp;value2);*/</P>=0A=
<P>return rc;</P>=0A=
<P>err:</P>=0A=
<P>trng4xx_pka_config_clear();</P>=0A=
<P>return rc;</P>=0A=
<P>}</P>=0A=
<P>static int __devexit trng4xx_remove(struct of_device *dev)</P>=0A=
<P>{</P>=0A=
<P>hwrng_unregister(&amp;trng4xx_func);</P>=0A=
<P>trng4xx_pka_config_clear();</P>=0A=
<P>return 0;</P>=0A=
<P>}</P>=0A=
<P>static struct of_device_id trng4xx_match[] =3D {</P>=0A=
<P>{ .compatible =3D "ppc4xx-trng", },</P>=0A=
<P>{ .compatible =3D "amcc,ppc4xx-trng", },</P>=0A=
<P>{ },</P>=0A=
<P>};</P>=0A=
<P>static struct of_platform_driver trng4xx_driver =3D {</P>=0A=
<P>.name =3D "ppc4xx-trng",</P>=0A=
<P>.match_table =3D trng4xx_match,</P>=0A=
<P>.probe =3D trng4xx_probe,</P>=0A=
<P>.remove =3D trng4xx_remove,</P>=0A=
<P>};</P>=0A=
<P>static int __init mod_init(void)</P>=0A=
<P>{</P>=0A=
<P>printk("entered mod_init\n"); </P>=0A=
<P>return of_register_platform_driver(&amp;trng4xx_driver);</P>=0A=
<P>}</P>=0A=
<P>static void __exit mod_exit(void)</P>=0A=
<P>{</P>=0A=
<P>of_unregister_platform_driver(&amp;trng4xx_driver);</P>=0A=
<P>}</P>=0A=
<P>module_init(mod_init);</P>=0A=
<P>module_exit(mod_exit);</P>=0A=
<P>MODULE_DESCRIPTION("AMCC 4xx True Random Number Generator");</P>=0A=
<P>MODULE_LICENSE("GPL");</P></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>------------trng4xx.h ------------------- </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV><FONT size=3D2>=0A=
<P =
dir=3Dltr>/**************************************************************=
*****************</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* Copyright (c) 2008 Loc Ho &lt;lho@amcc.com&gt;</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* This program is free software; you can redistribute it =
and/or modify</P>=0A=
<P dir=3Dltr>* it under the terms of the GNU General Public License as =
published by</P>=0A=
<P dir=3Dltr>* the Free Software Foundation; either version 2 of the =
License, or</P>=0A=
<P dir=3Dltr>* (at your option) any later version.</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* This program is distributed in the hope that it will be =
useful,</P>=0A=
<P dir=3Dltr>* but WITHOUT ANY WARRANTY; without even the implied =
warranty of</P>=0A=
<P dir=3Dltr>* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See =
the</P>=0A=
<P dir=3Dltr>* GNU General Public License for more details.</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* Detail Description:</P>=0A=
<P dir=3Dltr>* This file defines ioctl structures for the Linux =
CryptoAPI interface. It</P>=0A=
<P dir=3Dltr>* provides user space applications accesss into the Linux =
CryptoAPI</P>=0A=
<P dir=3Dltr>* functionalities.</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* @file trng4xx.h</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P dir=3Dltr>* This file provides access to the AMCC SoC TRNG.</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>#ifndef __TRNG4XX_H__</P>=0A=
<P dir=3Dltr>#define __TRNG4XX_H__</P>=0A=
<P =
dir=3Dltr>/**************************************************************=
*****************</P>=0A=
<P dir=3Dltr>* TRNG Register and bit Definitions</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>/* Register TRNG4XX_STATUS bit definition */</P>=0A=
<P dir=3Dltr>#define TRNG4XX_STATUS_BUSY 0x00000001</P>=0A=
<P dir=3Dltr>/* Register TRNG4XX_CNTL bit definition */</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_RING_OUT 0x00000001</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_MODE 0x00000002</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_RUN 0x00000004</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_EN1 0x00000008</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_EN2 0x00000010</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_DISABLE_ALARM 0x00000020</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_CLOCK_ON 0x00000040</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_SHORT_CYCLE 0x00000080</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_ALARM 0x00000100</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_TST_LFSR 0x00000200</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_RESET_LFSR 0x00000400</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_BYPASS_TRNG 0x00000800</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_POST_PROC_EN 0x00001000</P>=0A=
<P dir=3Dltr>/* Register TRNG4XX_CFG bit definition */</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RING1_DELAY_SEL_SHIFT 0</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RING1_DELAY_SEL_MASK (7)</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT 3</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RING2_DELAY_SEL_MASK (7 &lt;&lt; =
TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT)</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RESET_CNT_SHIFT 6</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_RESET_CNT_SHIFT_MASK (0x3F &lt;&lt; =
TRNG4XX_CFG_RING2_DELAY_SEL_SHIFT)</P>=0A=
<P dir=3Dltr>/* TRNG Register definition */</P>=0A=
<P dir=3Dltr>#define TRNG4XX_OUTPUT_ADDR 0x0000</P>=0A=
<P dir=3Dltr>#define TRNG4XX_STATUS_ADDR 0x0004</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CNTL_ADDR 0x0008</P>=0A=
<P dir=3Dltr>#define TRNG4XX_CFG_ADDR 0x000C</P>=0A=
<P dir=3Dltr>#define TRNG4XX_ALARMCNT_ADDR 0x0010</P>=0A=
<P dir=3Dltr>#define TRNG4XX_AREG_ADDR 0x0014</P>=0A=
<P dir=3Dltr>#define TRNG4XX_BREG_ADDR 0x0018</P>=0A=
<P dir=3Dltr>#define TRNG4XX_XREG_0_ADDR 0x001C</P>=0A=
<P dir=3Dltr>#define TRNG4XX_XREG_1_ADDR 0x0020</P>=0A=
<P dir=3Dltr>#define TRNG4XX_XREG_2_ADDR 0x0024</P>=0A=
<P dir=3Dltr>#define TRNG4XX_LFSR1_L_ADDR 0x0028</P>=0A=
<P dir=3Dltr>#define TRNG4XX_LFSR1_H_ADDR 0x002C</P>=0A=
<P dir=3Dltr>#define TRNG4XX_LFSR2_L_ADDR 0x0030</P>=0A=
<P dir=3Dltr>#define TRNG4XX_LFSR2_H_ADDR 0x0034</P>=0A=
<P dir=3Dltr>#define TRNG4XX_KEY0_L_ADDR 0x0038</P>=0A=
<P dir=3Dltr>#define TRNG4XX_KEY0_H_ADDR 0x003C</P>=0A=
<P dir=3Dltr>#define TRNG4XX_KEY1_L_ADDR 0x0040</P>=0A=
<P dir=3Dltr>#define TRNG4XX_KEY1_H_ADDR 0x0044</P>=0A=
<P dir=3Dltr>#define TRNG4XX_IV_L_ADDR 0x0048</P>=0A=
<P dir=3Dltr>#define TRNG4XX_IV_H_ADDR 0x004C</P>=0A=
<P dir=3Dltr>struct hal_config;</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This function MUSTs be called to initialize the =
HW</P>=0A=
<P dir=3Dltr>* access function.</P>=0A=
<P dir=3Dltr>* @param amcc_hal_cfg HW access configuration. If NULL,</P>=0A=
<P dir=3Dltr>* default will be used.</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>* @note To load all access functions from HAL with default =
initial</P>=0A=
<P dir=3Dltr>* map address, pass a NULL as its parameter.</P>=0A=
<P dir=3Dltr>* @n To load all access functions from HAL with default =
runtime</P>=0A=
<P dir=3Dltr>* map address, initialize an amcc_hal_config_t struct</P>=0A=
<P dir=3Dltr>* with valid HAL signature and set</P>=0A=
<P dir=3Dltr>* amcc_hal_config-&gt;flags |=3D PPRO_HAL_FLAG_LOADINIT;</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>int trng4xx_config_set(struct hal_config *cfg);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This function MUSTs be called to de-initialize the =
HW</P>=0A=
<P dir=3Dltr>* access function.</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>int trng4xx_config_clear(void);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This functions reads from the TRNG registers.</P>=0A=
<P dir=3Dltr>* @param reg_addr Device register offset</P>=0A=
<P dir=3Dltr>* @param data_val An DWORD pointer to store the returned =
value</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>inline int trng4xx_hw_read32(u32 reg_addr, u32 =
*data_val);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This functions writes to the TRNG registers.</P>=0A=
<P dir=3Dltr>* @param reg_addr Device register offset</P>=0A=
<P dir=3Dltr>* @param data_val An DWORD value to write</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>inline int trng4xx_hw_write32(u32 reg_addr, u32 =
data_val);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This functions initializes the TRNG for =
operation.</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>int trng4xx_hw_init(void);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This functions de-initializes the TRNG.</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK or PPRO_RC_FATAL</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>int trng4xx_hw_deinit(void);</P>=0A=
<P dir=3Dltr>/**</P>=0A=
<P dir=3Dltr>* @brief This functions retrieves an true random number.</P>=0A=
<P dir=3Dltr>* @param rand_val A pointer to a DWORD to store the =
value</P>=0A=
<P dir=3Dltr>* @return PPRO_RC_OK if successfull. PPRO_RC_EINPROGRESS if =
failed. This</P>=0A=
<P dir=3Dltr>* should not happen as this means the hardware still =
busy.</P>=0A=
<P dir=3Dltr>*</P>=0A=
<P =
dir=3Dltr>***************************************************************=
****************</P>=0A=
<P dir=3Dltr>*/</P>=0A=
<P dir=3Dltr>int trng4xx_random(u32 *rand_val);</P>=0A=
<P dir=3Dltr>#endif</P>=0A=
<P></FONT>&nbsp;</P>=0A=
<P>------------------------- DTS file ---------------</P><FONT size=3D2>=0A=
<P>/*</P>=0A=
<P>* Device Tree Source for AMCC Canyonlands (460EX)</P>=0A=
<P>*</P>=0A=
<P>* Copyright 2008 DENX Software Engineering, Stefan Roese =
&lt;sr@denx.de&gt;</P>=0A=
<P>*</P>=0A=
<P>* This file is licensed under the terms of the GNU General Public</P>=0A=
<P>* License version 2. This program is licensed "as is" without</P>=0A=
<P>* any warranty of any kind, whether express or implied.</P>=0A=
<P>*/</P>=0A=
<P>/ {</P>=0A=
<P>#address-cells =3D &lt;2&gt;;</P>=0A=
<P>#size-cells =3D &lt;1&gt;;</P>=0A=
<P>model =3D "amcc,canyonlands";</P>=0A=
<P>compatible =3D "amcc,canyonlands";</P>=0A=
<P>dcr-parent =3D &lt;&amp;/cpus/cpu@0&gt;;</P>=0A=
<P>aliases {</P>=0A=
<P>ethernet0 =3D &amp;EMAC0;</P>=0A=
<P>ethernet1 =3D &amp;EMAC1;</P>=0A=
<P>serial0 =3D &amp;UART0;</P>=0A=
<P>serial1 =3D &amp;UART1;</P>=0A=
<P>};</P>=0A=
<P>cpus {</P>=0A=
<P>#address-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>cpu@0 {</P>=0A=
<P>device_type =3D "cpu";</P>=0A=
<P>model =3D "PowerPC,460EX";</P>=0A=
<P>reg =3D &lt;0&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>timebase-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>i-cache-line-size =3D &lt;20&gt;;</P>=0A=
<P>d-cache-line-size =3D &lt;20&gt;;</P>=0A=
<P>i-cache-size =3D &lt;8000&gt;;</P>=0A=
<P>d-cache-size =3D &lt;8000&gt;;</P>=0A=
<P>dcr-controller;</P>=0A=
<P>dcr-access-method =3D "native";</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>memory {</P>=0A=
<P>device_type =3D "memory";</P>=0A=
<P>reg =3D &lt;0 0 0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>};</P>=0A=
<P>UIC0: interrupt-controller0 {</P>=0A=
<P>compatible =3D "ibm,uic-460ex","ibm,uic";</P>=0A=
<P>interrupt-controller;</P>=0A=
<P>cell-index =3D &lt;0&gt;;</P>=0A=
<P>dcr-reg =3D &lt;0c0 009&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;2&gt;;</P>=0A=
<P>};</P>=0A=
<P>UIC1: interrupt-controller1 {</P>=0A=
<P>compatible =3D "ibm,uic-460ex","ibm,uic";</P>=0A=
<P>interrupt-controller;</P>=0A=
<P>cell-index =3D &lt;1&gt;;</P>=0A=
<P>dcr-reg =3D &lt;0d0 009&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;2&gt;;</P>=0A=
<P>interrupts =3D &lt;1e 4 1f 4&gt;; /* cascade */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>};</P>=0A=
<P>UIC2: interrupt-controller2 {</P>=0A=
<P>compatible =3D "ibm,uic-460ex","ibm,uic";</P>=0A=
<P>interrupt-controller;</P>=0A=
<P>cell-index =3D &lt;2&gt;;</P>=0A=
<P>dcr-reg =3D &lt;0e0 009&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;2&gt;;</P>=0A=
<P>interrupts =3D &lt;a 4 b 4&gt;; /* cascade */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>};</P>=0A=
<P>UIC3: interrupt-controller3 {</P>=0A=
<P>compatible =3D "ibm,uic-460ex","ibm,uic";</P>=0A=
<P>interrupt-controller;</P>=0A=
<P>cell-index =3D &lt;3&gt;;</P>=0A=
<P>dcr-reg =3D &lt;0f0 009&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;2&gt;;</P>=0A=
<P>interrupts =3D &lt;10 4 11 4&gt;; /* cascade */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>};</P>=0A=
<P>SDR0: sdr {</P>=0A=
<P>compatible =3D "ibm,sdr-460ex";</P>=0A=
<P>dcr-reg =3D &lt;00e 002&gt;;</P>=0A=
<P>};</P>=0A=
<P>CPR0: cpr {</P>=0A=
<P>compatible =3D "ibm,cpr-460ex";</P>=0A=
<P>dcr-reg =3D &lt;00c 002&gt;;</P>=0A=
<P>};</P>=0A=
<P>L2C0: l2c {</P>=0A=
<P>compatible =3D "ibm,l2-cache-460ex", "ibm,l2-cache";</P>=0A=
<P>dcr-reg =3D &lt;20 8 /* Internal SRAM DCR's */</P>=0A=
<P>30 8&gt;; /* L2 cache DCR's */</P>=0A=
<P>cache-line-size =3D &lt;20&gt;; /* 32 bytes */</P>=0A=
<P>cache-size =3D &lt;40000&gt;; /* L2, 256K */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC2&gt;;</P>=0A=
<P>interrupts =3D &lt;17 1&gt;;</P>=0A=
<P>};</P>=0A=
<P>plb {</P>=0A=
<P>compatible =3D "ibm,plb-460ex", "ibm,plb4";</P>=0A=
<P>#address-cells =3D &lt;2&gt;;</P>=0A=
<P>#size-cells =3D &lt;1&gt;;</P>=0A=
<P>ranges;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>SDRAM0: sdram {</P>=0A=
<P>compatible =3D "ibm,sdram-460ex", "ibm,sdram-405gp";</P>=0A=
<P>dcr-reg =3D &lt;010 2&gt;;</P>=0A=
<P>};</P>=0A=
<P>MAL0: mcmal {</P>=0A=
<P>compatible =3D "ibm,mcmal-460ex", "ibm,mcmal2";</P>=0A=
<P>dcr-reg =3D &lt;180 62&gt;;</P>=0A=
<P>num-tx-chans =3D &lt;2&gt;;</P>=0A=
<P>num-rx-chans =3D &lt;10&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC2&gt;;</P>=0A=
<P>interrupts =3D &lt; /*TXEOB*/ 6 4</P>=0A=
<P>/*RXEOB*/ 7 4</P>=0A=
<P>/*SERR*/ 3 4</P>=0A=
<P>/*TXDE*/ 4 4</P>=0A=
<P>/*RXDE*/ 5 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>USB0: ehci@bffd0400 {</P>=0A=
<P>compatible =3D "ibm,usb-ehci-460ex", "usb-ehci";</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC2&gt;;</P>=0A=
<P>interrupts =3D &lt;1d 4&gt;;</P>=0A=
<P>reg =3D &lt;4 bffd0400 90 4 bffd0490 70&gt;;</P>=0A=
<P>};</P>=0A=
<P>USB1: usb@bffd0000 {</P>=0A=
<P>compatible =3D "ohci-le";</P>=0A=
<P>reg =3D &lt;4 bffd0000 60&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC2&gt;;</P>=0A=
<P>interrupts =3D &lt;1e 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>USBOTG0: usbotg@bff80000 {</P>=0A=
<P>compatible =3D "amcc,usb-otg-460ex";</P>=0A=
<P>reg =3D &lt;4 bff80000 10000&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;USBOTG0&gt;;</P>=0A=
<P>interrupts =3D &lt;0 1 2&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>interrupt-map =3D &lt;/* USB-OTG */ 0 &amp;UIC2 1c 4</P>=0A=
<P>/* HIGH-POWER */ 1 &amp;UIC1 1a 8</P>=0A=
<P>/* DMA */ 2 &amp;UIC0 c 4&gt;;</P>=0A=
<P>interrupt-map-mask =3D &lt;ffffffff&gt;;</P>=0A=
<P>};</P>=0A=
<P>CRYPTO: crypto@180000 {</P>=0A=
<P>compatible =3D "amcc,ppc460ex-crypto", "amcc,ppc4xx-crypto";</P>=0A=
<P>reg =3D &lt;4 00180000 84000&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>interrupts =3D &lt;1d 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>TRNG: trng@110000 {</P>=0A=
<P>device_type =3D "trng";</P>=0A=
<P>compatible =3D "ppc4xx-trng", "amcc, ppc4xx-trng";</P>=0A=
<P>reg =3D &lt;4 00110000 100&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC1&gt;;</P>=0A=
<P>interrupts =3D &lt;3 2&gt;;</P>=0A=
<P>};</P>=0A=
<P></P>=0A=
<P>PKA: pka@114000 {</P>=0A=
<P>device_type =3D "pka";</P>=0A=
<P>compatible =3D "ppc4xx-pka", "amcc, ppc4xx-pka";</P>=0A=
<P>reg =3D &lt;4 00114000 4000&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>interrupts =3D &lt;14 2&gt;;</P>=0A=
<P>};</P>=0A=
<P>POB0: opb {</P>=0A=
<P>compatible =3D "ibm,opb-460ex", "ibm,opb";</P>=0A=
<P>#address-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;1&gt;;</P>=0A=
<P>ranges =3D &lt;b0000000 4 b0000000 50000000&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>EBC0: ebc {</P>=0A=
<P>compatible =3D "ibm,ebc-460ex", "ibm,ebc";</P>=0A=
<P>dcr-reg =3D &lt;012 2&gt;;</P>=0A=
<P>#address-cells =3D &lt;2&gt;;</P>=0A=
<P>#size-cells =3D &lt;1&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>/* ranges property is supplied by U-Boot */</P>=0A=
<P>interrupts =3D &lt;6 4&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC1&gt;;</P>=0A=
<P>nor_flash@0,0 {</P>=0A=
<P>compatible =3D "amd,s29gl512n", "cfi-flash";</P>=0A=
<P>bank-width =3D &lt;2&gt;;</P>=0A=
<P>reg =3D &lt;0 000000 4000000&gt;;</P>=0A=
<P>#address-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;1&gt;;</P>=0A=
<P>partition@0 {</P>=0A=
<P>label =3D "kernel";</P>=0A=
<P>reg =3D &lt;0 1e0000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@1e0000 {</P>=0A=
<P>label =3D "dtb";</P>=0A=
<P>reg =3D &lt;1e0000 20000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@200000 {</P>=0A=
<P>label =3D "ramdisk";</P>=0A=
<P>reg =3D &lt;200000 1400000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@1600000 {</P>=0A=
<P>label =3D "jffs2";</P>=0A=
<P>reg =3D &lt;1600000 400000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@1a00000 {</P>=0A=
<P>label =3D "user";</P>=0A=
<P>reg =3D &lt;1a00000 2560000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@3f60000 {</P>=0A=
<P>label =3D "env";</P>=0A=
<P>reg =3D &lt;3f60000 40000&gt;;</P>=0A=
<P>};</P>=0A=
<P>partition@3fa0000 {</P>=0A=
<P>label =3D "u-boot";</P>=0A=
<P>reg =3D &lt;3fa0000 60000&gt;;</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>UART0: serial@ef600300 {</P>=0A=
<P>device_type =3D "serial";</P>=0A=
<P>compatible =3D "ns16550";</P>=0A=
<P>reg =3D &lt;ef600300 8&gt;;</P>=0A=
<P>virtual-reg =3D &lt;ef600300&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>current-speed =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC1&gt;;</P>=0A=
<P>interrupts =3D &lt;1 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>UART1: serial@ef600400 {</P>=0A=
<P>device_type =3D "serial";</P>=0A=
<P>compatible =3D "ns16550";</P>=0A=
<P>reg =3D &lt;ef600400 8&gt;;</P>=0A=
<P>virtual-reg =3D &lt;ef600400&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>current-speed =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>interrupts =3D &lt;1 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>UART2: serial@ef600500 {</P>=0A=
<P>device_type =3D "serial";</P>=0A=
<P>compatible =3D "ns16550";</P>=0A=
<P>reg =3D &lt;ef600500 8&gt;;</P>=0A=
<P>virtual-reg =3D &lt;ef600500&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>current-speed =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC1&gt;;</P>=0A=
<P>interrupts =3D &lt;1d 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>UART3: serial@ef600600 {</P>=0A=
<P>device_type =3D "serial";</P>=0A=
<P>compatible =3D "ns16550";</P>=0A=
<P>reg =3D &lt;ef600600 8&gt;;</P>=0A=
<P>virtual-reg =3D &lt;ef600600&gt;;</P>=0A=
<P>clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>current-speed =3D &lt;0&gt;; /* Filled in by U-Boot */</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC1&gt;;</P>=0A=
<P>interrupts =3D &lt;1e 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>&nbsp;</P>=0A=
<P>IIC0: i2c@ef600700 {</P>=0A=
<P>compatible =3D "ibm,iic-460ex", "ibm,iic";</P>=0A=
<P>reg =3D &lt;ef600700 14&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>interrupts =3D &lt;2 4&gt;;</P>=0A=
<P>#address-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>rtc@68 {</P>=0A=
<P>compatible =3D "stm,m41t80";</P>=0A=
<P>reg =3D &lt;68&gt;;</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>&nbsp;</P>=0A=
<P>&nbsp;</P>=0A=
<P>IIC1: i2c@ef600800 {</P>=0A=
<P>compatible =3D "ibm,iic-460ex", "ibm,iic";</P>=0A=
<P>reg =3D &lt;ef600800 14&gt;;</P>=0A=
<P>interrupt-parent =3D &lt;&amp;UIC0&gt;;</P>=0A=
<P>interrupts =3D &lt;3 4&gt;;</P>=0A=
<P>};</P>=0A=
<P>ZMII0: emac-zmii@ef600d00 {</P>=0A=
<P>compatible =3D "ibm,zmii-460ex", "ibm,zmii";</P>=0A=
<P>reg =3D &lt;ef600d00 c&gt;;</P>=0A=
<P>};</P>=0A=
<P>RGMII0: emac-rgmii@ef601500 {</P>=0A=
<P>compatible =3D "ibm,rgmii-460ex", "ibm,rgmii";</P>=0A=
<P>reg =3D &lt;ef601500 8&gt;;</P>=0A=
<P>has-mdio;</P>=0A=
<P>};</P>=0A=
<P>TAH0: emac-tah@ef601350 {</P>=0A=
<P>compatible =3D "ibm,tah-460ex", "ibm,tah";</P>=0A=
<P>reg =3D &lt;ef601350 30&gt;;</P>=0A=
<P>};</P>=0A=
<P>TAH1: emac-tah@ef601450 {</P>=0A=
<P>compatible =3D "ibm,tah-460ex", "ibm,tah";</P>=0A=
<P>reg =3D &lt;ef601450 30&gt;;</P>=0A=
<P>};</P>=0A=
<P>EMAC0: ethernet@ef600e00 {</P>=0A=
<P>device_type =3D "network";</P>=0A=
<P>compatible =3D "ibm,emac-460ex", "ibm,emac4";</P>=0A=
<P>interrupt-parent =3D &lt;&amp;EMAC0&gt;;</P>=0A=
<P>interrupts =3D &lt;0 1&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>interrupt-map =3D &lt;/*Status*/ 0 &amp;UIC2 10 4</P>=0A=
<P>/*Wake*/ 1 &amp;UIC2 14 4&gt;;</P>=0A=
<P>reg =3D &lt;ef600e00 70&gt;;</P>=0A=
<P>local-mac-address =3D [000000000000]; /* Filled in by U-Boot */</P>=0A=
<P>mal-device =3D &lt;&amp;MAL0&gt;;</P>=0A=
<P>mal-tx-channel =3D &lt;0&gt;;</P>=0A=
<P>mal-rx-channel =3D &lt;0&gt;;</P>=0A=
<P>cell-index =3D &lt;0&gt;;</P>=0A=
<P>max-frame-size =3D &lt;2328&gt;;</P>=0A=
<P>rx-fifo-size =3D &lt;1000&gt;;</P>=0A=
<P>tx-fifo-size =3D &lt;800&gt;;</P>=0A=
<P>phy-mode =3D "rgmii";</P>=0A=
<P>phy-map =3D &lt;00000000&gt;;</P>=0A=
<P>rgmii-device =3D &lt;&amp;RGMII0&gt;;</P>=0A=
<P>rgmii-channel =3D &lt;0&gt;;</P>=0A=
<P>tah-device =3D &lt;&amp;TAH0&gt;;</P>=0A=
<P>tah-channel =3D &lt;0&gt;;</P>=0A=
<P>has-inverted-stacr-oc;</P>=0A=
<P>has-new-stacr-staopc;</P>=0A=
<P>};</P>=0A=
<P>EMAC1: ethernet@ef600f00 {</P>=0A=
<P>device_type =3D "network";</P>=0A=
<P>compatible =3D "ibm,emac-460ex", "ibm,emac4";</P>=0A=
<P>interrupt-parent =3D &lt;&amp;EMAC1&gt;;</P>=0A=
<P>interrupts =3D &lt;0 1&gt;;</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#address-cells =3D &lt;0&gt;;</P>=0A=
<P>#size-cells =3D &lt;0&gt;;</P>=0A=
<P>interrupt-map =3D &lt;/*Status*/ 0 &amp;UIC2 11 4</P>=0A=
<P>/*Wake*/ 1 &amp;UIC2 15 4&gt;;</P>=0A=
<P>reg =3D &lt;ef600f00 70&gt;;</P>=0A=
<P>local-mac-address =3D [000000000000]; /* Filled in by U-Boot */</P>=0A=
<P>mal-device =3D &lt;&amp;MAL0&gt;;</P>=0A=
<P>mal-tx-channel =3D &lt;1&gt;;</P>=0A=
<P>mal-rx-channel =3D &lt;8&gt;;</P>=0A=
<P>cell-index =3D &lt;1&gt;;</P>=0A=
<P>max-frame-size =3D &lt;2328&gt;;</P>=0A=
<P>rx-fifo-size =3D &lt;1000&gt;;</P>=0A=
<P>tx-fifo-size =3D &lt;800&gt;;</P>=0A=
<P>phy-mode =3D "rgmii";</P>=0A=
<P>phy-map =3D &lt;00000000&gt;;</P>=0A=
<P>rgmii-device =3D &lt;&amp;RGMII0&gt;;</P>=0A=
<P>rgmii-channel =3D &lt;1&gt;;</P>=0A=
<P>tah-device =3D &lt;&amp;TAH1&gt;;</P>=0A=
<P>tah-channel =3D &lt;1&gt;;</P>=0A=
<P>has-inverted-stacr-oc;</P>=0A=
<P>has-new-stacr-staopc;</P>=0A=
<P>mdio-device =3D &lt;&amp;EMAC0&gt;;</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>PCIX0: pci@c0ec00000 {</P>=0A=
<P>device_type =3D "pci";</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;2&gt;;</P>=0A=
<P>#address-cells =3D &lt;3&gt;;</P>=0A=
<P>compatible =3D "ibm,plb-pcix-460ex", "ibm,plb-pcix";</P>=0A=
<P>primary;</P>=0A=
<P>large-inbound-windows;</P>=0A=
<P>enable-msi-hole;</P>=0A=
<P>reg =3D &lt;c 0ec00000 8 /* Config space access */</P>=0A=
<P>0 0 0 /* no IACK cycles */</P>=0A=
<P>c 0ed00000 4 /* Special cycles */</P>=0A=
<P>c 0ec80000 100 /* Internal registers */</P>=0A=
<P>c 0ec80100 fc&gt;; /* Internal messaging registers */</P>=0A=
<P>/* Outbound ranges, one memory and one IO,</P>=0A=
<P>* later cannot be changed</P>=0A=
<P>*/</P>=0A=
<P>ranges =3D &lt;02000000 0 80000000 0000000d 80000000 0 80000000</P>=0A=
<P>01000000 0 00000000 0000000c 08000000 0 00010000&gt;;</P>=0A=
<P>/* Inbound 2GB range starting at 0 */</P>=0A=
<P>dma-ranges =3D &lt;42000000 0 0 0 0 0 80000000&gt;;</P>=0A=
<P>/* This drives busses 0 to 0x3f */</P>=0A=
<P>bus-range =3D &lt;0 3f&gt;;</P>=0A=
<P>/* All PCI interrupts are routed to ext IRQ 2 -&gt; UIC1-0 */</P>=0A=
<P>interrupt-map-mask =3D &lt;0000 0 0 0&gt;;</P>=0A=
<P>interrupt-map =3D &lt; 0000 0 0 0 &amp;UIC1 0 8 &gt;;</P>=0A=
<P>};</P>=0A=
<P>PCIE0: pciex@d00000000 {</P>=0A=
<P>device_type =3D "pci";</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;2&gt;;</P>=0A=
<P>#address-cells =3D &lt;3&gt;;</P>=0A=
<P>compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";</P>=0A=
<P>primary;</P>=0A=
<P>port =3D &lt;0&gt;; /* port number */</P>=0A=
<P>reg =3D &lt;d 00000000 20000000 /* Config space access */</P>=0A=
<P>c 08010000 00001000&gt;; /* Registers */</P>=0A=
<P>dcr-reg =3D &lt;100 020&gt;;</P>=0A=
<P>sdr-base =3D &lt;300&gt;;</P>=0A=
<P>/* Outbound ranges, one memory and one IO,</P>=0A=
<P>* later cannot be changed</P>=0A=
<P>*/</P>=0A=
<P>ranges =3D &lt;02000000 0 80000000 0000000e 00000000 0 80000000</P>=0A=
<P>01000000 0 00000000 0000000f 80000000 0 00010000&gt;;</P>=0A=
<P>/* Inbound 2GB range starting at 0 */</P>=0A=
<P>dma-ranges =3D &lt;42000000 0 0 0 0 0 80000000&gt;;</P>=0A=
<P>/* This drives busses 40 to 0x7f */</P>=0A=
<P>bus-range =3D &lt;40 7f&gt;;</P>=0A=
<P>/* Legacy interrupts (note the weird polarity, the bridge seems</P>=0A=
<P>* to invert PCIe legacy interrupts).</P>=0A=
<P>* We are de-swizzling here because the numbers are actually for</P>=0A=
<P>* port of the root complex virtual P2P bridge. But I want</P>=0A=
<P>* to avoid putting a node for it in the tree, so the numbers</P>=0A=
<P>* below are basically de-swizzled numbers.</P>=0A=
<P>* The real slot is on idsel 0, so the swizzling is 1:1</P>=0A=
<P>*/</P>=0A=
<P>interrupt-map-mask =3D &lt;0000 0 0 7&gt;;</P>=0A=
<P>interrupt-map =3D &lt;</P>=0A=
<P>0000 0 0 1 &amp;UIC3 c 4 /* swizzled int A */</P>=0A=
<P>0000 0 0 2 &amp;UIC3 d 4 /* swizzled int B */</P>=0A=
<P>0000 0 0 3 &amp;UIC3 e 4 /* swizzled int C */</P>=0A=
<P>0000 0 0 4 &amp;UIC3 f 4 /* swizzled int D */&gt;;</P>=0A=
<P>};</P>=0A=
<P>PCIE1: pciex@d20000000 {</P>=0A=
<P>device_type =3D "pci";</P>=0A=
<P>#interrupt-cells =3D &lt;1&gt;;</P>=0A=
<P>#size-cells =3D &lt;2&gt;;</P>=0A=
<P>#address-cells =3D &lt;3&gt;;</P>=0A=
<P>compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";</P>=0A=
<P>primary;</P>=0A=
<P>port =3D &lt;1&gt;; /* port number */</P>=0A=
<P>reg =3D &lt;d 20000000 20000000 /* Config space access */</P>=0A=
<P>c 08011000 00001000&gt;; /* Registers */</P>=0A=
<P>dcr-reg =3D &lt;120 020&gt;;</P>=0A=
<P>sdr-base =3D &lt;340&gt;;</P>=0A=
<P>/* Outbound ranges, one memory and one IO,</P>=0A=
<P>* later cannot be changed</P>=0A=
<P>*/</P>=0A=
<P>ranges =3D &lt;02000000 0 80000000 0000000e 80000000 0 80000000</P>=0A=
<P>01000000 0 00000000 0000000f 80010000 0 00010000&gt;;</P>=0A=
<P>/* Inbound 2GB range starting at 0 */</P>=0A=
<P>dma-ranges =3D &lt;42000000 0 0 0 0 0 80000000&gt;;</P>=0A=
<P>/* This drives busses 80 to 0xbf */</P>=0A=
<P>bus-range =3D &lt;80 bf&gt;;</P>=0A=
<P>/* Legacy interrupts (note the weird polarity, the bridge seems</P>=0A=
<P>* to invert PCIe legacy interrupts).</P>=0A=
<P>* We are de-swizzling here because the numbers are actually for</P>=0A=
<P>* port of the root complex virtual P2P bridge. But I want</P>=0A=
<P>* to avoid putting a node for it in the tree, so the numbers</P>=0A=
<P>* below are basically de-swizzled numbers.</P>=0A=
<P>* The real slot is on idsel 0, so the swizzling is 1:1</P>=0A=
<P>*/</P>=0A=
<P>interrupt-map-mask =3D &lt;0000 0 0 7&gt;;</P>=0A=
<P>interrupt-map =3D &lt;</P>=0A=
<P>0000 0 0 1 &amp;UIC3 10 4 /* swizzled int A */</P>=0A=
<P>0000 0 0 2 &amp;UIC3 11 4 /* swizzled int B */</P>=0A=
<P>0000 0 0 3 &amp;UIC3 12 4 /* swizzled int C */</P>=0A=
<P>0000 0 0 4 &amp;UIC3 13 4 /* swizzled int D */&gt;;</P>=0A=
<P>};</P>=0A=
<P>};</P>=0A=
<P>};</P></FONT>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>-------------------- Kconfig ----------</DIV><FONT =
size=3D2>=0A=
<P dir=3Dltr>#</P>=0A=
<P dir=3Dltr># Hardware Random Number Generator (RNG) configuration</P>=0A=
<P dir=3Dltr>#</P>=0A=
<P dir=3Dltr>config HW_RANDOM</P>=0A=
<P dir=3Dltr>tristate "Hardware Random Number Generator Core support"</P>=0A=
<P dir=3Dltr>default m</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>Hardware Random Number Generator Core infrastructure.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called rng-core. This provides a device</P>=0A=
<P dir=3Dltr>that's usually called /dev/hw_random, and which exposes =
one</P>=0A=
<P dir=3Dltr>of possibly several hardware random number generators.</P>=0A=
<P dir=3Dltr>These hardware random number generators do not feed =
directly</P>=0A=
<P dir=3Dltr>into the kernel's random number generator. That is =
usually</P>=0A=
<P dir=3Dltr>handled by the "rngd" daemon. =
Documentation/hw_random.txt</P>=0A=
<P dir=3Dltr>has more information.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_INTEL</P>=0A=
<P dir=3Dltr>tristate "Intel HW Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; (X86 || IA64) &amp;&amp; =
PCI</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on Intel i8xx-based =
motherboards.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called intel-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_AMD</P>=0A=
<P dir=3Dltr>tristate "AMD HW Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; X86 &amp;&amp; PCI</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on AMD 76x-based motherboards.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called amd-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_GEODE</P>=0A=
<P dir=3Dltr>tristate "AMD Geode HW Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; X86_32 &amp;&amp; PCI</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on the AMD Geode LX.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called geode-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_VIA</P>=0A=
<P dir=3Dltr>tristate "VIA HW Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; X86_32</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on VIA based motherboards.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called via-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_IXP4XX</P>=0A=
<P dir=3Dltr>tristate "Intel IXP4xx NPU HW Random Number Generator =
support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; ARCH_IXP4XX</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random</P>=0A=
<P dir=3Dltr>Number Generator hardware found on the Intel IXP4xx NPU.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called ixp4xx-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_OMAP</P>=0A=
<P dir=3Dltr>tristate "OMAP Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; (ARCH_OMAP16XX || =
ARCH_OMAP24XX)</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on OMAP16xx and OMAP24xx =
multimedia</P>=0A=
<P dir=3Dltr>processors.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called omap-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_PASEMI</P>=0A=
<P dir=3Dltr>tristate "PA Semi HW Random Number Generator support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; PPC_PASEMI</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on PA Semi PWRficient SoCs.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called pasemi-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<P dir=3Dltr>config HW_RANDOM_TRNG4xx</P>=0A=
<P dir=3Dltr>tristate "AMCC 4xx TRNG True Random Number Generator =
support"</P>=0A=
<P dir=3Dltr>depends on HW_RANDOM &amp;&amp; PPC</P>=0A=
<P dir=3Dltr>default HW_RANDOM</P>=0A=
<P dir=3Dltr>---help---</P>=0A=
<P dir=3Dltr>This driver provides kernel-side support for the Random =
Number</P>=0A=
<P dir=3Dltr>Generator hardware found on PA Semi PWRficient SoCs.</P>=0A=
<P dir=3Dltr>To compile this driver as a module, choose M here: the</P>=0A=
<P dir=3Dltr>module will be called pasemi-rng.</P>=0A=
<P dir=3Dltr>If unsure, say Y.</P>=0A=
<DIV dir=3Dltr></FONT>----------------------------------------Makefile =
--------------------</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>=0A=
<P>#</P>=0A=
<P># Makefile for HW Random Number Generator (RNG) device drivers.</P>=0A=
<P>#</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM) +=3D rng-core.o</P>=0A=
<P>rng-core-y :=3D core.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_INTEL) +=3D intel-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_AMD) +=3D amd-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_GEODE) +=3D geode-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_VIA) +=3D via-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_IXP4XX) +=3D ixp4xx-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_OMAP) +=3D omap-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_PASEMI) +=3D pasemi-rng.o</P>=0A=
<P>obj-$(CONFIG_HW_RANDOM_TRNG4xx) +=3D trng4xx.o</P></FONT><BR></DIV>=0A=
<DIV dir=3Dltr>=0A=
<HR tabIndex=3D-1>=0A=
</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2><B>From:</B> =
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of Tirumala =
Reddy Marri<BR><B>Sent:</B> Wed 4/1/2009 10:05 AM<BR><B>To:</B> Felix =
Radensky; linuxppc-dev@ozlabs.org<BR><B>Subject:</B> RE: /dev/random on =
PPC40EXr<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>There is PKA/TRNG driver for sure. Let me check if it =
was accepted in<BR>opensource yet. Otherwise I will forward you the =
driver which may not be<BR>there in opensource =
yet.<BR><BR><BR>-----Original Message-----<BR>From: =
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org<BR>[<A =
href=3D"mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org">mailto:=
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org</A>] On Behalf =
Of<BR>Felix Radensky<BR>Sent: Wednesday, April 01, 2009 5:00 AM<BR>To: =
linuxppc-dev@ozlabs.org<BR>Subject: /dev/random on =
PPC40EXr<BR><BR><BR>Hi,<BR><BR>On my custom board based on 405EXr =
/dev/random produces no output<BR>at all, and /dev/urandom is not random =
enough for our purposes. Saving<BR>entropy pool between reboots doesn't =
help much.<BR><BR>What can be done to increase the entropy of the system =
?<BR>I was thinking of adding IRQF_SAMPLE_RANDOM to network =
driver,<BR>but since not too many drivers implement it, I don't know =
whether<BR>it's a good idea or not.<BR><BR>Is there any work in progress =
to develop hw_random driver for 4xx<BR>TRNG ?<BR><BR>Thanks a =
lot.<BR><BR>Felix.<BR>--<BR>View this message in context:<BR><A =
href=3D"http://www.nabble.com/-dev-random-on-PPC40EXr-tp22824979p22824979=
.html">http://www.nabble.com/-dev-random-on-PPC40EXr-tp22824979p22824979.=
html</A><BR>Sent from the linuxppc-dev mailing list archive at =
Nabble.com.<BR><BR>_______________________________________________<BR>Lin=
uxppc-dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR>________________________________=
_______________<BR>Linuxppc-dev mailing =
list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_002_01C9B358.CF7555FA--

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: text/plain;
	name="trng4xx.c"
Content-Transfer-Encoding: base64
Content-Description: trng4xx.c
Content-Disposition: attachment;
	filename="trng4xx.c"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNCiAqDQogKiBDb3B5cmlnaHQgKGMpIDIwMDggTG9jIEhv
IDxsaG9AYW1jYy5jb20+DQogKg0KICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCiAqIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQogKiB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcg0KICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCiAqDQogKiBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwNCiAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mDQogKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQogKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLg0KICoNCiAqDQogKiBEZXRhaWwgRGVzY3JpcHRpb246DQogKiBUaGlz
IGZpbGUgZGVmaW5lcyBpb2N0bCBzdHJ1Y3R1cmVzIGZvciB0aGUgTGludXggQ3J5cHRvQVBJIGlu
dGVyZmFjZS4gSXQNCiAqIHByb3ZpZGVzIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIGFjY2Vzc3Mg
aW50byB0aGUgTGludXggQ3J5cHRvQVBJDQogKiBmdW5jdGlvbmFsaXRpZXMuDQogKg0KICogQGZp
bGUgdHJuZzR4eC5jDQogKg0KICogVGhpcyBmaWxlIHByb3ZpZGVzIGFjY2VzcyB0byB0aGUgQU1D
QyBQUEM0WFggVFJORyBmb3IgTGludXguDQogKg0KICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCiAq
Lw0KI2luY2x1ZGUgPGxpbnV4L3ZlcnNpb24uaD4NCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
CiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCiNpbmNsdWRlIDxsaW51eC9od19yYW5kb20uaD4NCiNpbmNsdWRlIDxsaW51eC9pbnRl
cnJ1cHQuaD4NCiNpbmNsdWRlIDxhc20vb2ZfcGxhdGZvcm0uaD4NCiNpbmNsdWRlIDxhc20vaW8u
aD4NCg0KI2luY2x1ZGUgInRybmc0eHguaCINCg0KI2RlZmluZSBUUk5HNFhYX1ZFUl9TVFIJIjAu
MSINCiNkZWZpbmUgUEZYCQkJS0JVSUxEX01PRE5BTUUgIjogIg0KDQpzdHJ1Y3QgdHJuZzR4eF9k
ZXYgew0KCXN0cnVjdCByZXNvdXJjZSAJcmVzOw0KCXUzMgkJCWlycTsNCgl2b2xhdGlsZSBjaGFy
IF9faW9tZW0gICAqY3NyOw0KCXN0cnVjdCBzZW1hcGhvcmUgICAgICAgIGFjY2Vzc19wcm90Ow0K
CXUzMglkYXR1bTsNCn07DQoNCnN0cnVjdCBoYWxfY29uZmlnIHsNCglzdHJ1Y3Qgb2ZfZGV2aWNl
IAkqb2ZkZXY7DQp9Ow0KDQpzdGF0aWMgc3RydWN0IHRybmc0eHhfZGV2CXRybmc0eHhfZGV2Ow0K
DQpzdGF0aWMgaW50ICAJdHJuZzR4eF9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICogaWQpOw0K
c3RhdGljIHZvaWQJdHJuZzR4eF9jaGtfb3ZlcmZsb3codm9pZCk7DQoNCmludCAgICB0cm5nNHh4
X2NvbmZpZ19zZXQoc3RydWN0IGhhbF9jb25maWcgKmNmZykNCnsNCglzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnJuZ19ucCA9IGNmZy0+b2ZkZXYtPm5vZGU7DQoJaW50IHJjID0gMDsNCg0KCXJjID0gb2Zf
YWRkcmVzc190b19yZXNvdXJjZShybmdfbnAsIDAsICZ0cm5nNHh4X2Rldi5yZXMpOw0KCWlmIChy
YykNCgkJcmV0dXJuIC1FTk9ERVY7DQoNCgl0cm5nNHh4X2Rldi5jc3IgICAgPSBpb3JlbWFwKHRy
bmc0eHhfZGV2LnJlcy5zdGFydCwNCgkJCQkgIHRybmc0eHhfZGV2LnJlcy5lbmQgLSB0cm5nNHh4
X2Rldi5yZXMuc3RhcnQgKyAxKTsNCglpZiAodHJuZzR4eF9kZXYuY3NyID09IE5VTEwpIHsNCgkJ
cHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRvIGlvcmVtYXAgMHglMDJYXyUwOFggc2l6ZSAl
ZFxuIiwNCgkJCSh1MzIpICh0cm5nNHh4X2Rldi5yZXMuc3RhcnQgPj4gMzIpLA0KCQkJKHUzMikg
dHJuZzR4eF9kZXYucmVzLnN0YXJ0LA0KCQkJKHUzMikgKHRybmc0eHhfZGV2LnJlcy5lbmQgLSB0
cm5nNHh4X2Rldi5yZXMuc3RhcnQgKyAxKSk7DQoJCXJldHVybiAtRU5PTUVNOw0KCX0NCiNpZiAw
DQoJcHJpbnRrKCJUUk5HMSAweCUwMlhfJTA4WCBzaXplICVkXG4iLA0KCQkJKHUzMikgKHRybmc0
eHhfZGV2LnJlcy5zdGFydCA+PiAzMiksDQoJCQkodTMyKSB0cm5nNHh4X2Rldi5yZXMuc3RhcnQs
DQoJCQkodTMyKSAodHJuZzR4eF9kZXYucmVzLmVuZCAtIHRybmc0eHhfZGV2LnJlcy5zdGFydCAr
IDEpKTsNCiNlbmRpZg0KDQoJdHJuZzR4eF9kZXYuaXJxID0gb2ZfaXJxX3RvX3Jlc291cmNlKHJu
Z19ucCwgMCwgTlVMTCk7IA0KCXByaW50ayAoIlRSTkcgSVJRID0gJWRcbiIsdHJuZzR4eF9kZXYu
aXJxKTsgDQogICAgICAgIGlmICh0cm5nNHh4X2Rldi5pcnEgPT0gTk9fSVJRKSB7DQoJCS8qIFVu
LW1hcCBDU1IgKi8NCgkJaW91bm1hcCh0cm5nNHh4X2Rldi5jc3IpOw0KCQl0cm5nNHh4X2Rldi5j
c3IgPSBOVUxMOw0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICAgICB9DQoN
CglyZXR1cm4gMDsNCn0NCg0KaW50ICAgIHRybmc0eHhfcGthX2NvbmZpZ19jbGVhcih2b2lkKQ0K
ew0KCWlvdW5tYXAodHJuZzR4eF9kZXYuY3NyKTsNCglyZXR1cm4gMDsNCn0NCg0KaW5saW5lIGlu
dCAgICB0cm5nNHh4X2h3X3JlYWQzMih1MzIgcmVnX2FkZHIsIHUzMiAqZGF0YV92YWwpDQp7DQoJ
KmRhdGFfdmFsID0gaW5fYmUzMigodm9sYXRpbGUgdW5zaWduZWQgX19pb21lbSAqKQ0KCQkJCSh0
cm5nNHh4X2Rldi5jc3IgKyByZWdfYWRkcikpOw0KCXJldHVybiAwOw0KfQ0KDQppbmxpbmUgaW50
ICAgIHRybmc0eHhfaHdfd3JpdGUzMih1MzIgcmVnX2FkZHIsIHUzMiBkYXRhX3ZhbCkNCnsNCglv
dXRfYmUzMigodm9sYXRpbGUgdW5zaWduZWQgX19pb21lbSAqKSAodHJuZzR4eF9kZXYuY3NyICsg
cmVnX2FkZHIpLA0KCQkgZGF0YV92YWwpOw0KICAgICAgICByZXR1cm4gMDsNCn0NCg0KaW50IAl0
cm5nNHh4X2h3X2luaXQodm9pZCkNCnsNCglpbnQgcmM7DQoNCglyYyA9IHJlcXVlc3RfaXJxKHRy
bmc0eHhfZGV2LmlycSwgdHJuZzR4eF9pcnFfaGFuZGxlciwNCgkJCSAwLCAiVFJORyIsIE5VTEwp
Ow0KCWlmIChyYyAhPSAwKSB7DQoJCXByaW50ayhLRVJOX0VSUiBQRlggImZhaWxlZCB0byByZWdp
c3RlciBpbnRlcnJ1cHQgSVJRICVkXG4iLA0KCQkJdHJuZzR4eF9kZXYuaXJxKTsNCgkJcmV0dXJu
IHJjOw0KCX0NCglyZXR1cm4gMDsNCn0NCg0KaW50IAl0cm5nNHh4X2h3X2RlaW5pdCh2b2lkKQ0K
ew0KCWZyZWVfaXJxKHRybmc0eHhfZGV2LmlycSwgTlVMTCk7DQoJcmV0dXJuIDA7DQp9DQoNCnN0
YXRpYyBpbnQgCXRybmc0eHhfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqIGlkKQ0Kew0KCS8q
IFRSTkcgQWxhcm0gQ291bnRlciBvdmVyZmxvdyAqLw0KCXRybmc0eHhfY2hrX292ZXJmbG93KCk7
DQoJcmV0dXJuIDA7DQp9DQoNCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQogKiBUUk5HIEZ1bmN0
aW9ucw0KICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCiAqLw0Kc3RhdGljIHZvaWQgdHJuZzR4eF9j
aGtfb3ZlcmZsb3codm9pZCkNCnsNCgkvKiBUUk5HIEFsYXJtIENvdW50ZXIgb3ZlcmZsb3cgKi8N
CglpbnQgICAgIHJjOw0KCXUzMiAgICB2YWw7DQoJc3RydWN0IHRybmc0eHhfY2ZnIHsNCgkJdTMy
ICAgIHJpbmcxX2RlbGF5X3NlbCA6IDM7DQoJCXUzMiAgICByaW5nMl9kZWxheV9zZWwgOiAzOw0K
CQl1MzIgICAgcmVzZXRfY250ICAgICAgIDogNjsNCgl9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkp
Ow0KDQoNCglyYyA9IHRybmc0eHhfaHdfd3JpdGUzMihUUk5HNFhYX0FMQVJNQ05UX0FERFIsIHZh
bCk7DQoJaWYgKHJjICE9IDApDQoJCXJldHVybjsNCg0KCWlmICh2YWwgPiAxMjgpIHsNCgkJc3Ry
dWN0IHRybmc0eHhfY2ZnICp0cm5nNHh4X2NmZzsNCg0KCQkvKiBBbGFybSBjb3VudCBpcyBoYWxm
LCByZXNldCBpdCAqLw0KCQlyYyA9IHRybmc0eHhfaHdfcmVhZDMyKFRSTkc0WFhfQ0ZHX0FERFIs
ICZ2YWwpOw0KCQlpZiAocmMgIT0gMCkNCgkJCXJldHVybjsNCgkJdHJuZzR4eF9jZmcgPSAoc3Ry
dWN0IHRybmc0eHhfY2ZnICopICZ2YWw7DQoJCSsrdHJuZzR4eF9jZmctPnJpbmcxX2RlbGF5X3Nl
bDsNCgkJdHJuZzR4eF9jZmctPnJpbmcyX2RlbGF5X3NlbCA9ICh+dHJuZzR4eF9jZmctPnJpbmcx
X2RlbGF5X3NlbCkgJiAweDA3Ow0KDQoJCXJjID0gdHJuZzR4eF9od193cml0ZTMyKFRSTkc0WFhf
Q0ZHX0FERFIsIHZhbCk7DQoJCWlmIChyYyAhPSAwKQ0KCQkJcmV0dXJuOw0KCQl0cm5nNHh4X2h3
X3dyaXRlMzIoVFJORzRYWF9BTEFSTUNOVF9BRERSLCAweDAwMDAwMDAwKTsNCgkJaWYgKHJjICE9
IDApDQoJCQlyZXR1cm47DQoJfQ0KfQ0KDQppbnQJdHJuZzR4eF9yYW5kb20odTMyICpyYW5kX3Zh
bCkNCnsNCgl1MzIgICAgCXZhbCA9IDA7DQoJaW50CXJjOw0KCSNkZWZpbmUgICAgIE1BWF9UUlkg
ICAgIDMNCgl1MTYgICAgIHRyeV9jbnQgPSAwOw0KDQoJZG93bigmdHJuZzR4eF9kZXYuYWNjZXNz
X3Byb3QpOw0KCWRvIHsNCgkJcmMgPSB0cm5nNHh4X2h3X3JlYWQzMihUUk5HNFhYX1NUQVRVU19B
RERSLCAmdmFsKTsNCgkJaWYgKHJjICE9IDApDQoJCQlnb3RvIGVycjsNCgl9IHdoaWxlKCh2YWwg
JiBUUk5HNFhYX1NUQVRVU19CVVNZKSAmJiArK3RyeV9jbnQgPD0gTUFYX1RSWSk7DQoJaWYgKHZh
bCAmIFRSTkc0WFhfU1RBVFVTX0JVU1kpIHsNCgkJcmMgPSAtRUlOUFJPR1JFU1M7DQoJCWdvdG8g
ZXJyOw0KCX0NCgkNCglyYyA9IHRybmc0eHhfaHdfcmVhZDMyKFRSTkc0WFhfT1VUUFVUX0FERFIs
IHJhbmRfdmFsKTsNCg0KDQplcnI6DQoJLy9wcmludGsoInN0YXR1cyBidXN5XG4iKTsNCgl1cCgm
dHJuZzR4eF9kZXYuYWNjZXNzX3Byb3QpOw0KCXJldHVybiByYzsNCn0NCkVYUE9SVF9TWU1CT0xf
R1BMKHRybmc0eHhfcmFuZG9tKTsNCg0KI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9W
RVJTSU9OKDIsNiwyNSkNCnN0YXRpYyBpbnQgdHJuZzR4eF9kYXRhX3ByZXNlbnQoc3RydWN0IGh3
cm5nICpybmcpDQojZWxzZQ0Kc3RhdGljIGludCB0cm5nNHh4X2RhdGFfcHJlc2VudChzdHJ1Y3Qg
aHdybmcgKnJuZywgaW50IHdhaXQpDQojZW5kaWYNCnsNCglzdHJ1Y3QgdHJuZzR4eF9kZXYgKmRl
diA9IChzdHJ1Y3QgdHJuZzR4eF9kZXYgKikgcm5nLT5wcml2Ow0KCWludCAgICAgaTsNCgl1MzIg
CXZhbDsNCglwcmludGsoImluc2lkZSAlczpcbiIsIF9fRlVOQ1RJT05fXyk7DQoNCglkb3duKCZ0
cm5nNHh4X2Rldi5hY2Nlc3NfcHJvdCk7DQoJLyogV2Ugc2hvdWxkIG5vdCB0YWtlIG1vcmUgdGhh
biAyMDA/Pz8gdXMgKi8NCglmb3IgKGkgPSAwOyBpIDwgMjA7IGkrKykgew0KCQl0cm5nNHh4X2h3
X3JlYWQzMihUUk5HNFhYX1NUQVRVU19BRERSLCAmdmFsKTsNCgkJaWYgKCEodmFsICYgVFJORzRY
WF9TVEFUVVNfQlVTWSkpIHsNCgkJCXRybmc0eHhfaHdfcmVhZDMyKFRSTkc0WFhfT1VUUFVUX0FE
RFIsICZkZXYtPmRhdHVtKTsNCgkJCWJyZWFrOw0KCQl9DQojaWYgTElOVVhfVkVSU0lPTl9DT0RF
IDwgS0VSTkVMX1ZFUlNJT04oMiw2LDI1KQ0KCQlicmVhazsNCiNlbHNlDQoJCWlmICghd2FpdCkN
CgkJCWJyZWFrOw0KICAgICAgICAgICAgICAgIHVkZWxheSgxMCk7DQojZW5kaWYNCgl9DQoJdXAo
JnRybmc0eHhfZGV2LmFjY2Vzc19wcm90KTsNCglyZXR1cm4gKHZhbCAmIFRSTkc0WFhfU1RBVFVT
X0JVU1kpID8gMCA6IDE7DQp9DQoNCnN0YXRpYyBpbnQgdHJuZzR4eF9kYXRhX3JlYWQoc3RydWN0
IGh3cm5nICpybmcsIHUzMiAqZGF0YSkNCnsNCglzdHJ1Y3QgdHJuZzR4eF9kZXYgKmRldiA9IChz
dHJ1Y3QgdHJuZzR4eF9kZXYgKikgcm5nLT5wcml2Ow0KDQoJKmRhdGEgPSBkZXYtPmRhdHVtOw0K
ICAgICAgICBwcmludGsoImRhdGEgcmVhZCA9ICV1XG4iLCAqZGF0YSk7IA0KCXJldHVybiAwOw0K
fQ0KDQpzdGF0aWMgaW50IHRybmc0eHhfaW5pdChzdHJ1Y3QgaHdybmcgKnJuZykNCnsNCiAgcmV0
dXJuIHRybmc0eHhfaHdfaW5pdCgpOw0KfQ0KDQpzdGF0aWMgdm9pZCB0cm5nNHh4X2NsZWFudXAo
c3RydWN0IGh3cm5nICpybmcpDQp7DQogIA0KICAgICB0cm5nNHh4X2h3X2RlaW5pdCgpOw0KfQ0K
DQpzdGF0aWMgc3RydWN0IGh3cm5nIHRybmc0eHhfZnVuYyA9IHsNCgkubmFtZQkJPSAicHBjNHh4
LXRybmciLA0KCS5pbml0CQk9IHRybmc0eHhfaW5pdCwNCgkuY2xlYW51cAk9IHRybmc0eHhfY2xl
YW51cCwNCgkuZGF0YV9wcmVzZW50CT0gdHJuZzR4eF9kYXRhX3ByZXNlbnQsDQoJLmRhdGFfcmVh
ZAk9IHRybmc0eHhfZGF0YV9yZWFkLA0KCS5wcml2CQk9ICh1bnNpZ25lZCBsb25nKSAmdHJuZzR4
eF9kZXYsDQp9Ow0KDQovKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KICoNCiAqIFNldHVwIERyaXZl
ciB3aXRoIHBsYXRmb3JtIHJlZ2lzdHJhdGlvbg0KICoNCiAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
DQogKi8NCnN0YXRpYyBpbnQgX19kZXZpbml0IHRybmc0eHhfcHJvYmUoc3RydWN0IG9mX2Rldmlj
ZSAqb2ZkZXYsDQoJCQkJICAgICBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaCkNCnsN
CglzdHJ1Y3QgaGFsX2NvbmZpZyBod19jZmc7DQoJaW50IAlyYzsNCgl1MzIgICAgIHZhbHVlLCB2
YWx1ZTI7DQoJdTMyICAgICBjdHJsX3ZhbCwgY29udHJvbF92YWx1ZTsNCg0KCWh3X2NmZy5vZmRl
diA9IG9mZGV2Ow0KCXJjID0gdHJuZzR4eF9jb25maWdfc2V0KCZod19jZmcpOw0KCWlmIChyYyAh
PSAwKQ0KCQlyZXR1cm4gcmM7DQojaWYgMQ0KCXByaW50ayggIkFNQ0MgNHh4IFRSTkcgdiVzIEAw
eCUwMlhfJTA4WCBzaXplICVkIElSUSAlZFxuIiwNCgkJVFJORzRYWF9WRVJfU1RSLA0KCQkodTMy
KSAodHJuZzR4eF9kZXYucmVzLnN0YXJ0ID4+IDMyKSwNCgkJKHUzMikgdHJuZzR4eF9kZXYucmVz
LnN0YXJ0LA0KCQkodTMyKSAodHJuZzR4eF9kZXYucmVzLmVuZCAtIHRybmc0eHhfZGV2LnJlcy5z
dGFydCArIDEpLA0KCQl0cm5nNHh4X2Rldi5pcnEpOw0KI2VuZGlmDQoJaW5pdF9NVVRFWCgmdHJu
ZzR4eF9kZXYuYWNjZXNzX3Byb3QpOw0KDQoJcmMgPSBod3JuZ19yZWdpc3RlcigmdHJuZzR4eF9m
dW5jKTsNCglpZiAocmMpIHsNCgkJcHJpbnRrKEtFUk5fRVJSIFBGWA0KCQkJIkFNQ0MgNHh4IFRS
TkcgcmVnaXN0ZXJpbmcgZmFpbGVkIGVycm9yICVkXG4iLCByYyk7DQoJCWdvdG8gZXJyOw0KCX0N
CgkNCgl0cm5nNHh4X2h3X3JlYWQzMihUUk5HNFhYX0NOVExfQUREUiwgJmN0cmxfdmFsKTsNCgkv
L3ByaW50ayAoImNudGwgdmFsdWUgPSAweCV4XG4iLCBjdHJsX3ZhbCk7DQoNCgl2YWx1ZSA9IGN0
cmxfdmFsIHwgVFJORzRYWF9DTlRMX1RTVF9BTEFSTTsNCgkvL3ByaW50ayAoInZhbHVlIHRvIHdy
aXRlID0gMHgleFxuIiwgdmFsdWUpOw0KDQoJLypyYyA9IHRybmc0eHhfaHdfd3JpdGUzMihUUk5H
NFhYX0NOVExfQUREUiwgdmFsdWUpOw0KCWlmIChyYyAhPSAwKQ0KCSAgcHJpbnRrICgiRVJST1I6
IHdyaXRpbmdcbiIpOw0KDQoNCgl0cm5nNHh4X2h3X3JlYWQzMihUUk5HNFhYX0NOVExfQUREUiwg
JmNvbnRyb2xfdmFsdWUpOw0KCXByaW50ayAoImNvbnRyb2wgdmFsdWUgPSAweCV4XG4iLCBjb250
cm9sX3ZhbHVlKTsqLw0KCQ0KCS8qdmFsdWUgPSAwOw0KCXByaW50ayAoImNoZWNraW5nIHJhbmRv
bSB2YWx1ZSByZWdpc3RlclxuIik7DQoJcmMgPSB0cm5nNHh4X3JhbmRvbSAoJnZhbHVlKTsNCgkN
CgkNCglwcmludGsgKCJjaGVja2luZyByYW5kb20gdmFsdWUgcmVnaXN0ZXJcbiIpOw0KCXJjID0g
dHJuZzR4eF9yYW5kb20gKCZ2YWx1ZTIpOyovDQoJcmV0dXJuIHJjOw0KDQplcnI6DQoJdHJuZzR4
eF9wa2FfY29uZmlnX2NsZWFyKCk7DQoJcmV0dXJuIHJjOw0KfQ0KDQpzdGF0aWMgaW50IF9fZGV2
ZXhpdCB0cm5nNHh4X3JlbW92ZShzdHJ1Y3Qgb2ZfZGV2aWNlICpkZXYpDQp7DQoJaHdybmdfdW5y
ZWdpc3RlcigmdHJuZzR4eF9mdW5jKTsNCgl0cm5nNHh4X3BrYV9jb25maWdfY2xlYXIoKTsNCgly
ZXR1cm4gMDsNCn0NCg0Kc3RhdGljIHN0cnVjdCBvZl9kZXZpY2VfaWQgdHJuZzR4eF9tYXRjaFtd
ID0gew0KCXsgLmNvbXBhdGlibGUgICAgICA9ICJwcGM0eHgtdHJuZyIsIH0sDQoJeyAuY29tcGF0
aWJsZSAgICAgID0gImFtY2MscHBjNHh4LXRybmciLCB9LA0KCXsgfSwNCn07DQoNCnN0YXRpYyBz
dHJ1Y3Qgb2ZfcGxhdGZvcm1fZHJpdmVyIHRybmc0eHhfZHJpdmVyID0gew0KCS5uYW1lCQk9ICJw
cGM0eHgtdHJuZyIsDQoJLm1hdGNoX3RhYmxlCT0gdHJuZzR4eF9tYXRjaCwNCgkucHJvYmUJCT0g
dHJuZzR4eF9wcm9iZSwNCgkucmVtb3ZlCQk9IHRybmc0eHhfcmVtb3ZlLA0KfTsNCg0Kc3RhdGlj
IGludCBfX2luaXQgbW9kX2luaXQodm9pZCkNCnsNCiAgcHJpbnRrKCJlbnRlcmVkIG1vZF9pbml0
XG4iKTsgICAgDQogIHJldHVybiBvZl9yZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoJnRybmc0eHhf
ZHJpdmVyKTsNCn0NCg0Kc3RhdGljIHZvaWQgX19leGl0IG1vZF9leGl0KHZvaWQpDQp7DQoJb2Zf
dW5yZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoJnRybmc0eHhfZHJpdmVyKTsNCn0NCg0KbW9kdWxl
X2luaXQobW9kX2luaXQpOw0KbW9kdWxlX2V4aXQobW9kX2V4aXQpOw0KDQpNT0RVTEVfREVTQ1JJ
UFRJT04oIkFNQ0MgNHh4IFRydWUgUmFuZG9tIE51bWJlciBHZW5lcmF0b3IiKTsNCk1PRFVMRV9M
SUNFTlNFKCJHUEwiKTsNCg==

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: text/plain;
	name="trng4xx.h"
Content-Transfer-Encoding: base64
Content-Description: trng4xx.h
Content-Disposition: attachment;
	filename="trng4xx.h"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNCiAqDQogKiBDb3B5cmlnaHQgKGMpIDIwMDggTG9jIEhv
IDxsaG9AYW1jYy5jb20+DQogKg0KICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCiAqIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQogKiB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcg0KICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCiAqDQogKiBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwNCiAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mDQogKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQogKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLg0KICoNCiAqDQogKiBEZXRhaWwgRGVzY3JpcHRpb246DQogKiBUaGlz
IGZpbGUgZGVmaW5lcyBpb2N0bCBzdHJ1Y3R1cmVzIGZvciB0aGUgTGludXggQ3J5cHRvQVBJIGlu
dGVyZmFjZS4gSXQNCiAqIHByb3ZpZGVzIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIGFjY2Vzc3Mg
aW50byB0aGUgTGludXggQ3J5cHRvQVBJDQogKiBmdW5jdGlvbmFsaXRpZXMuDQogKg0KICogQGZp
bGUgdHJuZzR4eC5oDQogKg0KICogVGhpcyBmaWxlIHByb3ZpZGVzIGFjY2VzcyB0byB0aGUgQU1D
QyBTb0MgVFJORy4NCiAqDQogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KICovDQojaWZuZGVmIF9f
VFJORzRYWF9IX18NCiNkZWZpbmUgX19UUk5HNFhYX0hfXw0KDQovKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKg0KICogVFJORyBSZWdpc3RlciBhbmQgYml0IERlZmluaXRpb25zDQogKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKg0KICovDQoNCi8qIFJlZ2lzdGVyIFRSTkc0WFhfU1RBVFVTIGJpdCBkZWZpbml0
aW9uICovDQojZGVmaW5lIFRSTkc0WFhfU1RBVFVTX0JVU1kgICAgICAgICAgICAgICAgMHgwMDAw
MDAwMQ0KDQovKiBSZWdpc3RlciBUUk5HNFhYX0NOVEwgYml0IGRlZmluaXRpb24gKi8NCiNkZWZp
bmUgVFJORzRYWF9DTlRMX1RTVF9SSU5HX09VVCAgICAgICAgICAweDAwMDAwMDAxDQojZGVmaW5l
IFRSTkc0WFhfQ05UTF9UU1RfTU9ERSAgICAgICAgICAgICAgMHgwMDAwMDAwMg0KI2RlZmluZSBU
Uk5HNFhYX0NOVExfVFNUX1JVTiAgICAgICAgICAgICAgIDB4MDAwMDAwMDQNCiNkZWZpbmUgVFJO
RzRYWF9DTlRMX1RTVF9FTjEgICAgICAgICAgICAgICAweDAwMDAwMDA4DQojZGVmaW5lIFRSTkc0
WFhfQ05UTF9UU1RfRU4yICAgICAgICAgICAgICAgMHgwMDAwMDAxMA0KI2RlZmluZSBUUk5HNFhY
X0NOVExfRElTQUJMRV9BTEFSTSAgICAgICAgIDB4MDAwMDAwMjANCiNkZWZpbmUgVFJORzRYWF9D
TlRMX0NMT0NLX09OICAgICAgICAgICAgICAweDAwMDAwMDQwDQojZGVmaW5lIFRSTkc0WFhfQ05U
TF9TSE9SVF9DWUNMRSAgICAgICAgICAgMHgwMDAwMDA4MA0KI2RlZmluZSBUUk5HNFhYX0NOVExf
VFNUX0FMQVJNICAgICAgICAgICAgIDB4MDAwMDAxMDANCiNkZWZpbmUgVFJORzRYWF9DTlRMX1RT
VF9MRlNSICAgICAgICAgICAgICAweDAwMDAwMjAwDQojZGVmaW5lIFRSTkc0WFhfQ05UTF9SRVNF
VF9MRlNSICAgICAgICAgICAgMHgwMDAwMDQwMA0KI2RlZmluZSBUUk5HNFhYX0NOVExfQllQQVNT
X1RSTkcgICAgICAgICAgIDB4MDAwMDA4MDANCiNkZWZpbmUgVFJORzRYWF9DTlRMX1BPU1RfUFJP
Q19FTiAgICAgICAgICAweDAwMDAxMDAwDQoNCi8qIFJlZ2lzdGVyIFRSTkc0WFhfQ0ZHIGJpdCBk
ZWZpbml0aW9uICovDQojZGVmaW5lIFRSTkc0WFhfQ0ZHX1JJTkcxX0RFTEFZX1NFTF9TSElGVCAg
MA0KI2RlZmluZSBUUk5HNFhYX0NGR19SSU5HMV9ERUxBWV9TRUxfTUFTSyAgICg3KQ0KI2RlZmlu
ZSBUUk5HNFhYX0NGR19SSU5HMl9ERUxBWV9TRUxfU0hJRlQgIDMNCiNkZWZpbmUgVFJORzRYWF9D
RkdfUklORzJfREVMQVlfU0VMX01BU0sgICAoNyA8PCBUUk5HNFhYX0NGR19SSU5HMl9ERUxBWV9T
RUxfU0hJRlQpDQojZGVmaW5lIFRSTkc0WFhfQ0ZHX1JFU0VUX0NOVF9TSElGVCAgICAgICAgNg0K
I2RlZmluZSBUUk5HNFhYX0NGR19SRVNFVF9DTlRfU0hJRlRfTUFTSyAgICgweDNGIDw8IFRSTkc0
WFhfQ0ZHX1JJTkcyX0RFTEFZX1NFTF9TSElGVCkNCg0KLyogVFJORyBSZWdpc3RlciBkZWZpbml0
aW9uICovDQojZGVmaW5lIFRSTkc0WFhfT1VUUFVUX0FERFIgICAgICAgMHgwMDAwDQojZGVmaW5l
IFRSTkc0WFhfU1RBVFVTX0FERFIgICAgICAgMHgwMDA0DQojZGVmaW5lIFRSTkc0WFhfQ05UTF9B
RERSICAgICAgICAgMHgwMDA4DQojZGVmaW5lIFRSTkc0WFhfQ0ZHX0FERFIgICAgICAgICAgMHgw
MDBDDQojZGVmaW5lIFRSTkc0WFhfQUxBUk1DTlRfQUREUiAgICAgMHgwMDEwDQojZGVmaW5lIFRS
Tkc0WFhfQVJFR19BRERSICAgICAgICAgMHgwMDE0DQojZGVmaW5lIFRSTkc0WFhfQlJFR19BRERS
ICAgICAgICAgMHgwMDE4DQojZGVmaW5lIFRSTkc0WFhfWFJFR18wX0FERFIgICAgICAgMHgwMDFD
DQojZGVmaW5lIFRSTkc0WFhfWFJFR18xX0FERFIgICAgICAgMHgwMDIwDQojZGVmaW5lIFRSTkc0
WFhfWFJFR18yX0FERFIgICAgICAgMHgwMDI0DQojZGVmaW5lIFRSTkc0WFhfTEZTUjFfTF9BRERS
ICAgICAgMHgwMDI4DQojZGVmaW5lIFRSTkc0WFhfTEZTUjFfSF9BRERSICAgICAgMHgwMDJDDQoj
ZGVmaW5lIFRSTkc0WFhfTEZTUjJfTF9BRERSICAgICAgMHgwMDMwDQojZGVmaW5lIFRSTkc0WFhf
TEZTUjJfSF9BRERSICAgICAgMHgwMDM0DQojZGVmaW5lIFRSTkc0WFhfS0VZMF9MX0FERFIgICAg
ICAgMHgwMDM4DQojZGVmaW5lIFRSTkc0WFhfS0VZMF9IX0FERFIgICAgICAgMHgwMDNDDQojZGVm
aW5lIFRSTkc0WFhfS0VZMV9MX0FERFIgICAgICAgMHgwMDQwDQojZGVmaW5lIFRSTkc0WFhfS0VZ
MV9IX0FERFIgICAgICAgMHgwMDQ0DQojZGVmaW5lIFRSTkc0WFhfSVZfTF9BRERSICAgICAgICAg
MHgwMDQ4DQojZGVmaW5lIFRSTkc0WFhfSVZfSF9BRERSICAgICAgICAgMHgwMDRDDQoNCnN0cnVj
dCBoYWxfY29uZmlnOw0KDQovKioNCiAqIEBicmllZiAgIFRoaXMgZnVuY3Rpb24gTVVTVHMgYmUg
Y2FsbGVkIHRvIGluaXRpYWxpemUgdGhlIEhXDQogKiAgICAgICAgICBhY2Nlc3MgZnVuY3Rpb24u
DQogKiBAcGFyYW0gICBhbWNjX2hhbF9jZmcgICAgICAgIEhXIGFjY2VzcyBjb25maWd1cmF0aW9u
LiBJZiBOVUxMLA0KICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0IHdpbGwg
YmUgdXNlZC4NCiAqIEByZXR1cm4gIFBQUk9fUkNfT0sgb3IgUFBST19SQ19GQVRBTA0KICogQG5v
dGUgICAgVG8gbG9hZCBhbGwgYWNjZXNzIGZ1bmN0aW9ucyBmcm9tIEhBTCB3aXRoIGRlZmF1bHQg
aW5pdGlhbA0KICogICAgICAgICAgICAgIG1hcCBhZGRyZXNzLCBwYXNzIGEgTlVMTCBhcyBpdHMg
cGFyYW1ldGVyLg0KICogQG4gICAgICAgVG8gbG9hZCBhbGwgYWNjZXNzIGZ1bmN0aW9ucyBmcm9t
IEhBTCB3aXRoIGRlZmF1bHQgcnVudGltZQ0KICogICAgICAgICAgICAgIG1hcCBhZGRyZXNzLCBp
bml0aWFsaXplIGFuIGFtY2NfaGFsX2NvbmZpZ190IHN0cnVjdA0KICogICAgICAgICAgICAgIHdp
dGggdmFsaWQgSEFMIHNpZ25hdHVyZSBhbmQgc2V0DQogKiAgICAgICAgICAgICAgYW1jY19oYWxf
Y29uZmlnLT5mbGFncyB8PSBQUFJPX0hBTF9GTEFHX0xPQURJTklUOw0KICoNCiAqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqDQogKi8NCmludCAgICB0cm5nNHh4X2NvbmZpZ19zZXQoc3RydWN0IGhhbF9j
b25maWcgKmNmZyk7DQoNCi8qKg0KICogQGJyaWVmICAgVGhpcyBmdW5jdGlvbiBNVVNUcyBiZSBj
YWxsZWQgdG8gZGUtaW5pdGlhbGl6ZSB0aGUgSFcNCiAqICAgICAgICAgIGFjY2VzcyBmdW5jdGlv
bi4NCiAqIEByZXR1cm4gIFBQUk9fUkNfT0sgb3IgUFBST19SQ19GQVRBTA0KICoNCiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqDQogKi8NCmludCAgICB0cm5nNHh4X2NvbmZpZ19jbGVhcih2b2lkKTsN
Cg0KLyoqDQogKiBAYnJpZWYgICBUaGlzIGZ1bmN0aW9ucyByZWFkcyBmcm9tIHRoZSBUUk5HIHJl
Z2lzdGVycy4NCiAqIEBwYXJhbSAgIHJlZ19hZGRyICAgIERldmljZSByZWdpc3RlciBvZmZzZXQN
CiAqIEBwYXJhbSAgIGRhdGFfdmFsICAgIEFuIERXT1JEIHBvaW50ZXIgdG8gc3RvcmUgdGhlIHJl
dHVybmVkIHZhbHVlDQogKiBAcmV0dXJuICBQUFJPX1JDX09LIG9yIFBQUk9fUkNfRkFUQUwNCiAq
DQogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKg0KICovDQppbmxpbmUgaW50ICAgIHRybmc0eHhfaHdf
cmVhZDMyKHUzMiByZWdfYWRkciwgdTMyICpkYXRhX3ZhbCk7DQoNCi8qKg0KICogQGJyaWVmICAg
VGhpcyBmdW5jdGlvbnMgd3JpdGVzIHRvIHRoZSBUUk5HIHJlZ2lzdGVycy4NCiAqIEBwYXJhbSAg
IHJlZ19hZGRyICAgIERldmljZSByZWdpc3RlciBvZmZzZXQNCiAqIEBwYXJhbSAgIGRhdGFfdmFs
ICAgIEFuIERXT1JEIHZhbHVlIHRvIHdyaXRlDQogKiBAcmV0dXJuICBQUFJPX1JDX09LIG9yIFBQ
Uk9fUkNfRkFUQUwNCiAqDQogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KICovDQppbmxpbmUgaW50
ICAgIHRybmc0eHhfaHdfd3JpdGUzMih1MzIgcmVnX2FkZHIsIHUzMiBkYXRhX3ZhbCk7DQoNCi8q
Kg0KICogQGJyaWVmICAgVGhpcyBmdW5jdGlvbnMgaW5pdGlhbGl6ZXMgdGhlIFRSTkcgZm9yIG9w
ZXJhdGlvbi4NCiAqIEByZXR1cm4gIFBQUk9fUkNfT0sgb3IgUFBST19SQ19GQVRBTA0KICoNCiAq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqDQogKi8NCmludCAJdHJuZzR4eF9od19pbml0KHZvaWQpOw0K
DQovKioNCiAqIEBicmllZiAgIFRoaXMgZnVuY3Rpb25zIGRlLWluaXRpYWxpemVzIHRoZSBUUk5H
Lg0KICogQHJldHVybiAgUFBST19SQ19PSyBvciBQUFJPX1JDX0ZBVEFMDQogKg0KICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCiAqLw0KaW50IAl0cm5nNHh4X2h3X2RlaW5pdCh2b2lkKTsNCg0KLyoq
DQogKiBAYnJpZWYgICBUaGlzIGZ1bmN0aW9ucyByZXRyaWV2ZXMgYW4gdHJ1ZSByYW5kb20gbnVt
YmVyLg0KICogQHBhcmFtICAgcmFuZF92YWwgICAgQSBwb2ludGVyIHRvIGEgRFdPUkQgdG8gc3Rv
cmUgdGhlIHZhbHVlDQogKiBAcmV0dXJuICBQUFJPX1JDX09LIGlmIHN1Y2Nlc3NmdWxsLiBQUFJP
X1JDX0VJTlBST0dSRVNTIGlmIGZhaWxlZC4gVGhpcw0KICogICAgICAgICAgc2hvdWxkIG5vdCBo
YXBwZW4gYXMgdGhpcyBtZWFucyB0aGUgaGFyZHdhcmUgc3RpbGwgYnVzeS4NCiAqDQogKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKg0KICovDQppbnQgCXRybmc0eHhfcmFuZG9tKHUzMiAqcmFuZF92YWwp
Ow0KDQojZW5kaWYNCg==

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: application/octet-stream;
	name="canyonlands.dts"
Content-Transfer-Encoding: base64
Content-Description: canyonlands.dts
Content-Disposition: attachment;
	filename="canyonlands.dts"

LyoKICogRGV2aWNlIFRyZWUgU291cmNlIGZvciBBTUNDIENhbnlvbmxhbmRzICg0NjBFWCkKICoK
ICogQ29weXJpZ2h0IDIwMDggREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZywgU3RlZmFuIFJvZXNl
IDxzckBkZW54LmRlPgogKgogKiBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMKICogTGljZW5zZSB2ZXJzaW9uIDIuICBUaGlzIHBy
b2dyYW0gaXMgbGljZW5zZWQgImFzIGlzIiB3aXRob3V0CiAqIGFueSB3YXJyYW50eSBvZiBhbnkg
a2luZCwgd2hldGhlciBleHByZXNzIG9yIGltcGxpZWQuCiAqLwoKLyB7CgkjYWRkcmVzcy1jZWxs
cyA9IDwyPjsKCSNzaXplLWNlbGxzID0gPDE+OwoJbW9kZWwgPSAiYW1jYyxjYW55b25sYW5kcyI7
Cgljb21wYXRpYmxlID0gImFtY2MsY2FueW9ubGFuZHMiOwoJZGNyLXBhcmVudCA9IDwmL2NwdXMv
Y3B1QDA+OwoKCWFsaWFzZXMgewoJCWV0aGVybmV0MCA9ICZFTUFDMDsKCQlldGhlcm5ldDEgPSAm
RU1BQzE7CgkJc2VyaWFsMCA9ICZVQVJUMDsKCQlzZXJpYWwxID0gJlVBUlQxOwoJfTsKCgljcHVz
IHsKCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwwPjsKCgkJY3B1QDAg
ewoJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOwoJCQltb2RlbCA9ICJQb3dlclBDLDQ2MEVYIjsKCQkJ
cmVnID0gPDA+OwoJCQljbG9jay1mcmVxdWVuY3kgPSA8MD47IC8qIEZpbGxlZCBpbiBieSBVLUJv
b3QgKi8KCQkJdGltZWJhc2UtZnJlcXVlbmN5ID0gPDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290
ICovCgkJCWktY2FjaGUtbGluZS1zaXplID0gPDIwPjsKCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8
MjA+OwoJCQlpLWNhY2hlLXNpemUgPSA8ODAwMD47CgkJCWQtY2FjaGUtc2l6ZSA9IDw4MDAwPjsK
CQkJZGNyLWNvbnRyb2xsZXI7CgkJCWRjci1hY2Nlc3MtbWV0aG9kID0gIm5hdGl2ZSI7CgkJfTsK
CX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJCXJlZyA9IDwwIDAgMD47
IC8qIEZpbGxlZCBpbiBieSBVLUJvb3QgKi8KCX07CgoJVUlDMDogaW50ZXJydXB0LWNvbnRyb2xs
ZXIwIHsKCQljb21wYXRpYmxlID0gImlibSx1aWMtNDYwZXgiLCJpYm0sdWljIjsKCQlpbnRlcnJ1
cHQtY29udHJvbGxlcjsKCQljZWxsLWluZGV4ID0gPDA+OwoJCWRjci1yZWcgPSA8MGMwIDAwOT47
CgkJI2FkZHJlc3MtY2VsbHMgPSA8MD47CgkJI3NpemUtY2VsbHMgPSA8MD47CgkJI2ludGVycnVw
dC1jZWxscyA9IDwyPjsKCX07CgoJVUlDMTogaW50ZXJydXB0LWNvbnRyb2xsZXIxIHsKCQljb21w
YXRpYmxlID0gImlibSx1aWMtNDYwZXgiLCJpYm0sdWljIjsKCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsKCQljZWxsLWluZGV4ID0gPDE+OwoJCWRjci1yZWcgPSA8MGQwIDAwOT47CgkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MD47CgkJI3NpemUtY2VsbHMgPSA8MD47CgkJI2ludGVycnVwdC1jZWxscyA9IDwy
PjsKCQlpbnRlcnJ1cHRzID0gPDFlIDQgMWYgND47IC8qIGNhc2NhZGUgKi8KCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZVSUMwPjsKCX07CgoJVUlDMjogaW50ZXJydXB0LWNvbnRyb2xsZXIyIHsKCQlj
b21wYXRpYmxlID0gImlibSx1aWMtNDYwZXgiLCJpYm0sdWljIjsKCQlpbnRlcnJ1cHQtY29udHJv
bGxlcjsKCQljZWxsLWluZGV4ID0gPDI+OwoJCWRjci1yZWcgPSA8MGUwIDAwOT47CgkJI2FkZHJl
c3MtY2VsbHMgPSA8MD47CgkJI3NpemUtY2VsbHMgPSA8MD47CgkJI2ludGVycnVwdC1jZWxscyA9
IDwyPjsKCQlpbnRlcnJ1cHRzID0gPGEgNCBiIDQ+OyAvKiBjYXNjYWRlICovCgkJaW50ZXJydXB0
LXBhcmVudCA9IDwmVUlDMD47Cgl9OwoKCVVJQzM6IGludGVycnVwdC1jb250cm9sbGVyMyB7CgkJ
Y29tcGF0aWJsZSA9ICJpYm0sdWljLTQ2MGV4IiwiaWJtLHVpYyI7CgkJaW50ZXJydXB0LWNvbnRy
b2xsZXI7CgkJY2VsbC1pbmRleCA9IDwzPjsKCQlkY3ItcmVnID0gPDBmMCAwMDk+OwoJCSNhZGRy
ZXNzLWNlbGxzID0gPDA+OwoJCSNzaXplLWNlbGxzID0gPDA+OwoJCSNpbnRlcnJ1cHQtY2VsbHMg
PSA8Mj47CgkJaW50ZXJydXB0cyA9IDwxMCA0IDExIDQ+OyAvKiBjYXNjYWRlICovCgkJaW50ZXJy
dXB0LXBhcmVudCA9IDwmVUlDMD47Cgl9OwoKCVNEUjA6IHNkciB7CgkJY29tcGF0aWJsZSA9ICJp
Ym0sc2RyLTQ2MGV4IjsKCQlkY3ItcmVnID0gPDAwZSAwMDI+OwoJfTsKCglDUFIwOiBjcHIgewoJ
CWNvbXBhdGlibGUgPSAiaWJtLGNwci00NjBleCI7CgkJZGNyLXJlZyA9IDwwMGMgMDAyPjsKCX07
CgoJTDJDMDogbDJjIHsKCQljb21wYXRpYmxlID0gImlibSxsMi1jYWNoZS00NjBleCIsICJpYm0s
bDItY2FjaGUiOwoJCWRjci1yZWcgPSA8MjAgOAkJCS8qIEludGVybmFsIFNSQU0gRENSJ3MgKi8K
CQkJICAgMzAgOD47CQkvKiBMMiBjYWNoZSBEQ1IncyAqLwoJCWNhY2hlLWxpbmUtc2l6ZSA9IDwy
MD47CQkvKiAzMiBieXRlcyAqLwoJCWNhY2hlLXNpemUgPSA8NDAwMDA+OwkJLyogTDIsIDI1Nksg
Ki8KCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZVSUMyPjsKCQlpbnRlcnJ1cHRzID0gPDE3IDE+OwoJ
fTsKCglwbGIgewoJCWNvbXBhdGlibGUgPSAiaWJtLHBsYi00NjBleCIsICJpYm0scGxiNCI7CgkJ
I2FkZHJlc3MtY2VsbHMgPSA8Mj47CgkJI3NpemUtY2VsbHMgPSA8MT47CgkJcmFuZ2VzOwoJCWNs
b2NrLWZyZXF1ZW5jeSA9IDwwPjsgLyogRmlsbGVkIGluIGJ5IFUtQm9vdCAqLwoKCQlTRFJBTTA6
IHNkcmFtIHsKCQkJY29tcGF0aWJsZSA9ICJpYm0sc2RyYW0tNDYwZXgiLCAiaWJtLHNkcmFtLTQw
NWdwIjsKCQkJZGNyLXJlZyA9IDwwMTAgMj47CgkJfTsKCgkJTUFMMDogbWNtYWwgewoJCQljb21w
YXRpYmxlID0gImlibSxtY21hbC00NjBleCIsICJpYm0sbWNtYWwyIjsKCQkJZGNyLXJlZyA9IDwx
ODAgNjI+OwoJCQludW0tdHgtY2hhbnMgPSA8Mj47CgkJCW51bS1yeC1jaGFucyA9IDwxMD47CgkJ
CSNhZGRyZXNzLWNlbGxzID0gPDA+OwoJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJaW50ZXJydXB0
LXBhcmVudCA9IDwmVUlDMj47CgkJCWludGVycnVwdHMgPSA8CS8qVFhFT0IqLyA2IDQKCQkJCQkv
KlJYRU9CKi8gNyA0CgkJCQkJLypTRVJSKi8gIDMgNAoJCQkJCS8qVFhERSovICA0IDQKCQkJCQkv
KlJYREUqLyAgNSA0PjsKCQl9OwoKCQlVU0IwOiBlaGNpQGJmZmQwNDAwIHsKCQkJY29tcGF0aWJs
ZSA9ICJpYm0sdXNiLWVoY2ktNDYwZXgiLCAidXNiLWVoY2kiOwoJCQlpbnRlcnJ1cHQtcGFyZW50
ID0gPCZVSUMyPjsKCQkJaW50ZXJydXB0cyA9IDwxZCA0PjsKCQkJcmVnID0gPDQgYmZmZDA0MDAg
OTAgNCBiZmZkMDQ5MCA3MD47CgkJfTsKCgkJVVNCMTogdXNiQGJmZmQwMDAwIHsKCQkJY29tcGF0
aWJsZSA9ICJvaGNpLWxlIjsKCQkJcmVnID0gPDQgYmZmZDAwMDAgNjA+OwoJCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZVSUMyPjsKCQkJaW50ZXJydXB0cyA9IDwxZSA0PjsKCQl9OwoKCQlVU0JPVEcw
OiB1c2JvdGdAYmZmODAwMDAgewoJCQljb21wYXRpYmxlID0gImFtY2MsdXNiLW90Zy00NjBleCI7
CgkJCXJlZyA9IDw0IGJmZjgwMDAwIDEwMDAwPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmVVNC
T1RHMD47CgkJCWludGVycnVwdHMgPSA8MCAxIDI+OwoJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+
OwoJCQkjYWRkcmVzcy1jZWxscyA9IDwwPjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWludGVy
cnVwdC1tYXAgPSA8LyogVVNCLU9URyAqLyAwICZVSUMyIDFjIDQKCQkJCQkgLyogSElHSC1QT1dF
UiAqLyAxICZVSUMxIDFhIDgKCQkJCQkgLyogRE1BICovIDIgJlVJQzAgYyA0PjsKCQkJaW50ZXJy
dXB0LW1hcC1tYXNrID0gPGZmZmZmZmZmPjsKCQl9OwoKCQlDUllQVE86IGNyeXB0b0AxODAwMDAg
ewoJCQljb21wYXRpYmxlID0gImFtY2MscHBjNDYwZXgtY3J5cHRvIiwgImFtY2MscHBjNHh4LWNy
eXB0byI7CgkJCXJlZyA9IDw0IDAwMTgwMDAwIDg0MDAwPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9
IDwmVUlDMD47CgkJCWludGVycnVwdHMgPSA8MWQgND47CgkJfTsKCgkJVFJORzogdHJuZ0AxMTAw
MDAgewoJCQlkZXZpY2VfdHlwZSA9ICJ0cm5nIjsKCQkJY29tcGF0aWJsZSA9ICJwcGM0eHgtdHJu
ZyIsICJhbWNjLCBwcGM0eHgtdHJuZyI7CgkJCXJlZyA9IDw0IDAwMTEwMDAwIDEwMD47CgkJCWlu
dGVycnVwdC1wYXJlbnQgPSA8JlVJQzE+OwoJCQlpbnRlcnJ1cHRzID0gPDMgMj47CgkJfTsKCQkK
CSAgICAgICAgUEtBOiBwa2FAMTE0MDAwIHsKCQkJZGV2aWNlX3R5cGUgPSAicGthIjsKCQkJY29t
cGF0aWJsZSA9ICJwcGM0eHgtcGthIiwgImFtY2MsIHBwYzR4eC1wa2EiOwoJCQlyZWcgPSA8NCAw
MDExNDAwMCA0MDAwPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmVUlDMD47CgkJCWludGVycnVw
dHMgPSA8MTQgMj47CgkJfTsKCgkJUE9CMDogb3BiIHsKCQkJY29tcGF0aWJsZSA9ICJpYm0sb3Bi
LTQ2MGV4IiwgImlibSxvcGIiOwoJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJI3NpemUtY2Vs
bHMgPSA8MT47CgkJCXJhbmdlcyA9IDxiMDAwMDAwMCA0IGIwMDAwMDAwIDUwMDAwMDAwPjsKCQkJ
Y2xvY2stZnJlcXVlbmN5ID0gPDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgoJCQlFQkMw
OiBlYmMgewoJCQkJY29tcGF0aWJsZSA9ICJpYm0sZWJjLTQ2MGV4IiwgImlibSxlYmMiOwoJCQkJ
ZGNyLXJlZyA9IDwwMTIgMj47CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsKCQkJCSNzaXplLWNl
bGxzID0gPDE+OwoJCQkJY2xvY2stZnJlcXVlbmN5ID0gPDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1C
b290ICovCgkJCQkvKiByYW5nZXMgcHJvcGVydHkgaXMgc3VwcGxpZWQgYnkgVS1Cb290ICovCgkJ
CQlpbnRlcnJ1cHRzID0gPDYgND47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZVSUMxPjsKCgkJ
CQlub3JfZmxhc2hAMCwwIHsKCQkJCQljb21wYXRpYmxlID0gImFtZCxzMjlnbDUxMm4iLCAiY2Zp
LWZsYXNoIjsKCQkJCQliYW5rLXdpZHRoID0gPDI+OwoJCQkJCXJlZyA9IDwwIDAwMDAwMCA0MDAw
MDAwPjsKCQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJCQkjc2l6ZS1jZWxscyA9IDwxPjsK
CQkJCQlwYXJ0aXRpb25AMCB7CgkJCQkJCWxhYmVsID0gImtlcm5lbCI7CgkJCQkJCXJlZyA9IDww
IDFlMDAwMD47CgkJCQkJfTsKCQkJCQlwYXJ0aXRpb25AMWUwMDAwIHsKCQkJCQkJbGFiZWwgPSAi
ZHRiIjsKCQkJCQkJcmVnID0gPDFlMDAwMCAyMDAwMD47CgkJCQkJfTsKCQkJCQlwYXJ0aXRpb25A
MjAwMDAwIHsKCQkJCQkJbGFiZWwgPSAicmFtZGlzayI7CgkJCQkJCXJlZyA9IDwyMDAwMDAgMTQw
MDAwMD47CgkJCQkJfTsKCQkJCQlwYXJ0aXRpb25AMTYwMDAwMCB7CgkJCQkJCWxhYmVsID0gImpm
ZnMyIjsKCQkJCQkJcmVnID0gPDE2MDAwMDAgNDAwMDAwPjsKCQkJCQl9OwoJCQkJCXBhcnRpdGlv
bkAxYTAwMDAwIHsKCQkJCQkJbGFiZWwgPSAidXNlciI7CgkJCQkJCXJlZyA9IDwxYTAwMDAwIDI1
NjAwMDA+OwoJCQkJCX07CgkJCQkJcGFydGl0aW9uQDNmNjAwMDAgewoJCQkJCQlsYWJlbCA9ICJl
bnYiOwoJCQkJCQlyZWcgPSA8M2Y2MDAwMCA0MDAwMD47CgkJCQkJfTsKCQkJCQlwYXJ0aXRpb25A
M2ZhMDAwMCB7CgkJCQkJCWxhYmVsID0gInUtYm9vdCI7CgkJCQkJCXJlZyA9IDwzZmEwMDAwIDYw
MDAwPjsKCQkJCQl9OwoJCQkJfTsKCQkJfTsKCgkJCVVBUlQwOiBzZXJpYWxAZWY2MDAzMDAgewoJ
CQkJZGV2aWNlX3R5cGUgPSAic2VyaWFsIjsKCQkJCWNvbXBhdGlibGUgPSAibnMxNjU1MCI7CgkJ
CQlyZWcgPSA8ZWY2MDAzMDAgOD47CgkJCQl2aXJ0dWFsLXJlZyA9IDxlZjYwMDMwMD47CgkJCQlj
bG9jay1mcmVxdWVuY3kgPSA8MD47IC8qIEZpbGxlZCBpbiBieSBVLUJvb3QgKi8KCQkJCWN1cnJl
bnQtc3BlZWQgPSA8MD47IC8qIEZpbGxlZCBpbiBieSBVLUJvb3QgKi8KCQkJCWludGVycnVwdC1w
YXJlbnQgPSA8JlVJQzE+OwoJCQkJaW50ZXJydXB0cyA9IDwxIDQ+OwoJCQl9OwoKCQkJVUFSVDE6
IHNlcmlhbEBlZjYwMDQwMCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJzZXJpYWwiOwoJCQkJY29tcGF0
aWJsZSA9ICJuczE2NTUwIjsKCQkJCXJlZyA9IDxlZjYwMDQwMCA4PjsKCQkJCXZpcnR1YWwtcmVn
ID0gPGVmNjAwNDAwPjsKCQkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsgLyogRmlsbGVkIGluIGJ5
IFUtQm9vdCAqLwoJCQkJY3VycmVudC1zcGVlZCA9IDwwPjsgLyogRmlsbGVkIGluIGJ5IFUtQm9v
dCAqLwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmVUlDMD47CgkJCQlpbnRlcnJ1cHRzID0gPDEg
ND47CgkJCX07CgoJCQlVQVJUMjogc2VyaWFsQGVmNjAwNTAwIHsKCQkJCWRldmljZV90eXBlID0g
InNlcmlhbCI7CgkJCQljb21wYXRpYmxlID0gIm5zMTY1NTAiOwoJCQkJcmVnID0gPGVmNjAwNTAw
IDg+OwoJCQkJdmlydHVhbC1yZWcgPSA8ZWY2MDA1MDA+OwoJCQkJY2xvY2stZnJlcXVlbmN5ID0g
PDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgkJCQljdXJyZW50LXNwZWVkID0gPDA+OyAv
KiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZVSUMxPjsK
CQkJCWludGVycnVwdHMgPSA8MWQgND47CgkJCX07CgoJCQlVQVJUMzogc2VyaWFsQGVmNjAwNjAw
IHsKCQkJCWRldmljZV90eXBlID0gInNlcmlhbCI7CgkJCQljb21wYXRpYmxlID0gIm5zMTY1NTAi
OwoJCQkJcmVnID0gPGVmNjAwNjAwIDg+OwoJCQkJdmlydHVhbC1yZWcgPSA8ZWY2MDA2MDA+OwoJ
CQkJY2xvY2stZnJlcXVlbmN5ID0gPDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgkJCQlj
dXJyZW50LXNwZWVkID0gPDA+OyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgkJCQlpbnRlcnJ1
cHQtcGFyZW50ID0gPCZVSUMxPjsKCQkJCWludGVycnVwdHMgPSA8MWUgND47CgkJCX07CgoKCQkJ
SUlDMDogaTJjQGVmNjAwNzAwIHsKCQkJCWNvbXBhdGlibGUgPSAiaWJtLGlpYy00NjBleCIsICJp
Ym0saWljIjsKCQkJCXJlZyA9IDxlZjYwMDcwMCAxND47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0g
PCZVSUMwPjsKCQkJCWludGVycnVwdHMgPSA8MiA0PjsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+
OwoJCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCQlydGNANjggewoJCQkJCWNvbXBhdGlibGUgPSAi
c3RtLG00MXQ4MCI7CgkJCQkJcmVnID0gPDY4PjsKCQkJCX07CgkJCX07CgoKCgkJCUlJQzE6IGky
Y0BlZjYwMDgwMCB7CgkJCQljb21wYXRpYmxlID0gImlibSxpaWMtNDYwZXgiLCAiaWJtLGlpYyI7
CgkJCQlyZWcgPSA8ZWY2MDA4MDAgMTQ+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmVUlDMD47
CgkJCQlpbnRlcnJ1cHRzID0gPDMgND47CgkJCX07CgoJCQlaTUlJMDogZW1hYy16bWlpQGVmNjAw
ZDAwIHsKCQkJCWNvbXBhdGlibGUgPSAiaWJtLHptaWktNDYwZXgiLCAiaWJtLHptaWkiOwoJCQkJ
cmVnID0gPGVmNjAwZDAwIGM+OwoJCQl9OwoKCQkJUkdNSUkwOiBlbWFjLXJnbWlpQGVmNjAxNTAw
IHsKCQkJCWNvbXBhdGlibGUgPSAiaWJtLHJnbWlpLTQ2MGV4IiwgImlibSxyZ21paSI7CgkJCQly
ZWcgPSA8ZWY2MDE1MDAgOD47CgkJCQloYXMtbWRpbzsKCQkJfTsKCgkJCVRBSDA6IGVtYWMtdGFo
QGVmNjAxMzUwIHsKCQkJCWNvbXBhdGlibGUgPSAiaWJtLHRhaC00NjBleCIsICJpYm0sdGFoIjsK
CQkJCXJlZyA9IDxlZjYwMTM1MCAzMD47CgkJCX07CgoJCQlUQUgxOiBlbWFjLXRhaEBlZjYwMTQ1
MCB7CgkJCQljb21wYXRpYmxlID0gImlibSx0YWgtNDYwZXgiLCAiaWJtLHRhaCI7CgkJCQlyZWcg
PSA8ZWY2MDE0NTAgMzA+OwoJCQl9OwoKCQkJRU1BQzA6IGV0aGVybmV0QGVmNjAwZTAwIHsKCQkJ
CWRldmljZV90eXBlID0gIm5ldHdvcmsiOwoJCQkJY29tcGF0aWJsZSA9ICJpYm0sZW1hYy00NjBl
eCIsICJpYm0sZW1hYzQiOwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmRU1BQzA+OwoJCQkJaW50
ZXJydXB0cyA9IDwwIDE+OwoJCQkJI2ludGVycnVwdC1jZWxscyA9IDwxPjsKCQkJCSNhZGRyZXNz
LWNlbGxzID0gPDA+OwoJCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCQlpbnRlcnJ1cHQtbWFwID0g
PC8qU3RhdHVzKi8gMCAmVUlDMiAxMCA0CgkJCQkJCSAvKldha2UqLyAgIDEgJlVJQzIgMTQgND47
CgkJCQlyZWcgPSA8ZWY2MDBlMDAgNzA+OwoJCQkJbG9jYWwtbWFjLWFkZHJlc3MgPSBbMDAwMDAw
MDAwMDAwXTsgLyogRmlsbGVkIGluIGJ5IFUtQm9vdCAqLwoJCQkJbWFsLWRldmljZSA9IDwmTUFM
MD47CgkJCQltYWwtdHgtY2hhbm5lbCA9IDwwPjsKCQkJCW1hbC1yeC1jaGFubmVsID0gPDA+OwoJ
CQkJY2VsbC1pbmRleCA9IDwwPjsKCQkJCW1heC1mcmFtZS1zaXplID0gPDIzMjg+OwoJCQkJcngt
Zmlmby1zaXplID0gPDEwMDA+OwoJCQkJdHgtZmlmby1zaXplID0gPDgwMD47CgkJCQlwaHktbW9k
ZSA9ICJyZ21paSI7CgkJCQlwaHktbWFwID0gPDAwMDAwMDAwPjsKCQkJCXJnbWlpLWRldmljZSA9
IDwmUkdNSUkwPjsKCQkJCXJnbWlpLWNoYW5uZWwgPSA8MD47CgkJCQl0YWgtZGV2aWNlID0gPCZU
QUgwPjsKCQkJCXRhaC1jaGFubmVsID0gPDA+OwoJCQkJaGFzLWludmVydGVkLXN0YWNyLW9jOwoJ
CQkJaGFzLW5ldy1zdGFjci1zdGFvcGM7CgkJCX07CgoJCQlFTUFDMTogZXRoZXJuZXRAZWY2MDBm
MDAgewoJCQkJZGV2aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCQljb21wYXRpYmxlID0gImlibSxl
bWFjLTQ2MGV4IiwgImlibSxlbWFjNCI7CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZFTUFDMT47
CgkJCQlpbnRlcnJ1cHRzID0gPDAgMT47CgkJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8MD47CgkJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJCWludGVycnVw
dC1tYXAgPSA8LypTdGF0dXMqLyAwICZVSUMyIDExIDQKCQkJCQkJIC8qV2FrZSovICAgMSAmVUlD
MiAxNSA0PjsKCQkJCXJlZyA9IDxlZjYwMGYwMCA3MD47CgkJCQlsb2NhbC1tYWMtYWRkcmVzcyA9
IFswMDAwMDAwMDAwMDBdOyAvKiBGaWxsZWQgaW4gYnkgVS1Cb290ICovCgkJCQltYWwtZGV2aWNl
ID0gPCZNQUwwPjsKCQkJCW1hbC10eC1jaGFubmVsID0gPDE+OwoJCQkJbWFsLXJ4LWNoYW5uZWwg
PSA8OD47CgkJCQljZWxsLWluZGV4ID0gPDE+OwoJCQkJbWF4LWZyYW1lLXNpemUgPSA8MjMyOD47
CgkJCQlyeC1maWZvLXNpemUgPSA8MTAwMD47CgkJCQl0eC1maWZvLXNpemUgPSA8ODAwPjsKCQkJ
CXBoeS1tb2RlID0gInJnbWlpIjsKCQkJCXBoeS1tYXAgPSA8MDAwMDAwMDA+OwoJCQkJcmdtaWkt
ZGV2aWNlID0gPCZSR01JSTA+OwoJCQkJcmdtaWktY2hhbm5lbCA9IDwxPjsKCQkJCXRhaC1kZXZp
Y2UgPSA8JlRBSDE+OwoJCQkJdGFoLWNoYW5uZWwgPSA8MT47CgkJCQloYXMtaW52ZXJ0ZWQtc3Rh
Y3Itb2M7CgkJCQloYXMtbmV3LXN0YWNyLXN0YW9wYzsKCQkJCW1kaW8tZGV2aWNlID0gPCZFTUFD
MD47CgkJCX07CgkJfTsKCgkJUENJWDA6IHBjaUBjMGVjMDAwMDAgewoJCQlkZXZpY2VfdHlwZSA9
ICJwY2kiOwoJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwyPjsK
CQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJCWNvbXBhdGlibGUgPSAiaWJtLHBsYi1wY2l4LTQ2
MGV4IiwgImlibSxwbGItcGNpeCI7CgkJCXByaW1hcnk7CgkJCWxhcmdlLWluYm91bmQtd2luZG93
czsKCQkJZW5hYmxlLW1zaS1ob2xlOwoJCQlyZWcgPSA8YyAwZWMwMDAwMCAgIDgJLyogQ29uZmln
IHNwYWNlIGFjY2VzcyAqLwoJCQkgICAgICAgMCAwIDAJCS8qIG5vIElBQ0sgY3ljbGVzICovCgkJ
CSAgICAgICBjIDBlZDAwMDAwICAgNCAgIC8qIFNwZWNpYWwgY3ljbGVzICovCgkJCSAgICAgICBj
IDBlYzgwMDAwIDEwMAkvKiBJbnRlcm5hbCByZWdpc3RlcnMgKi8KCQkJICAgICAgIGMgMGVjODAx
MDAgIGZjPjsJLyogSW50ZXJuYWwgbWVzc2FnaW5nIHJlZ2lzdGVycyAqLwoKCQkJLyogT3V0Ym91
bmQgcmFuZ2VzLCBvbmUgbWVtb3J5IGFuZCBvbmUgSU8sCgkJCSAqIGxhdGVyIGNhbm5vdCBiZSBj
aGFuZ2VkCgkJCSAqLwoJCQlyYW5nZXMgPSA8MDIwMDAwMDAgMCA4MDAwMDAwMCAwMDAwMDAwZCA4
MDAwMDAwMCAwIDgwMDAwMDAwCgkJCQkgIDAxMDAwMDAwIDAgMDAwMDAwMDAgMDAwMDAwMGMgMDgw
MDAwMDAgMCAwMDAxMDAwMD47CgoJCQkvKiBJbmJvdW5kIDJHQiByYW5nZSBzdGFydGluZyBhdCAw
ICovCgkJCWRtYS1yYW5nZXMgPSA8NDIwMDAwMDAgMCAwIDAgMCAwIDgwMDAwMDAwPjsKCgkJCS8q
IFRoaXMgZHJpdmVzIGJ1c3NlcyAwIHRvIDB4M2YgKi8KCQkJYnVzLXJhbmdlID0gPDAgM2Y+OwoK
CQkJLyogQWxsIFBDSSBpbnRlcnJ1cHRzIGFyZSByb3V0ZWQgdG8gZXh0IElSUSAyIC0+IFVJQzEt
MCAqLwoJCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MDAwMCAwIDAgMD47CgkJCWludGVycnVwdC1t
YXAgPSA8IDAwMDAgMCAwIDAgJlVJQzEgMCA4ID47CgkJfTsKCgkJUENJRTA6IHBjaWV4QGQwMDAw
MDAwMCB7CgkJCWRldmljZV90eXBlID0gInBjaSI7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47
CgkJCSNzaXplLWNlbGxzID0gPDI+OwoJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsKCQkJY29tcGF0
aWJsZSA9ICJpYm0scGxiLXBjaWV4LTQ2MGV4IiwgImlibSxwbGItcGNpZXgiOwoJCQlwcmltYXJ5
OwoJCQlwb3J0ID0gPDA+OyAvKiBwb3J0IG51bWJlciAqLwoJCQlyZWcgPSA8ZCAwMDAwMDAwMCAy
MDAwMDAwMAkvKiBDb25maWcgc3BhY2UgYWNjZXNzICovCgkJCSAgICAgICBjIDA4MDEwMDAwIDAw
MDAxMDAwPjsJLyogUmVnaXN0ZXJzICovCgkJCWRjci1yZWcgPSA8MTAwIDAyMD47CgkJCXNkci1i
YXNlID0gPDMwMD47CgoJCQkvKiBPdXRib3VuZCByYW5nZXMsIG9uZSBtZW1vcnkgYW5kIG9uZSBJ
TywKCQkJICogbGF0ZXIgY2Fubm90IGJlIGNoYW5nZWQKCQkJICovCgkJCXJhbmdlcyA9IDwwMjAw
MDAwMCAwIDgwMDAwMDAwIDAwMDAwMDBlIDAwMDAwMDAwIDAgODAwMDAwMDAKCQkJCSAgMDEwMDAw
MDAgMCAwMDAwMDAwMCAwMDAwMDAwZiA4MDAwMDAwMCAwIDAwMDEwMDAwPjsKCgkJCS8qIEluYm91
bmQgMkdCIHJhbmdlIHN0YXJ0aW5nIGF0IDAgKi8KCQkJZG1hLXJhbmdlcyA9IDw0MjAwMDAwMCAw
IDAgMCAwIDAgODAwMDAwMDA+OwoKCQkJLyogVGhpcyBkcml2ZXMgYnVzc2VzIDQwIHRvIDB4N2Yg
Ki8KCQkJYnVzLXJhbmdlID0gPDQwIDdmPjsKCgkJCS8qIExlZ2FjeSBpbnRlcnJ1cHRzIChub3Rl
IHRoZSB3ZWlyZCBwb2xhcml0eSwgdGhlIGJyaWRnZSBzZWVtcwoJCQkgKiB0byBpbnZlcnQgUENJ
ZSBsZWdhY3kgaW50ZXJydXB0cykuCgkJCSAqIFdlIGFyZSBkZS1zd2l6emxpbmcgaGVyZSBiZWNh
dXNlIHRoZSBudW1iZXJzIGFyZSBhY3R1YWxseSBmb3IKCQkJICogcG9ydCBvZiB0aGUgcm9vdCBj
b21wbGV4IHZpcnR1YWwgUDJQIGJyaWRnZS4gQnV0IEkgd2FudAoJCQkgKiB0byBhdm9pZCBwdXR0
aW5nIGEgbm9kZSBmb3IgaXQgaW4gdGhlIHRyZWUsIHNvIHRoZSBudW1iZXJzCgkJCSAqIGJlbG93
IGFyZSBiYXNpY2FsbHkgZGUtc3dpenpsZWQgbnVtYmVycy4KCQkJICogVGhlIHJlYWwgc2xvdCBp
cyBvbiBpZHNlbCAwLCBzbyB0aGUgc3dpenpsaW5nIGlzIDE6MQoJCQkgKi8KCQkJaW50ZXJydXB0
LW1hcC1tYXNrID0gPDAwMDAgMCAwIDc+OwoJCQlpbnRlcnJ1cHQtbWFwID0gPAoJCQkJMDAwMCAw
IDAgMSAmVUlDMyBjIDQgLyogc3dpenpsZWQgaW50IEEgKi8KCQkJCTAwMDAgMCAwIDIgJlVJQzMg
ZCA0IC8qIHN3aXp6bGVkIGludCBCICovCgkJCQkwMDAwIDAgMCAzICZVSUMzIGUgNCAvKiBzd2l6
emxlZCBpbnQgQyAqLwoJCQkJMDAwMCAwIDAgNCAmVUlDMyBmIDQgLyogc3dpenpsZWQgaW50IEQg
Ki8+OwoJCX07CgoJCVBDSUUxOiBwY2lleEBkMjAwMDAwMDAgewoJCQlkZXZpY2VfdHlwZSA9ICJw
Y2kiOwoJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwyPjsKCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJCWNvbXBhdGlibGUgPSAiaWJtLHBsYi1wY2lleC00NjBl
eCIsICJpYm0scGxiLXBjaWV4IjsKCQkJcHJpbWFyeTsKCQkJcG9ydCA9IDwxPjsgLyogcG9ydCBu
dW1iZXIgKi8KCQkJcmVnID0gPGQgMjAwMDAwMDAgMjAwMDAwMDAJLyogQ29uZmlnIHNwYWNlIGFj
Y2VzcyAqLwoJCQkgICAgICAgYyAwODAxMTAwMCAwMDAwMTAwMD47CS8qIFJlZ2lzdGVycyAqLwoJ
CQlkY3ItcmVnID0gPDEyMCAwMjA+OwoJCQlzZHItYmFzZSA9IDwzNDA+OwoKCQkJLyogT3V0Ym91
bmQgcmFuZ2VzLCBvbmUgbWVtb3J5IGFuZCBvbmUgSU8sCgkJCSAqIGxhdGVyIGNhbm5vdCBiZSBj
aGFuZ2VkCgkJCSAqLwoJCQlyYW5nZXMgPSA8MDIwMDAwMDAgMCA4MDAwMDAwMCAwMDAwMDAwZSA4
MDAwMDAwMCAwIDgwMDAwMDAwCgkJCQkgIDAxMDAwMDAwIDAgMDAwMDAwMDAgMDAwMDAwMGYgODAw
MTAwMDAgMCAwMDAxMDAwMD47CgoJCQkvKiBJbmJvdW5kIDJHQiByYW5nZSBzdGFydGluZyBhdCAw
ICovCgkJCWRtYS1yYW5nZXMgPSA8NDIwMDAwMDAgMCAwIDAgMCAwIDgwMDAwMDAwPjsKCgkJCS8q
IFRoaXMgZHJpdmVzIGJ1c3NlcyA4MCB0byAweGJmICovCgkJCWJ1cy1yYW5nZSA9IDw4MCBiZj47
CgoJCQkvKiBMZWdhY3kgaW50ZXJydXB0cyAobm90ZSB0aGUgd2VpcmQgcG9sYXJpdHksIHRoZSBi
cmlkZ2Ugc2VlbXMKCQkJICogdG8gaW52ZXJ0IFBDSWUgbGVnYWN5IGludGVycnVwdHMpLgoJCQkg
KiBXZSBhcmUgZGUtc3dpenpsaW5nIGhlcmUgYmVjYXVzZSB0aGUgbnVtYmVycyBhcmUgYWN0dWFs
bHkgZm9yCgkJCSAqIHBvcnQgb2YgdGhlIHJvb3QgY29tcGxleCB2aXJ0dWFsIFAyUCBicmlkZ2Uu
IEJ1dCBJIHdhbnQKCQkJICogdG8gYXZvaWQgcHV0dGluZyBhIG5vZGUgZm9yIGl0IGluIHRoZSB0
cmVlLCBzbyB0aGUgbnVtYmVycwoJCQkgKiBiZWxvdyBhcmUgYmFzaWNhbGx5IGRlLXN3aXp6bGVk
IG51bWJlcnMuCgkJCSAqIFRoZSByZWFsIHNsb3QgaXMgb24gaWRzZWwgMCwgc28gdGhlIHN3aXp6
bGluZyBpcyAxOjEKCQkJICovCgkJCWludGVycnVwdC1tYXAtbWFzayA9IDwwMDAwIDAgMCA3PjsK
CQkJaW50ZXJydXB0LW1hcCA9IDwKCQkJCTAwMDAgMCAwIDEgJlVJQzMgMTAgNCAvKiBzd2l6emxl
ZCBpbnQgQSAqLwoJCQkJMDAwMCAwIDAgMiAmVUlDMyAxMSA0IC8qIHN3aXp6bGVkIGludCBCICov
CgkJCQkwMDAwIDAgMCAzICZVSUMzIDEyIDQgLyogc3dpenpsZWQgaW50IEMgKi8KCQkJCTAwMDAg
MCAwIDQgJlVJQzMgMTMgNCAvKiBzd2l6emxlZCBpbnQgRCAqLz47CgkJfTsKCX07Cn07Cg==

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: text/plain;
	name="Kconfig"
Content-Transfer-Encoding: base64
Content-Description: Kconfig
Content-Disposition: attachment;
	filename="Kconfig"

IwojIEhhcmR3YXJlIFJhbmRvbSBOdW1iZXIgR2VuZXJhdG9yIChSTkcpIGNvbmZpZ3VyYXRpb24K
IwoKY29uZmlnIEhXX1JBTkRPTQoJdHJpc3RhdGUgIkhhcmR3YXJlIFJhbmRvbSBOdW1iZXIgR2Vu
ZXJhdG9yIENvcmUgc3VwcG9ydCIKCWRlZmF1bHQgbQoJLS0taGVscC0tLQoJICBIYXJkd2FyZSBS
YW5kb20gTnVtYmVyIEdlbmVyYXRvciBDb3JlIGluZnJhc3RydWN0dXJlLgoKCSAgVG8gY29tcGls
ZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCgkgIG1vZHVsZSB3
aWxsIGJlIGNhbGxlZCBybmctY29yZS4gIFRoaXMgcHJvdmlkZXMgYSBkZXZpY2UKCSAgdGhhdCdz
IHVzdWFsbHkgY2FsbGVkIC9kZXYvaHdfcmFuZG9tLCBhbmQgd2hpY2ggZXhwb3NlcyBvbmUKCSAg
b2YgcG9zc2libHkgc2V2ZXJhbCBoYXJkd2FyZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvcnMuCgoJ
ICBUaGVzZSBoYXJkd2FyZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvcnMgZG8gbm90IGZlZWQgZGly
ZWN0bHkKCSAgaW50byB0aGUga2VybmVsJ3MgcmFuZG9tIG51bWJlciBnZW5lcmF0b3IuICBUaGF0
IGlzIHVzdWFsbHkKCSAgaGFuZGxlZCBieSB0aGUgInJuZ2QiIGRhZW1vbi4gIERvY3VtZW50YXRp
b24vaHdfcmFuZG9tLnR4dAoJICBoYXMgbW9yZSBpbmZvcm1hdGlvbi4KCgkgIElmIHVuc3VyZSwg
c2F5IFkuCgpjb25maWcgSFdfUkFORE9NX0lOVEVMCgl0cmlzdGF0ZSAiSW50ZWwgSFcgUmFuZG9t
IE51bWJlciBHZW5lcmF0b3Igc3VwcG9ydCIKCWRlcGVuZHMgb24gSFdfUkFORE9NICYmIChYODYg
fHwgSUE2NCkgJiYgUENJCglkZWZhdWx0IEhXX1JBTkRPTQoJLS0taGVscC0tLQoJICBUaGlzIGRy
aXZlciBwcm92aWRlcyBrZXJuZWwtc2lkZSBzdXBwb3J0IGZvciB0aGUgUmFuZG9tIE51bWJlcgoJ
ICBHZW5lcmF0b3IgaGFyZHdhcmUgZm91bmQgb24gSW50ZWwgaTh4eC1iYXNlZCBtb3RoZXJib2Fy
ZHMuCgoJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJl
OiB0aGUKCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGludGVsLXJuZy4KCgkgIElmIHVuc3VyZSwg
c2F5IFkuCgpjb25maWcgSFdfUkFORE9NX0FNRAoJdHJpc3RhdGUgIkFNRCBIVyBSYW5kb20gTnVt
YmVyIEdlbmVyYXRvciBzdXBwb3J0IgoJZGVwZW5kcyBvbiBIV19SQU5ET00gJiYgWDg2ICYmIFBD
SQoJZGVmYXVsdCBIV19SQU5ET00KCS0tLWhlbHAtLS0KCSAgVGhpcyBkcml2ZXIgcHJvdmlkZXMg
a2VybmVsLXNpZGUgc3VwcG9ydCBmb3IgdGhlIFJhbmRvbSBOdW1iZXIKCSAgR2VuZXJhdG9yIGhh
cmR3YXJlIGZvdW5kIG9uIEFNRCA3NngtYmFzZWQgbW90aGVyYm9hcmRzLgoKCSAgVG8gY29tcGls
ZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCgkgIG1vZHVsZSB3
aWxsIGJlIGNhbGxlZCBhbWQtcm5nLgoKCSAgSWYgdW5zdXJlLCBzYXkgWS4KCmNvbmZpZyBIV19S
QU5ET01fR0VPREUKCXRyaXN0YXRlICJBTUQgR2VvZGUgSFcgUmFuZG9tIE51bWJlciBHZW5lcmF0
b3Igc3VwcG9ydCIKCWRlcGVuZHMgb24gSFdfUkFORE9NICYmIFg4Nl8zMiAmJiBQQ0kKCWRlZmF1
bHQgSFdfUkFORE9NCgktLS1oZWxwLS0tCgkgIFRoaXMgZHJpdmVyIHByb3ZpZGVzIGtlcm5lbC1z
aWRlIHN1cHBvcnQgZm9yIHRoZSBSYW5kb20gTnVtYmVyCgkgIEdlbmVyYXRvciBoYXJkd2FyZSBm
b3VuZCBvbiB0aGUgQU1EIEdlb2RlIExYLgoKCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBh
IG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCgkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBnZW9k
ZS1ybmcuCgoJICBJZiB1bnN1cmUsIHNheSBZLgoKY29uZmlnIEhXX1JBTkRPTV9WSUEKCXRyaXN0
YXRlICJWSUEgSFcgUmFuZG9tIE51bWJlciBHZW5lcmF0b3Igc3VwcG9ydCIKCWRlcGVuZHMgb24g
SFdfUkFORE9NICYmIFg4Nl8zMgoJZGVmYXVsdCBIV19SQU5ET00KCS0tLWhlbHAtLS0KCSAgVGhp
cyBkcml2ZXIgcHJvdmlkZXMga2VybmVsLXNpZGUgc3VwcG9ydCBmb3IgdGhlIFJhbmRvbSBOdW1i
ZXIKCSAgR2VuZXJhdG9yIGhhcmR3YXJlIGZvdW5kIG9uIFZJQSBiYXNlZCBtb3RoZXJib2FyZHMu
CgoJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0
aGUKCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHZpYS1ybmcuCgoJICBJZiB1bnN1cmUsIHNheSBZ
LgoKY29uZmlnIEhXX1JBTkRPTV9JWFA0WFgKCXRyaXN0YXRlICJJbnRlbCBJWFA0eHggTlBVIEhX
IFJhbmRvbSBOdW1iZXIgR2VuZXJhdG9yIHN1cHBvcnQiCglkZXBlbmRzIG9uIEhXX1JBTkRPTSAm
JiBBUkNIX0lYUDRYWAoJZGVmYXVsdCBIV19SQU5ET00KCS0tLWhlbHAtLS0KCSAgVGhpcyBkcml2
ZXIgcHJvdmlkZXMga2VybmVsLXNpZGUgc3VwcG9ydCBmb3IgdGhlIFJhbmRvbQoJICBOdW1iZXIg
R2VuZXJhdG9yIGhhcmR3YXJlIGZvdW5kIG9uIHRoZSBJbnRlbCBJWFA0eHggTlBVLgoKCSAgVG8g
Y29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCgkgIG1v
ZHVsZSB3aWxsIGJlIGNhbGxlZCBpeHA0eHgtcm5nLgoKCSAgSWYgdW5zdXJlLCBzYXkgWS4KCmNv
bmZpZyBIV19SQU5ET01fT01BUAoJdHJpc3RhdGUgIk9NQVAgUmFuZG9tIE51bWJlciBHZW5lcmF0
b3Igc3VwcG9ydCIKCWRlcGVuZHMgb24gSFdfUkFORE9NICYmIChBUkNIX09NQVAxNlhYIHx8IEFS
Q0hfT01BUDI0WFgpCglkZWZhdWx0IEhXX1JBTkRPTQogCS0tLWhlbHAtLS0KIAkgIFRoaXMgZHJp
dmVyIHByb3ZpZGVzIGtlcm5lbC1zaWRlIHN1cHBvcnQgZm9yIHRoZSBSYW5kb20gTnVtYmVyCgkg
IEdlbmVyYXRvciBoYXJkd2FyZSBmb3VuZCBvbiBPTUFQMTZ4eCBhbmQgT01BUDI0eHggbXVsdGlt
ZWRpYQoJICBwcm9jZXNzb3JzLgoKCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVs
ZSwgY2hvb3NlIE0gaGVyZTogdGhlCgkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBvbWFwLXJuZy4K
CiAJICBJZiB1bnN1cmUsIHNheSBZLgoKY29uZmlnIEhXX1JBTkRPTV9QQVNFTUkKCXRyaXN0YXRl
ICJQQSBTZW1pIEhXIFJhbmRvbSBOdW1iZXIgR2VuZXJhdG9yIHN1cHBvcnQiCglkZXBlbmRzIG9u
IEhXX1JBTkRPTSAmJiBQUENfUEFTRU1JCglkZWZhdWx0IEhXX1JBTkRPTQoJLS0taGVscC0tLQoJ
ICBUaGlzIGRyaXZlciBwcm92aWRlcyBrZXJuZWwtc2lkZSBzdXBwb3J0IGZvciB0aGUgUmFuZG9t
IE51bWJlcgoJICBHZW5lcmF0b3IgaGFyZHdhcmUgZm91bmQgb24gUEEgU2VtaSBQV1JmaWNpZW50
IFNvQ3MuCgoJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBo
ZXJlOiB0aGUKCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHBhc2VtaS1ybmcuCgoJICBJZiB1bnN1
cmUsIHNheSBZLgoKY29uZmlnIEhXX1JBTkRPTV9UUk5HNHh4Cgl0cmlzdGF0ZSAiQU1DQyA0eHgg
VFJORyBUcnVlIFJhbmRvbSBOdW1iZXIgR2VuZXJhdG9yIHN1cHBvcnQiCglkZXBlbmRzIG9uIEhX
X1JBTkRPTSAmJiBQUEMKCWRlZmF1bHQgSFdfUkFORE9NCgktLS1oZWxwLS0tCgkgIFRoaXMgZHJp
dmVyIHByb3ZpZGVzIGtlcm5lbC1zaWRlIHN1cHBvcnQgZm9yIHRoZSBSYW5kb20gTnVtYmVyCgkg
IEdlbmVyYXRvciBoYXJkd2FyZSBmb3VuZCBvbiBQQSBTZW1pIFBXUmZpY2llbnQgU29Dcy4KCgkg
IFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQoJ
ICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgcGFzZW1pLXJuZy4KCgkgIElmIHVuc3VyZSwgc2F5IFku

------_=_NextPart_001_01C9B358.CF7555FA
Content-Type: text/plain;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

IwojIE1ha2VmaWxlIGZvciBIVyBSYW5kb20gTnVtYmVyIEdlbmVyYXRvciAoUk5HKSBkZXZpY2Ug
ZHJpdmVycy4KIwoKb2JqLSQoQ09ORklHX0hXX1JBTkRPTSkgKz0gcm5nLWNvcmUubwpybmctY29y
ZS15IDo9IGNvcmUubwpvYmotJChDT05GSUdfSFdfUkFORE9NX0lOVEVMKSArPSBpbnRlbC1ybmcu
bwpvYmotJChDT05GSUdfSFdfUkFORE9NX0FNRCkgKz0gYW1kLXJuZy5vCm9iai0kKENPTkZJR19I
V19SQU5ET01fR0VPREUpICs9IGdlb2RlLXJuZy5vCm9iai0kKENPTkZJR19IV19SQU5ET01fVklB
KSArPSB2aWEtcm5nLm8Kb2JqLSQoQ09ORklHX0hXX1JBTkRPTV9JWFA0WFgpICs9IGl4cDR4eC1y
bmcubwpvYmotJChDT05GSUdfSFdfUkFORE9NX09NQVApICs9IG9tYXAtcm5nLm8Kb2JqLSQoQ09O
RklHX0hXX1JBTkRPTV9QQVNFTUkpICs9IHBhc2VtaS1ybmcubwpvYmotJChDT05GSUdfSFdfUkFO
RE9NX1RSTkc0eHgpICs9IHRybmc0eHgubwo=

------_=_NextPart_001_01C9B358.CF7555FA--
