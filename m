Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 980A71007D1
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2012 20:06:18 +1100 (EST)
Message-ID: <1328000769.28487.72.camel@pasglop>
Subject: Re: RTC on 2.6.36 for PowerMac 8600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
Date: Tue, 31 Jan 2012 20:06:09 +1100
In-Reply-To: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw@mail.gmail.com>
References: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-01-28 at 21:08 -0600, kevin diggs wrote:
> Hi,
> 
> What will give me access to the RTC hardware on an old PowerMac 8600?
> I modload rtc-generic. /proc/devices has:

should work with rtc generic, not sure what's up.

You can check with printk ... rtc_generic should call into get_rtc_time
which should go via ppc_md. into some powermac specific variants,
themselves calling into the cuda driver.

Cheers,
Ben.

> 254 rtc
> 
> and ls -l /dev/rtc*:
> 
> crw-r--r--  2 root root 254,   0 Sep  2  2010 /dev/rtc
> crw-r--r--  2 root root 254,   0 Sep  2  2010 /dev/rtc0
> crw-r--r--  1 root root  10, 135 Aug 10  2004 /dev/rtc.old
> 
> Trying to run hwclock gives:
> 
> [root@PowerMac8600B root]# hwclock --debug
> hwclock from util-linux-2.12pre
> Using /dev/rtc interface to clock.
> Last drift adjustment done at 1317444443 seconds after 1969
> Last calibration done at 1317444443 seconds after 1969
> Hardware clock is on local time
> Assuming hardware clock is kept in local time.
> Waiting for clock tick...
> /dev/rtc does not have interrupt functions. Waiting in loop for time
> from /dev/rtc to change
> RTC_RD_TIME: Invalid argument
> ioctl() to /dev/rtc to read the time failed.
> 
> I could have sworn this used to work on this system???
> 
> What am I forgetting?
> 
> gzip -dc /proc/config.gz|grep -i rtc lists:
> 
> CONFIG_RTC_LIB=m
> CONFIG_RTC_CLASS=m
> # RTC interfaces
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # Platform RTC drivers
> CONFIG_RTC_DRV_CMOS=m
> # on-CPU RTC drivers
> CONFIG_RTC_DRV_GENERIC=m
> 
> Thanks!
> 
> kevin
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
