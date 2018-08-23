Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wwth22d3zF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 17:25:47 +1000 (AEST)
Date: Thu, 23 Aug 2018 09:25:43 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Haren Myneni <haren@linux.vnet.ibm.com>, n-horiguchi@ah.jp.nec.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180823072543.GS29735@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <87bm9ug34l.fsf@linux.ibm.com>
 <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 22-08-18 11:58:02, Mike Kravetz wrote:
> On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
[...]
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 4eb6e824a80c..f9bdea685cf4 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> >  				return pfn;
> >  			if (__PageMovable(page))
> >  				return pfn;
> > -			if (PageHuge(page)) {
> > +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> > +			    PageHuge(page)) {
> 
> How about using hugepage_migration_supported instead?  It would automatically
> catch those non-migratable huge page sizes.  Something like:
> 
> 			if (PageHuge(page) &&
> 			    hugepage_migration_supported(page_hstate(page))) {

Ohh, definitely, this is much better.
-- 
Michal Hocko
SUSE Labs
