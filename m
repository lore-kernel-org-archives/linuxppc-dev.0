Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVtx95pqPzDqdS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 05:39:09 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id b75so6525577ywe.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:39:09 -0700 (PDT)
Date: Thu, 16 Jun 2016 15:39:05 -0400
From: Tejun Heo <htejun@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160616193905.GC3262@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
 <20160615160112.GC24102@mtj.duckdns.org>
 <1466079084.19127.2.camel@ellerman.id.au>
 <20160616124548.GE30921@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160616124548.GE30921@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 02:45:48PM +0200, Peter Zijlstra wrote:
> Subject: workqueue: Fix setting affinity of unbound worker threads
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jun 16 14:38:42 CEST 2016
> 
> With commit e9d867a67fd03ccc ("sched: Allow per-cpu kernel threads to
> run on online && !active"), __set_cpus_allowed_ptr() expects that only
> strict per-cpu kernel threads can have affinity to an online CPU which
> is not yet active.
> 
> This assumption is currently broken in the CPU_ONLINE notification
> handler for the workqueues where restore_unbound_workers_cpumask()
> calls set_cpus_allowed_ptr() when the first cpu in the unbound
> worker's pool->attr->cpumask comes online. Since
> set_cpus_allowed_ptr() is called with pool->attr->cpumask in which
> only one CPU is online which is not yet active, we get the following
> WARN_ON during an CPU online operation.

Applied to wq/for-4.7-fixes.

Thanks.

-- 
tejun
