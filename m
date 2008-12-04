Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D2CCDDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 09:02:56 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors v2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081204073314.2ee5d809@zod.rchland.ibm.com>
References: <20081204061341.C45CBDDDF6@ozlabs.org>
	<20081204073314.2ee5d809@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Dec 2008 09:02:49 +1100
Message-Id: <1228428169.10722.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 07:33 -0500, Josh Boyer wrote:
> On Thu, 04 Dec 2008 17:12:59 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
> > these processors. The result is that update_mmu_cache() would flush
> > the cache for all pages mapped to userspace which is totally
> > unnecessary on those processors since we already handle flushing
> > on execute in the page fault path.
> > 
> > This should provide a nice speed up ;-)
> 
> Did you test it this time?  If so, how and what were the results?

Yes, I verified I no longer had PG_arch1 all over my PCI GART pages with
DRI enabled :-)

I didn't actually benchmark anything.

Cheers,
Ben.
