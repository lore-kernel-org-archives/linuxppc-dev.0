Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C8A4867A76
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:02:53 +1100 (EST)
In-Reply-To: <42282C83.9040707@jp.fujitsu.com>
References: <42282C83.9040707@jp.fujitsu.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <baf2848b8e77015677749f9c4b90f73a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 10:02:40 -0600
To: "Takeharu KATO" <kato.takeharu@jp.fujitsu.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt,

Do you think this really needs a config option?  Should it not be =20
sufficient that if you enable watchdog you get this functionality on =20
4xx/e500?

- kumar

On Mar 4, 2005, at 3:38 AM, Takeharu KATO wrote:

> Matt and Kurmar:
>
> I post the device driver part with this mail.
>
> This is the last part of this driver.
>
> Please apply.
>
> Regards,
>
> Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
>
> --- linux-2.6.11/drivers/char/watchdog/Kconfig=A0 2005-03-04 =20
> 17:14:57.687966296 +0900
>  +++ linux-2.6.11-booke-wdt/drivers/char/watchdog/Kconfig=A0=A0=A0=A0=A0=
=A0=A0 =20
> 2005-03-04 13:21:32.000000000 +0900
>  @@ -346,6 +346,13 @@ config 8xx_WDT
>  =A0 =A0=A0=A0=A0=A0 tristate "MPC8xx Watchdog Timer"
>  =A0 =A0=A0=A0=A0=A0 depends on WATCHDOG && 8xx
>
> +config BOOKE_WDT
>  +=A0=A0=A0 bool "Book E(PowerPC 4xx/e500) Watchdog Timer"
>  +=A0=A0=A0 depends on WATCHDOG && ( 4xx || E500 )
>  +=A0=A0=A0 ---help---
>  +=A0=A0=A0=A0=A0 This is the driver for the watchdog timers on
>  +=A0=A0=A0=A0=A0 PowerPC 4xx and PowerPC e500.
>  +
>  =A0 # MIPS Architecture
>
> =A0 config INDYDOG
>  --- linux-2.6.11/drivers/char/watchdog/Makefile 2005-03-04 =20
> 17:15:30.582965496 +0900
>  +++ linux-2.6.11-booke-wdt/drivers/char/watchdog/Makefile=A0=A0=A0=A0=A0=
=A0 =20
> 2005-03-04 13:21:32.000000000 +0900
>  @@ -39,3 +39,4 @@ obj-$(CONFIG_USBPCWATCHDOG) +=3D pcwd_usb.
>  =A0 obj-$(CONFIG_IXP4XX_WATCHDOG) +=3D ixp4xx_wdt.o
>  =A0 obj-$(CONFIG_IXP2000_WATCHDOG) +=3D ixp2000_wdt.o
> =A0 obj-$(CONFIG_8xx_WDT) +=3D mpc8xx_wdt.o
>  +obj-$(CONFIG_BOOKE_WDT) +=3D booke_wdt.o
>  --- linux-2.6.11/drivers/char/watchdog/booke_wdt.c=A0=A0=A0=A0=A0 =
1970-01-01 =20
> 09:00:00.000000000 +0900
>  +++ linux-2.6.11-booke-wdt/drivers/char/watchdog/booke_wdt.c=A0=A0=A0 =
=20
> 2005-03-04 16:38:58.000000000 +0900
>  @@ -0,0 +1,664 @@
>  +/*
>  + *=A0=A0=A0 Copyright (c) 2005 Fujitsu Limited
>  + *
>  + *=A0=A0=A0 Module name: booke_wdt.c
>  + *=A0=A0=A0 Author:=A0=A0=A0=A0=A0 Takeharu =
KATO<kato.takeharu@jp.fujitsu.com>
> + *
>  + *=A0=A0=A0 This program is free software; you can redistribute it =
and/or
>  + *=A0=A0=A0 modify it under the terms of the GNU General Public =
License
> + *=A0=A0=A0 as published by the Free Software Foundation; either =
version 2
>  + *=A0=A0=A0 of the License, or (at your option) any later version.
>  + *
>  + *=A0=A0=A0 Neither Takeharu KATO nor Fujitsu Ltd. admit liability =
nor =20
> provide
>  + *=A0=A0=A0 warranty for any of this software.
>  + *
>  + *=A0=A0=A0 Description:
>  + *=A0=A0=A0=A0 Watchdog driver for PowerPC Book E (PowerPC 4xx =
series =20
> processors and
>  + *=A0=A0=A0=A0 PowerPC e500 series processors).
>  + *=A0=A0=A0=A0 Derived from drivers/char/watchdog/wdt.c by Alan cox
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and=A0 =
drivers/char/watchdog/ppc405_wdt.c by Armin =20
> Kuster.
>  + *=A0=A0=A0=A0 PPC4xx WDT operation is driverd from Appendix of
>  + *=A0=A0=A0=A0 PowerPC Embedded Processors Application Note
>  + *=A0=A0=A0=A0=A0 ``PowerPC 40x Watch Dog Timer'' published from =
IBM.
>  + *=A0=A0=A0=A0 This driver is written according to ``PowerPC e500 =
Core =20
> Complex
>  + *=A0=A0=A0=A0 Reference Manual'' for e500 part.
>  + */
>  +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/miscdevice.h>
> +#include <linux/watchdog.h>
> +#include <linux/fs.h>
>  +#include <linux/reboot.h>
> +#include <linux/init.h>
>  +#include <linux/capability.h>
> +#include <linux/string.h>
> +#include <linux/ptrace.h>
> +#include <asm/reg.h>
>  +#include <asm/uaccess.h>
> +#include <asm/system.h>
> +#include "booke_wdt.h"
> +
>  +/* micro seconds per one milli-second(used to calculatewatchdog
> + * counter to be set). */
>  +#define US_PER_MS 1000
>  +/*=A0 Calculate watchdog count=A0=A0 */
>  +#define calculate_wdt_count(t) ((((unsigned long)(t))*HZ)/1000)
> +
>  +int wdt_enable=3D0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* WDT start =
on boot=A0 */
>  +int wdt_period=3DWDT_TIMO;=A0=A0=A0=A0=A0=A0 /* Time out in ms */
>  +
>  +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> +static int nowayout =3D 1;
>  +#else
>  +static int nowayout =3D 0;
>  +#endif
>  +
>  +/*
>  + * Global variables
>  + */
>  +static int wdt_count =3D 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* WDT =
intrrupt counter to be =20
> reloaded */
>  +static volatile int wdt_heartbeat_count =3D 0;=A0 /* WDT intrrupt =20=

> counter(compatible mode)*/
>  +static unsigned long driver_state; /* Driver status (see: =20
> booke_wdt.h) */
>  +/*
>  + *=A0 Identifier for this watchdog
>  + */
>  +static struct watchdog_info ident =3D {
>  +=A0 .options=3DWDIOF_SETTIMEOUT|WDIOF_KEEPALIVEPING|WDIOF_MAGICCLOSE,
> +=A0 .firmware_version =3D=A0=A0=A0 0, /*=A0 This is filled with PVR =
in =20
> initialization. */
>  +=A0 .identity =3D=A0=A0=A0=A0=A0=A0=A0 "Book E(PPC 4xx/e500) WDT",
>  +};
>  +
>  +/*
>  + *=A0 PowerPC Linux common exception handler
>  + */
>  +extern void _exception(int signr, struct pt_regs *regs, int code, =20=

> unsigned long addr);
>  +/*=A0 Panic notifier=A0 */
>  +extern struct notifier_block *panic_notifier_list;
> +/*
>  + *=A0 External linkage functions
>  + */
>  +void booke_wdt_heartbeat(void);
> +void booke_wdt_setup_options(char *cmd_line);
>  +void booke_wdt_exception(struct pt_regs *regs);
> +/*
>  + * Internal linkage functions
>  + */
>  +static __inline__ void __booke_wdt_setup_val(int period,int reset);
>  +static __inline__ void __booke_wdt_enable(void);
> +static __inline__ void __booke_wdt_disable(void);
> +static __inline__ int=A0 __booke_wdt_is_enabled(void);
> +static __inline__ void __booke_wdt_clear_int_stat(void);
> +static __inline__ void __booke_wdt_set_timeout(int t);
>  +static __inline__ void booke_wdt_init_device(void);
> +static __inline__ int=A0 booke_wdt_is_enabled(void);
> +static __inline__ int=A0 booke_wdt_start(void);
> +static __inline__ int=A0 booke_wdt_stop(void);
> +static __inline__ int=A0 booke_wdt_ping(void);
> +static __inline__ int=A0 booke_wdt_set_timeout(int t);
>  +static __inline__ int=A0 booke_wdt_get_status(int *status);
>  +static ssize_t booke_wdt_write(struct file *file, const char *buf, =20=

> size_t count, loff_t *ppos);
>  +static int booke_wdt_ioctl(struct inode *inode, struct file *file, =20=

> unsigned int cmd,unsigned long arg);
>  +static int booke_wdt_open(struct inode *inode, struct file *file);
> +static int booke_wdt_release(struct inode *inode, struct file *file);
> +static int booke_wdt_notify_sys(struct notifier_block *this, unsigned =
=20
> long code,void *unused);
>  +static int __init booke_wdt_init(void);
> +static void __exit booke_wdt_exit(void);
> +
>  +/*
>  + *=A0=A0=A0 Watchdog operations on PPC4xx/e500 MPU
>  + */
>  +
>  +/**
>  + *=A0=A0=A0=A0=A0 __booke_wdt_setup_val
> + *=A0=A0=A0=A0=A0 Enable Watchdog, sets up passed in values for =
TCR[WP],
>  + *=A0=A0=A0=A0=A0 TCR[WRC]
>  + *
>  + *=A0=A0=A0 @period:=A0=A0=A0 Input Watchdog Period - TCR[WP]
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =
=3D 217 clocks
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 =3D=
 221 clocks
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 =3D=
 225 clocks
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3 =3D=
 229 clocks
> + *=A0=A0=A0=A0=A0 @reset:=A0=A0=A0=A0=A0=A0=A0=A0 Watchdog reset =
control - TCR[WRC]
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =
=3D No reset
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 =
=3D PPC Core reset only
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 =
=3D PPC Chip reset
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3 =
=3D System reset
>  + *=A0=A0=A0=A0 Note: The meaning of period number is differ PPC440GP =
from =20
> PPC440GX.
>  + */
>  +#if defined(CONFIG_4xx)
> +static __inline__ void
> +__booke_wdt_setup_val(int period,int reset)
>  +{
>  +=A0 unsigned long val;
>  +
>  +=A0 /*=A0 Set up TCR=A0 */
>  +=A0 =20
> =
val=3D((period)<<WDT_TCR_WP_SHIFT|(reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_=20=

> TCR);
> +=A0 /*=A0 Disable WDT=A0 */
>  +=A0 val &=3D ~(WDT_TCR_WDT_ENABLE);
> +
>  +=A0 mtspr(SPRN_TCR,val);
> +}
>  +#else
>  +/*=A0 e500=A0 */
>  +static __inline__ void
> +__booke_wdt_setup_val(int period,int reset)
>  +{
>  +=A0 unsigned long val;
>  +=A0 /*=A0 Set up TCR=A0 */
>  +
>  +=A0 val=3D(((period)&(WDT_TCR_WP_BITMSK)) << WDT_TCR_WP_SHIFT|
> +=A0=A0=A0=A0=A0=A0 ( ( (period) >> 2 )&(WDT_TCR_WPEXT_BITMSK)) << =20
> WDT_TCR_WPEXT_SHIFT|
> +=A0=A0=A0=A0=A0=A0 (reset)<<WDT_TCR_WRC_SHIFT)|mfspr(SPRN_TCR);
> +=A0 /*=A0 Disable WDT=A0 */
>  +=A0 val &=3D ~(WDT_TCR_WDT_ENABLE);
> +
>  +=A0 mtspr(SPRN_TCR,val);
> +}
>  +#endif=A0 /*=A0 CONFIG_E500 */
>  +/**
>  + *=A0=A0=A0=A0=A0 __booke_wdt_enable
> + *=A0=A0=A0=A0=A0 Enable Watchdog
>  + */
>  +static __inline__ void
> +__booke_wdt_enable(void)
> +{
>  +=A0 mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
> +}
>  +/**
>  + *=A0=A0=A0=A0=A0 __booke_wdt_disable
> + *=A0=A0=A0=A0=A0 Disable Watchdog
>  + */
>  +static __inline__ void
> +__booke_wdt_disable(void)
> +{
>  +=A0 mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
> +}
>  +/**
>  + *=A0=A0=A0=A0=A0 __booke_wdt_is_enabled
> + *=A0=A0=A0=A0=A0 Check whether Watchdog is enabled.
>  + */
>  +static __inline__ int
>  +__booke_wdt_is_enabled(void)
> +{
>  +=A0 return (mfspr(SPRN_TCR) & WDT_TCR_WDT_ENABLE);
> +}
>  +/**
>  + *=A0=A0=A0=A0=A0 __booke_wdt_clear_init_stat
> + *=A0=A0=A0=A0=A0 Clear interrupt status of watchdog to ping it.
>  + */
>  +static __inline__ void
> +__booke_wdt_clear_int_stat(void)
> +{
>  +=A0 mtspr(SPRN_TSR, (TSR_ENW|TSR_WIS));
> +}
>  +/**
>  + *=A0=A0=A0 __booke_wdt_set_timeout:
> + *=A0=A0=A0 @t:=A0=A0=A0 the new time out value that needs to be set.
>  + *
>  + *=A0=A0=A0 Set a new time out value for the watchdog device.
>  + *
>  + */
>  +static __inline__ void
> +__booke_wdt_set_timeout(int t)
>  +{
>  +=A0 wdt_count=3Dcalculate_wdt_count(t);
> +=A0 return;
>  +}
>  +
>  +/*
>  + * Driver specific functions
>  + */
>  +
>  +/**
>  + *=A0=A0 booke_wdt_setup_options
> + *=A0=A0 @cmd_line : a pointer to kernel command line.
> + *
>  + */
>  +void
>  +booke_wdt_setup_options(char *cmd_line)
>  +{
>  +/*
>  + * Look for wdt=3D option on command line
>  + */
>  +=A0 if (strstr(cmd_line, "wdt=3D")) {
>  +=A0=A0=A0 int valid_wdt =3D 0;
>  +=A0=A0=A0 char *p, *q;
> +
>  +=A0=A0=A0 for (q =3D cmd_line; (p =3D strstr(q, "wdt=3D")) !=3D 0;) =
{
> +=A0=A0=A0=A0=A0 q =3D p + 4;
> +=A0=A0=A0=A0=A0 if (p > cmd_line && p[-1] !=3D ' ')
>  +=A0=A0=A0 continue;
>  +=A0=A0=A0=A0=A0 wdt_period =3D simple_strtoul(q, &q, 0);
>  +=A0=A0=A0=A0=A0 valid_wdt =3D 1;
>  +=A0=A0=A0=A0=A0 ++q;
>  +=A0=A0=A0 }
>  +=A0=A0=A0 wdt_enable =3D valid_wdt;
>  +=A0 }
>  +=A0 return;
>  +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_heartbeat:
> + *=A0=A0=A0=A0=A0 Ping routine called from kernel.
>  + */
>  +void
>  +booke_wdt_heartbeat(void)
> +{
>  +=A0 /* Disable watchdog */
>  +=A0 __booke_wdt_disable();
> +
>  +=A0 /* Write a watchdog value */
>  +=A0 __booke_wdt_clear_int_stat();
> +
>  +=A0 if (!wdt_enable)
>  +=A0=A0=A0 goto out;
>  +
>  +=A0 if=A0 (wdt_heartbeat_count > 0)
>  +=A0=A0=A0 wdt_heartbeat_count--;
>  +=A0 else
>  +=A0=A0=A0 panic(booke_mkmsg("Initiating system reboot.\n"));
>  +
>  +=A0 /* Enable watchdog */
>  +=A0 __booke_wdt_enable();
> + out:
>  +=A0 /*=A0 Reset count=A0 */
>  +=A0 ppc_md.heartbeat_count =3D 0;
>  +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_exception:
> + *=A0=A0=A0=A0=A0 WatchDog Exception handler for PPC4xx/e500.
> + *=A0=A0=A0=A0=A0 @regs : A registers information.
>  + */
>  +void
>  +booke_wdt_exception(struct pt_regs *regs)
>  +{
>  +=A0 wdt_enable=3D0;
> +=A0 __booke_wdt_disable();
> +=A0 printk("WDT Exception at PC: %lx, MSR: %lx, vector=3D%lx=A0=A0=A0 =
%s\n",
>  +=A0=A0=A0=A0=A0=A0=A0 regs->nip, regs->msr, regs->trap, =
print_tainted());
> +=A0 panic(booke_mkmsg("Initiating system reboot.\n"));
>  +}
>  +/*
>  + *=A0=A0=A0 Driver Logic functions
> + */
>  +static __inline__ int
>  +booke_wdt_is_enabled(void)
> +{
>  +=A0 return=A0 __booke_wdt_is_enabled();
> +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_start:
> + *
>  + *=A0=A0=A0 Start the watchdog driver.
>  + */
>  +static __inline__ int
>  +booke_wdt_start(void)
> +{
>  +=A0 __booke_wdt_enable();
> +=A0 return 0;
>  +}
>  +
>  +/**
>  + *=A0=A0=A0 booke_wdt_stop:
> + *
>  + *=A0=A0=A0 Stop the watchdog driver.
>  + */
>  +static __inline__ int
>  +booke_wdt_stop (void)
>  +{
>  +=A0 __booke_wdt_disable();
> +=A0 return 0;
>  +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_ping:
> + *
>  + *=A0=A0=A0 Reload counter one with the watchdog heartbeat. We don't =
=20
> bother reloading
>  + *=A0=A0=A0 the cascade counter.
>  + */
>  +static __inline__ int
>  +booke_wdt_ping(void)
> +{
>  +=A0 /* Disable watchdog */
>  +=A0 __booke_wdt_disable();
> +=A0 /* Write a watchdog value */
>  +=A0 __booke_wdt_clear_int_stat();
> +=A0 /*=A0 Reset count=A0 */
>  +=A0 wdt_heartbeat_count=3Dwdt_count;
> +=A0 /* Enable watchdog */
>  +=A0 __booke_wdt_enable();
> +
>  +=A0 return 0;
>  +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_set_timeout:
> + *=A0=A0=A0 @t:=A0=A0=A0=A0=A0=A0=A0 the new timeout value that needs =
to be set.
>  + *
>  + *=A0=A0=A0 Set a new time out value for the watchdog device.
>  + *=A0=A0=A0=A0=A0 If the heartbeat value is incorrect we keep the =
old value
>  + *=A0=A0=A0=A0=A0 and return -EINVAL. If successfull we return 0.
>  + */
>  +static __inline__ int
>  +booke_wdt_set_timeout(int t)
>  +{
>  +=A0 if ((t < WDT_HEARTBEAT_MIN) || (t > WDT_HEARTBEAT_MAX))
> +=A0=A0=A0 return -EINVAL;
>  +
>  +=A0 wdt_period =3D t;
>  +=A0 __booke_wdt_set_timeout(t);
> +=A0 wdt_heartbeat_count=3Dwdt_count;
> +=A0 booke_wdt_dbg("The WDT counter set %d.\n",wdt_count);
> +
>  +=A0 return 0;
>  +}
>  +
>  +/**
>  + *=A0=A0=A0 booke_wdt_get_status:
> + *=A0=A0=A0 @status: the new status.
>  + *
>  + *=A0=A0=A0 Return the enable/disable card status.
>  + */
>  +static __inline__ int
>  +booke_wdt_get_status(int *status)
>  +{
>  +=A0 if (wdt_enable)
>  +=A0=A0=A0=A0=A0 *status =3D WDIOS_ENABLECARD;
> +=A0 else
>  +=A0=A0=A0=A0=A0 *status =3D WDIOS_DISABLECARD;
> +
>  +=A0 return 0;
>  +}
>  +/*
>  + *=A0=A0=A0 Kernel Interfaces
>  + */
>  +/**
>  + *=A0=A0=A0 booke_wdt_init_device:
> + *
>  + *=A0=A0=A0=A0=A0 Initilize PowerPC 4xx/e500 family Watch Dog =
facility.
>  + */
>  +static void
>  +booke_wdt_init_device(void)
> +{
>  +=A0=A0=A0=A0=A0=A0=A0 /* Hardware WDT provided by the processor.
>  +=A0=A0=A0=A0 * So, we set firmware version as processor version =
number.
>  +=A0=A0=A0=A0 */
>  +=A0=A0=A0 ident.firmware_version=3Dmfspr(PVR);
> +=A0=A0=A0 __booke_wdt_setup_val(WDT_WP,WDT_RESET_NONE);
> +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_write:
> + *=A0=A0=A0 @file: file handle to the watchdog
>  + *=A0=A0=A0 @buf: buffer to write (unused as data does not matter =
here
>  + *=A0=A0=A0 @count: count of bytes
>  + *=A0=A0=A0 @ppos: pointer to the position to write. No seeks =
allowed
>  + *
>  + *=A0=A0=A0 A write to a watchdog device is defined as a keepalive =
signal. =20
> Any
>  + *=A0=A0=A0 write of data will do, as we we don't define content =
meaning =20
> expept
>  + *=A0=A0=A0=A0=A0 'V' character. It is performed as a sign to set =20=

> stop-on-close mode.
>  + */
>  +
>  +static ssize_t
>  +booke_wdt_write(struct file *file, const char *buf, size_t count, =20=

> loff_t *ppos)
>  +{
>  +=A0 size_t i;
>  +
>  +=A0=A0=A0 if (!nowayout) {
>  +=A0=A0=A0=A0=A0 /* In case it was set long ago */
>  +=A0=A0=A0=A0=A0 clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
> +
>  +=A0=A0=A0=A0=A0 for (i =3D 0; i < count; i++) {
> +=A0=A0=A0 char c;
>  +
>  +=A0=A0=A0 if (get_user(c, buf + i))
>  +=A0=A0=A0=A0=A0 return -EFAULT;
>  +
>  +=A0=A0=A0 if (c =3D=3D 'V') {
>  +=A0=A0=A0=A0=A0 set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
> +=A0=A0=A0 }
>  +=A0=A0=A0=A0=A0 }
>  +=A0=A0=A0 }
>  +=A0=A0=A0 booke_wdt_ping();
> +
>  +=A0 return count;
>  +}
>  +
>  +/**
>  + *=A0=A0=A0 booke_wdt_ioctl:
> + *=A0=A0=A0 @inode: inode of the device
>  + *=A0=A0=A0 @file: file handle to the device
>  + *=A0=A0=A0 @cmd: watchdog command
>  + *=A0=A0=A0 @arg: argument pointer
>  + *
>  + */
>  +static int
>  +booke_wdt_ioctl(struct inode *inode, struct file *file, unsigned int =
=20
> cmd,
>  +=A0=A0=A0 unsigned long arg)
>  +{
>  +=A0=A0=A0 int new_timeout;
>  +=A0=A0=A0 int status;
>  +
>  +=A0=A0=A0 if (!capable(CAP_SYS_ADMIN))
> +=A0=A0=A0=A0=A0=A0=A0 return -EPERM;=A0 /*=A0 It may be too strict =
manner.=A0 */
>  +=A0=A0=A0 switch(cmd)
>  +=A0=A0=A0 {
>  +=A0=A0=A0 default:
>  +=A0=A0=A0=A0=A0=A0=A0 return -ENOIOCTLCMD;
> +=A0=A0=A0 case WDIOC_GETSUPPORT:
> +=A0=A0=A0=A0=A0=A0=A0 if (copy_to_user((struct watchdog_info *)arg, =
&ident, =20
> sizeof(struct watchdog_info)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
>  +=A0=A0=A0=A0=A0=A0=A0 else
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>  +=A0=A0=A0 case WDIOC_GETSTATUS:
> +=A0=A0=A0=A0=A0=A0=A0 booke_wdt_get_status(&status);
> +=A0=A0=A0=A0=A0=A0=A0 return put_user(status,(int *)arg);
>  +=A0=A0=A0 case WDIOC_KEEPALIVE:
> +=A0=A0=A0=A0=A0=A0=A0 booke_wdt_ping();
> +=A0=A0=A0=A0=A0=A0=A0 break;
>  +=A0=A0=A0 case WDIOC_SETTIMEOUT:
> +=A0=A0=A0=A0=A0=A0=A0 if (get_user(new_timeout, (int *)arg))
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
>  +=A0=A0=A0=A0=A0=A0=A0 if (booke_wdt_set_timeout(new_timeout))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>  +=A0=A0=A0=A0=A0=A0=A0 booke_wdt_ping();
> +=A0=A0=A0=A0=A0=A0=A0 break;
>  +=A0=A0=A0 case WDIOC_GETTIMEOUT:
> +=A0=A0=A0=A0=A0=A0=A0 return put_user(wdt_period, (int *)arg);
>  +=A0=A0=A0 case WDIOC_SETOPTIONS:
> +=A0=A0=A0=A0=A0=A0=A0 if (get_user(status, (int *)arg))
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
>  +=A0=A0=A0=A0=A0=A0=A0 /*=A0 Return -EINVAL when the driver can not =
figure out
>  +=A0=A0=A0=A0=A0=A0=A0=A0 *=A0 what it should do. Unknown cases are =
just ignored.
>  +=A0=A0=A0=A0=A0=A0=A0=A0 */
>  +=A0=A0=A0=A0=A0=A0=A0 if ( (status & =
(WDIOS_DISABLECARD|WDIOS_ENABLECARD))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D =
(WDIOS_DISABLECARD|WDIOS_ENABLECARD) )
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>  +=A0=A0=A0=A0=A0=A0=A0 if (status & WDIOS_DISABLECARD) {
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wdt_enable =3D 0;
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 booke_wdt_stop();
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 booke_wdt_info("Watchdog timer is =
disabled\n");
>  +=A0=A0=A0=A0=A0=A0=A0 }
>  +=A0=A0=A0=A0=A0=A0=A0 if (status & WDIOS_ENABLECARD) {
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wdt_enable =3D 1;
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 booke_wdt_start();
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 booke_wdt_info("Watchdog timer is =
enabled\n");
>  +=A0=A0=A0=A0=A0=A0=A0 }
>  +=A0=A0=A0=A0=A0=A0=A0 break;
>  +=A0=A0=A0 }
>  +=A0=A0=A0 return 0;
>  +}
>  +/**
>  + *=A0=A0=A0 booke_wdt_open:
> + *=A0=A0=A0 @inode: inode of device
>  + *=A0=A0=A0 @file: file handle to device
>  + *
>  + *=A0=A0=A0 The watchdog device has been opened. The watchdog device =
is =20
> single
> + *=A0=A0=A0 open and start the WDT timer.
>  + */
>  +static int
>  +booke_wdt_open(struct inode *inode, struct file *file)
>  +{
>  +=A0=A0=A0 if (!capable(CAP_SYS_ADMIN))
> +=A0=A0=A0=A0=A0=A0=A0 return -EPERM;
>  +
>  +=A0=A0=A0 if (test_and_set_bit(WDT_STATE_OPEN, &driver_state))
> +=A0=A0=A0=A0=A0=A0=A0 return -EBUSY;
>  +=A0=A0=A0 /*
>  +=A0=A0=A0=A0 * Activate
>  +=A0=A0=A0=A0 */
>  +=A0=A0=A0 booke_wdt_start();
> +=A0=A0=A0 wdt_enable=3D1;
> +
>  +=A0=A0=A0 if (nowayout)
>  +=A0=A0=A0=A0=A0 set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
> +
>  +=A0=A0=A0 return 0;
>  +}
>  +
>  +/**
>  + *=A0=A0=A0 booke_wdt_release:
> + *=A0=A0=A0 @inode: inode to board
> + *=A0=A0=A0 @file: file handle to board
>  + *
>  + */
>  +static int
>  +booke_wdt_release(struct inode *inode, struct file *file)
>  +{
>  +=A0 if (test_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state)) {
>  +=A0=A0=A0=A0=A0 booke_wdt_note("WDT device is stopped.\n");
>  +=A0=A0=A0 booke_wdt_stop();
> +=A0=A0=A0 wdt_enable=3D0;
> +=A0 } else {
>  +=A0=A0=A0 if ( (booke_wdt_is_enabled()) && (!nowayout) ) {
>  +=A0=A0=A0=A0=A0 booke_wdt_note("WDT device may be closed =
unexpectedly.=A0 WDT =20
> will not stop!\n");
>  +=A0=A0=A0=A0=A0 booke_wdt_ping();
> +=A0=A0=A0 }
>  +=A0 }
>  +=A0 clear_bit(WDT_STATE_OPEN, &driver_state);
> +
>  +=A0 return 0;
>  +}
>  +/**
>  + *=A0=A0=A0 notify_sys:
>  + *=A0=A0=A0 @this: our notifier block
>  + *=A0=A0=A0 @code: the event being reported
> + *=A0=A0=A0 @unused: unused
>  + *=A0=A0=A0 Note: This function assume that the panic notifier is =
called =20
> with CODE=3D0
>  + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 (see panic function in =
kernel/panic.c).
> + */
>  +static int
>  +booke_wdt_notify_sys(struct notifier_block *this, unsigned long =
code,
>  +=A0=A0=A0 void *unused)
>  +{
>  +
>  +=A0=A0=A0 if (code !=3D SYS_POWER_OFF)=A0=A0 /* Turn the card off */
>  +=A0=A0=A0=A0=A0 booke_wdt_stop();
> +
>  +=A0=A0=A0 return NOTIFY_DONE;
> +}
>  +
>  +static struct file_operations booke_wdt_fops =3D {
>  +=A0=A0=A0 .owner=A0=A0=A0=A0=A0=A0=A0 =3D THIS_MODULE,
> +=A0=A0=A0 .llseek=A0=A0=A0=A0=A0=A0=A0 =3D no_llseek,
>  +=A0=A0=A0 .write=A0=A0=A0=A0=A0=A0=A0 =3D booke_wdt_write,
> +=A0=A0=A0 .ioctl=A0=A0=A0=A0=A0=A0=A0 =3D booke_wdt_ioctl,
> +=A0=A0=A0 .open=A0=A0=A0=A0=A0=A0=A0 =3D booke_wdt_open,
> +=A0=A0=A0 .release=A0=A0=A0 =3D booke_wdt_release,
> +};
>  +
>  +static struct miscdevice booke_wdt_miscdev =3D {
>  +=A0=A0=A0 .minor=A0=A0=A0 =3D WATCHDOG_MINOR,
> +=A0=A0=A0 .name=A0=A0=A0 =3D "watchdog",
>  +=A0=A0=A0 .fops=A0=A0=A0 =3D &booke_wdt_fops,
> +};
>  +
>  +/*
>  + *=A0=A0=A0 The WDT card needs to know about shutdowns in order to
>  + *=A0=A0=A0 turn WDT off.
>  + */
>  +
>  +static struct notifier_block booke_wdt_notifier =3D {
>  +=A0=A0=A0 .notifier_call =3D booke_wdt_notify_sys,
> +};
>  +
>  +/**
>  + *=A0=A0=A0 cleanup_module:
> + *
>  + *=A0=A0=A0 If your watchdog is set to continue ticking on close and =
you =20
> unload
>  + *=A0=A0=A0 it, well it keeps ticking.=A0 You just have to load a =
new
>  + *=A0=A0=A0 module in 60 seconds or reboot.
>  + *=A0=A0=A0=A0=A0 This behavior(more over the comments as above) is =
borrowed =20
> from
>  + *=A0=A0=A0=A0=A0 Alan cox's driver.
>  + */
>  +
>  +static void __exit
>  +booke_wdt_exit(void)
> +{
>  +=A0=A0=A0 misc_deregister(&booke_wdt_miscdev);
> +=A0=A0=A0 unregister_reboot_notifier(&booke_wdt_notifier);
> +=A0=A0=A0 =20
> notifier_chain_unregister(&panic_notifier_list,&booke_wdt_notifier);
> +}
>  +
>  +/**
>  + *=A0=A0=A0=A0 booke_wdt_init:
> + *
>  + *=A0=A0=A0 Set up the WDT relevant timer facility.
>  + */
>  +
>  +static int __init
>  +booke_wdt_init(void)
> +{
>  +=A0=A0=A0 int ret;
>  +=A0=A0=A0 unsigned long flags;
>  +
>  +=A0=A0=A0 ret =3D register_reboot_notifier(&booke_wdt_notifier);
> +=A0=A0=A0 if(ret) {
>  +=A0=A0=A0=A0=A0 booke_wdt_err("Cannot register reboot notifier =
(err=3D%d)\n", =20
> ret);
>  +=A0=A0=A0=A0=A0 return ret;
> +=A0=A0=A0 }
>  +
>  +=A0=A0=A0 /* Register panic notifier=A0 */
>  +=A0=A0=A0 ret =3D =20
> notifier_chain_register(&panic_notifier_list,&booke_wdt_notifier);
> +=A0=A0=A0 if(ret) {
>  +=A0=A0=A0=A0=A0 booke_wdt_err("Cannot register panic notifier =
(err=3D%d)\n", =20
> ret);
>  +=A0=A0=A0=A0=A0 unregister_reboot_notifier(&booke_wdt_notifier);
> +=A0=A0=A0=A0=A0 return ret;
> +=A0=A0=A0 }
>  +
>  +=A0=A0=A0 ret =3D 0;
>  +=A0=A0=A0 booke_wdt_init_device();
> +=A0=A0=A0 /* Check that the heartbeat value is within it's range ; if =
not =20
> reset to the default */
>  +=A0=A0=A0 if (booke_wdt_set_timeout(wdt_period)) {
>  +=A0=A0=A0=A0=A0 if (wdt_period)
>  +=A0=A0=A0=A0=A0=A0=A0 booke_wdt_info("The heartbeat value must be %d =
< wdt_period =20
> < %d, using
> %d\n",WDT_HEARTBEAT_MIN,WDT_HEARTBEAT_MAX,WDT_TIMO);
> +=A0=A0=A0=A0=A0 booke_wdt_set_timeout(WDT_TIMO);
> +=A0=A0=A0 }
>  +
>  +=A0=A0=A0 local_irq_save(flags); /* Prevent timer interrupt */
>  +=A0=A0=A0 ppc_md.heartbeat_count =3D 0;
>  +=A0=A0=A0 ppc_md.heartbeat=3Dbooke_wdt_heartbeat;
> +=A0=A0=A0 local_irq_restore(flags);
> +
>  +=A0=A0=A0 booke_wdt_info("Book E(PPC 4xx/e500) Watchdog Driver. =
period=3D%d =20
> ms (nowayout=3D%d)\n",wdt_period,
>  nowayout);
>  +
>  +=A0=A0=A0 ret =3D misc_register(&booke_wdt_miscdev);
> +=A0=A0=A0 if (ret) {
>  +=A0=A0=A0=A0=A0 booke_wdt_err("Cannot register miscdev on minor=3D%d =
(err=3D%d)\n",
>  +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WATCHDOG_MINOR, ret);
>  +=A0=A0=A0=A0=A0=A0=A0 goto outmisc;
>  +=A0=A0=A0 }
>  +
>  +=A0=A0=A0 if (wdt_enable) {
>  +=A0=A0=A0=A0=A0 booke_wdt_info("WDT start on boot.\n");
>  +=A0=A0=A0=A0=A0 booke_wdt_start();
> +=A0=A0=A0 }
>  +out:
>  +=A0=A0=A0 return ret;
>  +outmisc:
>  +=A0=A0=A0 unregister_reboot_notifier(&booke_wdt_notifier);
> +=A0=A0=A0 local_irq_save(flags);
> +=A0=A0=A0 ppc_md.heartbeat=3DNULL;
> +=A0=A0=A0 ppc_md.heartbeat_count =3D 0;
>  +=A0=A0=A0 local_irq_restore(flags);
> +=A0=A0=A0 goto out;
>  +}
>  +
>  +device_initcall(booke_wdt_init);
> --- linux-2.6.11/drivers/char/watchdog/booke_wdt.h=A0=A0=A0=A0=A0 =
1970-01-01 =20
> 09:00:00.000000000 +0900
>  +++ linux-2.6.11-booke-wdt/drivers/char/watchdog/booke_wdt.h=A0=A0=A0 =
=20
> 2005-03-04 16:38:58.000000000 +0900
>  @@ -0,0 +1,125 @@
>  +/*
>  + *
>  + *=A0=A0=A0 Copyright (c) 2004 Fujitsu Limited
>  + *
>  + *=A0=A0=A0 Module name: booke_wdt.h
>  + *=A0=A0=A0 Author:=A0=A0=A0=A0=A0 Takeharu =
KATO<kato.takeharu@jp.fujitsu.com>
> + *=A0=A0=A0 Description:
>  + *=A0=A0=A0=A0=A0 Header file for PowerPC Book E(PPC 4xx/e500) =
watchdog driver.
>  + *
>  + *=A0=A0=A0 This program is free software; you can redistribute it =
and/or
>  + *=A0=A0=A0 modify it under the terms of the GNU General Public =
License
> + *=A0=A0=A0 as published by the Free Software Foundation; either =
version 2
>  + *=A0=A0=A0 of the License, or (at your option) any later version.
>  + *
>  + *=A0=A0=A0 Neither Takeharu KATO nor Fujitsu Ltd. admit liability =
nor =20
> provide
>  + *=A0=A0=A0 warranty for any of this software.
>  + *
>  + */
>  +#ifndef _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H
> +#define _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/ptrace.h>
> +#include <linux/watchdog.h>
> +
>  +/*
>  + *=A0 Driver state flags(bit position)
>  + */
>  +#define WDT_STATE_OPEN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 /* driver is opend=A0 */
>  +#define WDT_STATE_STOP_ON_CLOSE=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0 /* =
Stop with close is =20
> expected */
>  +/*
>  + * Configurations
> + */
>  +#define WDT_TIMO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 60000=A0=A0=A0 /* =
Default timeout =3D 60000 =20
> ms(1min) */
>  +#define WDT_HEARTBEAT_MIN=A0 100=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* =
Minimum timeout =3D 100 ms =20
> */
>  +#define WDT_HEARTBEAT_MAX=A0 600000=A0=A0=A0=A0=A0=A0 /* Maximum =
timeout =3D =20
> 600000ms(1hour) */
>  +#ifdef __KERNEL__
>  +//#define BOOKE_WDT_DEBUG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 /*=A0 Debug switch */
>  +/*
>  + *=A0 Reset type
> + */
>  +#define WDT_RESET_NONE=A0=A0=A0=A0 0
>  +#define WDT_RESET_CORE=A0=A0=A0=A0 1
>  +#define WDT_RESET_CHIP=A0=A0=A0=A0 2
>  +#define WDT_RESET_SYS=A0=A0=A0=A0=A0 3
>  +/*
>  + *=A0=A0 Bit positions in=A0 TCR register on PPC4xx/e500 series.
>  + */
>  +#define WDT_TCR_WP_BIT=A0=A0=A0=A0 1=A0=A0 /*=A0 WP=A0 bit in TCR =
(bit[0..1])=A0=A0 */
>  +#define WDT_TCR_WRC_BIT=A0=A0=A0 3=A0=A0 /*=A0 WRC bit in TCR =
(bit[2..3])=A0=A0 */
>  +#define WDT_TCR_WIE_BIT=A0=A0=A0 4=A0=A0 /*=A0 WIE bit in TCR =
(bit[4])=A0=A0=A0=A0=A0 */
>  +/*
>  + *=A0 TCR[WP] relevant definitions
>  + */
>  +#define WDT_TCR_WP_SHIFT=A0=A0=A0=A0=A0=A0 (31 - WDT_TCR_WP_BIT)
> +#define WDT_TCR_WRC_SHIFT=A0=A0=A0=A0=A0 (31 - WDT_TCR_WRC_BIT)
> +#define WDT_TCR_WIE_SHIFT=A0=A0=A0=A0=A0 (31 - WDT_TCR_WIE_BIT)
> +#define WDT_TCR_WDT_ENABLE=A0=A0=A0=A0 (1<<WDT_TCR_WIE_SHIFT)
> +/*=A0 MASK value to obatain TCR[WP]=A0 */
>  +#define WDT_TCR_WP_MASK=A0=A0=A0=A0=A0=A0=A0 (3<<(WDT_TCR_WP_SHIFT))
> +
>  +/*=A0 Watchdog timer periods can be set on PPC 4xx cpus. */
>  +#if defined(CONFIG_4xx)
> +/*
>  + *=A0 For PowerPC 4xx
>  + */
>  +#define WDT_WP0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
>  +#define WDT_WP1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
>  +#define WDT_WP2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
>  +#define WDT_WP3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
>  +#else
>  +#if defined(CONFIG_E500)
> +/*
>  + *=A0 For e500 CPU
>  + *=A0 Actually, e500 can arbitrary periods can be set,
>  + *=A0 But this driver uses fix period value as same as PPC440
>  + *=A0 on purpose for simplicity.
>  + *=A0 Following values split into WP and WP_EXT parts in =
booke_wdt.c.
>  + */
>  +#define WDT_WP0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 21
>  +#define WDT_WP1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25
>  +#define WDT_WP2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 29
>  +#define WDT_WP3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 33
>  +#define WDT_TCR_WP_BITMSK=A0=A0=A0=A0 0x3=A0 /*=A0 2bit length=A0 */
>  +#define WDT_TCR_WPEXT_BITMSK=A0 0xf=A0 /*=A0 4bit length=A0 */
>  +#define WDT_TCR_WPEXT_SHIFT=A0 17
>  +#else
>  +#error "Book E WDT detects invalid configuration(Unknown CPU)"
>  +#endif=A0 /*=A0 CONFIG_E500=A0 */
>  +#endif=A0 /*=A0 CONFIG_4xx=A0=A0 */
>  +/*
>  + *=A0 WP relevant values used in our driver.
>  + *=A0 Note:WDT period must be more than HZ(Timer ticks)
> + */
>  +#define WDT_WP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
WDT_WP3
>  +
>  +/*
>  + *=A0 IOCTL commands for comaptiblity for old driver
>  + */
>  +#define WDIOC_GETPERIOD=A0=A0=A0=A0=A0=A0=A0=A0 WDIOC_GETTIMEOUT
> +#define WDIOC_SETPERIOD=A0=A0=A0=A0=A0=A0=A0=A0 WDIOC_SETTIMEOUT
> +
>  +/*
>  + *=A0 output messages
>  + */
>  +#define __BOOKE_WDT_MSG "BookE-WDT : "
>  +#define booke_mkmsg(str) __BOOKE_WDT_MSG str
>  +#define booke_wdt_info(fmt,arg...) \
>  +=A0=A0=A0 printk(KERN_INFO __BOOKE_WDT_MSG fmt,##arg)
>  +#define booke_wdt_note(fmt,arg...) \
>  +=A0=A0=A0 printk(KERN_NOTICE __BOOKE_WDT_MSG fmt,##arg)
>  +#define booke_wdt_err(fmt,arg...) \
>  +=A0=A0=A0 printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
>  +#define booke_wdt_crit(fmt,arg...) \
>  +=A0=A0=A0 printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
>  +#if defined(BOOKE_WDT_DEBUG)
> +#define booke_wdt_dbg(fmt,arg...) \
>  +=A0=A0=A0 printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
>  +#else
>  +#define booke_wdt_dbg(fmt,arg...) \
>  +=A0=A0=A0=A0=A0=A0=A0 do{}while(0)
>  +#endif=A0 /*=A0 WDT_DEBUG=A0 */
>  +
>  +#endif=A0 /* __KERNEL__=A0 */
>  +#endif=A0 /*=A0 _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H=A0 */
>
> =20=
