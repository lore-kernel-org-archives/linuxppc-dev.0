Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWJk2h6nzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:45:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78Ai5d8095810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 06:45:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c7a00nsjh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 06:45:39 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 04:45:39 -0600
Date: Tue, 8 Aug 2017 16:15:34 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 12/13] powerpc/64s: idle POWER9 can execute stop in
 virtual mode
Reply-To: ego@linux.vnet.ibm.com
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-13-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170805170241.22966-13-npiggin@gmail.com>
Message-Id: <20170808104534.GC9107@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 06, 2017 at 03:02:40AM +1000, Nicholas Piggin wrote:
> The hardware can execute stop in any context, and KVM does not
> require real mode. This saves a switch to real-mode when going
> idle.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/idle_book3s.S | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 75746111e2c4..8ac366a51bb5 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -141,7 +141,16 @@ pnv_powersave_common:
>  	std	r5,_CCR(r1)
>  	std	r1,PACAR1(r13)
> 
> +BEGIN_FTR_SECTION
> +	/*
> +	 * POWER9 does not require real mode to stop, and does not set
> +	 * hwthread_state for KVM (threads don't share MMU context), so
> +	 * we can remain in virtual mode for this.
> +	 */
> +	bctr
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	/*
> +	 * POWER8
>  	 * Go to real mode to do the nap, as required by the architecture.
>  	 * Also, we need to be in real mode before setting hwthread_state,
>  	 * because as soon as we do that, another thread can switch
> -- 
> 2.11.0
> 
