Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 237DCB70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 23:48:41 +1000 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 27E7DDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 23:48:38 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n59DmaN1026882 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Tue, 9 Jun 2009 22:48:36 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 48B1845DE63
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 22:48:36 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 15F8F45DE57
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 22:48:36 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E1BFC1DB8040
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 22:48:35 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D8941DB803B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 22:48:35 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v4] zone_reclaim is always 0 by default
In-Reply-To: <20090608115048.GA15070@csn.ul.ie>
References: <20090604192236.9761.A69D9226@jp.fujitsu.com>
	<20090608115048.GA15070@csn.ul.ie>
Message-Id: <20090609211721.DD9A.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Tue,  9 Jun 2009 22:48:34 +0900 (JST)
Cc: Rik van Riel <riel@redhat.com>, Christoph Lameter <cl@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Robin Holt <holt@sgi.com>, kosaki.motohiro@jp.fujitsu.com,
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

Hi

sorry for late responce. my e-mail reading speed is very slow ;-)

First, Could you please read past thread?
I think many topic of this mail are already discussed.


> On Thu, Jun 04, 2009 at 07:23:15PM +0900, KOSAKI Motohiro wrote:
> > 
> > Current linux policy is, zone_reclaim_mode is enabled by default if the machine
> > has large remote node distance. it's because we could assume that large distance
> > mean large server until recently.
> > 
> 
> We don't make assumptions about the server being large, small or otherwise. The
> affinity tables reporting a distance of 20 or more is saying "remote memory
> has twice the latency of local memory". This is true irrespective of workload
> and implies that going off-node has a real penalty regardless of workload.

No.
Now, we talk about off-node allocation vs unnecessary file cache dropping.
IOW, off-node allocation vs disk access.

Then, the worth doesn't only depend on off-node distance, but also depend on
workload IO tendency and IO speed.

Fujitsu has 64 core ia64 HPC box, zone-reclaim sometimes made performance
degression although its box. 

So, I don't think this problem is small vs large machine issue.
nor i7 issue.
high-speed P2P CPU integrated memory controller expose old issue.


> > In general, workload depended configration shouldn't put into default settings.
> > 
> > However, current code is long standing about two year. Highest POWER and IA64 HPC machine
> > (only) use this setting.
> > 
> > Thus, x86 and almost rest architecture change default setting, but Only power and ia64
> > remain current configuration for backward-compatibility.
> > 
> 
> What about if it's x86-64-based NUMA but it's not i7 based. There, the
> NUMA distances might really mean something and that zone_reclaim behaviour
> is desirable.

hmmm..
I don't hope ignore AMD, I think it's common characterastic of P2P and
integrated memory controller machine.

Also, I don't hope detect CPU family or similar, because we need update
such code evey when Intel makes new cpu.

Can we detect P2P interconnect machine? I'm not sure.


> I think if we're going down the road of setting the default, it shouldn't be
> per-architecture defaults as such. Other choices for addressing this might be;
> 
> 1. Make RECLAIM_DISTANCE a variable on x86. Set it to 20 by default, and 5
>    (or some other sensible figure) on i7
> 
> 2. There should be a per-arch modifier callback for the affinity
>    distances. If the x86 code detects the CPU is an i7, it can reduce the
>    reported latencies to be more in line with expected reality.
> 
> 3. Do not use zone_reclaim() for file-backed data if more than 20% of memory
>    overall is free. The difficulty is figuring out if the allocation is for
>    file pages.
> 
> 4. Change zone_reclaim_mode default to mean "do your best to figure it
>    out". Patch 1 would default large distances to 1 to see what happens.
>    Then apply a heuristic when in figure-it-out mode and using reclaim_mode == 1
> 
> 	If we have locally reclaimed 2% of the nodes memory in file pages
> 	within the last 5 seconds when >= 20% of total physical memory was
> 	free, then set the reclaim_mode to 0 on the assumption the node is
> 	mostly caching pages and shouldn't be reclaimed to avoid excessive IO
> 
> Option 1 would appear to be the most straight-forward but option 2
> should be doable. Option 3 and 4 could turn into a rats nest and I would
> consider those approaches a bit more drastic.

hmhm. 
I think the key-point of option 1 and 2 are proper hardware detecting way.

option 3 and 4 are more prefere idea to me. I like workload adapted heuristic.
but you already pointed out its hard, because page-allocator don't know
allocation purpose ;)


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


arch/ia64/include/asm/topology.h has

	/*
	 * Distance above which we begin to use zone reclaim
	 */
	#define RECLAIM_DISTANCE 15


I don't think distance==15 is machine independent proper definition.
but there is long lived definition ;)
