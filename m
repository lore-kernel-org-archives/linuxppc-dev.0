Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 19BD5DE127
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 02:54:32 +1000 (EST)
Date: Thu, 23 Apr 2009 20:54:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423165430.GA8355@oksana.dev.rtsoft.ru>
References: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
	<20090423160048.GC19717@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090423160048.GC19717@ld0162-tx32.am.freescale.net>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 11:00:48AM -0500, Scott Wood wrote:
> On Thu, Apr 23, 2009 at 05:50:05PM +0400, Anton Vorontsov wrote:
> > As for Freescale parts, all the reference board I've seen were
> > very friendly wrt upgrading their device-trees, i.e. none of
> > the boards were shipping with device-tree soldered into the
> > firmware.
> 
> But many of them have broken when a dtb that u-boot didn't like was
> inserted.

Yes, I agree here. And I'm not going to contradict on this
matter. If we stick with these two rules, I think we should always
be OK:

(1) We should avoid any changes that might break compatibility with
    an officially supported firmware;
(2) Breaking "new Linux" <-> "old device tree" compatibility should
    be OK if (1) is satisfied.

Note that this applies only for targets that have no problem w/
device-tree upgrades.

> > And note that most developers are using up-to-date firmwares
> > (U-Boots), device trees, and kernels. 
> 
> So then why did we have to make cuImage?

I don't know. I've never used them. ;-) Honestly. But I believe
it's a great stuff for those who use really old and now unsupported
firmwares.

It has nothing to do with device-tree changes though. We can easily
maintain device-tree compatibility w/ firmwares, but what is the
point in maintaining Linux' compatibility for older device trees
when you can easily upgrade it?

That is, I still don't get why somebody don't want to upgrade
device tree along with Linux (assuming it won't cause breakages in
the firmware)?

[...]
> > Sure, there is a completely different story wrt device-tree
> > changes that might break firmwares. And that I believe we'd
> > better avoid. For example device_type = "soc", if removed,
> > most firmwares would not fix-up {clock,bus}-frequency properties.
> 
> Even if the given change may not break the firmware, it could force an
> update in which a prior change breaks the firmware.

I'm not sure I'm following here. Could you give an example?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
