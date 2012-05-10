Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 70225B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 23:44:41 +1000 (EST)
Date: Thu, 10 May 2012 14:34:55 +0100
From: Mel Gorman <mel@csn.ul.ie>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] page_alloc.c: remove argument to
 pageblock_default_order
Message-ID: <20120510133454.GG9004@csn.ul.ie>
References: <1336065312-2891-1-git-send-email-rajman.mekaco@gmail.com>
 <20120503163749.d24bf07f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20120503163749.d24bf07f.akpm@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, rajman mekaco <rajman.mekaco@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Minchan Kim <minchan.kim@gmail.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2012 at 04:37:49PM -0700, Andrew Morton wrote:
> On Thu,  3 May 2012 22:45:12 +0530
> rajman mekaco <rajman.mekaco@gmail.com> wrote:
> 
> > When CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is not defined, then
> > pageblock_default_order has an argument to it.
> > 
> > However, free_area_init_core will call it without any argument
> > anyway.
> > 
> > Remove the argument to pageblock_default_order when
> > CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is not defined.
> > 
> > Signed-off-by: rajman mekaco <rajman.mekaco@gmail.com>
> > ---
> >  mm/page_alloc.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a712fb9..4b95412 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4274,7 +4274,7 @@ static inline void __init set_pageblock_order(unsigned int order)
> >   * at compile-time. See include/linux/pageblock-flags.h for the values of
> >   * pageblock_order based on the kernel config
> >   */
> > -static inline int pageblock_default_order(unsigned int order)
> > +static inline int pageblock_default_order(void)
> >  {
> >  	return MAX_ORDER-1;
> >  }
> 
> Interesting.  It has been that way since at least 3.1.
> 

/me slaps self

> It didn't break the build because pageblock_default_order() is only
> ever invoked by set_pageblock_order(), with:
> 
> 	set_pageblock_order(pageblock_default_order());
> 
> and set_pageblock_order() is a macro:
> 
> #define set_pageblock_order(x)	do {} while (0)
> 
> There's yet another reason not to use macros, dammit - they hide bugs.
> 
> 
> Mel, can you have a think about this please?  Can we just kill off
> pageblock_default_order() and fold its guts into
> set_pageblock_order(void)?  Only ia64 and powerpc can define
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE.
> 

This looks reasonable to me.

-- 
Mel Gorman
SUSE Labs
