Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ym3HM3rzTzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 10:42:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARNdTwD019050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 18:42:05 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2egv5frxeq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 18:42:04 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 16:42:03 -0700
Date: Mon, 27 Nov 2017 15:41:58 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
References: <20171127171935.21364-1-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127171935.21364-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20171127234158.GA8067@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain [vaibhav@linux.vnet.ibm.com] wrote:
> There is an unsafe signed to unsigned conversion in set_thread_tidr()
> that may cause an error value to be assigned to SPRN_TIDR register and
> used as thread-id.

Thanks for fixing this. I have a comment below
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
> i.e all -ve return-values are error codes and a return value of '0'
> indicates success.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> 
> ---
> Changelog:
> 
> v3  ->  Updated the patch to not impact the calling convention [Mpe, Christophe]
> 
> v2  ->	* Update the patch description to document the calling
> 	convention of set_thread_tidr(). [Mpe]
> 	* Fix a tidr allocation leak.
> ---
>  arch/powerpc/kernel/process.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index bfdd783e3916..9fb69211a3d4 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1569,19 +1569,22 @@ void arch_release_task_struct(struct task_struct *t)
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
> -
> -	return 0;
> +	rc = assign_thread_tidr();
> +	if (rc > 0) {
> +		t->thread.tidr = rc;
> +		mtspr(SPRN_TIDR, t->thread.tidr);
> +		return 0;
> +	} else {
> +		return rc;
> +	}

We can eliminate the 'else' and be consistent with existing code, if
we check for error (i.e rc < 0) and return rc. assign_thread_tidr() will
not return 0, but even if it did, setting the register and thread.tidr
to 0 should not be a problem.

Sukadev
