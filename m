Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E293DE039
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 09:06:15 +1100 (EST)
Subject: Re: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20080111174152.GA17240@gate.ebshome.net>
References: <7310408706.20071107014010@emcraft.com>
	<20071128195037.GB22325@gate.ebshome.net>
	<200801111824.46920.yur@emcraft.com>
	<20080111174152.GA17240@gate.ebshome.net>
Content-Type: text/plain
Date: Sat, 12 Jan 2008 09:05:35 +1100
Message-Id: <1200089135.6896.59.camel@pasglop>
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


> >  The s/w synchronization algorithms proposed in my patches has no LL PLB 
> > limitations as opposed to h/w snooping, but, probably, this is not the best 
> > way of how it might be implemented. Even though with these patches the h/w 
> > accelerated RAID starts to operate correctly (with L2-cache enabled) there is 
> > a performance degradation (induced by loops in the L2-cache synchronization 
> > routines) observed in the most cases. So, as a result, there is no benefit 
> > from using L2-cache for these, RAID, cases at all.
> 
> Thanks a lot for explanation, Yuri. I'd never imagine they were so 
> stupid to make new chips with such behaviour.

Indeed. Now the question is do we want to make that configurable by the
platform so it can select whether to enable snooping, or use this
mechanism (in which case we can disable snooping on the L2) ?

Another option would be to make the dma_ops smart enough to know whether
a given device is on the snooped portion of the bus, which would be
easier to do after I merge 32 and 64 bits DMA ops, so we get the ability
to change the dma-ops per bus or per device even.

What do you guys think ?

Cheers,
Ben.
