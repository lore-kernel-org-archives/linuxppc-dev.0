Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV2ZJ4TdzzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 20:19:51 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FAEM9f059209
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 06:19:49 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jggt5rb9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 06:19:49 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 04:19:48 -0600
Date: Wed, 15 Jun 2016 15:49:36 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160614112234.GF30154@twins.programming.kicks-ass.net>
Message-Id: <20160615101936.GA31671@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Tue, Jun 14, 2016 at 01:22:34PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 07, 2016 at 08:44:03PM +0530, Gautham R. Shenoy wrote:
> 
> I'm still puzzled why we don't see this on x86. Afaict there's nothing
> PPC specific about this.

You are right. On PPC, at boot time we hit the WARN_ON like once in 5
times. Using some debug prints, I have verified that these are
instances when the workqueue subsystem gets initialized before all the
CPUs come online. On x86, I have never been able to hit this since it
appears that every time the workqueues get initialized only after all
the CPUs have come online.

PPC doesn't uses any specific unbound workqueue early in the boot. The
unbound workqueues causing the WARN_ON() were the
"events_unbound" workqueue which was created by workqueue_init().

=================================================================================
[WQ] Creating Unbound workers for WQ events_unbound,cpumask 0-127.
     online mask 0
[WQ] Creating Unbound workers for WQ events_unbound,cpumask 0-31. 
     online mask 0
[WQ] Creating Unbound workers for WQ events_unbound,cpumask 32-63.
      online mask 0
[WQ] Creating Unbound workers for WQ events_unbound,cpumask 64-95.
      online mask 0
[WQ] Creating Unbound workers for WQ events_unbound,cpumask 96-127.
      online mask 0
=================================================================================

Also, with the first patch in the series (which ensures that
restore_unbound_workers are called *after* the new workers for the
newly onlined CPUs are created) and without this one, you can
reproduce this WARN_ON on both x86 and PPC by offlining all the CPUs
of a node and bringing just one of them online. So essentially the BUG
fixed by the previous patch is currently hiding this BUG which is why
we are not able to reproduce this WARN_ON() with CPU-hotplug once the
system has booted.

> 
> > This patch sets the affinity of the worker to
> > a) the only online CPU in the cpumask of the worker pool when it comes
> >    online.
> > b) the cpumask of the worker pool when the second CPU in the pool's
> >    cpumask comes online.
> 
> This basically works around the WARN conditions, which I suppose is fair
> enough, but I would like a note here to revisit this once the whole cpu
> hotplug rework has settled.
> 

Sure.

> The real problem is that workqueues seem to want to create worker
> threads before there's anybody who would use them or something like
> that.

I am not sure about that. The workqueue creates unbound workers for a
node via wq_update_unbound_numa() whenever the first CPU of every node
comes online. So that seems legitimate. It then tries to affine these
workers to the cpumask of that node. Again this seems right. As an
optimization, it does this only when the first CPU of the node comes
online. Since this online CPU is not yet active, and since
nr_cpus_allowed > 1, we will hit the WARN_ON().

However, I agree with you that during boot-up, the workqueue subsystem
needs to create unbound worker threads for only the online CPUs
(instead of all possible CPUs as it currently does!) and let the
CPU_ONLINE notification take care of creating the remaining workers
when they are really required.

> 
> Or is that what PPC does funny? Use an unbound workqueue this early in
> cpu bringup?

Like I pointed out above, PPC doesn't use an unbound workqueue early
in the CPU bring up.

--
Thanks and Regards
gautham.
