Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t38Qh0YvwzDvk4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:24:28 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t38Qg3Pc2z9sdn
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 21:24:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9PAOFT8013291
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 06:24:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26a25pk12q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 06:24:24 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 04:24:23 -0600
Date: Tue, 25 Oct 2016 15:54:18 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64: Re-fix race condition between going idle
 and entering guest
Reply-To: ego@linux.vnet.ibm.com
References: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
Message-Id: <20161025102418.GA3244@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

[Added Shreyas's current e-mail address ]

On Fri, Oct 21, 2016 at 08:03:05PM +1100, Paul Mackerras wrote:
> Commit 8117ac6a6c2f ("powerpc/powernv: Switch off MMU before entering
> nap/sleep/rvwinkle mode", 2014-12-10) fixed a race condition where one
> thread entering a KVM guest could switch the MMU context to the guest
> while another thread was still in host kernel context with the MMU on.
> That commit moved the point where a thread entering a power-saving
> mode set its kvm_hstate.hwthread_state field in its PACA to
> KVM_HWTHREAD_IN_IDLE from a point where the MMU was on to after the
> MMU had been switched off.  That commit also added a comment
> explaining that we have to switch to real mode before setting
> hwthread_state to avoid this race.
> 
> Nevertheless, commit 4eae2c9ae54a ("powerpc/powernv: Make
> pnv_powersave_common more generic", 2016-07-08) subsequently moved
> the setting of hwthread_state back to a point where the MMU is on,
> thus reintroducing the race, despite the comment saying that this
> should not be done being included in full in the context lines of
> the patch that did it.
>

Sorry about missing that part. I am at fault, since I reviewed
4eae2c9ae54a patch. Will keep this in mind in the future.

> This fixes the race again and adds a bigger and shoutier comment
> explaining the potential race condition.
> 
> Cc: stable@vger.kernel.org # v4.8
> Fixes: 4eae2c9ae54a
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index bd739fe..0d8712a 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -163,12 +163,6 @@ _GLOBAL(pnv_powersave_common)
>  	std	r9,_MSR(r1)
>  	std	r1,PACAR1(r13)
> 
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	/* Tell KVM we're entering idle */
> -	li	r4,KVM_HWTHREAD_IN_IDLE
> -	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> -#endif
> -
>  	/*
>  	 * Go to real mode to do the nap, as required by the architecture.
>  	 * Also, we need to be in real mode before setting hwthread_state,
> @@ -185,6 +179,26 @@ _GLOBAL(pnv_powersave_common)
> 
>  	.globl pnv_enter_arch207_idle_mode
>  pnv_enter_arch207_idle_mode:
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Tell KVM we're entering idle */
> +	li	r4,KVM_HWTHREAD_IN_IDLE
> +	/******************************************************/
> +	/*  N O T E   W E L L    ! ! !    N O T E   W E L L   */
> +	/* The following store to HSTATE_HWTHREAD_STATE(r13)  */
> +	/* MUST occur in real mode, i.e. with the MMU off,    */
> +	/* and the MMU must stay off until we clear this flag */
> +	/* and test HSTATE_HWTHREAD_REQ(r13) in the system    */
> +	/* reset interrupt vector in exceptions-64s.S.        */
> +	/* The reason is that another thread can switch the   */
> +	/* MMU to a guest context whenever this flag is set   */
> +	/* to KVM_HWTHREAD_IN_IDLE, and if the MMU was on,    */
> +	/* that would potentially cause this thread to start  */
> +	/* executing instructions from guest memory in        */
> +	/* hypervisor mode, leading to a host crash or data   */
> +	/* corruption, or worse.                              */
> +	/******************************************************/
> +	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> +#endif
>  	stb	r3,PACA_THREAD_IDLE_STATE(r13)
>  	cmpwi	cr3,r3,PNV_THREAD_SLEEP
>  	bge	cr3,2f
> @@ -250,6 +264,12 @@ enter_winkle:
>   * r3 - requested stop state
>   */
>  power_enter_stop:
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Tell KVM we're entering idle */
> +	li	r4,KVM_HWTHREAD_IN_IDLE
> +	/* DO THIS IN REAL MODE!  See comment above. */
> +	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> +#endif
>  /*
>   * Check if the requested state is a deep idle state.
>   */
> -- 
> 2.7.4
> 
