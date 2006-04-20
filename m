Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0D5267A05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 08:40:15 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060420211908.GC25755@gate.ebshome.net>
References: <28892.1145559466@www088.gmx.net>
	<20060420203848.GA23192@gate.ebshome.net>
	<1145567174.4517.1.camel@localhost.localdomain>
	<20060420211321.GB25755@gate.ebshome.net>
	<20060420211908.GC25755@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 08:40:05 +1000
Message-Id: <1145572806.4517.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-20 at 14:19 -0700, Eugene Surovegin wrote:
> On Thu, Apr 20, 2006 at 02:13:21PM -0700, Eugene Surovegin wrote:
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
> Even if this "prefetching" problem is real, instead of implementing 
> separate pool for allocations which will be quite rare at best, just 
> allocate guard space before your consistent memory and stop worrying 
> about it.

Won't necessarily help with the speculative execution problem and in
fact, how do you do that in practice ?

Ben.
