Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbFW24YlzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:41:50 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CEe7iA037905
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:41:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1p1dbtj6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:41:47 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 10:41:46 -0400
Date: Mon, 12 Jun 2017 20:11:40 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/14] powerpc/64s: interrupt replay balance the return
 branch predictor
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-7-npiggin@gmail.com>
Message-Id: <20170612144140.GE10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 09:58:27AM +1000, Nicholas Piggin wrote:
> The __replay_interrupt code is branched to with bl, but the caller is
> returned to directly with rfid from the interrupt.
> 
> Instead return to a return stub that returns to the caller with blr,
> which should do better with the return predictor.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a04ee0d7f88e..d55201625ea3 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1586,7 +1586,7 @@ _GLOBAL(__replay_interrupt)
>  	 * we don't give a damn about, so we don't bother storing them.
>  	 */
>  	mfmsr	r12
> -	mflr	r11
> +	LOAD_REG_ADDR(r11, __replay_interrupt_return)
>  	mfcr	r9
>  	ori	r12,r12,MSR_EE
>  	cmpwi	r3,0x900
> @@ -1604,4 +1604,5 @@ FTR_SECTION_ELSE
>  	cmpwi	r3,0xa00
>  	beq	doorbell_super_common_msgclr
>  ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> +__replay_interrupt_return:
>  	blr
> -- 
> 2.11.0
> 
