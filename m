Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylXny3qPmzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:48:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
References: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 14:48:22 +1100
Message-ID: <8737504c1l.fsf@concordia.ellerman.id.au>
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
>
> The patch shouldn't impact the calling convention of set_thread_tidr()

But it does? I'm really confused.

Please fix and resend.

cheers

>  int set_thread_tidr(struct task_struct *t)
>  {
> +	int rc;
> +
>  	if (!cpu_has_feature(CPU_FTR_ARCH_300))
>  		return -EINVAL;
                ^
                -ve error

>  
>  	if (t != current)
>  		return -EINVAL;
                ^
                -ve error

>  
> -	t->thread.tidr = assign_thread_tidr();
> -	if (t->thread.tidr < 0)
> -		return t->thread.tidr;
                ^
                -ve error

Yes I know we never hit that case because of the bug, that is what this
patch should be fixing, and only that.

> -
> -	mtspr(SPRN_TIDR, t->thread.tidr);
> +	rc = assign_thread_tidr();
> +	if (rc > 0) {
> +		t->thread.tidr = rc;
> +		mtspr(SPRN_TIDR, t->thread.tidr);
> +	}
>  
> -	return 0;

Success == 0

> +	return rc;

Success == +ve TIDR

>  }

cheers
