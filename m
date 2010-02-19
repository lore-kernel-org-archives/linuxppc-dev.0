Return-Path: <cl@linux-foundation.org>
Received: from nlpi157.prodigy.net (nlpi157.sbcis.sbc.com [207.115.36.171])
	by ozlabs.org (Postfix) with ESMTP id CFB00B7C98
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 02:17:59 +1100 (EST)
Date: Fri, 19 Feb 2010 09:12:17 -0600 (CST)
From: Christoph Lameter <cl@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
In-Reply-To: <20100219145523.GN30258@csn.ul.ie>
Message-ID: <alpine.DEB.2.00.1002190906190.7486@router.home>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 19 Feb 2010, Mel Gorman wrote:

> > > The patch below sets a smaller value for RECLAIM_DISTANCE and thus enables
> > > zone reclaim.
> >
>
> I've no problem with the patch anyway.

Nor do I.

> > - We seem to end up racing between zone_watermark_ok, zone_reclaim and
> >   buffered_rmqueue. Since everyone is in here the memory one thread reclaims
> >   may be stolen by another thread.
> >
>
> You're pretty much on the button here. Only one thread at a time enters
> zone_reclaim. The others back off and try the next zone in the zonelist
> instead. I'm not sure what the original intention was but most likely it
> was to prevent too many parallel reclaimers in the same zone potentially
> dumping out way more data than necessary.

Yes it was to prevent concurrency slowing down reclaim. At that time the
number of processors per NUMA node was 2 or so. The number of pages that
are reclaimed is limited to avoid tossing too many page cache pages.

> You could experiment with waiting on the bit if the GFP flags allowi it? The
> expectation would be that the reclaim operation does not take long. Wait
> on the bit, if you are making the forward progress, recheck the
> watermarks before continueing.

You could reclaim more pages during a zone reclaim pass? Increase the
nr_to_reclaim in __zone_reclaim() and see if that helps. One zone reclaim
pass should reclaim enough local pages to keep the processors on a node
happy for a reasonable interval. Maybe do a fraction of a zone? 1/16th?
