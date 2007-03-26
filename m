Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id F0265DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 01:53:32 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2QFrS7v010161
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 08:53:28 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2QFrRfb024714
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 10:53:27 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2QFXM9P020522
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 10:33:22 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 13994AEFC9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 10:53:26 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2QFrPX7028686
	for linuxppc-dev@ozlabs.org; Mon, 26 Mar 2007 10:53:25 -0500
Date: Mon, 26 Mar 2007 10:53:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070326155325.GA28620@ld0162-tx32.am.freescale.net>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
	<20070323055442.GB27940@localhost.localdomain>
	<20070323153056.GD6060@ld0162-tx32.am.freescale.net>
	<20070323233712.GC4459@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323233712.GC4459@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2007 at 10:37:12AM +1100, David Gibson wrote:
> Is there any reasonable way we can determine the memory size early
> enough for the zImage to relocate itself to (approximately) the top of
> RAM first thing?

We can with cuboot (and it's at the beginning of the bd_t, so it's not
affected by the ifdef mess), but some platforms might require accessing
the device tree to get that information.

> Or we could get the wrapper script to base the link/load address on
> the vmlinux size.

That'd be nice.

> > I'm not sure that it's true that only in-tree device trees would be used
> > -- I can imagine customers having old firmware on custom boards that
> > would like to upgrade the kernel, but do not want to upgrade the
> > firmware.
> 
> Um.. since the zImage's tree comes from the kernel, what does
> upgrading the firmware have to do with it?

My point was simply that it's not just the reference boards with
in-kernel dts files that this would be useful on.  Thus, it makes sense
to allow out-of-tree dts files.

> > I'd be happy to see the name be changed to just be "/soc", though it
> > would require u-boot changes.
> 
> Err.. why?

So we don't have to partition the dts files into "works with cuimage" and
"works with dt-aware u-boot".  U-boot has hardcoded references to the soc
node with model number.

-Scott
