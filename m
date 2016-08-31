Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com
 [46.22.139.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPQBY5Y3vzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 22:47:00 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
 by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id
 F2EED1C2306
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 13:46:55 +0100 (IST)
Date: Wed, 31 Aug 2016 13:46:54 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Michal Hocko <mhocko@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Minchan Kim <minchan@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/34] mm, vmscan: make kswapd reclaim in terms of nodes
Message-ID: <20160831124654.GZ8119@techsingularity.net>
References: <1467970510-21195-1-git-send-email-mgorman@techsingularity.net>
 <1467970510-21195-8-git-send-email-mgorman@techsingularity.net>
 <20160829093844.GA2592@linux.vnet.ibm.com>
 <20160830120728.GV8119@techsingularity.net>
 <20160830142508.GA10514@linux.vnet.ibm.com>
 <20160830150051.GW8119@techsingularity.net>
 <20160831060959.GA6787@linux.vnet.ibm.com>
 <20160831084942.GX8119@techsingularity.net>
 <20160831110932.GB21661@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20160831110932.GB21661@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2016 at 01:09:33PM +0200, Michal Hocko wrote:
> > We cannot just convert populated_zone() as many existing users really
> > need to check for present_pages. This patch introduces a managed_zone()
> > helper and uses it in the few cases where it is critical that the check
> > is made for managed pages -- zonelist constuction and page reclaim.
> 
> OK, the patch makes sense to me. I am not happy about two very similar
> functions, to be honest though. managed vs. present checks will be quite
> subtle and it is not entirely clear when to use which one.

In the vast majority of cases, the distinction is irrelevant. The patch
only updates the places where it really matters to minimise any
confusion.

> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> /*
>  * Returns true if a zone has pages managed by the buddy allocator.
>  * All the reclaim decisions have to use this function rather than
>  * populated_zone(). If the whole zone is reserved then we can easily
>  * end up with populated_zone() && !managed_zone().
>  */
> 
> What do you think?
> 

This makes a lot of sense. I've updated the patch and will await a test
from Srikar before reposting.

-- 
Mel Gorman
SUSE Labs
