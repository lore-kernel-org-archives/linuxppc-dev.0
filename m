Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A52C367B5C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 04:44:22 +1000 (EST)
Date: Tue, 25 Jul 2006 20:44:06 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: powermac: More powermac backlight fixes
Message-ID: <20060725184406.GA12226@hansmi.ch>
References: <20060715130900.GA29287@hansmi.ch>
	<20060724200315.d3c80ed0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060724200315.d3c80ed0.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, aris@valeta.org,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Andrew

On Mon, Jul 24, 2006 at 08:03:15PM -0700, Andrew Morton wrote:
> I see schedule_work()s in there, but no flush_scheduled_work()s or anything
> like that.  Generally, this means there are races against rmmod, close(),
> etc.

I'll check that. Another patch is in the work already.

> > +void pmac_backlight_disable()
> > +{
> > +	atomic_inc(&kernel_backlight_disabled);
> > +}
> > +
> > +void pmac_backlight_enable()
> > +{
> > +	atomic_dec(&kernel_backlight_disabled);
> > +}
> > +

> So if userspace calls ioctl(PMU_IOC_GRAB_BACKLIGHT) eleven times, eleven
> enables are needed?  (Actually, eleven open()/close() sequences, I think).

> Methinks you wanted just

> 	kernel_backlight_disabled = 1;
> ?

Aristeu already asked me that, and no, the disabling is meant to be
recursive. The old code did something like "spin_lock(...); disable++;
spin_unlock(...);". It then checked for "if (disable) return;". My code
basically moves the code from the via-pmu driver and removes the
spinlocks.

Thanks,
Michael
