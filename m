Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2A94CB6F9D
 for <linuxppc-dev@ozlabs.org>; Sun, 29 Jan 2012 19:30:08 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: kevin diggs <diggskevin38@gmail.com>
Subject: Re: RTC on 2.6.36 for PowerMac 8600
References: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw__43210.997261531$1327806577$gmane$org@mail.gmail.com>
Date: Sun, 29 Jan 2012 09:29:59 +0100
In-Reply-To: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw__43210.997261531$1327806577$gmane$org@mail.gmail.com>
 (kevin diggs's message of "Sat, 28 Jan 2012 21:08:56 -0600")
Message-ID: <m2obtmhpx4.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kevin diggs <diggskevin38@gmail.com> writes:

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

Perhaps the RTC was reset due to battery running out?  That would set
the year to 1900, but the kernel RTC interface cannot represent dates
before 1970.  Unfortunately hwclock insists on reading the RTC even when
you just want to write to it, so you cannot fix that with hwclock -w.
When the battery of my iBook has run out I'm using the following to
reset RTC to current time so that it is usable again.

Andreas.

#include <time.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/rtc.h>

int
main (void)
{
  time_t now;
  struct tm gmt;
  struct rtc_time rtc;
  int fd;

  now = time (0);
  gmt = *gmtime (&now);
  rtc.tm_sec = gmt.tm_sec;
  rtc.tm_min = gmt.tm_min;
  rtc.tm_hour = gmt.tm_hour;
  rtc.tm_mday = gmt.tm_mday;
  rtc.tm_mon = gmt.tm_mon;
  rtc.tm_year = gmt.tm_year;
  rtc.tm_wday = gmt.tm_wday;
  rtc.tm_yday = gmt.tm_yday;
  rtc.tm_isdst = gmt.tm_isdst;
  fd = open ("/dev/rtc", O_RDONLY);
  if (fd < 0)
    fd = open ("/dev/rtc0", O_RDONLY);
  if (fd < 0)
    {
      perror ("/dev/rtc");
      return 1;
    }
  if (ioctl (fd, RTC_SET_TIME, &rtc) < 0)
    {
      perror ("RTC_SET_TIME");
      return 1;
    }
  return 0;
}

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
