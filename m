Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVj0Y1bpGzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:11:25 +1000 (AEST)
Message-ID: <1466079084.19127.2.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <htejun@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Aneesh
 Kumar <aneesh.kumar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 16 Jun 2016 22:11:24 +1000
In-Reply-To: <20160615160112.GC24102@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
 <20160615160112.GC24102@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-15 at 12:01 -0400, Tejun Heo wrote:
> On Wed, Jun 15, 2016 at 03:14:15PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 15, 2016 at 06:20:33PM +0530, Gautham R Shenoy wrote:
> > > We will no longer have the optimization in
> > > restore_unbound_workers_cpumask() but I suppose we don't lose much by
> > > resetting the affinity every time a CPU in the pool->attr->cpumask
> > > comes online.
> > 
> > Right; optimizing hotplug really isn't worth it. The code needs to be
> > simple and robust (ha! funny).
> 
> The only case it might matter is CPU hotplug being used aggressively
> for power saving.  No idea how popular that is now tho.
> set_cpus_allowed isn't that expensive and phones don't tend to have
> massive number of kworkers, so hopefully it won't show up.
> 
> > In any case, Tejun, does this work for you?
> 
> I'm not sure about the reordering part but for setting affinity on
> each onlining, no objection.  If it ever shows up as performance /
> power regression, we can revisit it later.

Peterz do you want to send a SOB'ed patch, or can we take what you posted and
add your SOB?

And Tejun are you happy to merge this for rc4?

cheers
