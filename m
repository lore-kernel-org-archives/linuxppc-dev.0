Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6D72CDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 19:05:44 +1100 (EST)
Date: Wed, 12 Nov 2008 09:05:38 +0100
From: Gabriel Paubert <paubert@iram.es>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Message-ID: <20081112080538.GA2711@iram.es>
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
	<1226412639.4367.256.camel@macbook.infradead.org>
	<200811111258.59874.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811111258.59874.david-b@pacbell.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Paul Mundt <lethal@linux-sh.org>,
	David Woodhouse <dwmw2@infradead.org>,
	rtc-linux@googlegroups.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 12:58:59PM -0800, David Brownell wrote:
> On Tuesday 11 November 2008, David Woodhouse wrote:
> > I believe you were also concerned that some device wouldn't want the
> > behaviour given by the existing sync_cmos_clock() function and workqueue
> > stuff in kernel/ntp.c, where we update the clock precisely half-way
> > through the second?
> 
> That's a problem, yes.  I've never heard of any RTC that wants
> such delays ... except for the PC's "CMOS" RTC.

Indeed, they are the oddball, although very frequent. Could it be
made a constant (500msec on x86, 0 on all other architectures) ?

> 
> There was some discussion about how to expose that knowledge to
> userspace too.  The "hwclock" utility always imposes that delay,
> and it shouldn't (except when talking to a PC RTC).
> 
> > We should probably rip that code out of ntp.c (or just disable it ifdef
> > CONFIG_RTC_CLASS), and provide our own version of notify_cmos_timer().
> 
> My suggestion for in-kernel code is that "struct rtc_device" just
> grow a field like "unsigned settime_delay_msec" which would never
> be initialized except by rtc-cmos (which uses 500) ... and the NTP
> sync code would use that value.

Hmm, I believed that most internal interfaces are now using nanoseconds
for subsecond fields and values; 500000000 also fits in 32 bits and may 
avoid some unnecessary arithmetic. It is obviously overkill with 32768Hz 
crystals but consistency is nice. 

> 
> For out-of-kernel use, that value could be extracted with an ioctl(),
> and used similarly.
> 
> 
> > The workqueue stuff to trigger at half-past the second could be kept as
> > a library function which most RTC devices would use, but they'd have the
> > option to use their own instead.
> 
> I thought the workqueue stuff was primarily there to make sure
> that RTC was always updated in task context -- so it can grab the
> relevant mutex -- and the half-second delay was legacy PC code ...

Please allow configs that only use RTC internally without exposing
the driver to userspace. 

At least that's how I use the RTC, I have some messages on shutdown telling
me that the clock could not be accessed but I don't care since all these 
machines have ntp and the RTC is completely useless for anything else than 
setting the time quite precisely on reboot (on some of the boards I have, 
the RTC interrupt is not even wired, so no alarm, no periodic interrupt).

	Gabriel
