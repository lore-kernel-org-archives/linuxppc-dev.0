Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DB51B7005
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2012 02:32:57 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 16 Jun 2012 10:32:55 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6E29619D8052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 16:32:22 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5GGWOBx178236
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 10:32:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5GGWLqo015210
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 10:32:24 -0600
Date: Sat, 16 Jun 2012 09:32:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [RFC PATCH 09/10] POWERPC: smp: remove call to
 ipi_call_lock()/ipi_call_unlock()
Message-ID: <20120616163219.GI2420@linux.vnet.ibm.com>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
 <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
Cc: axboe@kernel.dk, nikunj@linux.vnet.ibm.com, sshtylyov@mvista.com,
 david.daney@cavium.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, akpm@linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, srivatsa.bhat@linux.vnet.ibm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 29, 2012 at 03:16:04PM +0800, Yong Zhang wrote:
> From: Yong Zhang <yong.zhang@windriver.com>
> 
> 1) call_function.lock used in smp_call_function_many() is just to protect
>    call_function.queue and &data->refs, cpu_online_mask is outside of the
>    lock. And it's not necessary to protect cpu_online_mask,
>    because data->cpumask is pre-calculate and even if a cpu is brougt up
>    when calling arch_send_call_function_ipi_mask(), it's harmless because
>    validation test in generic_smp_call_function_interrupt() will take care
>    of it.
> 
> 2) For cpu down issue, stop_machine() will guarantee that no concurrent
>    smp_call_fuction() is processing.

However, there is an effort to get rid of stop_machine() from the
CPU-down path...  So something else will be needed.

							Thanx, Paul

> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/smp.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index e4cb343..e1417c4 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -571,7 +571,6 @@ void __devinit start_secondary(void *unused)
>  	if (system_state == SYSTEM_RUNNING)
>  		vdso_data->processorCount++;
>  #endif
> -	ipi_call_lock();
>  	notify_cpu_starting(cpu);
>  	set_cpu_online(cpu, true);
>  	/* Update sibling maps */
> @@ -601,7 +600,6 @@ void __devinit start_secondary(void *unused)
>  		of_node_put(np);
>  	}
>  	of_node_put(l2_cache);
> -	ipi_call_unlock();
> 
>  	local_irq_enable();
> 
> -- 
> 1.7.5.4
> 
