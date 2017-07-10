Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5kpb3d5PzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 22:21:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6ACIshF092737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 08:21:24 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjucv4u4d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 08:21:24 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 22:21:21 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6ACL84L15794366
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 22:21:16 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6ACKir9020353
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 22:20:44 +1000
Received: from [9.124.35.83] (sriharisrinidhi.in.ibm.com [9.124.35.83])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v6ACKha3019756
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 22:20:43 +1000
Subject: Re: [PATCH] POWER9 PMU interrupt after idle workaround
To: linuxppc-dev@lists.ozlabs.org
References: <20170710061938.22513-1-npiggin@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 17:50:18 +0530
MIME-Version: 1.0
In-Reply-To: <20170710061938.22513-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a9de7aa8-6d0c-b910-7a24-6c1bd65fba3d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 10 July 2017 11:49 AM, Nicholas Piggin wrote:
> POWER9 DD2 can see spurious PMU interrupts after state-loss idle in
> some conditions.
>
> A solution is to save and reload MMCR0 over state-loss idle.

Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kernel/idle_book3s.S | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 5adb390e773b..516ebef905c0 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -30,6 +30,7 @@
>    * Use unused space in the interrupt stack to save and restore
>    * registers for winkle support.
>    */
> +#define _MMCR0	GPR0
>   #define _SDR1	GPR3
>   #define _PTCR	GPR3
>   #define _RPR	GPR4
> @@ -272,6 +273,14 @@ power_enter_stop:
>   	b 	pnv_wakeup_noloss
>
>   .Lhandle_esl_ec_set:
> +	/*
> +	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
> +	 * state-loss idle. Saving and restoring MMCR0 over idle is a
> +	 * workaround.
> +	 */
> +	mfspr	r4,SPRN_MMCR0
> +	std	r4,_MMCR0(r1)
> +
>   /*
>    * Check if the requested state is a deep idle state.
>    */
> @@ -450,10 +459,14 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>   pnv_restore_hyp_resource_arch300:
>   	/*
>   	 * Workaround for POWER9, if we lost resources, the ERAT
> -	 * might have been mixed up and needs flushing.
> +	 * might have been mixed up and needs flushing. We also need
> +	 * to reload MMCR0 (see comment above).
>   	 */
>   	blt	cr3,1f
>   	PPC_INVALIDATE_ERAT
> +	ld	r1,PACAR1(r13)
> +	ld	r4,_MMCR0(r1)
> +	mtspr	SPRN_MMCR0,r4
>   1:
>   	/*
>   	 * POWER ISA 3. Use PSSCR to determine if we
