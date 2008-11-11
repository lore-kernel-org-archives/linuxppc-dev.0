Return-Path: <SRS0+3e43fe3c9f4e6f5295c0+1906+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78FF3DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 01:10:47 +1100 (EST)
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
From: David Woodhouse <dwmw2@infradead.org>
To: Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 14:10:39 +0000
Message-Id: <1226412639.4367.256.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-10 at 16:40 +0100, Alessandro Zummo wrote:
> Adds in-kernel hctosys functionality that can
> be used by ntp sync code.
> 
> This is an RFC and has not been tested, I just want
> to check if something similar could solve the problems
> of those who want the NTP sync mode.

You might do better to open the device once and keep it open, rather
than taking the mutex and opening it again _during_ each call? You're
going to be perturbing the timing by doing that.

I believe you were also concerned that some device wouldn't want the
behaviour given by the existing sync_cmos_clock() function and workqueue
stuff in kernel/ntp.c, where we update the clock precisely half-way
through the second?

We should probably rip that code out of ntp.c (or just disable it ifdef
CONFIG_RTC_CLASS), and provide our own version of notify_cmos_timer().

The workqueue stuff to trigger at half-past the second could be kept as
a library function which most RTC devices would use, but they'd have the
option to use their own instead.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
