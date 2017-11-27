Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylT4c4LFszDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:00:48 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAR0xDgR018902
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 20:00:45 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eg0v9mffc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 20:00:45 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 27 Nov 2017 01:00:44 -0000
Subject: Re: [PATCH v2 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "Alastair D'Silva" <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 27 Nov 2017 12:00:38 +1100
MIME-Version: 1.0
In-Reply-To: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8f6923e8-3abb-167c-8c1c-ff6a034a7568@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/11/17 19:33, Vaibhav Jain wrote:
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
> i.e all -ve return-values are error codes, +ve return values are
> assigned Thread-ids. The way function is implemented it should never
> return a '0'.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> 
> ---
> Changelog:
> 
> v2  ->	* Update the patch description to document the calling
> 	convention of set_thread_tidr(). [Mpe]
> 	* Fix a tidr allocation leak.
> ---
>   arch/powerpc/kernel/process.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index bfdd783e3916..5d8176c7c2d8 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1569,19 +1569,21 @@ void arch_release_task_struct(struct task_struct *t)
>    */
>   int set_thread_tidr(struct task_struct *t)
>   {
> +	int rc;
> +
>   	if (!cpu_has_feature(CPU_FTR_ARCH_300))
>   		return -EINVAL;
> 
>   	if (t != current)
>   		return -EINVAL;
> 
> -	t->thread.tidr = assign_thread_tidr();
> -	if (t->thread.tidr < 0)
> -		return t->thread.tidr;
> -
> -	mtspr(SPRN_TIDR, t->thread.tidr);
> +	rc = assign_thread_tidr();
> +	if (rc > 0) {
> +		t->thread.tidr = rc;
> +		mtspr(SPRN_TIDR, t->thread.tidr);
> +	}
> 
> -	return 0;
> +	return rc;
>   }
> 
>   #endif /* CONFIG_PPC64 */
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
