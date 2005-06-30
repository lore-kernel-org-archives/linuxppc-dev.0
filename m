Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CC7267B6A
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 15:11:52 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <3FD36254-F985-4040-A68A-72EEB212D8A3@freescale.com>
References: <1120089411.31924.36.camel@gaston>
	<3FD36254-F985-4040-A68A-72EEB212D8A3@freescale.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 15:06:08 +1000
Message-Id: <1120107968.31924.42.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: set_phys_avail() futures question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-06-30 at 00:06 -0500, Kumar Gala wrote:
> On Jun 29, 2005, at 6:56 PM, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2005-06-29 at 16:14 -0500, Jon Loeliger wrote:
> >
> >> Ben (primarily),
> >>
> >> I'd like to get your opinion on what the future of
> >> arch/ppc/mm/init.c/set_phys_avail() looks like.
> >> Currently, its job is to traverse the mem_pieces data
> >> and remove a whole series of #ifdef'ed regions of
> >> memory based on configuration options.  These regions
> >> are the initrd, the RTAS data, and the AGP special page.
> >>
> >> Do you see these regions as being explicitly listed in
> >> the proposed  "reserved memory blocks" area of the Flat
> >> Dev Tree header structure?
> >>
> >
> > Yes. initrd for sure, RTAS too, AGP special page well ... I have to
> > check if we still use that one at all... but it's not allocated in
> > prom_init so it may need it's own little bit here still.
> 
> What this implies to me is that what a flattened OF tree we will no  
> longer need to call set_phys_avail().

It will have to do some equivalent to transfer the reserve map to
mem_pieces tho ...

Ben.
