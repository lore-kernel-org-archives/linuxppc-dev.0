Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7351A029C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:39:23 +1100 (AEDT)
Date: Wed, 2 Mar 2016 12:39:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] powerpc/mm: Update prot_none implementation
 using _PAGE_READ
Message-ID: <20160302013920.GC3160@oak.ozlabs.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Another thing:

On Fri, Feb 26, 2016 at 08:50:49AM +0530, Aneesh Kumar K.V wrote:
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -173,9 +173,11 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  	 * and there is no kernel RO (_PAGE_KERNEL_RO).
>  	 * User area is mapped with PP=0x2 for read/write
>  	 * or PP=0x3 for read-only (including writeable but clean pages).
> +	 * We also map user prot none as with PP=00.
>  	 */
>  	if (pteflags & _PAGE_USER) {
> -		rflags |= 0x2;
> +		if ((pteflags & _PAGE_READ) || (pteflags & _PAGE_RW))
> +			rflags |= 0x2;

You need to check _PAGE_EXEC too here.  I would do:

		if (pteflags & (_PAGE_READ | _PAGE_RW | _PAGE_EXEC))
			rflags |= 0x2;

Paul.
