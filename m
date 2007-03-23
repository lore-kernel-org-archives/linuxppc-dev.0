Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8D0D5DE05F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 02:18:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2NFIcJk019110
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 08:18:38 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2NFIb2Y014805
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 10:18:37 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2NEweMB011138
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 09:58:40 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id F3F94AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 10:18:36 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2NFIa4e006213
	for linuxppc-dev@ozlabs.org; Fri, 23 Mar 2007 10:18:36 -0500
Date: Fri, 23 Mar 2007 10:18:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] bootwrapper: Add a cuImage target.
Message-ID: <20070323151836.GC6060@ld0162-tx32.am.freescale.net>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194928.GE31965@ld0162-tx32.am.freescale.net>
	<20070323054048.GA27940@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323054048.GA27940@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 04:40:48PM +1100, David Gibson wrote:
> > +cuboot-plats :=
> > +src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
> 
> Rather than this special cuboot-plats stuff, I suggest you just list
> each cuboot platform in src-plat independently.

OK, I suppose the number of platforms will be few enough for that.

> We can also git rid of the need for a CONFIG option specifying the dts
> (and thereby taking us back to the one-config-per-board era) by using
> rules like:
> 
> $(obj)/uImage.83xx.%: vmlinux $(wrapperbits) $(srctree)/$(src)/dts/%.dts
> 	$(call if_changed,wrap,cuboot-83xx,$(srctree)/$(src)/dts/$*)

But then you can't build with an out-of-tree dts.  It's not a huge deal,
but still...  What's wrong with a config option?

> And to get the right things built use something like:
> image-$(CONFIG-83xx)	+= $(mpx83xx-boards:%=uImage.83xx.%)

And then I'd have to determine which boards are supported by the kernel
that was built, so I don't trick the user into thinking that valid images
were produced for every single 83xx.  I'd also have to enumerate every
single board in the makefile, which would suck.

> Or optionally add a batch of bool config options for each board
> variant.

I don't want to do that.  There shouldn't have to be a 1-1 correspondence
between each dts file and anything in the kernel.

-Scott
