Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6A5D9688C3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 03:13:40 +1100 (EST)
Message-ID: <43A2E7A8.3020101@varma-el.com>
Date: Fri, 16 Dec 2005 19:13:28 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Frank Bennett <bennett78@digis.net>
References: <43A2071A.3030802@digis.net> <43A29A21.8080102@varma-el.com>
	<43A2DE2C.6010708@digis.net> <43A2E054.6090506@digis.net>
In-Reply-To: <43A2E054.6090506@digis.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC5200 ppc_md.set_rtc_time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

bennett78 wrote:
> bennett78 wrote:
> 
>> Andrey Volkov wrote:
>>
>>>Hello Frank,
>>>
>>>bennett78 wrote:
>>>  
>>>
>>>>Hi:
>>>>   How / when does "ppc_md.set_rtc_time" get filled
>>>>in for Lite5200?
>>>>
>>>>Config for support /dev/rtc enables CONFIG_PPC_RTC
>>>>which enable driver/char/rtc.c which mentions CMOS_WRITE
>>>>panics the kernel!
>>>>
>>>>I trying to use driver/char/genrtc.c.   I can set date
>>>>but not hwclock.
>>>>
>>>>    
>>>>
>>>>>hwclock --set --date="9/22/96 16:45:05"
>>>>>      
>>>>>
>>>>gen_set_rtc_irq_bit:exit
>>>>gen_rtc_ioctl RTC_SET_TIME 00000060
>>>>RTC_SET_TIME: Invalid argument
>>>>ioctl() to /dev/rtc to set the time failed.
>>>>
>>>>bash-2.05b# cat /proc/driver/rtc
>>>>rtc_time        : 00:50339648:36914
>>>>rtc_date        : -1072186980-497--1073718072
>>>>rtc_epoch       : 1900
>>>>alarm           : 00:00:00
>>>>DST_enable      : no
>>>>BCD             : yes
>>>>24hr            : yes
>>>>square_wave     : no
>>>>alarm_IRQ       : no
>>>>update_IRQ      : no  <----- how can I hook one?
>>>>periodic_IRQ    : no
>>>>periodic_freq   : 0
>>>>batt_status     : okay
>>>>
>>>>
>>>>thanks,
>>>>
>>>>*/Frank Bennett
>>>>/*
>>>>    
>>>>
>>>For 2.6 kernel, check arch/ppc/syslib/lite5200.c, especially
>>>platform_init() (at the end of file).
>>>    
>>>
> is this your point?
> linux-2.6.12/arch/ppc/platforms/lite5200.c
>       /* No time keeper on the LITE5200 */
>     ppc_md.time_init    = NULL;
>     ppc_md.get_rtc_time = NULL;
>     ppc_md.set_rtc_time = NULL;
> 
Yes.

> I don't see any arch/ppc/syslib/lite5200.c
But, sorry, from which file are you quotating prev code ;)?

> 
>>>  
>>>
>> Andrey:
>>     Thanks, sorry I forgot to mention I'm on DENX linuxppc_2_4_devel.
>> Where is the linuxppc 2.6.x distribution?
Check here http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git

>> Is anyone maintaining a checklist of working features for imbedded 2.6?
>> Is this mail list searchable? (other than a month at a time?)
>>
AFAIK - no. By very simple reason - all drivers in vanilla kernel MUST
be work, if some code not in Linus git, then it (usually) unstable or in
the pending stage.

--
Regards
Andrey Volkov
