Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id AD0B967A3F
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 09:46:46 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 21 Apr 2006 01:46:40 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420234640.GA20059@iram.es>
References: <28892.1145559466@www088.gmx.net>
	<20060420203848.GA23192@gate.ebshome.net>
	<1145567174.4517.1.camel@localhost.localdomain>
	<20060420211321.GB25755@gate.ebshome.net>
	<1145572770.4517.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145572770.4517.8.camel@localhost.localdomain>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 08:39:29AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-20 at 14:13 -0700, Eugene Surovegin wrote:
> > On Fri, Apr 21, 2006 at 07:06:13AM +1000, Benjamin Herrenschmidt wrote:
> > > Unfortunately, he has to do things a bit differently. He can't afford to
> > > have the kernel BAT mapping cover his non-cacheable pages. Thus he needs
> > > a reserved pool. Last I looked at our coherent code, it didn't reserve
> > > memory at all, just address space, thus assuming the CPU can handle
> > > having both a caheable and a non-cacheable mapping of the same pages...
> > > (On 6xx this is deadly even if you don't access those cacheable pages
> > > because the CPU prefetch may do it for you).
> > 
> > Ben, is this _real_ problem on 6xx or just a theory? Does 6xx actually 
> > prefetch beyond page boundary?
> > 
> > So far, all "prefetching" I saw which broke non-coherent DMA was not 
> > due to the CPU doing prefetching, but _software_ prefetching being 
> > too aggressive.
> 
> Not 100% certain... we definitely have a bug with AGP on macs currently
> for that reason though I yet have to isolate a crash caused by it ;)
> (That is, we map AGP pages non-cacheable but they stay in the linear
> mapping).

In this case the problem is double mapping with inconsistent attributes
(through BAT and page tables I assume). 

> 
> On POWER4, 970 and later, the chip guys confirmed that the problem is
> real though. Not only bcs of prefetch but also speculative execution
> which can cause the chip to do a load that will never actually be
> executed. Imagine for example a loop walking an array, the chip might
> speculatively load elements beyond the array by speculatively executing
> beyond the branch that ends the loop.

Even if the page has the guarded bit set?

	Gabriel
