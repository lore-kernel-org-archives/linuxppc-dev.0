Return-Path: <diggskevin38@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25399B6EF7
 for <linuxppc-dev@ozlabs.org>; Sun, 29 Jan 2012 14:08:59 +1100 (EST)
Received: by dang27 with SMTP id g27so1762218dan.15
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Jan 2012 19:08:56 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 28 Jan 2012 21:08:56 -0600
Message-ID: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw@mail.gmail.com>
Subject: RTC on 2.6.36 for PowerMac 8600
From: kevin diggs <diggskevin38@gmail.com>
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

What will give me access to the RTC hardware on an old PowerMac 8600?
I modload rtc-generic. /proc/devices has:

254 rtc

and ls -l /dev/rtc*:

crw-r--r--  2 root root 254,   0 Sep  2  2010 /dev/rtc
crw-r--r--  2 root root 254,   0 Sep  2  2010 /dev/rtc0
crw-r--r--  1 root root  10, 135 Aug 10  2004 /dev/rtc.old

Trying to run hwclock gives:

[root@PowerMac8600B root]# hwclock --debug
hwclock from util-linux-2.12pre
Using /dev/rtc interface to clock.
Last drift adjustment done at 1317444443 seconds after 1969
Last calibration done at 1317444443 seconds after 1969
Hardware clock is on local time
Assuming hardware clock is kept in local time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time
from /dev/rtc to change
RTC_RD_TIME: Invalid argument
ioctl() to /dev/rtc to read the time failed.

I could have sworn this used to work on this system???

What am I forgetting?

gzip -dc /proc/config.gz|grep -i rtc lists:

CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m
# RTC interfaces
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# Platform RTC drivers
CONFIG_RTC_DRV_CMOS=m
# on-CPU RTC drivers
CONFIG_RTC_DRV_GENERIC=m

Thanks!

kevin
