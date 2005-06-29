Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2328367BA1
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 10:02:26 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1120079668.1798.98.camel@cashmere.sps.mot.com>
References: <1120079668.1798.98.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:56:51 +1000
Message-Id: <1120089411.31924.36.camel@gaston>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: set_phys_avail() futures question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-29 at 16:14 -0500, Jon Loeliger wrote:
> Ben (primarily),
> 
> I'd like to get your opinion on what the future of
> arch/ppc/mm/init.c/set_phys_avail() looks like.
> Currently, its job is to traverse the mem_pieces data
> and remove a whole series of #ifdef'ed regions of
> memory based on configuration options.  These regions
> are the initrd, the RTAS data, and the AGP special page.
> 
> Do you see these regions as being explicitly listed in 
> the proposed  "reserved memory blocks" area of the Flat
> Dev Tree header structure?

Yes. initrd for sure, RTAS too, AGP special page well ... I have to
check if we still use that one at all... but it's not allocated in
prom_init so it may need it's own little bit here still.

> If so, then they would follow the same conceptual flow
> as the ppc64 reservations in the LMB.  They would then
> be SetPagReserved() and removed from the do_init_bootmem()
> regions of memory as well.

I'm not sure we actually need to explicitely call SetPageReserved(), do
we ? As long as they are not returned to the free pool ...  Oh well,
that can't hurt :)

Ben.
