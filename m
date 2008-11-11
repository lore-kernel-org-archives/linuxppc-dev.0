Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id 42042DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 07:59:07 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Date: Tue, 11 Nov 2008 12:58:59 -0800
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
	<1226412639.4367.256.camel@macbook.infradead.org>
In-Reply-To: <1226412639.4367.256.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811111258.59874.david-b@pacbell.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Paul Mundt <lethal@linux-sh.org>,
	rtc-linux@googlegroups.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 November 2008, David Woodhouse wrote:
> I believe you were also concerned that some device wouldn't want the
> behaviour given by the existing sync_cmos_clock() function and workqueue
> stuff in kernel/ntp.c, where we update the clock precisely half-way
> through the second?

That's a problem, yes.  I've never heard of any RTC that wants
such delays ... except for the PC's "CMOS" RTC.

There was some discussion about how to expose that knowledge to
userspace too.  The "hwclock" utility always imposes that delay,
and it shouldn't (except when talking to a PC RTC).

> We should probably rip that code out of ntp.c (or just disable it ifdef
> CONFIG_RTC_CLASS), and provide our own version of notify_cmos_timer().

My suggestion for in-kernel code is that "struct rtc_device" just
grow a field like "unsigned settime_delay_msec" which would never
be initialized except by rtc-cmos (which uses 500) ... and the NTP
sync code would use that value.

For out-of-kernel use, that value could be extracted with an ioctl(),
and used similarly.


> The workqueue stuff to trigger at half-past the second could be kept as
> a library function which most RTC devices would use, but they'd have the
> option to use their own instead.

I thought the workqueue stuff was primarily there to make sure
that RTC was always updated in task context -- so it can grab the
relevant mutex -- and the half-second delay was legacy PC code ...

- Dave
