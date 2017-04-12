Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2vnG0CWgzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 16:55:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash: don't opencode VMALLOC_INDEX
In-Reply-To: <1491972022-14602-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491972022-14602-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 16:55:13 +1000
Message-ID: <87zifmt8ry.fsf@concordia.ellerman.id.au>
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

> powerpc/mm/hash: don't opencode VMALLOC_INDEX

OK.

> Also remove wrong indentation to fix checkpatch.pl warning.

No thanks :)

Or at least do it as a separate patch.

I'll fix it up this time.

cheers

> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 98ae810b8c21..3d580ccf4b71 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -131,9 +131,9 @@ static void __slb_flush_and_rebolt(void)
>  		     "slbmte	%2,%3\n"
>  		     "isync"
>  		     :: "r"(mk_vsid_data(VMALLOC_START, mmu_kernel_ssize, vflags)),
> -		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, 1)),
> -		        "r"(ksp_vsid_data),
> -		        "r"(ksp_esid_data)
> +			"r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, VMALLOC_INDEX)),
> +			"r"(ksp_vsid_data),
> +			"r"(ksp_esid_data)
>  		     : "memory");
>  }
>  
> -- 
> 2.7.4
