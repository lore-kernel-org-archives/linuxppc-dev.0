Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4BAE67B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 00:13:50 +1000 (EST)
In-Reply-To: <1159240397.5462.11.camel@localhost.localdomain>
References: <20060925215531.3e43be36.kim.phillips@freescale.com>
	<1159240397.5462.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2FE0EA9E-D0E8-4A6B-8184-454DAAE02FC5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add powerpc get/set_rtc_time interface to new generic rtc
	class
Date: Tue, 26 Sep 2006 09:14:15 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2006, at 10:13 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2006-09-25 at 21:55 -0500, Kim Phillips wrote:
>> Add powerpc get/set_rtc_time interface to new generic rtc class. This
>> abstracts rtc chip specific code from the platform code for rtc- 
>> over-i2c
>> platforms.  Specific RTC chip support is now configured under
>> Device Drivers -> Real Time Clock. Setting time of day from the RTC
>> on startup is also configurable.
>>
>> Currently, the only default config in powerpc arch is the 8349 itx.
>> Other platforms wanting to consolidate code may also use this.
>>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>
> I think we should only get that in if we also adapt the various  
> platform
> RTC code to be in drivers/rtc ... right now, enabling that option will
> just break everybody.

Maybe just drop the init call for now and let people migrate over to  
using this and moving the drivers over to drivers/rtc which aren't  
supported there.

- k

>> ---
>>  arch/powerpc/kernel/time.c |   44 ++++++++++++++++++++++++++++++++ 
>> ++++++++++++
>>  1 files changed, 44 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 7a3c3f7..a231b6d 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -1048,6 +1048,50 @@ void __init time_init(void)
>>  	set_dec(tb_ticks_per_jiffy);
>>  }
>>
>> +#ifdef CONFIG_RTC_CLASS
>> +int set_rtc_class_time(struct rtc_time *tm)
>> +{
>> +	int err;
>> +	struct class_device *class_dev =
>> +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
>> +
>> +	if (class_dev == NULL)
>> +		return -ENODEV;
>> +
>> +	err = rtc_set_time(class_dev, tm);
>> +
>> +	rtc_class_close(class_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +void get_rtc_class_time(struct rtc_time *tm)
>> +{
>> +	int err;
>> +	struct class_device *class_dev =
>> +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
>> +
>> +	if (class_dev == NULL)
>> +		return;
>> +
>> +	err = rtc_read_time(class_dev, tm);
>> +
>> +	rtc_class_close(class_dev);
>> +
>> +	return;
>> +}
>> +
>> +static int __init rtc_class_hookup(void)
>> +{
>> +	ppc_md.get_rtc_time = get_rtc_class_time;
>> +	ppc_md.set_rtc_time = set_rtc_class_time;
>> +
>> +	return 0;
>> +}
>> +
>> +late_initcall(rtc_class_hookup);
>> +#endif /* CONFIG_RTC_CLASS */
>> +
>>
>>  #define FEBRUARY	2
>>  #define	STARTOFTIME	1970
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
