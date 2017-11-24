Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjmFR6c92zDrSw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 17:17:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <20171123124718.16839-1-vaibhav@linux.vnet.ibm.com>
References: <20171123124718.16839-1-vaibhav@linux.vnet.ibm.com>
Date: Fri, 24 Nov 2017 17:17:30 +1100
Message-ID: <87lgiw19qd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> There is an unsafe signed to unsigned conversion in set_thread_tidr()
> that may cause an error value to be assigned to SPRN_TIDR register and
> used as thread-id.
>
> The issue happens as assign_thread_tidr() returns an int and
> thread.tidr is an unsigned-long. So a negative error code returned
> from assign_thread_tidr() will fail the error check and gets assigned
> as tidr as a large positive value.
>
> To fix this the patch assigns the return value of assign_thread_tidr()
> to a temporary int and assigns it to thread.tidr iff its '> 0'.

.. and changes the calling convention of the function.

Now it returns -ve error values, or a +ve TIDR value when it succeeds,
or possibly 0 if that's returned by assign_thread_tidr().

Which I'm not sure you meant to do. If you did, you should at least
document it.

But frankly I'd rather we left it the way it was, -ve error or 0 for
success.

cheers

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index bfdd783e3916..a6eaf924c8b6 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1569,19 +1569,21 @@ void arch_release_task_struct(struct task_struct *t)
>   */
>  int set_thread_tidr(struct task_struct *t)
>  {
> +	int rc;
> +
>  	if (!cpu_has_feature(CPU_FTR_ARCH_300))
>  		return -EINVAL;
>  
>  	if (t != current)
>  		return -EINVAL;
>  
> -	t->thread.tidr = assign_thread_tidr();
> -	if (t->thread.tidr < 0)
> -		return t->thread.tidr;
> -
> -	mtspr(SPRN_TIDR, t->thread.tidr);
> +	rc = assign_thread_tidr();
> +	if (rc > 0) {
> +		t->thread.tidr = assign_thread_tidr();
> +		mtspr(SPRN_TIDR, t->thread.tidr);
> +	}
>  
> -	return 0;
> +	return rc;
>  }
>  
>  #endif /* CONFIG_PPC64 */
> -- 
> 2.14.3
