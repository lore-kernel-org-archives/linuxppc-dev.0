Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D32F1A0EC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 19:16:51 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB99B1400B7
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2015 19:16:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 13:46:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 33082E0056
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2015 13:47:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t078HOrf57671822
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2015 13:47:24 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t078GhEJ016061
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2015 13:46:43 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
In-Reply-To: <20150107044237.5803.85825.stgit@mars.in.ibm.com>
References: <20150107044237.5803.85825.stgit@mars.in.ibm.com>
Date: Wed, 07 Jan 2015 13:46:42 +0530
Message-ID: <87iogjovit.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> commit id 9975f5e added new config variable CONFIG_KVM_BOOK3S_HV_POSSIBLE
> that helps to select the relevant code in the kernel when HV and PR
> bits are built as separate modules. As part of that commit, all the
> instances of #ifdef CONFIG_KVM_BOOK3S_64_HV was replaced with
> CONFIG_KVM_BOOK3S_HV_POSSIBLE. But the MCE code still depends on
> CONFIG_KVM_BOOK3S_64_HV which is wrong. When HV bits are built as a
> separate module the relevent MCE code gets excluded. This patch fixes
> the MCE code to use CONFIG_KVM_BOOK3S_HV_POSSIBLE.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index c2df815..7335857 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1408,7 +1408,7 @@ machine_check_handle_early:
>  	bne	9f			/* continue in V mode if we are. */
>
>  5:
> -#ifdef CONFIG_KVM_BOOK3S_64_HV
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	/*
>  	 * We are coming from kernel context. Check if we are coming from
>  	 * guest. if yes, then we can continue. We will fall through

Do we also need to update the HSTATE_IN_GUEST check to avoid checking
the PR guest mode ?ie, 

	lbz	r11,HSTATE_IN_GUEST(r13)
	cmpwi	r11,0			/* Check if coming from guest */

checking for 0 is what you want there ?

-aneesh
