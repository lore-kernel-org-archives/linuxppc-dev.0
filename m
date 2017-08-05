Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPzhb44VqzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 08:57:34 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v75MsbZR128755
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Aug 2017 18:57:31 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c5a1mw255-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 18:57:31 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 6 Aug 2017 08:57:28 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v75MvQIV8126464
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Aug 2017 08:57:27 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v75MvQNE021166
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Aug 2017 08:57:26 +1000
Subject: Re: [PATCH 12/13] powerpc/64s: idle POWER9 can execute stop in
 virtual mode
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Paul Mackerras
 <pmac@au1.ibm.com>
Date: Sun, 06 Aug 2017 08:57:25 +1000
In-Reply-To: <20170805170241.22966-13-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-13-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1501973845.2664.134.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-08-06 at 03:02 +1000, Nicholas Piggin wrote:
> The hardware can execute stop in any context, and KVM does not
> require real mode. This saves a switch to real-mode when going
> idle.

+Paulus.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
