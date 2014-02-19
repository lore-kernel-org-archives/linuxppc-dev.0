Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 859D92C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 04:24:18 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 12:24:15 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2085A38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 12:24:12 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JHNmnO8323544
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 17:24:12 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JGTrPK024056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 11:29:53 -0500
Date: Wed, 19 Feb 2014 08:24:38 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: ppc: RECLAIM_DISTANCE 10?
Message-ID: <20140219162438.GB27108@linux.vnet.ibm.com>
References: <20140218090658.GA28130@dhcp22.suse.cz>
 <20140218233404.GB10844@linux.vnet.ibm.com>
 <20140218235800.GC10844@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1402181737530.17521@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1402181737530.17521@chino.kir.corp.google.com>
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.02.2014 [17:43:38 -0800], David Rientjes wrote:
> On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:
> 
> > How about the following?
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 5de4337..1a0eced 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1854,7 +1854,8 @@ static void __paginginit init_zone_allows_reclaim(int nid)
> >         int i;
> >  
> >         for_each_online_node(i)
> > -               if (node_distance(nid, i) <= RECLAIM_DISTANCE)
> > +               if (node_distance(nid, i) <= RECLAIM_DISTANCE ||
> > +                                       !NODE_DATA(i)->node_present_pages)
> >                         node_set(i, NODE_DATA(nid)->reclaim_nodes);
> >                 else
> >                         zone_reclaim_mode = 1;
> 
>  [ I changed the above from NODE_DATA(nid) -> NODE_DATA(i) as you caught 
>    so we're looking at the right code. ]
> 
> That can't be right, it would allow reclaiming from a memoryless node.  I 
> think what you want is

Gah, you're right.

> 	for_each_online_node(i) {
> 		if (!node_present_pages(i))
> 			continue;
> 		if (node_distance(nid, i) <= RECLAIM_DISTANCE) {
> 			node_set(i, NODE_DATA(nid)->reclaim_nodes);
> 			continue;
> 		}
> 		/* Always try to reclaim locally */
> 		zone_reclaim_mode = 1;
> 	}
> 
> but we really should be able to do for_each_node_state(i, N_MEMORY) here 
> and memoryless nodes should already be excluded from that mask.

Yep, I found that afterwards, which simplifies the logic. I'll add this
to my series :)

<snip>

> > I think it's safe to move init_zone_allows_reclaim, because I don't
> > think any allocates are occurring here that could cause us to reclaim
> > anyways, right? Moving it allows us to safely reference
> > node_present_pages.
> > 
> 
> Yeah, this is fine.

Thanks,
Nish
