Return-Path: <newsuser@famdijkstra.org>
Received: from baardmijt.demon.nl (baardmijt.demon.nl [212.238.157.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 526A5DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 09:46:08 +1100 (EST)
Date: Sun, 18 Mar 2007 23:46:01 +0100
From: Tim Dijkstra <newsuser@famdijkstra.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hibernate, suspend and s2both support
Message-ID: <20070318234601.3f6cc53b@commensaal.drs.p>
In-Reply-To: <1174228670.13027.46.camel@johannes.berg>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
	<1174208083.13027.36.camel@johannes.berg>
	<20070318144115.00ab8912@commensaal.drs.p>
	<1174228670.13027.46.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 18 Mar 2007 15:37:50 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Sun, 2007-03-18 at 14:41 +0100, Tim Dijkstra wrote:
> 
> > So if I build a binary on ppc that first tries /dev/pmu (if it exists) and then
> > /sys/power/state, that would be safe?
> 
> Yeah, my current patchset will print a message that the /dev/pmu ioctl
> will be removed but that may well not be present.
> 
> > I guess that the powerpcs that do not
> > support suspend-to-ram will report that via the PMU_IOC_CAN_SLEEP ioctl
> 
> They either have no /dev/pmu device or return an error on the ioctl.
> 
> >  and
> > they will lack 'mem' in /sys/power/state?
> 
> That's tricky. Up until I posted a patch *very* recently (unreleased as
> of yet I think) the contents of /sys/power/state didn't reflect what was
> supported, in fact if *nothing* was supported then "mem" and "standby"
> would be shown. Also, up until that patch I cited in my previous mail,
> mem and standby would, on powermac, kill the machine. On other machines,
> mem and standby exist but return an error.

So maybe the safest algorithm would be
- If /dev/pmu exists
	- Check PMU_IOC_CAN_SLEEP
		- Yes -> suspend
		- No -> Fail (maybe prevents a crash when we would have tried 'echo mem')
- No /dev/pmu
	- try 'echo mem ...'


> have tested the 'platform' powerdown method for suspend to disk support
> in the kernel and that killed the machine due to a yet unidentified
> problem.

I think this is a know problem, at least it happens on more machines.
Will have to ask for the details.

> 
 > If we get
> > suspend-to-ram working I'll put up proper source package which you can
> > dpkg-buildpackage. That will include hooks for initramfs-tools and will
> > build an initramfs for you.
> 
> Do you really think that I let debian build my initramfs? :P
> Have you documented somewhere in text form what pm-utils needs in the
> initramfs?

Well before initramfs-tools I also crafted my own, but I got a bit fed
up about forgetting to update it when a new udev (or zzz) had arrived.

Anyway, on your initramfs you need /dev/snapshot, /sbin/resume and /etc/suspend.conf. 
Your swap partition needs to be available, your filesystems should _not_ be mounted
and then you should just call /sbin/resume.

Oh, I think I forgot to tell this before, but to use s2both/s2disk you
need a config file (if you build it from the tarball I send you it
is /etc/suspend.conf, on debian /etc/uswsusp.conf). In it you need at
least the line:

	resume device = <path to swap device node>

That is it.

grts Tim
