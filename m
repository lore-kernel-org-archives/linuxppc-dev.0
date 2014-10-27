Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D2821A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 15:45:22 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 00:45:19 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A19586E8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 00:34:01 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R4jHKF6226334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 04:45:17 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R4jHbo003867
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 00:45:17 -0400
Message-ID: <544DCDD0.2080508@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 10:15:04 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 04/11] powerpc: kvm: introduce a kthread on primary thread
 to anti tickless
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-5-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-5-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
> (This patch is a place holder.)
> 
> If there is only one vcpu thread is ready(the other vcpu thread can
> wait for it to execute), the primary thread can enter tickless mode,

We do not configure NOHZ_FULL to y by default. Hence no thread would
enter tickless mode.

> which causes the primary keeps running, so the secondary has no
> opportunity to exit to host, even they have other tsk on them.

The secondary threads can still get scheduling ticks. The decrementer of
the secondary threads is still active. So as long as secondary threads
are busy, scheduling ticks will fire and try to schedule a new task on them.

Regards
Preeti U Murthy
> 
> Introduce a kthread (anti_tickless) on primary, so when there is only
> one vcpu thread on primary, the secondary can resort to anti_tickless
> to keep the primary out of tickless mode.
> (I thought that anti_tickless thread can goto NAP, so we can let the
> secondary run).
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index a2595dd..f0b110e 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -575,9 +575,11 @@ static ssize_t __used store_kvm_enable(struct device *dev,
>  	if (!test_bit(core, &kvm_on_core))
>  		for (thr = 1; thr< threads_per_core; thr++)
>  			if (cpu_online(thr * threads_per_core + thr))
> -				cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);
> +				cpumask_set_cpu(core * threads_per_core + thr, &stop_cpus);
>  
>  	stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
> +	/* fixme, create a kthread on primary hwthread to handle tickless mode */
> +	//kthread_create_on_cpu(prevent_tickless, NULL, core * threads_per_core, "ppckvm_prevent_tickless");
>  	set_bit(core, &kvm_on_core);
>  	return count;
>  }
> 
