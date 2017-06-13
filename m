Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5Wr3X0szDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:26:00 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5DAObH8136242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:25:58 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2dmfjwnw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:25:58 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 04:25:56 -0600
Date: Tue, 13 Jun 2017 15:55:53 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/14] powerpc/64s: idle avoid SRR usage in idle
 sleep/wake paths
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-9-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-9-npiggin@gmail.com>
Message-Id: <20170613102553.GJ10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Mon, Jun 12, 2017 at 09:58:29AM +1000, Nicholas Piggin wrote:
> Idle code now always runs at the 0xc... effective address whether
> in real or virtual mode. This means rfid can be ditched, along
> with a lot of SRR manipulations.
> 
> In the wakeup path, carry SRR1 around in r12. Use mtmsrd to change
> MSR states as required.
> 
> This also balances the return prediction for the idle call, by
> doing blr rather than rfid to return to the idle caller.
> 
> On POWER9, 2-process context switch on different cores, with snooze
> disabled, increases performance by 2%.
> ---
>  arch/powerpc/kernel/exceptions-64s.S    |  1 +
>  arch/powerpc/kernel/idle_book3s.S       | 57 +++++++++++++++------------------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |  8 ++++-
>  3 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index fec7c933d095..c3d0aef089a7 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -148,12 +147,8 @@ pnv_powersave_common:
>  	 * the MMU context to the guest.
>  	 */
>  	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
> -	li	r6, MSR_RI
> -	andc	r6, r9, r6
> -	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
> -	mtspr	SPRN_SRR0, r4
> -	mtspr	SPRN_SRR1, r7
> -	rfid
> +	mtmsrd	r7,0
> +	bctr

So at this point we need to transition from virtual to real mode as
the comment in pnv_enter_arch207_idle_mode expects us to. Which is
being performed by mtmsrd here. Then we jump to the function via
bctr. So, in this patch we are using two instructions to modify the
MSR and the PC, while earlier the rfid would update these atomically.

Does forgoing atomicity have any risk? I am asking this because
historically we have modified IR/DR bits in the MSR via rfid
mechanism.
--
Thanks and Regards
gautham.
