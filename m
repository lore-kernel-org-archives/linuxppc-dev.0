Return-Path: <newsuser@famdijkstra.org>
Received: from baardmijt.demon.nl (baardmijt.demon.nl [212.238.157.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 325A3DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 01:00:45 +1100 (EST)
Date: Sun, 18 Mar 2007 14:41:15 +0100
From: Tim Dijkstra <newsuser@famdijkstra.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hibernate, suspend and s2both support
Message-ID: <20070318144115.00ab8912@commensaal.drs.p>
In-Reply-To: <1174208083.13027.36.camel@johannes.berg>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
	<1174208083.13027.36.camel@johannes.berg>
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

On Sun, 18 Mar 2007 09:54:43 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi Tim,
> 
> Let me try to answer your questions, I've worked on suspend for powermac
> machines for quite a while.

Thanks for the answers! I removed debian-powerpc from the cc-list as
you suggested.

> > AFAIK, one can suspend-to-ram by using some ioctl's on the PMU. (Do all
> > ppc's have a PMU? What about ppc64?)
> 
> Yes, although I have a patch series that I'm going to post soon that
> deprecates the PMU ioctl and uses the regular mem > /sys/power/state
> mechanism, in fact the PMU ioctl only invokes that exact same code.
> However, you'll need to support older kernels, but trying
> sys/power/state before PMU will be safe on any kernel released after May
> 25 2006 (commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2). Before that,
> the machine just crashed when using the pm ops stuff and at the time I
> hadn't understood yet why and just papered over the problem.

So if I build a binary on ppc that first tries /dev/pmu (if it exists) and then
/sys/power/state, that would be safe? I guess that the powerpcs that do not
support suspend-to-ram will report that via the PMU_IOC_CAN_SLEEP ioctl and
they will lack 'mem' in /sys/power/state?

> > Hibernation can be done in the usual way. And s2both is unsupported. 
> 
> Yup; I've played with s2both a bit but it hangs the machine, I'm not
> really sure why yet. It may be related to another slight bug I just
> found yesterday though.

Hmm, so 'echo disk > /s/p/state' and s2ram suspend OK, but s2both doesn't?

> > If this is all true, could someone try to build 's2ram' and 's2both'
> > from the following tarball and run it? (no guarantees, on your own
> > risk, etc;)
> > 
> > http://www.famdijkstra.org/~tdykstra/suspend_pmu.tar.bz2
> 
> It works on my machine (see above), but it doesn't use the PMU ioctl:
> 
> #ifndef CONFIG_PMU
>         int fd;
>         unsigned long arg = 0;
> 
>         if ((fd = open("/dev/pmu", O_RDWR)) < 0)
> ...
> 
> seems to be the wrong way around. A kernel-based suspend to both has no
> chance of working properly since I currently disallow using 'platform'
> for the disk poweroff state, but I intend to fix this if I can. 

Oops, Yes that was the wrong way around... That's what you get if you
don't have a Mac;) Did you try it with the obvious fix?

> I can't
> try a userspace based s2both right now since I'd probably have to
> rebuild my initramfs at least to test a power-failure during suspend.

Yes you need an initramfs, but I don't see any reason why if
suspend-to-disk and suspend-to-ram work, s2both wouldn't. If we get
suspend-to-ram working I'll put up proper source package which you can
dpkg-buildpackage. That will include hooks for initramfs-tools and will
build an initramfs for you.

grts Tim
