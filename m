Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3LtJ6kkYzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 01:16:24 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c24so679036pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 08:16:24 -0700 (PDT)
Date: Fri, 7 Jul 2017 01:16:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas
 to pnv_alloc_idle_core_states
Message-ID: <20170707011609.76c51329@roar.ozlabs.ibm.com>
In-Reply-To: <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
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

On Wed,  5 Jul 2017 22:08:15 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On POWER9 DD1, in order to get around a hardware issue, we store in
> every CPU thread's paca the paca pointers of all its siblings.
> 
> Move this code into pnv_alloc_idle_core_states() soon after the space
> for saving the sibling pacas is allocated.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> -	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> -		int cpu;
> -
> -		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
> -		for_each_possible_cpu(cpu) {
> -			int base_cpu = cpu_first_thread_sibling(cpu);
> -			int idx = cpu_thread_in_core(cpu);
> -			int i;
> -

You could move the thread_sibling_pacas allocation to here?

Speaking of which... core_idle_state and thread_sibling_pacas are
allocated with kmalloc_node... What happens if we take an SLB miss
in the idle wakeup code on these guys? Nothing good I think. Perhaps
we should put them into the pacas or somewhere in bolted memory.

Good cleanup though.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
