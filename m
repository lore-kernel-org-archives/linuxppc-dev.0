Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3yZ22gLQzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 01:04:26 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v67Ex7pW072366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 11:04:24 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bj0wq98f3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 11:04:23 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Jul 2017 09:04:22 -0600
Date: Fri, 7 Jul 2017 20:34:16 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas
 to pnv_alloc_idle_core_states
Reply-To: ego@linux.vnet.ibm.com
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
 <20170707011609.76c51329@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170707011609.76c51329@roar.ozlabs.ibm.com>
Message-Id: <20170707150416.GD8913@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 07, 2017 at 01:16:09AM +1000, Nicholas Piggin wrote:
> On Wed,  5 Jul 2017 22:08:15 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On POWER9 DD1, in order to get around a hardware issue, we store in
> > every CPU thread's paca the paca pointers of all its siblings.
> > 
> > Move this code into pnv_alloc_idle_core_states() soon after the space
> > for saving the sibling pacas is allocated.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> > -	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> > -		int cpu;
> > -
> > -		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
> > -		for_each_possible_cpu(cpu) {
> > -			int base_cpu = cpu_first_thread_sibling(cpu);
> > -			int idx = cpu_thread_in_core(cpu);
> > -			int i;
> > -
> 
> You could move the thread_sibling_pacas allocation to here?
> 
> Speaking of which... core_idle_state and thread_sibling_pacas are
> allocated with kmalloc_node... What happens if we take an SLB miss
> in the idle wakeup code on these guys? Nothing good I think. Perhaps
> we should put them into the pacas or somewhere in bolted memory.

Yes, though the SLB miss hasn't yet been encountered in practise so
far!

While one can define thread_sibling_pacas in PACA, it doesn't make
sense to allocate space for core_idle_state in PACA since the
allocated value of the secondary threads will never be used.

What is the right way to ensure that these allocations fall in the
bolted range ?

> 
> Good cleanup though.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
