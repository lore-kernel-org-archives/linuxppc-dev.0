Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2B4EDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 20:15:55 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n3GAE0Lh031067
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 20:14:00 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3GAFqSI1380534
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 20:15:52 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3GAFpis031290
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 20:15:52 +1000
Message-ID: <49E70554.1060506@in.ibm.com>
Date: Thu, 16 Apr 2009 15:45:48 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
References: <49D1E21E.3090505@in.ibm.com> <1238539469.17330.70.camel@pasglop>
	<49D30C48.4090902@in.ibm.com> <49D3547E.8030200@in.ibm.com>
	<49E6C3F4.4080801@in.ibm.com>
	<1239870306.14642.181.camel@localhost>
In-Reply-To: <1239870306.14642.181.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Does this patch, on top of Ben's patch, fix it?
>
> cheers
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index db556d2..1ade7eb 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -753,7 +753,7 @@ void __init early_init_mmu(void)
>  }
>
>  #ifdef CONFIG_SMP
> -void __init early_init_mmu_secondary(void)
> +void __cpuinit early_init_mmu_secondary(void)
>  {
>         /* Initialize hash table for that CPU */
>         if (!firmware_has_feature(FW_FEATURE_LPAR))
Yes, this patch fixed the issue. Now i can offline/online cpus without 
any problem.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
