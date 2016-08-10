Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8M452w9czDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:41:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A6d4Ve027933
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:41:06 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9q6de5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:41:06 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 16:41:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4162D3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:41:01 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A6f1cQ15335646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:41:01 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A6excM011898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:41:00 +1000
Date: Wed, 10 Aug 2016 12:10:56 +0530
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87d1lhtb3s.fsf@concordia.ellerman.id.au>
Message-Id: <20160810064056.GB24800@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> > Conceptually it would be cleaner, if expensive, to calculate the real
> > memblock reserves if HASH_EARLY and ditch the dma_reserve, memory_reserve
> > and nr_kernel_pages entirely.
> 
> Why is it expensive? memblock tracks the totals for all memory and
> reserved memory AFAIK, so it should just be a case of subtracting one
> from the other?

Are you suggesting that we use something like
memblock_phys_mem_size() but one which returns
memblock.reserved.total_size ? Maybe a new function like
memblock_reserved_mem_size()?

> 
> > Unfortuantely, aside from the calculation,
> > there is a potential cost due to a smaller hash table that affects everyone,
> > not just ppc64.
> 
> Yeah OK. We could make it an arch hook, or controlled by a CONFIG.

If its based on memblock.reserved.total_size, then should it be arch
specific?

> 
> > However, if the hash table is meant to be sized on the
> > number of available pages then it really should be based on that and not
> > just a made-up number.
> 
> Yeah that seems to make sense.
> 
> The one complication I think is that we may have memory that's marked
> reserved in memblock, but is later freed to the page allocator (eg.
> initrd).

Yes, this is a possibility, for example lets say we want fadump to
continue to run instead of rebooting to a new kernel as it does today.

> 
> I'm not sure if that's actually a concern in practice given the relative
> size of the initrd and memory on most systems. But possibly there are
> other things that get reserved and then freed which could skew the hash
> table size calculation.
> 

-- 
Thanks and Regards
Srikar Dronamraju
