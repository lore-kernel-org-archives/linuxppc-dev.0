Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVB8Z5w7PzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 02:01:34 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id a186so3404628qkf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 09:01:34 -0700 (PDT)
Date: Wed, 15 Jun 2016 12:01:12 -0400
From: Tejun Heo <htejun@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160615160112.GC24102@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615131415.GI30909@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jun 15, 2016 at 03:14:15PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 15, 2016 at 06:20:33PM +0530, Gautham R Shenoy wrote:
> > We will no longer have the optimization in
> > restore_unbound_workers_cpumask() but I suppose we don't lose much by
> > resetting the affinity every time a CPU in the pool->attr->cpumask
> > comes online.
> 
> Right; optimizing hotplug really isn't worth it. The code needs to be
> simple and robust (ha! funny).

The only case it might matter is CPU hotplug being used aggressively
for power saving.  No idea how popular that is now tho.
set_cpus_allowed isn't that expensive and phones don't tend to have
massive number of kworkers, so hopefully it won't show up.

> In any case, Tejun, does this work for you?

I'm not sure about the reordering part but for setting affinity on
each onlining, no objection.  If it ever shows up as performance /
power regression, we can revisit it later.

Thanks.

-- 
tejun
