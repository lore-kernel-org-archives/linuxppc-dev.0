Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkSnr1gpnzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:43:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GCdFlP063648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:43:34 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297setcyrr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:43:34 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 08:43:33 -0400
Date: Thu, 16 Mar 2017 18:13:28 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] powerpc/64s: idle do not hold reservation longer
 than required
Reply-To: ego@linux.vnet.ibm.com
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314092349.10981-8-npiggin@gmail.com>
Message-Id: <20170316124328.GE16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Tue, Mar 14, 2017 at 07:23:48PM +1000, Nicholas Piggin wrote:
> When taking the core idle state lock, grab it immediately like a
> regular lock, rather than adding more tests in there. Holding the lock
> keeps it stable, so there is no need to do it whole holding the
> reservation.

I agree with this patch. Just a minor query

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 1c91dc35c559..3cb75907c5c5 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -488,12 +488,12 @@ BEGIN_FTR_SECTION
>  	CHECK_HMI_INTERRUPT
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> 
> -	lbz	r7,PACA_THREAD_MASK(r13)
>  	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
> -lwarx_loop2:
> -	lwarx	r15,0,r14
> -	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
> +	lbz	r7,PACA_THREAD_MASK(r13)

Is reversing the order of loads into r7 and r14 intentional?

Other than that,
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> +
>  	/*
> +	 * Take the core lock to synchronize against other threads.
> +	 *
>  	 * Lock bit is set in one of the 2 cases-
>  	 * a. In the sleep/winkle enter path, the last thread is executing
>  	 * fastsleep workaround code.
> @@ -501,7 +501,14 @@ lwarx_loop2:
>  	 * workaround undo code or resyncing timebase or restoring context
>  	 * In either case loop until the lock bit is cleared.
>  	 */
> +1:
> +	lwarx	r15,0,r14
> +	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
>  	bnel-	core_idle_lock_held
> +	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
> +	stwcx.	r15,0,r14
> +	bne-	1b
> +	isync
> 
>  	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
>  	cmpwi	cr2,r9,0
> @@ -513,11 +520,6 @@ lwarx_loop2:
>  	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
>  	 */
> 
> -	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
> -	stwcx.	r15,0,r14
> -	bne-	lwarx_loop2
> -	isync
> -
>  BEGIN_FTR_SECTION
>  	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
>  	and	r4,r4,r15
> -- 
> 2.11.0
> 
