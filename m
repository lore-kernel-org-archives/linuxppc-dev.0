Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Qdt6TrNzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:22:10 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A9JHlM057940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 05:22:08 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9uc2ug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 05:22:07 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 19:21:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2E1D12BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:21:50 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A9Lo7e30015634
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:21:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A9Lm6a020073
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:21:49 +1000
Date: Wed, 10 Aug 2016 14:51:45 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] fadump: Register the memory reserved by fadump
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1470318165-2521-1-git-send-email-srikar@linux.vnet.ibm.com>
 <87mvkritii.fsf@concordia.ellerman.id.au>
 <20160805072838.GF11268@linux.vnet.ibm.com>
 <87h9azin4g.fsf@concordia.ellerman.id.au>
 <20160805100609.GP2799@techsingularity.net>
 <87d1lhtb3s.fsf@concordia.ellerman.id.au>
 <20160810064056.GB24800@linux.vnet.ibm.com>
 <877fbpt8ju.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <877fbpt8ju.fsf@concordia.ellerman.id.au>
Message-Id: <20160810092145.GA20502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-08-10 16:57:57]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> >> 
> >> > Conceptually it would be cleaner, if expensive, to calculate the real
> >> > memblock reserves if HASH_EARLY and ditch the dma_reserve, memory_reserve
> >> > and nr_kernel_pages entirely.
> >> 
> >> Why is it expensive? memblock tracks the totals for all memory and
> >> reserved memory AFAIK, so it should just be a case of subtracting one
> >> from the other?
> >
> > Are you suggesting that we use something like
> > memblock_phys_mem_size() but one which returns
> > memblock.reserved.total_size ? Maybe a new function like
> > memblock_reserved_mem_size()?
> 
> Yeah, something like that. I'm not sure if it actually needs a function,
> AFAIK you can just look at the structure directly.

For now memblock structure is only available in mm/memblock.c
Every other access to memblock from outside mm/memblock is through an
api.

> >
> > Yes, this is a possibility, for example lets say we want fadump to
> > continue to run instead of rebooting to a new kernel as it does today.
> 
> But that's a bad idea and no one should ever do it.
> 
> For starters all your caches will be undersized, and anything that is
> allocated per-node early in boot will not be allocated on the nodes
> which were reserved, so the system's performance will potentially differ
> from a normal boot in weird and unpredictable ways.
> 

Okay

-- 
Thanks and Regards
Srikar Dronamraju
