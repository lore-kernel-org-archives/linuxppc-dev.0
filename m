Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68015DDF2B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 07:11:51 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBAKB7gd030245
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:11:07 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBAKBmgB166656
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:11:48 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBALBvXT026815
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 16:11:57 -0500
Date: Wed, 10 Dec 2008 15:11:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/2] powerpc: 44x doesn't need G set everywhere
Message-ID: <20081210151141.7a5a66b2@zod.rchland.ibm.com>
In-Reply-To: <1228939437.22413.75.camel@pasglop>
References: <20081210055139.A7FFCDDF65@ozlabs.org>
	<20081210083143.62b869f4@zod.rchland.ibm.com>
	<1228939437.22413.75.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 07:03:57 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > We still leave G=1 on the linear mapping for now, we need to
> > > stop over-mapping RAM to be able to remove it.
> > 
> > Hm.  Over-mapping it has the nice advantage that we use as few pinned
> > TLB entries as possible.  For 440x6 cores with more than 256 MiB of
> > DRAM, you could theoretically use a single 1GiB TLB entry to map all
> > kernel DRAM.
> 
> Ok well, there are several issues here.. see below
> 
> > Do you think the trade-offs of allowing speculative accesses are worth
> > the increased TLB pressure?  Large base pages will help with that in
> > some workloads, but others are still going to be TLB constrained.
> > 
> > I know, I'm probably paranoid.  But changing things like this around
> > without some kind of benchmark data or testcase to make sure we aren't
> > making it worse gives me the heebee-geebees.
> 
> Yup, which is why I'm not changing it yet :-) My initial thinking was
> along the lines of: We can use up to 4 bolted TLB entries, that will
> cover most classic memory configurations such as 256, 512 etc.... and
> leave what doesn't fit to highmem.
> 
> However that fails miserably with 128M which is quite common.
> 
> Then I thought we could overmap and use G for things that don't quite
> fit and remove G when we know we can do an exact mapping...
> 
> Then I though .. heh, first we know there is no speculative or
> prefetched data access on 440. We also know that speculative /
> prefetched instruction access is busted and must be disabled.
> 
> Thus can't we just both overmap and not have G ?
> 
> Needs testing of course :-) I'm waiting for an answer from the chip guys
> here.

Heh.  I like it.

> G=1 has some other impacts, such as preventing write combining I think,
> re-ordering, and a few other things.

Yeah.

Overall, I'm OK with changing things as long as we can sort of prove we
aren't making it worse.

josh
