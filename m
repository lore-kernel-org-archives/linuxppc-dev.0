Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Rc16db2zF1wD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:00:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 3/4] powerpc/mm/hash64: Increase the VA range
In-Reply-To: <20180318110558.30493-4-aneesh.kumar@linux.vnet.ibm.com>
References: <20180318110558.30493-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180318110558.30493-4-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 00:00:31 +1100
Message-ID: <87efkcfeog.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index fdb424a29f03..63470b06c502 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -68,12 +68,6 @@
>  
>  #include "mmu_decl.h"
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -#if H_PGTABLE_RANGE > USER_VSID_RANGE
> -#warning Limited user VSID range means pagetable space is wasted
> -#endif
> -#endif /* CONFIG_PPC_BOOK3S_64 */

As discussed I updated this instead of dropping it, and moved it to
pgtable-hash64.c, where it doesn't need the ifdef:

#if H_PGTABLE_RANGE > (USER_VSID_RANGE * (TASK_SIZE_USER64 / TASK_CONTEXT_SIZE))
#warning Limited user VSID range means pagetable space is wasted
#endif

cheers
