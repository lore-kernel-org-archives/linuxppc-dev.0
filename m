Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp08.blacknight.com (outbound-smtp08.blacknight.com
 [46.22.139.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJB1d4XpxzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:20:53 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
 by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id
 31DFE1C1B09
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 10:15:06 +0100 (IST)
Date: Mon, 30 May 2016 10:15:04 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oliver O'Halloran <oohall@gmail.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] mm/init: fix zone boundary creation
Message-ID: <20160530091504.GN2527@techsingularity.net>
References: <1462435033-15601-1-git-send-email-oohall@gmail.com>
 <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2016 at 02:21:42PM -0700, Andrew Morton wrote:
> On Thu,  5 May 2016 17:57:13 +1000 "Oliver O'Halloran" <oohall@gmail.com> wrote:
> 
> > As a part of memory initialisation the architecture passes an array to
> > free_area_init_nodes() which specifies the max PFN of each memory zone.
> > This array is not necessarily monotonic (due to unused zones) so this
> > array is parsed to build monotonic lists of the min and max PFN for
> > each zone. ZONE_MOVABLE is special cased here as its limits are managed by
> > the mm subsystem rather than the architecture. Unfortunately, this special
> > casing is broken when ZONE_MOVABLE is the not the last zone in the zone
> > list. The core of the issue is:
> > 
> > 	if (i == ZONE_MOVABLE)
> > 		continue;
> > 	arch_zone_lowest_possible_pfn[i] =
> > 		arch_zone_highest_possible_pfn[i-1];
> > 
> > As ZONE_MOVABLE is skipped the lowest_possible_pfn of the next zone
> > will be set to zero. This patch fixes this bug by adding explicitly
> > tracking where the next zone should start rather than relying on the
> > contents arch_zone_highest_possible_pfn[].
> 
> hm, this is all ten year old Mel code.
> 

ZONE_MOVABLE at the time always existed at the end of a node during
initialisation time. It was allowed because the memory was always "stolen"
from the end of the node where it could have the same limitations as
ZONE_HIGHMEM if necessary. It was also safe to assume that zones never
overlapped as zones were about addressing limitations.  If ZONE_CMA or
ZONE_DEVICE can overlap with other zones during initialisation time then
there may be a few gremlins hiding in there. Unfortunately I have not
done an audit searching for problems with overlapping zones.

-- 
Mel Gorman
SUSE Labs
