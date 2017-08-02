Return-Path: <srs0=wwrk=7e=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMmRL6Pf0zDrVh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 18:23:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xMmRL5lFGz8sWS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 18:23:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xMmRL1Z4Sz9sxR
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2017 18:23:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v728Decj039701
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 04:23:24 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c36n5nh6g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Aug 2017 04:23:23 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 18:23:21 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v728LtxW26935394
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 18:22:03 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v728LVRF001789
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2017 18:21:31 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH 2/3] powerpc/mm/slb: Move comment next to the code it's
 referring to
In-Reply-To: <1501583364-14909-2-git-send-email-mpe@ellerman.id.au>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
 <1501583364-14909-2-git-send-email-mpe@ellerman.id.au>
Date: Wed, 02 Aug 2017 13:51:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3r2z8gh.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> There is a comment in slb_allocate() referring to the load of
> paca->vmalloc_sllp, but it's several lines prior in the assembly.
> We're about to change this code, and we want to add another comment,
> so move the comment immediately prior to the instruction it's talking
> about.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/slb_low.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index bde378559d01..2eb1b92a68ff 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -121,12 +121,13 @@ slb_miss_kernel_load_vmemmap:
>  1:
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>
> -	/* vmalloc mapping gets the encoding from the PACA as the mapping
> -	 * can be demoted from 64K -> 4K dynamically on some machines
> -	 */
>  	clrldi	r11,r10,48
>  	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
>  	bgt	5f
> +	/*
> +	 * vmalloc mapping gets the encoding from the PACA as the mapping
> +	 * can be demoted from 64K -> 4K dynamically on some machines.
> +	 */
>  	lhz	r11,PACAVMALLOCSLLP(r13)
>  	b	6f
>  5:
> -- 
> 2.7.4
