Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22C041A0935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 15:37:50 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 451931401CD
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 15:37:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 15:37:47 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 4/5] powerpc/mm: Simplify page size kconfig dependencies
In-Reply-To: <1438928387-6454-4-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
 <1438928387-6454-4-git-send-email-mpe@ellerman.id.au>
Date: Mon, 10 Aug 2015 11:06:44 +0530
Message-ID: <87tws7puvn.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> For config options with only a single value, guarding the single value
> with 'if' is the same as adding a 'depends' statement. And it's more
> standard to just use 'depends'.
>
> And if the option has both an 'if' guard and a 'depends' we can collapse
> them into a single 'depends' by combining them with &&.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/Kconfig | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5ef27113b898..3a4ba2809201 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -560,16 +560,17 @@ config PPC_4K_PAGES
>  	bool "4k page size"
>
>  config PPC_16K_PAGES
> -	bool "16k page size" if 44x || PPC_8xx
> +	bool "16k page size"
> +	depends on 44x || PPC_8xx
>
>  config PPC_64K_PAGES
> -	bool "64k page size" if 44x || PPC_STD_MMU_64 || PPC_BOOK3E_64
> -	depends on !PPC_FSL_BOOK3E
> +	bool "64k page size"
> +	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
>  	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
>
>  config PPC_256K_PAGES
> -	bool "256k page size" if 44x
> -	depends on !STDBINUTILS
> +	bool "256k page size"
> +	depends on 44x && !STDBINUTILS
>  	help
>  	  Make the page size 256k.
>
> -- 
> 2.1.4
