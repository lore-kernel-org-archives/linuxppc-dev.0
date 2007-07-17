Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 226C2DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 03:48:46 +1000 (EST)
Date: Tue, 17 Jul 2007 21:48:24 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] POWERPC: Added RTC support for mpc8313RDB and utilize
	"clock-frequency"
Message-ID: <20070717214824.04db9e88@vitb.ru.mvista.com>
In-Reply-To: <20070717163645.GB7347@ld0162-tx32.am.freescale.net>
References: <20070717004913.21682.50282.stgit@localhost.localdomain>
	<20070717163645.GB7347@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 11:36:45 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Tue, Jul 17, 2007 at 04:49:13AM +0400, Vitaly Bordug wrote:
> > +	np = of_find_node_by_type(NULL, "cpu");
> > +	if (np != 0) {
> > +		const unsigned int *fp =
> > +			get_property(np, "clock-frequency", NULL);
> > +		if (fp != 0)
> > +			loops_per_jiffy = *fp / HZ;
> > +		else
> > +			loops_per_jiffy = 50000000 / HZ;
> > +		of_node_put(np);
> > +	}
> 
> This is not necessary.  It's only used for /proc/cpuinfo (delays are done
> using tb_ticks_per_usec), and it'll be overwritten by the generic
> calibrate_delay() anyway.
> 
> We should be removing this from board files that have it, not adding it
> to ones that don't.
> 
Yet many boards still have this stuff (like pretty recent 86xx) - should
we at least add some comments or clean that up?

> > +#if defined (CONFIG_SENSORS_DS1337) && defined (CONFIG_I2C)
> > +
> > +extern int ds1337_do_command(int id, int cmd, void *arg);
> > +extern spinlock_t rtc_lock;
> > +#define DS1337_GET_DATE		0
> > +#define DS1337_SET_DATE		1
> > +
> > +static void mpc8313rdb_get_rtc_time(struct rtc_time *tm)
> > +{
> > +	int result;
> > +
> > +	result = ds1337_do_command(0, DS1337_GET_DATE, tm);
> > +
> > +	if (result == 0)
> > +		result = mktime(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
> > +}
> > +
> > +static int mpc8313rdb_set_rtc_time(struct rtc_time *tm)
> > +{
> > +	int result;
> > +
> > +	result = ds1337_do_command(0, DS1337_SET_DATE, tm);
> > +
> > +	return result;
> > +}
> > +
> > +static int __init rtc_hookup(void)
> > +{
> > +	ppc_md.get_rtc_time = mpc8313rdb_get_rtc_time;
> > +	ppc_md.set_rtc_time = mpc8313rdb_set_rtc_time;
> > +	return 0;
> > +}
> > +late_initcall(rtc_hookup);
> > +#endif
> 
> Please don't do this; drivers/i2c/chips/ds1337.c is deprecated.  You
> should be using the RTC-class driver in drivers/rtc/rtc-ds1307.c, which
> has a non-device-specific API that can be used.
> 
> The ppc_md RTC functions should really just go away, though -- setting
> the clock on bootup can be done by generic code, and periodically
> updating the RTC when using NTP can be done from userspace.
> 

If those ppc_md hookups would be declared deprecated, there's no much sense in the upper,
apparently. But I am not sure they will be... I'm inclined to let this patch floating since
interacting with rtc class from within BSP code just does not worth it.

-- 
Sincerely, 
Vitaly
