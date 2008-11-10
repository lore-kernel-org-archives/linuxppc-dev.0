Return-Path: <david-b@pacbell.net>
Received: from smtp127.sbc.mail.sp1.yahoo.com (smtp127.sbc.mail.sp1.yahoo.com
	[69.147.65.186]) by ozlabs.org (Postfix) with SMTP id 164D6DDF22
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 09:57:32 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Date: Mon, 10 Nov 2008 14:57:28 -0800
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
In-Reply-To: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811101457.29051.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	David Woodhouse <dwmw2@infradead.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yeah, we should have one of these.  :)


On Monday 10 November 2008, Alessandro Zummo wrote:
> @@ -30,7 +30,7 @@ config RTC_HCTOSYS
>  	  unnecessary fsck runs at boot time, and to network better.
>  
>  config RTC_HCTOSYS_DEVICE
> -	string "RTC used to set the system time"
> +	string "RTC used to set the system time on startup and resume"
>  	depends on RTC_HCTOSYS = y
>  	default "rtc0"
>  	help
> @@ -52,6 +52,23 @@ config RTC_HCTOSYS_DEVICE
>  	  sleep states. Do not specify an RTC here unless it stays powered
>  	  during all this system's supported sleep states.
>  
> +config RTC_SYSTOHC
> +	bool "Set RTC from system time in NTP sync mode"
> +	depends on RTC_CLASS = y
> +	default y
> +	help
> +	  If you say yes here, the system time (wall clock) will be written
> +	  to the hardware clock every 11 minutes, if the kernel is in NTP
> +	  mode and your platforms supports it.
> +
> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to save the system time in NTP sync mode"

Why not just use RTC_HCTOSYS_DEVICE for this?  I have a hard time
sseeing any other value make sense ... assuming there's only one
RTC involved.

A better default might be to update all the RTCs on the system.

I'm thinking of my trusty test-case here:  rtc0 is highly functional
(including wake from RTC alarm) but not battery backed, while rtc1
is battery backed but only tracks time.  NTP really needs to update
both of them ... rtc0 since that's what's used most of the time,
and also rtc1 since that's what actually *stores* the time during
power off cycles.


> +static int rtc_systohc(struct rtc_time *tm)

I think "static" will lose, especially since ...


> +EXPORT_SYMBOL(rtc_systohc);

... you want other code to call it. 
