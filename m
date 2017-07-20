Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCdhL4TFTzDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:51:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K2oJUu016378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:51:27 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bt9hkyp7w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:51:27 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 12:51:25 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K2pMPn23986178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:51:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K2pMd9013240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:51:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/4] powerpc/mm/radix: Improve _tlbiel_pid to be usable
 for PWC flushes
In-Reply-To: <20170719044907.21703-1-benh@kernel.crashing.org>
References: <20170719044907.21703-1-benh@kernel.crashing.org>
Date: Thu, 20 Jul 2017 08:21:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9sfrfbr.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> The PWC flush only needs a single set call, just like the
> full (RIC=2) flush.
>
> This will allow us to get rid of the dedicated _tlbiel_pwc()

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/mm/tlb-radix.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 744e0164ecf5..2f2967a2db93 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -54,12 +54,15 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>  	 */
>  	__tlbiel_pid(pid, 0, ric);
>
> -	if (ric == RIC_FLUSH_ALL)
> -		/* For the remaining sets, just flush the TLB */
> -		ric = RIC_FLUSH_TLB;
> +	/* For PWC, only one flush is needed */
> +	if (ric == RIC_FLUSH_PWC) {
> +		asm volatile("ptesync": : :"memory");
> +		return;
> +	}
>
> +	/* For the remaining sets, just flush the TLB */
>  	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
> -		__tlbiel_pid(pid, set, ric);
> +		__tlbiel_pid(pid, set, RIC_FLUSH_TLB);
>
>  	asm volatile("ptesync": : :"memory");
>  	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
> -- 
> 2.13.3
