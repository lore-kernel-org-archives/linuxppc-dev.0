Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thvwb15ZQzDwBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:58:54 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ8rlLG099244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:58:52 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27e96meveu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:58:52 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 01:58:51 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 1/5] powerpc/mm: set the radix linear page mapping size
In-Reply-To: <1481831443-22761-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-2-git-send-email-arbab@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 14:28:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760mguwfx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> This was defaulting to 4K, regardless of PAGE_SIZE.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 623a0dc..54bd70e 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -351,8 +351,10 @@ void __init radix__early_init_mmu(void)
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* PAGE_SIZE mappings */
>  	mmu_virtual_psize = MMU_PAGE_64K;
> +	mmu_linear_psize = MMU_PAGE_64K;

That is not clearly correct, we map the linear address with either 64K,
2M or 1G depending on the memory available. Take a look at
static void __init radix_init_pgtable(void)


>  #else
>  	mmu_virtual_psize = MMU_PAGE_4K;
> +	mmu_linear_psize = MMU_PAGE_4K;
>  #endif
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -- 
> 1.8.3.1
