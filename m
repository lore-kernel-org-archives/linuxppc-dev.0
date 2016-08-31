Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPFPH4MXczDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 16:10:43 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7V63Asf044357
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 02:10:41 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 255ncrumvm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 02:10:40 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 31 Aug 2016 11:40:36 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 46F18E0074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 11:39:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7V6ADgu15991032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 11:40:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7V6A1AE028021
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 11:40:12 +0530
Date: Wed, 31 Aug 2016 11:39:59 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/34] mm, vmscan: make kswapd reclaim in terms of nodes
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1467970510-21195-1-git-send-email-mgorman@techsingularity.net>
 <1467970510-21195-8-git-send-email-mgorman@techsingularity.net>
 <20160829093844.GA2592@linux.vnet.ibm.com>
 <20160830120728.GV8119@techsingularity.net>
 <20160830142508.GA10514@linux.vnet.ibm.com>
 <20160830150051.GW8119@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160830150051.GW8119@techsingularity.net>
Message-Id: <20160831060959.GA6787@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > The trigger is memblock_reserve() for the complete node memory.  And
> > this is exactly what FA_DUMP does.  Here again the node has memory but
> > its all reserved so there is no free memory in the node.
> > 
> > Did you mean populated_zone() when you said zone_populated or have I
> > mistaken? populated_zone() does return 1 since it checks for
> > zone->present_pages.
> > 
> 
> Yes, I meant populated_zone(). Using present pages may have hidden
> a long-lived corner case as it was unexpected that an entire node
> would be reserved. The old code happened to survive *probably* because
> pgdat_reclaimable would look false and kswapd checks for pgdat being
> balanced would happen to do the right thing in this case.
> 
> Can you check if something like this works?
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d572b78b65e1..cf64a5456cf6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -830,7 +830,7 @@ unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
> 
>  static inline int populated_zone(struct zone *zone)
>  {
> -	return (!!zone->present_pages);
> +	return (!!zone->managed_pages);
>  }
> 
>  extern int movable_zone;
> 

This indeed fixes the problem.
Please add my 
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
