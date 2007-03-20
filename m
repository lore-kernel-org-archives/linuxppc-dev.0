Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 122D3DE1B4
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 03:34:27 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2KGYO3g014727
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 09:34:24 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2KGYNOB011700
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 11:34:23 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2KGEXc6006775
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 11:14:33 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CC455AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 11:34:22 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2KGYMUT006464
	for linuxppc-dev@ozlabs.org; Tue, 20 Mar 2007 11:34:22 -0500
Date: Tue, 20 Mar 2007 11:34:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070320163422.GA6290@ld0162-tx32.am.freescale.net>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172757.GC29784@ld0162-tx32.am.freescale.net>
	<20070320035005.GB21124@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070320035005.GB21124@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 02:50:05PM +1100, David Gibson wrote:
> On Fri, Mar 16, 2007 at 12:27:57PM -0500, Scott Wood wrote:
> > xlate_reg() uses the ranges properties of a node's parentage to find the
> > absolute physical address of the node's registers.
> > 
> > The ns16550 driver uses this when no virtual-reg property is found.
> 
> This is a pretty large chunk of code for use on just some platforms.

It'd be useful on most flatdevicetree platforms that don't have
physical addresses larger than virtual addresses...

> Remind me why we can't just insist on the presence of virtual-reg?

We can, if that's what the general consensus is... but I'd prefer not to.

For one thing, it impairs mobility of the SOC register block -- the
knowledge of where the SOC is mapped would be contained both in the SOC
node and in the serial nodes (and have to be updated both places).  This
could be a bit of a pain if macros and/or overlays are implemented.

And I don't really understand complaining about the wastage for platforms
that don't need it in this specific case, when it happens in many others:
flatdevtree code with true OF, command line editing when it can be edited
just fine in the bootloader, simple_alloc with true OF, gzip code when
not compressing vmlinux, etc.  Not to mention the duplication of device
tree manipulation code that could have been shared with the kernel if
this stuff weren't forced into the wrapper (why is OF allowed to have a
special prom_init, but nothing else?).

If we really want to optimize for size, the approach of including
everything except small bits of code for specific other platforms
probably isn't the best one.  Does anyone actually do the
wrap-kernels-separate-from-building thing?

-Scott
