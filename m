Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrLgN2zBSzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 15:27:44 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6F5NO2u092534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 01:27:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 246k211vw7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 01:27:42 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 01:27:41 -0400
Date: Fri, 15 Jul 2016 10:57:28 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Reply-To: ego@linux.vnet.ibm.com
References: <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
 <20160615160112.GC24102@mtj.duckdns.org>
 <1466079084.19127.2.camel@ellerman.id.au>
 <20160616124548.GE30921@twins.programming.kicks-ass.net>
 <20160616193905.GC3262@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160616193905.GC3262@mtj.duckdns.org>
Message-Id: <20160715052728.GA5072@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tejun,

On Thu, Jun 16, 2016 at 03:39:05PM -0400, Tejun Heo wrote:
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

Did this patch get missed by any chance? It is not in
the master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git yet.

We're still hitting the WARN_ON() during boot-up on the mainline kernel.
> Thanks.
> 
> -- 
> tejun
> 

--
Thanks and Regards
gautham.
