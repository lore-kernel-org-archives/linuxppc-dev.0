Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D505767B52
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 00:58:48 +1000 (EST)
Date: Thu, 29 Jun 2006 09:58:39 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add support for the Freescale MPC8349E-mITX eval board
Message-Id: <20060629095839.55cb8e5f.kim.phillips@freescale.com>
In-Reply-To: <99F42AA0-3028-4C80-86C1-14A210C41229@kernel.crashing.org>
References: <20060628211317.7b21d085.kim.phillips@freescale.com>
	<99F42AA0-3028-4C80-86C1-14A210C41229@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2006 00:10:56 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jun 28, 2006, at 9:13 PM, Kim Phillips wrote:
> 
> > Add support for the Freescale MPC8349E-mITX eval board
> >
> > This is largely based on 8349 SYS code except that it uses the new  
> > rtc_class code in drivers/rtc instead of explicitly specifying the  
> > rtc chip.  SATA is untested, as this is work in progress.
> >

I forgot to mention the 5-port switch is also unsupported at this time..

<snip>
> > diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/ 
> > platforms/83xx/misc.c
> > index 1455bce..568a8f7 100644
> > --- a/arch/powerpc/platforms/83xx/misc.c
> > +++ b/arch/powerpc/platforms/83xx/misc.c
> > @@ -53,3 +53,55 @@ long __init mpc83xx_time_init(void)
> >
> >  	return 0;
> >  }
> > +
> > +#ifdef CONFIG_RTC_CLASS
> > +int mpc83xx_set_rtc_time(struct rtc_time *tm)
> > +{
> > +	int err;
> > +	struct class_device *class_dev =
> > +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> > +
> > +	if (class_dev == NULL) {
> > +		printk("%s: unable to open rtc device (%s)\n",
> > +			__FUNCTION__, CONFIG_RTC_HCTOSYS_DEVICE);
> > +		return -ENODEV;
> > +	}
> > +
> > +	err = rtc_set_time(class_dev, tm);
> > +	if (err != 0)
> > +		dev_err(class_dev->dev,
> > +			"%s: unable to set the hardware clock\n",__FUNCTION__);
> > +
> > +	rtc_class_close(class_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +void mpc83xx_get_rtc_time(struct rtc_time *tm)
> > +{
> > +	int err;
> > +	struct class_device *class_dev =
> > +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> > +
> > +	if (class_dev == NULL) {
> > +		printk("%s: unable to open rtc device (%s)\n",
> > +			__FUNCTION__, CONFIG_RTC_HCTOSYS_DEVICE);
> > +		return;
> > +	}
> > +
> > +	err = rtc_read_time(class_dev, tm);
> > +	if (err == 0) {
> > +		err = rtc_valid_tm(tm);
> > +		if (err != 0)
> > +			dev_err(class_dev->dev,
> > +				"%s: invalid date/time\n",__FUNCTION__);
> > +	}
> > +	else
> > +		dev_err(class_dev->dev,
> > +			"%s: unable to read the hardware clock\n",__FUNCTION__);
> > +
> > +	rtc_class_close(class_dev);
> > +
> > +	return;
> > +}
> > +#endif /* CONFIG_RTC_CLASS */
> 
> What is this trying to accomplish?  What RTC chip is on 834x ITC and  
> how's it connected?

It removes rtc chip-specific code from the platform code.  It accomplishes this by using the new "RTC-framework" glue.  

The board has a Dallas DS1339.  The driver in drivers/i2c/chips is apparently obsolete, and there is a new way of doing all things i2c-rtc.  See:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1abb0dc92d706e8c73c7a62ca813738fe2259a7f

The defconfig I sent out has CONFIG_RTC_DRV_DS1307 set.  The code works well and I have an upcoming patch to carry the i2c 'force' option in from the device tree, which instructs the i2c code to do a better job of identifying the ds133x chips from the ds130x chips.  btw, setting system time from RTC on startup is now user-configurable.

<snip>
> > diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
> > index 02ed2c3..80076be 100644
> > --- a/include/asm-ppc/mpc83xx.h
> > +++ b/include/asm-ppc/mpc83xx.h
> > @@ -25,6 +25,10 @@
> >  #include <platforms/83xx/mpc834x_sys.h>
> >  #endif
> >
> > +#ifdef CONFIG_MPC834x_ITX
> > +#include <platforms/83xx/mpc834x_itx.h>
> > +#endif
> > +
> 
> This shouldn't be needed, its a hold over from arch/ppc
> 
Unfortunately it won't build without it.

Kim
