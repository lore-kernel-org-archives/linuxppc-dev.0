Return-Path: <holt@sgi.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFDFBB70BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 20:01:04 +1000 (EST)
Received: from relay.sgi.com (relay3.sgi.com [192.48.156.57])
	by ozlabs.org (Postfix) with ESMTP id 76410DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 20:01:04 +1000 (EST)
Date: Tue, 9 Jun 2009 04:55:07 -0500
From: Robin Holt <holt@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v4] zone_reclaim is always 0 by default
Message-ID: <20090609095507.GA9851@attica.americas.sgi.com>
References: <20090604192236.9761.A69D9226@jp.fujitsu.com>
	<20090608115048.GA15070@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090608115048.GA15070@csn.ul.ie>
Cc: Rik van Riel <riel@redhat.com>, Christoph Lameter <cl@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Robin Holt <holt@sgi.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	linux-ia64@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Wu Fengguang <fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 08, 2009 at 12:50:48PM +0100, Mel Gorman wrote:

Let me start by saying I agree completely with everything you wrote and
still disagree with this patch, but was willing to compromise and work
around this for our upcoming x86_64 machine by putting a "value add"
into our packaging of adding a sysctl that turns reclaim back on.

...
> > Index: b/arch/powerpc/include/asm/topology.h
> > ===================================================================
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -10,6 +10,12 @@ struct device_node;
> >  
> >  #include <asm/mmzone.h>
> >  
> > +/*
> > + * Distance above which we begin to use zone reclaim
> > + */
> > +#define RECLAIM_DISTANCE 20
> > +
> > +
> 
> Where is the ia-64-specific modifier to RECAIM_DISTANCE?

It was already defined as 15 in arch/ia64/include/asm/topology.h

Thanks,
Robin
