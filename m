Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNMxN0zkVzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 18:03:03 +1000 (AEST)
Message-ID: <1501747359.2664.41.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Aug 2017 18:02:39 +1000
In-Reply-To: <62a8ad99-137f-765c-aa1b-ad5ba22231d0@kaod.org>
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
 <62a8ad99-137f-765c-aa1b-ad5ba22231d0@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 09:45 +0200, Cédric Le Goater wrote:
> On 08/02/2017 11:57 PM, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-08-02 at 18:43 +0200, Cédric Le Goater wrote:
> > > If xive_find_target_in_mask() fails to find a cpu, the fuzz value used
> > > in xive_pick_irq_target() is decremented and reused in the last
> > > returning call to xive_find_target_in_mask(). This can result in such
> > > WARNINGs if the initial fuzz value is zero :
> > 
> > Ah indeed ... would have worked better if "fuzz" had been unsigned.
> 
> but 'fuzz' is unsigned ! 

Haha right.

> With a -1, unsigned or not, the 'first' cpu  becomes out of range for
> the calculation below :
> 
> 	/* Pick up a starting point CPU in the mask based on  fuzz */
> 	num = cpumask_weight(mask);
> 	first = fuzz % num;

How can it ? fuzz % num should then return something that's

	0 <= first < num

Regardless of the value of fuzz.

Which means we should be able to locate it. The only case I could think
of that would fail would be if num is 0

> 	/* Locate it */
> 	cpu = cpumask_first(mask);
> 	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
> 		cpu = cpumask_next(cpu, mask);
> 
> May be there is a better fix ? 
> 

> Also, I am not sure of :
> 
> 	num = cpumask_weight(mask);
> 
> shouldn't we be using : 
> 
> 	num = nr_cpu_ids;
> 
> In that case, 'first' would have been in the cpu range.

No that's the whole point. If we did that, then we would go out of the
mask.

The basic idea is that the mask contains "num" bits set, and we want to
pick one of them. But those bits can be bit 0, 5, 12 ... while
nr_cpu_ids can be 96 for example.

So for example, if the bits set as above, and fuzz is 5, we have

num is 3 (3 bits set in the mask)

first will then be 5 % 3 which is 2. That means that we want to pick
the "2th 0-based" ie the 3rd bit in the mask as our tentative target.

So the loop will iterate all the bits in the mask until i reaches
first, which is 2. So it will start with cpu = 0 i = 0, then cpu = 5 i
= 1, then cpu = 12 i = 2 and will exit then.

Ben.

> Cheers,
> 
> C.
> 
