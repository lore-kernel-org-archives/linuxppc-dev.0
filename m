Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGJG59CzzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:13:18 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EDATI6145187
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 09:13:15 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cbasgn7cd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 09:13:15 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 14 Aug 2017 23:13:12 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7EDD9cf32047210
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:13:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7EDD9nx022393
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:13:09 +1000
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit
 for early allocations
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com
Date: Mon, 14 Aug 2017 23:13:07 +1000
In-Reply-To: <87h8xaqpp8.fsf@concordia.ellerman.id.au>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1502716387.4493.27.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 22:49 +1000, Michael Ellerman wrote:
> > -     /*
> > -      * We limit the allocation that depend on ppc64_rma_size
> > -      * to first_memblock_size. We also clamp it to 1GB to
> > -      * avoid some funky things such as RTAS bugs.
> 
> That comment about RTAS is 7 years old, and I'm pretty sure it was a
> historical note when it was written.
> 
> I'm inclined to drop it and if we discover new bugs with RTAS on Power9
> then we can always put it back.

Arent' we using a 32-bit RTAS ? (Afaik there's a 64-bit one, we just
never used it ..). In this case we need to at least clamp to 2G (no
trust RTAS doing unsigned properly).

> > -      *
> > -      * On radix config we really don't have a limitation
> > -      * on real mode access. But keeping it as above works
> > -      * well enough.
> 
> Ergh.
> 
> > -      */
> > -     ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
> > -     /*
> > -      * Finally limit subsequent allocations. We really don't want
> > -      * to limit the memblock allocations to rma_size. FIXME!! should
> > -      * we even limit at all ?
> > -      */
> 
> So I think we should just delete this function entirely.
> 
> Any objections?

Well.. RTAS is quite sucky ... 

Ben.

> cheers
