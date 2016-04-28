Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWHP2jV9zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:09:37 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Rich Felker <dalias@libc.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
 mpe@ellerman.id.au, dhowells@redhat.com, linux-alpha@vger.kernel.org,
 a.zummo@towertech.it, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 11:08:41 +0200
Message-ID: <2582931.5Q3899gsIm@wuerfel>
In-Reply-To: <20160427232122.GW21636@brightrain.aerifal.cx>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <1461796470-1291527-5-git-send-email-arnd@arndb.de>
 <20160427232122.GW21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 27 April 2016 19:21:22 Rich Felker wrote:
> On Thu, Apr 28, 2016 at 12:34:18AM +0200, Arnd Bergmann wrote:
> > The rtc-generic driver provides an architecture specific
> > wrapper on top of the generic rtc_class_ops abstraction,
> > and on sh, that goes through another indirection using
> > the rtc_sh_get_time/rtc_sh_set_time functions.
> > 
> > This changes the sh rtc-generic device to provide its
> > rtc_class_ops directly, skipping one of the abstraction
> > levels.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks ok in principle. Have you tested that it builds? 

I think I build tested version 1, but not the current version.

> > diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
> > index d6d0a986c6e9..92cd676970d9 100644
> > --- a/arch/sh/kernel/time.c
> > +++ b/arch/sh/kernel/time.c
> > @@ -50,27 +50,30 @@ int update_persistent_clock(struct timespec now)
> >  }
> >  #endif
> >  
> > -unsigned int get_rtc_time(struct rtc_time *tm)
> > +static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
> >  {
> > -	if (rtc_sh_get_time != null_rtc_get_time) {
> 
> This seems like a functional change -- whereas previously the
> null_rtc_get_time case left *tm unchanged, now the function gets
> called and junk gets filled in. Is that desired?

I dropped the check because it duplicates the check in rtc_generic_init()
below it: the old genrtc driver needed the check in get_rtc_time()
because it would call that function unconditionally, but with the
rtc-generic driver, we know that we only ever call this after
registering the device successfully.

> > -		struct timespec tv;
> > +	struct timespec tv;
> >  
> > -		rtc_sh_get_time(&tv);
> > -		rtc_time_to_tm(tv.tv_sec, tm);
> > -	}
> > -
> > -	return RTC_24H;
> > +	rtc_sh_get_time(&tv);
> > +	rtc_time_to_tm(tv.tv_sec, tm);
> > +	return 0;
> 
> Also the return value is changed. Is this correct?

Yes: again, the genrtc driver had obscure calling conventions requiring
RTC_24H to be returned on success, while the rtc-generic driver uses
the normal kernel coding style of using 0 for success.

Previously, this function was used to convert from get_rtc_time()
calling conventions (without a device) to the normal rtc_class_ops:

static int generic_get_time(struct device *dev, struct rtc_time *tm)
{
       unsigned int ret = get_rtc_time(tm);

       if (ret & RTC_BATT_BAD)
               return -EOPNOTSUPP;

       return rtc_valid_tm(tm);
}

> >  }
> > -EXPORT_SYMBOL(get_rtc_time);
> >  
> > -int set_rtc_time(struct rtc_time *tm)
> > +static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
> >  {
> >  	unsigned long secs;
> >  
> >  	rtc_tm_to_time(tm, &secs);
> > -	return rtc_sh_set_time(secs);
> > +	if (!rtc_sh_set_time || rtc_sh_set_time(secs) < 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL(set_rtc_time);
> 
> Why checking rtc_sh_set_time for a null pointer? null_rtc_set_time is
> not a null pointer but a dummy function that's always safe to call, I
> think.

You are right, it should check for null_rtc_set_time instead, I probably
copied it from powerpc, which does this a bit differently.

Actually calling null_rtc_set_time however would be (slightly) wrong here,
because we want to return an error to user space if we try to set a
read-only rtc.

> > +static const struct rtc_class_ops rtc_generic_ops = {
> > +	.read_time = rtc_generic_get_time,
> > +	.set_time = rtc_generic_set_time,
> > +};
> >  
> >  static int __init rtc_generic_init(void)
> >  {
> > @@ -79,7 +82,10 @@ static int __init rtc_generic_init(void)
> >  	if (rtc_sh_get_time == null_rtc_get_time)
> >  		return -ENODEV;
> >  
> > -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> > +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> > +					     &rtc_generic_ops,
> > +					     sizeof(rtc_generic_ops));
> > +
> 
> Not a complaint about your patch, but I'd like to get rid of this
> platform device and abstraction layer completely since it doesn't seem
> like something that can be modeled correctly in device tree. When
> you're done cleaning this up, will it be possible to just have rtc
> drivers that use whatever generic framework is left, where the right
> driver is automatically attached to compatible DT nodes? I'm trying to
> move all of arch/sh over to device tree and remove hard-coded platform
> devices.

Yes, I think that would be great. When an rtc driver is registered, you
don't actually need the read_persistent_clock/update_persistent_clock
functions (there are __weak versions of them that do nothing and cause
a fallback to calling into the rtc subsystem), so you can replace
the rtc_sh_get_time/rtc_sh_set_time with proper drivers one at a time.

I only see two of them anyway (dreamcast and sh03), so that should
be easy enough to do. For instance in arch/sh/boards/mach-sh03/rtc.c,
the sh03_time_init() function should register a platform driver,
whose probe function calls devm_rtc_device_register() to register
with the rtc subsystem. Then you move the entire file to drivers/rtc/
and change the callers of sh03_time_init() to create the device
manually (for the classic board file) or drop it (for DT).

After you have done that, all rtc related code can be removed from
arch/sh/kernel/time.c.

	Arnd
