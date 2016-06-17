Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW38d1PJvzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 11:49:37 +1000 (AEST)
Message-ID: <1466128176.12899.7.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <htejun@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Aneesh
 Kumar <aneesh.kumar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 17 Jun 2016 11:49:36 +1000
In-Reply-To: <20160616193905.GC3262@mtj.duckdns.org>
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
 <20160616193905.GC3262@mtj.duckdns.org>
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

On Thu, 2016-06-16 at 15:39 -0400, Tejun Heo wrote:
> On Thu, Jun 16, 2016 at 02:45:48PM +0200, Peter Zijlstra wrote:
> > Subject: workqueue: Fix setting affinity of unbound worker threads
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Jun 16 14:38:42 CEST 2016
> > 
> > With commit e9d867a67fd03ccc ("sched: Allow per-cpu kernel threads to
> > run on online && !active"), __set_cpus_allowed_ptr() expects that only
> > strict per-cpu kernel threads can have affinity to an online CPU which
> > is not yet active.
> > 
> > This assumption is currently broken in the CPU_ONLINE notification
> > handler for the workqueues where restore_unbound_workers_cpumask()
> > calls set_cpus_allowed_ptr() when the first cpu in the unbound
> > worker's pool->attr->cpumask comes online. Since
> > set_cpus_allowed_ptr() is called with pool->attr->cpumask in which
> > only one CPU is online which is not yet active, we get the following
> > WARN_ON during an CPU online operation.
> 
> Applied to wq/for-4.7-fixes.

Thanks all.

cheers
