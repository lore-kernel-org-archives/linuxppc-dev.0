Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E7391A0151
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:58:39 +1100 (AEDT)
Date: Thu, 2 Apr 2015 14:58:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
Message-ID: <20150402125819.GX23123@twins.programming.kicks-ass.net>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
 <20150402120256.GV23123@twins.programming.kicks-ass.net>
 <20150402121247.GA18104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402121247.GA18104@gmail.com>
Cc: nicolas.pitre@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2015 at 02:12:47PM +0200, Ingo Molnar wrote:
> Okay. I'll resurrect the fix with a hotplug_cpu__tick_pull() name - 
> agreed?

Sure.

> > > Also, I improved the changelog (attached below), but decided 
> > > against applying it until these questions are cleared - please use 
> > > that for future versions of this patch.
> > 
> > 
> > > Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> > 
> > You forgot to fix the Fixes line ;-)
> > 
> > My copy has:
> > 
> >  Fixes: 5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")
> 
> Hm, not sure how that got lost - my git-log of the patch ported on top 
> of timers/core still has it:


> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: mpe@ellerman.id.au
> Cc: nicolas.pitre@linaro.org
> Cc: peterz@infradead.org
> Cc: rjw@rjwysocki.net
> Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> Link: http://lkml.kernel.org/r/20150330092410.24979.59887.stgit@preeti.in.ibm.com
> [ Merged it to the latest timer tree, tidied up the changelog. ]
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

That doesn't have my Sob in it, so you took it from the list yourself,
not from my queue. I also (concurrently it seems) fixed up the Changelog
some :-)
