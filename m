Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x4QRh5QThzDr9C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 19:00:32 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q85so7592301pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Jul 2017 02:00:32 -0700 (PDT)
Date: Sat, 8 Jul 2017 19:00:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas
 to pnv_alloc_idle_core_states
Message-ID: <20170708190012.6c697975@roar.ozlabs.ibm.com>
In-Reply-To: <20170707150416.GD8913@in.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
 <20170707011609.76c51329@roar.ozlabs.ibm.com>
 <20170707150416.GD8913@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 7 Jul 2017 20:34:16 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> On Fri, Jul 07, 2017 at 01:16:09AM +1000, Nicholas Piggin wrote:
> > On Wed,  5 Jul 2017 22:08:15 +0530
> > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> >   
> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > 
> > > On POWER9 DD1, in order to get around a hardware issue, we store in
> > > every CPU thread's paca the paca pointers of all its siblings.
> > > 
> > > Move this code into pnv_alloc_idle_core_states() soon after the space
> > > for saving the sibling pacas is allocated.
> > > 
> > > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>  
> >   
> > > -	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> > > -		int cpu;
> > > -
> > > -		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
> > > -		for_each_possible_cpu(cpu) {
> > > -			int base_cpu = cpu_first_thread_sibling(cpu);
> > > -			int idx = cpu_thread_in_core(cpu);
> > > -			int i;
> > > -  
> > 
> > You could move the thread_sibling_pacas allocation to here?
> > 
> > Speaking of which... core_idle_state and thread_sibling_pacas are
> > allocated with kmalloc_node... What happens if we take an SLB miss
> > in the idle wakeup code on these guys? Nothing good I think. Perhaps
> > we should put them into the pacas or somewhere in bolted memory.  
> 
> Yes, though the SLB miss hasn't yet been encountered in practise so
> far!

Considering it's a node-affine allocation, it may actually be possible
to hit in practice on very large memory systems in practice.

> While one can define thread_sibling_pacas in PACA, it doesn't make
> sense to allocate space for core_idle_state in PACA since the
> allocated value of the secondary threads will never be used.

Well, same for core_idle_state, although that's smaller.

> What is the right way to ensure that these allocations fall in the
> bolted range ?

I'm not sure, I guess the memblock allocator is not up anymore at this
point. I think we'd have to move it earlier. You could allocate another
array of them along side the paca allocation.

Thanks,
Nick
