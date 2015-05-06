Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F1B51A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 19:28:19 +1000 (AEST)
Message-ID: <5549DEAC.6080709@suse.cz>
Date: Wed, 06 May 2015 11:28:12 +0200
From: Vlastimil Babka <vbabka@suse.cz>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] mm: vmscan: do not throttle based on pfmemalloc
 reserves if node has no reclaimable pages
References: <20150327192850.GA18701@linux.vnet.ibm.com>
 <5515BAF7.6070604@intel.com> <20150327222350.GA22887@linux.vnet.ibm.com>
 <20150331094829.GE9589@dhcp22.suse.cz> <551E47EF.5030800@suse.cz>
 <20150403174556.GF32318@linux.vnet.ibm.com>
 <20150505220913.GC32719@linux.vnet.ibm.com>
In-Reply-To: <20150505220913.GC32719@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Rik van Riel <riel@redhat.com>, anton@sambar.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Dave Hansen <dave.hansen@intel.com>, Mel Gorman <mgorman@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2015 12:09 AM, Nishanth Aravamudan wrote:
> On 03.04.2015 [10:45:56 -0700], Nishanth Aravamudan wrote:
>>> What I find somewhat worrying though is that we could potentially
>>> break the pfmemalloc_watermark_ok() test in situations where
>>> zone_reclaimable_pages(zone) == 0 is a transient situation (and not
>>> a permanently allocated hugepage). In that case, the throttling is
>>> supposed to help system recover, and we might be breaking that
>>> ability with this patch, no?
>>
>> Well, if it's transient, we'll skip it this time through, and once there
>> are reclaimable pages, we should notice it again.
>>
>> I'm not familiar enough with this logic, so I'll read through the code
>> again soon to see if your concern is valid, as best I can.
>
> In reviewing the code, I think that transiently unreclaimable zones will
> lead to some higher direct reclaim rates and possible contention, but
> shouldn't cause any major harm. The likelihood of that situation, as
> well, in a non-reserved memory setup like the one I described, seems
> exceedingly low.

OK, I guess when a reasonably configured system has nothing to reclaim, 
it's already busted and throttling won't change much.

Consider the patch Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Thanks,
> Nish
>
