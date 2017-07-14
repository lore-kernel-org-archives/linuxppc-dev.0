Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x82g36r5dzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 16:22:55 +1000 (AEST)
Message-ID: <1500013364.2865.73.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc/mm/radix: Avoid flushing the PWC on every
 flush_tlb_range
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com
Date: Fri, 14 Jul 2017 16:22:44 +1000
In-Reply-To: <87y3rrpo6n.fsf@skywalker.in.ibm.com>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <20170714015258.7933-3-benh@kernel.crashing.org>
 <87y3rrpo6n.fsf@skywalker.in.ibm.com>
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

On Fri, 2017-07-14 at 11:14 +0530, Aneesh Kumar K.V wrote:
> > +     pid = mm ? mm->context.id : 0;
> > +     if (unlikely(pid == MMU_NO_CONTEXT))
> > +             goto no_context;
> > +
> > +     /* 4k page size, just blow the world */
> > +     if (PAGE_SIZE == 0x1000) {
> > +             radix__flush_all_mm(mm);
> > +             return;
> > +     }
> 
> What is special here ? because it is 4096 tlb flushes ?

Yes, keeping in line with the existing logic in flush_tlb_pages(), more
than 32, do a full flush.

Cheers,
Ben.
