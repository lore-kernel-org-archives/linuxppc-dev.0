Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wtl34p0nzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 20:35:59 +1000 (AEST)
Subject: Re: [PATCH v2 9/9] powerpc/hugetlb: Enable hugetlb migration for ppc64
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926612-23928-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <69b4fae5-d413-4866-7ce4-3873d3c6590f@c-s.fr>
Date: Thu, 26 Apr 2018 12:35:55 +0200
MIME-Version: 1.0
In-Reply-To: <1494926612-23928-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/05/2017 à 11:23, Aneesh Kumar K.V a écrit :
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/Kconfig.cputype | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 80175000042d..8acc4f27d101 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -351,6 +351,11 @@ config PPC_RADIX_MMU
>   	  is only implemented by IBM Power9 CPUs, if you don't have one of them
>   	  you can probably disable this.
>   
> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
> +	def_bool y
> +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
> +
> +

Is there a reason why you redefine ARCH_ENABLE_HUGEPAGE_MIGRATION 
instead of doing a 'select' as it is already defined in mm/Kconfig ?

Christophe

>   config PPC_MMU_NOHASH
>   	def_bool y
>   	depends on !PPC_STD_MMU
> 
