Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4138F67B88
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 07:49:48 +1000 (EST)
Subject: Re: powermac: More powermac backlight fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060724200315.d3c80ed0.akpm@osdl.org>
References: <20060715130900.GA29287@hansmi.ch>
	<20060724200315.d3c80ed0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 16:49:01 -0500
Message-Id: <1153864141.18353.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, aris@valeta.org, johannes@sipsolutions.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-24 at 20:03 -0700, Andrew Morton wrote:
> On Sat, 15 Jul 2006 15:09:00 +0200
> Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> 
> > This patch fixes several problems:
> > - The legacy backlight value might be set at interrupt time. Introduced
> >   a worker to prevent it from directly calling the backlight code.
> > - via-pmu allows the backlight to be grabbed, in which case we need to
> >   prevent other kernel code from changing the brightness.
> > - Don't send PMU requests in via-pmu-backlight when the machine is about
> >   to sleep or waking up.
> > - More Kconfig fixes.
> > 
> > ...
> >
> >  static void pmac_backlight_key_worker(void *data);
> > +static void pmac_backlight_set_legacy_worker(void *data);
> > +
> >  static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
> > +static DECLARE_WORK(pmac_backlight_set_legacy_work, pmac_backlight_set_legacy_worker, NULL);
> 
> I see schedule_work()s in there, but no flush_scheduled_work()s or anything
> like that.  Generally, this means there are races against rmmod, close(),
> etc.

Can this be rmmod'ed ? No code at hand right now, but the old version
certainly couldn't and the PMU driver who calls that can't neither. It's
not a file descriptor neither.

> >  
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
> 
> So if userspace calls ioctl(PMU_IOC_GRAB_BACKLIGHT) eleven times, eleven
> enables are needed?  (Actually, eleven open()/close() sequences, I think).

It makes sense to do it his way... You do that to stop kernel from
handling the backlight keys as long as at least one userspace client has
set the "grab" and thus basically says it handles them there. When they
all are gone and/or their fd closed, the backlight control returns to
the kernel default version 

> Methinks you wanted just
> 
> 	kernel_backlight_disabled = 1;

Nope, I think he's right there. There are cases where both gnome and
pbbuttons for example say to the kernel they handle the backlight keys.
A bit dodgy but it actually works and you want the kernel to properly
refcount before re-enabling it's own implementation. 

Ben.
