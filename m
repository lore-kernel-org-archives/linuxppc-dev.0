Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x81lM1gkYzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:41:34 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6E5cgr6060428
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 01:41:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bpf0hsmm0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 01:41:29 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 14 Jul 2017 15:41:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6E5fPjD22020294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:41:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6E5fGLL032050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:41:16 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/mm/radix: Don't iterate all sets when
 flushing the PWC
In-Reply-To: <20170714015258.7933-1-benh@kernel.crashing.org>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
Date: Fri, 14 Jul 2017 11:11:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87379zr2wt.fsf@skywalker.in.ibm.com>
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
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/mm/tlb-radix.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 02e7140..5403419 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -52,12 +52,15 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
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


With the current code, we use tlbiel_pwc() for doing a pwc flush.
and that does what is done this patch. May be we can update this patch
such that we drop tlbiel_pwc and switch all those instance to
tlbiel_pid(pid, RIC_FLUSH_PWC) ?

You already do this in a later patch.

-aneesh
