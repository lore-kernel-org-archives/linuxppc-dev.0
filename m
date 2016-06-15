Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5wh4zckzDrST
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:51:00 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FCnRPV143974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 08:50:58 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jfuhkm1s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 08:50:58 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 06:50:45 -0600
Date: Wed, 15 Jun 2016 18:20:33 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
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
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615113249.GH30909@twins.programming.kicks-ass.net>
Message-Id: <20160615125033.GB31671@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 01:32:49PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 15, 2016 at 03:49:36PM +0530, Gautham R Shenoy wrote:
> 
> > Also, with the first patch in the series (which ensures that
> > restore_unbound_workers are called *after* the new workers for the
> > newly onlined CPUs are created) and without this one, you can
> > reproduce this WARN_ON on both x86 and PPC by offlining all the CPUs
> > of a node and bringing just one of them online.
> 
> Ah good.
> 
> > I am not sure about that. The workqueue creates unbound workers for a
> > node via wq_update_unbound_numa() whenever the first CPU of every node
> > comes online. So that seems legitimate. It then tries to affine these
> > workers to the cpumask of that node. Again this seems right. As an
> > optimization, it does this only when the first CPU of the node comes
> > online. Since this online CPU is not yet active, and since
> > nr_cpus_allowed > 1, we will hit the WARN_ON().
> 
> So I had another look and isn't the below a much simpler solution?
> 
> It seems to work on my x86 with:
> 
>   for i in /sys/devices/system/cpu/cpu*/online ; do echo 0 > $i ; done
>   for i in /sys/devices/system/cpu/cpu*/online ; do echo 1 > $i ; done
> 
> without complaint.

Yup. This will work on PPC as well. 

We will no longer have the optimization in
restore_unbound_workers_cpumask() but I suppose we don't lose much by
resetting the affinity every time a CPU in the pool->attr->cpumask
comes online.

--
Thanks and Regards
gautham.
