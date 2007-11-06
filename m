Return-Path: <jschopp@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC934DDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 10:08:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA6NAJeH013433
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:10:19 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA6N8hLg135184
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:08:43 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA6N8hk2025785
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 18:08:43 -0500
Message-ID: <4730F3FA.7060602@austin.ibm.com>
Date: Tue, 06 Nov 2007 17:08:42 -0600
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH] Fix rtas_ibm_suspend_me bugs
References: <20071106044309.GK9695@localdomain>
In-Reply-To: <20071106044309.GK9695@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > -		for_each_possible_cpu(i)
 > -			plpar_hcall_norets(H_PROD,i);

...

 > +	for_each_online_cpu(i)
 > +		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(i));

I assume this bit would be non-contriversial and could be sent up for 
immediate upstream inclusion.

Nathan Lynch wrote:
> (very rfc for now, no sign-off, needs more testing)
> 
> There are a couple of bugs in the rtas_ibm_suspend_me() and
> rtas_percpu_suspend_me() functions:
> 
> 1.  rtas_ibm_suspend_me() uses on_each_cpu() to invoke
> rtas_percpu_suspend_me() via IPI:
> 
> if (on_each_cpu(rtas_percpu_suspend_me, &data, 1, 0))
> ...
> 
> 'data' is on the stack, and rtas_ibm_suspend_me() takes no measures to
> ensure that all instances of rtas_percpu_suspend_me() are finished
> accessing 'data' before returning.  This can result in the IPI'd cpus
> accessing random stack data and getting stuck in H_JOIN.
> 
> Fix this by moving rtas_suspend_me_data off the stack, and protect it
> with a mutex.  Use a completion to ensure that all cpus are done
> accessing the data before unlocking.
> 
> 2.  rtas_percpu_suspend_me passes the Linux logical cpu id to the
> H_PROD hypervisor method, when it should be using the platform
> interrupt server value for that cpu (hard_smp_processor_id).  In
> practice, this probably causes problems only on partitions where
> processors have been removed and added in a particular order.
> 
> ---
>  arch/powerpc/kernel/rtas.c |   64 ++++++++++++++++++++++++++++++++-----------
>  1 files changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 2147807..24faaea 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -19,6 +19,9 @@
>  #include <linux/init.h>
>  #include <linux/capability.h>
>  #include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/smp.h>
>  
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -34,6 +37,7 @@
>  #include <asm/lmb.h>
>  #include <asm/udbg.h>
>  #include <asm/syscalls.h>
> +#include <asm/atomic.h>
>  
>  struct rtas_t rtas = {
>  	.lock = SPIN_LOCK_UNLOCKED
> @@ -41,10 +45,21 @@ struct rtas_t rtas = {
>  EXPORT_SYMBOL(rtas);
>  
>  struct rtas_suspend_me_data {
> +	atomic_t working; /* number of cpus accessing rtas_suspend_me_data */
>  	long waiting;
>  	struct rtas_args *args;
> +	struct completion done; /* wait on this until working == 0 */
>  };
>  
> +static void rtas_suspend_me_data_init(struct rtas_suspend_me_data *rsmd,
> +				      struct rtas_args *args)
> +{
> +	atomic_set(&rsmd->working, 0);
> +	rsmd->waiting = 1;
> +	rsmd->args = args;
> +	init_completion(&rsmd->done);
> +}
> +
>  DEFINE_SPINLOCK(rtas_data_buf_lock);
>  EXPORT_SYMBOL(rtas_data_buf_lock);
>  
> @@ -671,36 +686,49 @@ static void rtas_percpu_suspend_me(void *info)
>  	 * we set it to <0.
>  	 */
>  	local_irq_save(flags);
> +	atomic_inc(&data->working);
>  	do {
>  		rc = plpar_hcall_norets(H_JOIN);
>  		smp_rmb();
>  	} while (rc == H_SUCCESS && data->waiting > 0);
>  	if (rc == H_SUCCESS)
> +		/* join is complete (or there was an error) and this
> +		 * cpu was prodded
> +		 */
>  		goto out;
>  
>  	if (rc == H_CONTINUE) {
> +		/* this cpu does the join */
>  		data->waiting = 0;
>  		data->args->args[data->args->nargs] =
>  			rtas_call(ibm_suspend_me_token, 0, 1, NULL);
> -		for_each_possible_cpu(i)
> -			plpar_hcall_norets(H_PROD,i);
>  	} else {
>  		data->waiting = -EBUSY;
>  		printk(KERN_ERR "Error on H_JOIN hypervisor call\n");
>  	}
>  
> +	/* This cpu did the join or got an error, so we need to prod
> +	 * everyone else.  Extra prods are harmless.
> +	 */
> +	for_each_online_cpu(i)
> +		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(i));
> +
>  out:
> +	if (atomic_dec_return(&data->working) == 0)
> +		complete(&data->done);
>  	local_irq_restore(flags);
>  	return;
>  }
>  
> +static DEFINE_MUTEX(rsm_lock); /* protects rsm_data */
> +static struct rtas_suspend_me_data rsm_data;
> +
>  static int rtas_ibm_suspend_me(struct rtas_args *args)
>  {
> -	int i;
> +	int err;
>  	long state;
>  	long rc;
>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> -	struct rtas_suspend_me_data data;
>  
>  	/* Make sure the state is valid */
>  	rc = plpar_hcall(H_VASI_STATE, retbuf,
> @@ -721,25 +749,27 @@ static int rtas_ibm_suspend_me(struct rtas_args *args)
>  		return 0;
>  	}
>  
> -	data.waiting = 1;
> -	data.args = args;
> +	mutex_lock(&rsm_lock);
> +
> +	rtas_suspend_me_data_init(&rsm_data, args);
>  
> -	/* Call function on all CPUs.  One of us will make the
> -	 * rtas call
> +	/* Call function on all CPUs.  One of us (but not necessarily
> +	 * this one) will make the ibm,suspend-me call.
>  	 */
> -	if (on_each_cpu(rtas_percpu_suspend_me, &data, 1, 0))
> -		data.waiting = -EINVAL;
> +	if (on_each_cpu(rtas_percpu_suspend_me, &rsm_data, 1, 0))
> +		rsm_data.waiting = -EINVAL;
> +
> +	/* Must wait for all IPIs to complete before unlocking */
> +	wait_for_completion(&rsm_data.done);
>  
> -	if (data.waiting != 0)
> +	if (rsm_data.waiting != 0)
>  		printk(KERN_ERR "Error doing global join\n");
>  
> -	/* Prod each CPU.  This won't hurt, and will wake
> -	 * anyone we successfully put to sleep with H_JOIN.
> -	 */
> -	for_each_possible_cpu(i)
> -		plpar_hcall_norets(H_PROD, i);
> +	err = rsm_data.waiting;
> +
> +	mutex_unlock(&rsm_lock);
>  
> -	return data.waiting;
> +	return err;
>  }
>  #else /* CONFIG_PPC_PSERIES */
>  static int rtas_ibm_suspend_me(struct rtas_args *args)
