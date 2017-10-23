Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLCmP52TNzDqmL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:48:05 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NAiPQU038111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:48:02 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsbjcsggv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:48:01 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 11:48:00 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9NAluHw30081202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 10:47:58 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9NAlkPt019503
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:47:47 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
In-Reply-To: <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
Date: Mon, 23 Oct 2017 14:55:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vaj68bc0.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> powerpc needs an additional vma bit to support 32 keys.
> Till the additional vma bit lands in include/linux/mm.h
> we have to define  it  in powerpc specific header file.
> This is  needed to get pkeys working on power.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index c02305a..44e01a2 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -3,6 +3,24 @@
>
>  extern bool pkey_inited;
>  extern bool pkey_execute_disable_support;
> +
> +/*
> + * powerpc needs an additional vma bit to support 32 keys.
> + * Till the additional vma bit lands in include/linux/mm.h
> + * we have to carry the hunk below. This is  needed to get
> + * pkeys working on power. -- Ram
> + */
> +#ifndef VM_HIGH_ARCH_BIT_4
> +#define VM_HIGH_ARCH_BIT_4	36
> +#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
> +#define VM_PKEY_BIT0	VM_HIGH_ARCH_0
> +#define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +#define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> +#define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +#define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> +#endif
> +
>  #define ARCH_VM_PKEY_FLAGS 0

Do we want them in pkeys.h ? Even if they are arch specific for the
existing ones we have them in include/linux/mm.h. IIUC, vmflags details
are always in mm.h? This will be the first exception to that?


>
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> -- 
> 1.7.1
