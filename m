Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf2zJ2NPXzDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:05:47 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SB4N0v138736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:05:45 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23snu4bkch-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:05:45 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 05:05:44 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/38] powerpc: Move 64-bit feature fixup earlier
In-Reply-To: <1467026976-7974-7-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-7-git-send-email-benh@kernel.crashing.org>
Date: Tue, 28 Jun 2016 16:35:39 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a8i560ak.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Make it part of early_setup() as we really want the feature fixups
> to be applied before we turn on the MMU since they can have an impact
> on the various assembly path related to MMU management and interrupts.
>
> This makes 64-bit match what 32-bit does.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/setup_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 996bed2..e79cf1b 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -286,6 +286,9 @@ void __init early_setup(unsigned long dt_ptr)
>  	/* Initialize the hash table or TLB handling */
>  	early_init_mmu();
>  
> +	/* Apply all the dynamic patching */
> +	apply_feature_fixups();
> +
>  	/*
>  	 * At this point, we can let interrupts switch to virtual mode
>  	 * (the MMU has been setup), so adjust the MSR in the PACA to
> @@ -468,8 +471,6 @@ void __init setup_system(void)
>  {
>  	DBG(" -> setup_system()\n");
>  
> -	apply_feature_fixups();
> -
>  	/*
>  	 * Unflatten the device-tree passed by prom_init or kexec
>  	 */

Why not move it immediately after we finish all the device tress scan.

ie,
	early_init_devtree(__va(dt_ptr));

	epapr_paravirt_early_init();

  +      apply_feature_fixups();
	/* Now we know the logical id of our boot cpu, setup the paca. */
	setup_paca(&paca[boot_cpuid]);
	fixup_boot_paca();

Also with a comment explaining why we can't move it further up ?


-aneesh
