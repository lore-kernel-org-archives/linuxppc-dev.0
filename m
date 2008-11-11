Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 05237DDFD6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 04:17:43 +1100 (EST)
Date: Tue, 11 Nov 2008 18:17:34 +0100
From: Gabriel Paubert <paubert@iram.es>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Message-ID: <20081111171734.GA17886@iram.es>
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
	<1226412639.4367.256.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1226412639.4367.256.camel@macbook.infradead.org>
Cc: David Brownell <david-b@pacbell.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Mundt <lethal@linux-sh.org>, rtc-linux@googlegroups.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 02:10:39PM +0000, David Woodhouse wrote:
> On Mon, 2008-11-10 at 16:40 +0100, Alessandro Zummo wrote:
> > Adds in-kernel hctosys functionality that can
> > be used by ntp sync code.
> > 
> > This is an RFC and has not been tested, I just want
> > to check if something similar could solve the problems
> > of those who want the NTP sync mode.
> 
> You might do better to open the device once and keep it open, rather
> than taking the mutex and opening it again _during_ each call? You're
> going to be perturbing the timing by doing that.
> 
> I believe you were also concerned that some device wouldn't want the
> behaviour given by the existing sync_cmos_clock() function and workqueue
> stuff in kernel/ntp.c, where we update the clock precisely half-way
> through the second?

FYI, the RTC that are in my PPC machines definitely want an update
on the whole second, within a few hundred microseconds that is, since
it seems that not all LSB bits are reset by a write of the time: the 
jitter is much higher than the 31µs peak-peak you'd expect from a 32768Hz
crystal but I can't remember how much I found.

	Regards,
	Gabriel
