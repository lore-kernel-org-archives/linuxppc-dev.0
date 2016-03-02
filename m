Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCEBA1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:08:03 +1100 (AEDT)
Date: Wed, 2 Mar 2016 12:07:59 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
Message-ID: <20160302010759.GB3160@oak.ozlabs.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2016 at 08:50:50AM +0530, Aneesh Kumar K.V wrote:
> _PAGE_PRIV means the page can be accessed only by kernel. This is done
> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
> pages are now makred by clearing _PAGE_PRIV bit.

Mostly looks good, but some comments below...

> @@ -174,15 +174,12 @@
>   * Note due to the way vm flags are laid out, the bits are XWR
>   */
>  #define PAGE_NONE	__pgprot(_PAGE_BASE)
> -#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
> -#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
> -				 _PAGE_EXEC)
> -#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ )
> -#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
> -				 _PAGE_EXEC)
> -#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
> -#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
> -				 _PAGE_EXEC)
> +#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
> +#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)

These need _PAGE_READ as far as I can see.

> @@ -40,6 +40,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		if (unlikely(access & ~old_pte))
>  			return 1;

This check is going to do a different thing now as far as
_PAGE_USER/_PAGE_PRIV is concerned: previously it would prevent a
non-privileged access to a privileged page from creating a HPTE, now
it prevents a privileged access to a non-privileged page from creating
a HPTE.  A privileged access means an access by the kernel to a high
address, and arguably we would never have a non-privileged PTE at a
high (i.e. kernel) address, but it's still a semantic change that
should have been flagged in the patch description.

In fact it wouldn't really matter if we didn't check the privilege
here and went ahead and created the HPTE - if it's a non-privileged
access to a privileged page, the HPTE will get its permission bits set
so as to prevent non-privileged access anyway.

>  		/*
> +		 * access from user, but pte in _PAGE_PRIV
> +		 */
> +		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
> +			return 1;

And this catches both the privileged access to non-privileged page
case (which the previous statement already caught) and the
non-privileged access to privileged page case.

By the way, "pte in _PAGE_PRIV" is not good English.  You could say
"_PAGE_PRIV is set in pte" or "pte has _PAGE_PRIV set".

> +	/*
> +	 * access from user, but pte in _PAGE_PRIV
> +	 */
> +	if ((access & _PAGE_PRIV) != (pte_val(*ptep) & _PAGE_PRIV)) {
> +		DBG_LOW(" no access !\n");
> +		rc = 1;
> +		goto bail;
> +	}

Why do we need this added here?  Haven't you added the same check in
all the lower-level functions that this calls?

> @@ -158,7 +158,7 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
>  		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
>  
>  	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
> -	flags &= ~(_PAGE_USER | _PAGE_EXEC);
> +	flags &= ~(_PAGE_PRIV | _PAGE_EXEC);

Need to fix the comment too.

> @@ -198,7 +198,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
>  		flags |= _PAGE_DIRTY;
>  
>  	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
> -	flags &= ~(_PAGE_USER | _PAGE_EXEC);
> +	flags &= ~(_PAGE_PRIV | _PAGE_EXEC);

ditto

Paul.
