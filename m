Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DD5CDDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 13:37:14 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
	<712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
Content-Type: text/plain
Date: Sat, 10 Feb 2007 13:37:01 +1100
Message-Id: <1171075021.20494.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-09 at 12:08 -0500, Dan Malek wrote:
> On Feb 8, 2007, at 8:41 AM, Timur Tabi wrote:
> 
> > Walking the page table is slower than using pointer math, so you  
> > want to
> > avoid iopa() if you can.
> 
> Big deal.  With all of the other kernel bloat
> going on you want to argue about a couple
> of memory accesses?  :-)

We are fairly careful about not bloating fast path in general. It's more
than a couple of memory accesses, especially with PTEs in highmem where
it involves kmap.

Ben.
