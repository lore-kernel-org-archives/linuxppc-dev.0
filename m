Return-Path: <cl@linux-foundation.org>
Received: from nlpi157.prodigy.net (nlpi157.sbcis.sbc.com [207.115.36.171])
	by ozlabs.org (Postfix) with ESMTP id C29E3B7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 02:19:42 +1100 (EST)
Date: Mon, 1 Mar 2010 09:19:15 -0600 (CST)
From: Christoph Lameter <cl@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
In-Reply-To: <20100301120632.GB3852@csn.ul.ie>
Message-ID: <alpine.DEB.2.00.1003010859480.1309@router.home>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie> <20100223015551.GG31681@kryten>
	<20100301120632.GB3852@csn.ul.ie>
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

On Mon, 1 Mar 2010, Mel Gorman wrote:

> Christoph, how feasible would it be to allow parallel reclaimers in
> __zone_reclaim() that back off at a rate depending on the number of
> reclaimers?

Not too hard. Zone locking is there but there may be a lot of bouncing
cachelines if you run it concurrently.
