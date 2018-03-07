Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxQG80nZbzF1kj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 07:28:47 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27KPPwn122567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 15:28:45 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjkh4sb81-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 15:28:44 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 7 Mar 2018 20:28:40 -0000
Date: Wed, 7 Mar 2018 12:28:31 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm/keys: Move pte bits to correct headers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180307133645.29290-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307133645.29290-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180307202831.GJ1060@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2018 at 07:06:44PM +0530, Aneesh Kumar K.V wrote:
> Memory keys are supported only with hash translation mode. Instead of #ifdef in
> generic code move the key related pte bits to respective headers
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  7 +++++++
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 19 -------------------
>  3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index fc3dc6a93939..4103bfc7c223 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -33,6 +33,13 @@
>  #define H_PAGE_THP_HUGE 0x0
>  #define H_PAGE_COMBO	0x0
> 
> +/* memory key bits, only 8 keys supported */
> +#define H_PTE_PKEY_BIT0	0
> +#define H_PTE_PKEY_BIT1	0
> +#define H_PTE_PKEY_BIT2	_RPAGE_RSV3
> +#define H_PTE_PKEY_BIT3	_RPAGE_RSV4
> +#define H_PTE_PKEY_BIT4	_RPAGE_RSV5
> +


If CONFIG_PPC_MEM_KEYS is not defined, all of them have to be 0.  How is
that handled here? 

>  /* 8 bytes per each pte entry */
>  #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
>  #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index e53728ff29a0..bb880c97b87d 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -16,6 +16,13 @@
>  #define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
>  #define H_PAGE_HASHPTE	_RPAGE_RPN43	/* PTE has associated HPTE */
> 
> +/* memory key bits. */
> +#define H_PTE_PKEY_BIT0	_RPAGE_RSV1
> +#define H_PTE_PKEY_BIT1	_RPAGE_RSV2
> +#define H_PTE_PKEY_BIT2	_RPAGE_RSV3
> +#define H_PTE_PKEY_BIT3	_RPAGE_RSV4
> +#define H_PTE_PKEY_BIT4	_RPAGE_RSV5
> +

same comment as above.

RP
