Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPXYJ5LRtzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 03:33:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7VHXGQO125497
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 13:33:38 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2561d17sy1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 13:33:37 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 03:33:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6525D2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 03:33:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7VHXRPu57868296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 03:33:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7VHXQ2Y012849
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 03:33:27 +1000
Date: Wed, 31 Aug 2016 23:03:20 +0530
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
 <20160831060959.GA6787@linux.vnet.ibm.com>
 <20160831084942.GX8119@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160831084942.GX8119@techsingularity.net>
Message-Id: <20160831173320.GA5851@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> mm, vmscan: Only allocate and reclaim from zones with pages managed by the buddy allocator
> 
> Firmware Assisted Dump (FA_DUMP) on ppc64 reserves substantial amounts
> of memory when booting a secondary kernel. Srikar Dronamraju reported that
> multiple nodes may have no memory managed by the buddy allocator but still
> return true for populated_zone().
> 
> Commit 1d82de618ddd ("mm, vmscan: make kswapd reclaim in terms of nodes")
> was reported to cause kswapd to spin at 100% CPU usage when fadump was
> enabled. The old code happened to deal with the situation of a populated
> node with zero free pages by co-incidence but the current code tries to
> reclaim populated zones without realising that is impossible.
> 
> We cannot just convert populated_zone() as many existing users really
> need to check for present_pages. This patch introduces a managed_zone()
> helper and uses it in the few cases where it is critical that the check
> is made for managed pages -- zonelist constuction and page reclaim.

one nit
s/constuction/construction/

> 

Verified that it works fine.

-- 
Thanks and Regards
Srikar Dronamraju
