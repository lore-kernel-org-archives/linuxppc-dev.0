Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLClp0Vl3zDqmP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:47:33 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NAixXX034638
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:47:32 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsdha41xw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:47:31 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 11:47:29 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9NAlOd527787278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 10:47:26 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9NAlOUh009522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:47:25 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 06/25] powerpc: cleaup AMR,
 iAMR when a key is allocated or freed
In-Reply-To: <1504910713-7094-15-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-15-git-send-email-linuxram@us.ibm.com>
Date: Mon, 23 Oct 2017 15:13:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv4i8aii.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> cleanup the bits corresponding to a key in the AMR, and IAMR
> register, when the key is newly allocated/activated or is freed.
> We dont want some residual bits cause the hardware enforce
> unintended behavior when the key is activated or freed.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 5a83ed7..53bf13b 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -54,6 +54,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  		mm_set_pkey_is_allocated(mm, pkey));
>  }
>
> +extern void __arch_activate_pkey(int pkey);
> +extern void __arch_deactivate_pkey(int pkey);
>  /*
>   * Returns a positive, 5-bit key on success, or -1 on failure.
>   */
> @@ -80,6 +82,12 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
>
>  	ret = ffz((u32)mm_pkey_allocation_map(mm));
>  	mm_set_pkey_allocated(mm, ret);
> +
> +	/*
> +	 * enable the key in the hardware
> +	 */
> +	if (ret > 0)
> +		__arch_activate_pkey(ret);
>  	return ret;
>  }

We are already arch specific because we are defining them in
arch/powerpc/include/asm/, then why __arch_activate_pkey() ? 

>
> @@ -91,6 +99,10 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>  	if (!mm_pkey_is_allocated(mm, pkey))
>  		return -EINVAL;
>
> +	/*
> +	 * Disable the key in the hardware
> +	 */
> +	__arch_deactivate_pkey(pkey);
>  	mm_set_pkey_free(mm, pkey);
>
>  	return 0;
> -- 
> 1.7.1
