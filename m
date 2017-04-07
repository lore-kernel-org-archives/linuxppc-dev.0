Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w05v20DFrzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 03:20:30 +1000 (AEST)
Date: Fri, 7 Apr 2017 19:20:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] perf/x86/intel: Record branch type
Message-ID: <20170407172024.r66fkp4xkux5blxi@hirez.programming.kicks-ass.net>
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
 <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
 <20170407152031.k2auigfkj7ek4suo@hirez.programming.kicks-ass.net>
 <20170407164834.GA4021@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170407164834.GA4021@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2017 at 09:48:34AM -0700, Andi Kleen wrote:
> On Fri, Apr 07, 2017 at 05:20:31PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 07, 2017 at 06:47:43PM +0800, Jin Yao wrote:
> > > Perf already has support for disassembling the branch instruction
> > > and using the branch type for filtering. The patch just records
> > > the branch type in perf_branch_entry.
> > > 
> > > Before recording, the patch converts the x86 branch classification
> > > to common branch classification and compute for checking if the
> > > branches cross 4K or 2MB areas. It's an approximate computing for
> > > crossing 4K page or 2MB page.
> > 
> > The changelog is completely empty of rationale. Why do we care?
> > 
> > Not having the binary is a very bad reason; you can't do much of
> > anything if that's missing.
> 
> It's a somewhat common situation with partially JITed code, if you
> don't have an agent. You can still do a lot of useful things.

Like what? How can you say anything about code you don't have?

> We found it useful to have this extra information during workload
> analysis. Forward conditionals and page crossing jumps
> are indications of frontend problems.

But you already have the exact same information in {to,from}, why would
you need to repackage information already contained?
