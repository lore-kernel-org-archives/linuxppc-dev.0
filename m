Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id F1197DDE33
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 18:21:52 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 7 Sep 2007 10:21:43 +0200
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070907082143.GA27058@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<20070906170123.GA17990@ld0162-tx32.am.freescale.net>
	<20070906170547.GA12432@iram.es>
	<20070906172415.GA18226@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906172415.GA18226@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 12:24:15PM -0500, Scott Wood wrote:
> On Thu, Sep 06, 2007 at 07:05:47PM +0200, Gabriel Paubert wrote:
> > On Thu, Sep 06, 2007 at 12:01:23PM -0500, Scott Wood wrote:
> > > On Thu, Sep 06, 2007 at 06:55:35PM +0200, Gabriel Paubert wrote:
> > > > So who will be in charge of updating the RTC now? The update 
> > > > every 11 min is there to stay on x86(-64) it seems.
> > > 
> > > Put something in crontab to run hwclock periodically.
> > 
> > I have many machines on which cron is not even installed.
> 
> OK, so use something else that waits in a loop and periodically updates
> the clock.  It shouldn't be the kernel's responsibility.

It ha been the kernel's reposnibility ever since the NTP code
was included with the kernel. The only way to move it out
is to agree to something with NTP folks.

It is going to break working setups who rely on this feature, 
which is a big no-no.

The solution now used by i386/x86-64/sparc64 is
CONFIG_GENERIC_CMOS_UPDATE. Maybe powerpc should be switched
to use something similar, but the generic code has some
problems (it assumes that you have to set the clock
on a half-second, which is not the case of the RTC on 
my boards to start with).

Now I'm aware that some PowerPC RTC are messy to handle
in a timer/interrupt/whatever because some hardware designers
thought it was wise to put the RTC on a dog-slow bus like
I2C. You have however a variable to disable this update
if you want (no_sync_cmos_clock), set it to 1 by default
but please let people that use (and need) the functionality
enable it (even do it by default when the RTC access is fast).

	Gabriel
