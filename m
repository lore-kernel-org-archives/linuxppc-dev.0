Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCgW3488LzDrD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:13:35 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K4C6uh068071
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 00:13:33 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btce3t2pd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 00:13:33 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 14:13:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K4DSpM27459604
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:13:28 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K4DJWV009260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:13:20 +1000
Received: from [9.121.0.119] (sriharisrinidhi.in.ibm.com [9.121.0.119])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v6K4DJPp009241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:13:19 +1000
Subject: Re: [PATCH] POWER9 PMU stops after idle workaround
To: linuxppc-dev@lists.ozlabs.org
References: <20170720015322.24307-1-npiggin@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 20 Jul 2017 09:43:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170720015322.24307-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5b8a5618-5524-5518-df74-ac73610cb4b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 20 July 2017 07:23 AM, Nicholas Piggin wrote:
> POWER9 DD2 PMU can stop after a state-loss idle in some conditions.
>
> A solution is to set then clear MMCRA[60] after wake from state-loss
> idle.
Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kernel/idle_book3s.S | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 516ebef905c0..e6252c5a57a4 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -460,11 +460,17 @@ pnv_restore_hyp_resource_arch300:
>   	/*
>   	 * Workaround for POWER9, if we lost resources, the ERAT
>   	 * might have been mixed up and needs flushing. We also need
> -	 * to reload MMCR0 (see comment above).
> +	 * to reload MMCR0 (see comment above). We also need to set
> +	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
>   	 */
>   	blt	cr3,1f
>   	PPC_INVALIDATE_ERAT
>   	ld	r1,PACAR1(r13)
> +	mfspr	r4,SPRN_MMCRA
> +	ori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4
> +	xori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4
>   	ld	r4,_MMCR0(r1)
>   	mtspr	SPRN_MMCR0,r4
>   1:
