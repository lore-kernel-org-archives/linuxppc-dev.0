Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98B2D1A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:03:14 +1100 (AEDT)
Date: Thu, 2 Apr 2015 14:02:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
Message-ID: <20150402120256.GV23123@twins.programming.kicks-ass.net>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402104226.GB21105@gmail.com>
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

On Thu, Apr 02, 2015 at 12:42:27PM +0200, Ingo Molnar wrote:
> So why not use a suitable CPU_DOWN* notifier for this, instead of open 
> coding it all into a random place in the hotplug machinery?

Because notifiers are crap? ;-) Its entirely impossible to figure out
what's happening to core code in hotplug. You need to go chase down and
random order notifier things.

I'm planning on taking out many of the core hotplug notifiers and hard
coding their callbacks into the hotplug code.

That way at least its clear wtf happens when.

> Also, I improved the changelog (attached below), but decided against 
> applying it until these questions are cleared - please use that for 
> future versions of this patch.


> Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html

You forgot to fix the Fixes line ;-)

My copy has:

 Fixes: 5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")
