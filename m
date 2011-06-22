Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13688B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 08:05:41 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110622162457.1016390e@schlenkerla.am.freescale.net>
References: <20110603221232.GA29809@schlenkerla.am.freescale.net>
	<1308276050.2516.129.camel@pasglop>
	<20110617113215.56b3d6df@schlenkerla.am.freescale.net>
	<1308350669.32158.60.camel@pasglop>
	<20110622162457.1016390e@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Jun 2011 08:05:33 +1000
Message-ID: <1308780333.32158.171.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-22 at 16:24 -0500, Scott Wood wrote:
> 
> This saved another 1% or so.  I don't think TLB_SCRATCH needs to be saved
> by crit/debug/mcheck -- they shouldn't be taking TLB misses, at least
> in the bolted case.  

The code they call will (think accessing the UART)

> Even non-bolted, it doesn't look like there are enough
> extlb levels to deal with a linear TLB miss inside a crit/debug/mcheck
> inside a linear TLB miss inside a virtual page table miss inside a normal
> TLB miss.

My plan for crit/debug/mcheck (which I haven't implemented yet) was to
save the whole TLB save area onto the kernel stack and restore it.
 
> Currently, we could just as well take that crit/debug/mcheck after
> storing to TLB_SCRATCH but before saving it to extlb, and have the same
> problem.

Right. My point was more that TLB_SCRATCH itself shall be saved
somewhere by the crit/debug/mcheck handler along with the copy of the
TLB save area.

Cheers,
Ben.
