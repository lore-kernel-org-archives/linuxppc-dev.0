Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xChhV2KKrzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:06:50 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K544oN019492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:06:48 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btcgmbaeg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:06:47 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:06:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K56ioX18219154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:06:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K56hqo012851
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:06:43 +1000
Date: Thu, 20 Jul 2017 10:36:29 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <masriniv@in.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Neuling <mikey@neuling.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] POWER9 PMU stops after idle workaround
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170720015322.24307-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170720015322.24307-1-npiggin@gmail.com>
Message-Id: <20170720050629.GA13326@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-07-20 11:53:22]:

> POWER9 DD2 PMU can stop after a state-loss idle in some conditions.
> 
> A solution is to set then clear MMCRA[60] after wake from state-loss
> idle.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  arch/powerpc/kernel/idle_book3s.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 516ebef905c0..e6252c5a57a4 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -460,11 +460,17 @@ pnv_restore_hyp_resource_arch300:
>  	/*
>  	 * Workaround for POWER9, if we lost resources, the ERAT
>  	 * might have been mixed up and needs flushing. We also need
> -	 * to reload MMCR0 (see comment above).
> +	 * to reload MMCR0 (see comment above). We also need to set
> +	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
>  	 */
>  	blt	cr3,1f
>  	PPC_INVALIDATE_ERAT
>  	ld	r1,PACAR1(r13)
> +	mfspr	r4,SPRN_MMCRA
> +	ori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4
> +	xori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4


Timing is ok to resolve the issue?  Does back-to-back bit flip of
MMCRA[60] gets the job done for all cases?  Just asking since this
issue in itself is a corner case ;)

--Vaidy
