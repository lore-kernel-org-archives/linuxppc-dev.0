Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F212667A84
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 12:13:15 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
In-Reply-To: <42282C83.9040707@jp.fujitsu.com>
References: <4226FF62.30007@jp.fujitsu.com>
	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>
	<42272B69.8000303@ybb.ne.jp> <20050303101146.A8869@cox.net>
	<42282C83.9040707@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 18:34:28 -0600
Message-Id: <1109982868.1479.22.camel@jdub.homelinux.org>
Mime-Version: 1.0
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

On Fri, 2005-03-04 at 18:38 +0900, Takeharu KATO wrote:

Hi Takeharu,

Some comments below.  Looks good overall.

> 
> --- linux-2.6.11/drivers/char/watchdog/Kconfig	2005-03-04 17:14:57.687966296 +0900
> +++ linux-2.6.11-booke-wdt/drivers/char/watchdog/Kconfig	2005-03-04 13:21:32.000000000 +0900
> @@ -346,6 +346,13 @@ config 8xx_WDT
>   	tristate "MPC8xx Watchdog Timer"
>   	depends on WATCHDOG && 8xx
> 
> +config BOOKE_WDT
> +    bool "Book E(PowerPC 4xx/e500) Watchdog Timer"
> +    depends on WATCHDOG && ( 4xx || E500 )

This is slightly wrong.  Not all 4xx processors are BOOKE.  403 and 405
aren't to be specific.  But it's not really that big of a deal I guess.

> +
> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> +static int nowayout = 1;
> +#else
> +static int nowayout = 0;
> +#endif

Couldn't you just use the #ifdef in the release function and not
"disable" the watchdog?  It would save a global variable at least.

> + * Internal linkage functions
> + */
> +static __inline__ void __booke_wdt_setup_val(int period,int reset);
> +static __inline__ void __booke_wdt_enable(void);
> +static __inline__ void __booke_wdt_disable(void);
> +static __inline__ int  __booke_wdt_is_enabled(void);
> +static __inline__ void __booke_wdt_clear_int_stat(void);
> +static __inline__ void __booke_wdt_set_timeout(int t);
> +static __inline__ void booke_wdt_init_device(void);
> +static __inline__ int  booke_wdt_is_enabled(void);
> +static __inline__ int  booke_wdt_start(void);
> +static __inline__ int  booke_wdt_stop(void);
> +static __inline__ int  booke_wdt_ping(void);
> +static __inline__ int  booke_wdt_set_timeout(int t);
> +static __inline__ int  booke_wdt_get_status(int *status);
> +static ssize_t booke_wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos);
> +static int booke_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,unsigned long arg);
> +static int booke_wdt_open(struct inode *inode, struct file *file);
> +static int booke_wdt_release(struct inode *inode, struct file *file);
> +static int booke_wdt_notify_sys(struct notifier_block *this, unsigned long code,void *unused);
> +static int __init booke_wdt_init(void);
> +static void __exit booke_wdt_exit(void);

If you order these in the right way, you don't need to declare them in
advance.

> +/**
> + *      __booke_wdt_enable
> + *      Enable Watchdog
> + */
> +static __inline__ void
> +__booke_wdt_enable(void)
> +{
> +  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
> +}
> +/**
> + *      __booke_wdt_disable
> + *      Disable Watchdog
> + */
> +static __inline__ void
> +__booke_wdt_disable(void)
> +{
> +  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
> +}

These two functions are somewhat misleading.  On 4xx the timer is
essentially always enabled.  The bit you are setting and clearing here
is just to enable the exception after the expiration of the 2nd WP.  The
reason I bring this up is because if you ever set TCR[WRC] to something
non-zero and this bit is off, the processor will just be reset after 3
watchdog periods.  In other words, if TCR[WRC] is ever non-zero there is
no such thing as disabling the timer.  You will always need to do the
ping to keep the processor from resetting.

> +/**
> + *    booke_wdt_stop:
> + *
> + *    Stop the watchdog driver.
> + */
> +static __inline__ int
> +booke_wdt_stop (void)
> +{
> +  __booke_wdt_disable();
> +  return 0;
> +}

This is effectively "stop getting the interrupt" on 4xx for the reasons
I said above.

> +static void
> +booke_wdt_init_device(void)
> +{
> +        /* Hardware WDT provided by the processor.
> +     * So, we set firmware version as processor version number.
> +     */
> +    ident.firmware_version=mfspr(PVR);
> +    __booke_wdt_setup_val(WDT_WP,WDT_RESET_NONE);
> +}

Since you're using WDT_RESET_NONE, I think what you have here should
work.  

> +/*
> + *  Reset type
> + */
> +#define WDT_RESET_NONE     0
> +#define WDT_RESET_CORE     1
> +#define WDT_RESET_CHIP     2
> +#define WDT_RESET_SYS      3
> +/*
> + *   Bit positions in  TCR register on PPC4xx/e500 series.
> + */
> +#define WDT_TCR_WP_BIT     1   /*  WP  bit in TCR (bit[0..1])   */
> +#define WDT_TCR_WRC_BIT    3   /*  WRC bit in TCR (bit[2..3])   */
> +#define WDT_TCR_WIE_BIT    4   /*  WIE bit in TCR (bit[4])      */
> +/*
> + *  TCR[WP] relevant definitions
> + */
> +#define WDT_TCR_WP_SHIFT       (31 - WDT_TCR_WP_BIT)
> +#define WDT_TCR_WRC_SHIFT      (31 - WDT_TCR_WRC_BIT)
> +#define WDT_TCR_WIE_SHIFT      (31 - WDT_TCR_WIE_BIT)
> +#define WDT_TCR_WDT_ENABLE     (1<<WDT_TCR_WIE_SHIFT)
> +/*  MASK value to obatain TCR[WP]  */
> +#define WDT_TCR_WP_MASK        (3<<(WDT_TCR_WP_SHIFT))
> +
> +/*  Watchdog timer periods can be set on PPC 4xx cpus. */
> +#if defined(CONFIG_4xx)
> +/*
> + *  For PowerPC 4xx
> + */
> +#define WDT_WP0               0
> +#define WDT_WP1               1
> +#define WDT_WP2               2
> +#define WDT_WP3               3
> +#else
> +#if defined(CONFIG_E500)
> +/*
> + *  For e500 CPU
> + *  Actually, e500 can arbitrary periods can be set,
> + *  But this driver uses fix period value as same as PPC440
> + *  on purpose for simplicity.
> + *  Following values split into WP and WP_EXT parts in booke_wdt.c.
> + */
> +#define WDT_WP0               21
> +#define WDT_WP1               25
> +#define WDT_WP2               29
> +#define WDT_WP3               33
> +#define WDT_TCR_WP_BITMSK     0x3  /*  2bit length  */
> +#define WDT_TCR_WPEXT_BITMSK  0xf  /*  4bit length  */
> +#define WDT_TCR_WPEXT_SHIFT  17
> +#else
> +#error "Book E WDT detects invalid configuration(Unknown CPU)"
> +#endif  /*  CONFIG_E500  */
> +#endif  /*  CONFIG_4xx   */
> +/*
> + *  WP relevant values used in our driver.
> + *  Note:WDT period must be more than HZ(Timer ticks)
> + */
> +#define WDT_WP                 WDT_WP3

Most of this is in include/asm-ppc/reg_booke.h.  Could you use that
instead of redefining most of it?

> +/*
> + *  output messages
> + */
> +#define __BOOKE_WDT_MSG "BookE-WDT : "
> +#define booke_mkmsg(str) __BOOKE_WDT_MSG str
> +#define booke_wdt_info(fmt,arg...) \
> +    printk(KERN_INFO __BOOKE_WDT_MSG fmt,##arg)
> +#define booke_wdt_note(fmt,arg...) \
> +    printk(KERN_NOTICE __BOOKE_WDT_MSG fmt,##arg)
> +#define booke_wdt_err(fmt,arg...) \
> +    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
> +#define booke_wdt_crit(fmt,arg...) \
> +    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
> +#if defined(BOOKE_WDT_DEBUG)
> +#define booke_wdt_dbg(fmt,arg...) \
> +    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
> +#else
> +#define booke_wdt_dbg(fmt,arg...) \
> +        do{}while(0)
> +#endif  /*  WDT_DEBUG  */

In include/linux/device.h there are dev_printk and dev_dbg macros that
do pretty much the same thing.  Could you use those instead?

Overall I think you have a good heartbeat style driver.  Just watch out
if you ever add an ioctl to set the reset type to something other than
none ;).

josh
