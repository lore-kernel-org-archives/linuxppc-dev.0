Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B4F1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 14:23:45 +1000 (EST)
Date: Thu, 5 Jun 2014 14:23:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] powerpc, powernv, CPU hotplug: Put offline CPUs in
 Fast-Sleep instead of Nap
Message-ID: <20140605042336.GA3199@drongo>
References: <20140528043703.15676.58580.stgit@preeti.in.ibm.com>
 <20140528043856.15676.35844.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140528043856.15676.35844.stgit@preeti.in.ibm.com>
Cc: svaidyan@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 28, 2014 at 10:08:56AM +0530, Preeti U Murthy wrote:
> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> The offline cpus are put to fast sleep if the idle state is discovered in the
> device tree. This is to gain maximum powersavings in the offline state.

...

>  	while (!generic_check_cpu_restart(cpu)) {
>  		ppc64_runlatch_off();
> -		power7_nap();
> +
> +		/* If sleep is supported, go to sleep, instead of nap */
> +		if (idle_states & IDLE_USE_SLEEP)
> +			power7_sleep();
> +		else
> +			power7_nap();
> +
>  		ppc64_runlatch_on();
>  		if (!generic_check_cpu_restart(cpu)) {
>  			DBG("CPU%d Unexpected exit while offline !\n", cpu);

What is the latency for waking up from fast sleep state?  I'm concerned
this will increase the latency for entering KVM guests.

Paul.
