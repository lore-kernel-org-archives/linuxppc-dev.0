Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGFf1VxyzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:11:01 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EDAIYg087117
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 09:10:59 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cbbuja1c9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 09:10:59 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 14 Aug 2017 23:10:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7EDArn335324024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:10:53 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7EDAqfR017472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:10:53 +1000
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit
 for early allocations
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com
Date: Mon, 14 Aug 2017 23:10:50 +1000
In-Reply-To: <87h8xaqpp8.fsf@concordia.ellerman.id.au>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1502716250.4493.25.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 22:49 +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > This removes the RMA limit on powernv platform, which constrains
> > early allocations such as PACAs and stacks. There are still other
> > restrictions that must be followed, such as bolted SLB limits, but
> > real mode addressing has no constraints.

For radix, should we consider making the PACAs chip/node local ?

> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/hash_utils_64.c | 24 +++++++++++++++---------
> >  arch/powerpc/mm/pgtable-radix.c | 33 +++++++++++++++++----------------
> 
> I missed that we'd duplicated this logic for radix vs hash [yes I know I
> merged the commit that did it :)]
> 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index 671a45d86c18..61ca17d81737 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -598,22 +598,23 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
> >  	 * physical on those processors
> >  	 */
> >  	BUG_ON(first_memblock_base != 0);
> > -	/*
> > -	 * We limit the allocation that depend on ppc64_rma_size
> > -	 * to first_memblock_size. We also clamp it to 1GB to
> > -	 * avoid some funky things such as RTAS bugs.
> 
> That comment about RTAS is 7 years old, and I'm pretty sure it was a
> historical note when it was written.
> 
> I'm inclined to drop it and if we discover new bugs with RTAS on Power9
> then we can always put it back.
> 
> > -	 *
> > -	 * On radix config we really don't have a limitation
> > -	 * on real mode access. But keeping it as above works
> > -	 * well enough.
> 
> Ergh.
> 
> > -	 */
> > -	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
> > -	/*
> > -	 * Finally limit subsequent allocations. We really don't want
> > -	 * to limit the memblock allocations to rma_size. FIXME!! should
> > -	 * we even limit at all ?
> > -	 */
> 
> So I think we should just delete this function entirely.
> 
> Any objections?
> 
> cheers
