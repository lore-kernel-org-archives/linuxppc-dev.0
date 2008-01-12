Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9734DDDFF8
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 12:53:31 +1100 (EST)
Subject: Re: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20080111223831.GA2947@gate.ebshome.net>
References: <7310408706.20071107014010@emcraft.com>
	<20071128195037.GB22325@gate.ebshome.net>
	<200801111824.46920.yur@emcraft.com>
	<20080111174152.GA17240@gate.ebshome.net>
	<1200089135.6896.59.camel@pasglop>
	<20080111223831.GA2947@gate.ebshome.net>
Content-Type: text/plain
Date: Sat, 12 Jan 2008 12:52:55 +1100
Message-Id: <1200102775.6896.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-11 at 14:38 -0800, Eugene Surovegin wrote:
> On Sat, Jan 12, 2008 at 09:05:35AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > >  The s/w synchronization algorithms proposed in my patches has no LL PLB 
> > > > limitations as opposed to h/w snooping, but, probably, this is not the best 
> > > > way of how it might be implemented. Even though with these patches the h/w 
> > > > accelerated RAID starts to operate correctly (with L2-cache enabled) there is 
> > > > a performance degradation (induced by loops in the L2-cache synchronization 
> > > > routines) observed in the most cases. So, as a result, there is no benefit 
> > > > from using L2-cache for these, RAID, cases at all.
> > > 
> > > Thanks a lot for explanation, Yuri. I'd never imagine they were so 
> > > stupid to make new chips with such behaviour.
> > 
> > Indeed. Now the question is do we want to make that configurable by the
> > platform so it can select whether to enable snooping, or use this
> > mechanism (in which case we can disable snooping on the L2) ?
> 
> I don't think we should panish platforms with sane L2 caches, because 
> there are some brain-dead ones.

I agree, which is why I'm thinking about making it some kind of explicit
thing that a give platform would call from it's setup_arch() callbacks
to turn on manual L2 sycnhronization.

> > Another option would be to make the dma_ops smart enough to know whether
> > a given device is on the snooped portion of the bus, which would be
> > easier to do after I merge 32 and 64 bits DMA ops, so we get the ability
> > to change the dma-ops per bus or per device even.
> > 
> > What do you guys think ?
> 
> I like the idea of having smart DMA routines with different 
> per-bus/device behaviour.

That would be longer term. When I merge the dma ops, I'll look into a
way to provide 44x specific DMA ops that handle that case, and then a
way for devices to be tagged (maybe via the device-tree) on whether they
are on an L2 coherent or non-L2 coherent segment of the bus.

Cheers,
Ben.
