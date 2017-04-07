Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w06YH0SkQzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 03:50:09 +1000 (AEST)
Date: Fri, 7 Apr 2017 10:50:06 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] perf/x86/intel: Record branch type
Message-ID: <20170407175006.GB4021@tassilo.jf.intel.com>
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
 <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
 <20170407152031.k2auigfkj7ek4suo@hirez.programming.kicks-ass.net>
 <20170407164834.GA4021@tassilo.jf.intel.com>
 <20170407172024.r66fkp4xkux5blxi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170407172024.r66fkp4xkux5blxi@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > It's a somewhat common situation with partially JITed code, if you
> > don't have an agent. You can still do a lot of useful things.
> 
> Like what? How can you say anything about code you don't have?

For example if you combine the PMU topdown measurement, and see if it's
frontend bound, and then you see it has lots of forward conditionals,
then dynamic basic block reordering will help. If you have lots
of cross page jumps then function reordering will help. etc.

> > We found it useful to have this extra information during workload
> > analysis. Forward conditionals and page crossing jumps
> > are indications of frontend problems.
> 
> But you already have the exact same information in {to,from}, why would
> you need to repackage information already contained?

Without this patch, we don't know if it's conditional or something else.
And the kernel already knows this for its filtering, so it can as well
report it.

Right the CROSS_* and forward backward information could be computed
later.

-Andi
