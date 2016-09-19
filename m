Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd32z2kvzzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 21:05:47 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc: fix usage of _PAGE_RO in hugepage
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <20160919105855.435AF1A2455@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <db3ac3ab-9ac0-22bb-11d6-a4936b542db3@c-s.fr>
Date: Mon, 19 Sep 2016 13:05:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160919105855.435AF1A2455@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2016 à 12:58, Christophe Leroy a écrit :
> On some CPUs like the 8xx, _PAGE_RW hence _PAGE_WRITE is defined
> as 0 and _PAGE_RO has to be set when a page is not writable
>
> _PAGE_RO is defined by default in pte-common.h, however BOOK3S/64
> doesn't include that file so _PAGE_RO has to be defined explicitly
> in book3s/64/pgtable.h
>
> fixes: a7b9f671f2d14 ("powerpc32: adds handling of _PAGE_RO")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Forgot to add from V1:

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Christophe


> ---
> v1: This patch was initially part of the v1 serie of patchs for providing
>    hugepage support to the 8xx. As suggested by Aneesh, that serie has
>    been splited to focus only on hugepage implementation for 8xx.
>    This patch is a fix and is independant of 8xx hugepage implementation,
>    allthough it is required to have hugepage support working properly on
>    the 8xx.
>
> v2: Added a comment in the code as suggested by Aneesh.
>
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 2 ++
>  arch/powerpc/mm/hugetlbpage.c                | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 8ec8be9..9fd77f8 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -6,6 +6,8 @@
>   */
>  #define _PAGE_BIT_SWAP_TYPE	0
>
> +#define _PAGE_RO		0
> +
>  #define _PAGE_EXEC		0x00001 /* execute permission */
>  #define _PAGE_WRITE		0x00002 /* write access allowed */
>  #define _PAGE_READ		0x00004	/* read access allowed */
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 7372ee1..a5d3ecd 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -1019,8 +1019,15 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>
>  	pte = READ_ONCE(*ptep);
>  	mask = _PAGE_PRESENT | _PAGE_READ;
> +
> +	/*
> +	 * On some CPUs like the 8xx, _PAGE_RW hence _PAGE_WRITE is defined
> +	 * as 0 and _PAGE_RO has to be set when a page is not writable
> +	 */
>  	if (write)
>  		mask |= _PAGE_WRITE;
> +	else
> +		mask |= _PAGE_RO;
>
>  	if ((pte_val(pte) & mask) != mask)
>  		return 0;
>
