Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09E162C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 07:39:03 +1000 (EST)
Message-ID: <1379281131.4098.48.camel@pasglop>
Subject: Re: [PATCH v2 1/3] powerpc/booke64: add sync after writing PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 16 Sep 2013 07:38:51 +1000
In-Reply-To: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
References: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-13 at 22:50 -0500, Scott Wood wrote:
> The ISA says that a sync is needed to order a PTE write with a
> subsequent hardware tablewalk lookup.  On e6500, without this sync
> we've been observed to die with a DSI due to a PTE write not being seen
> by a subsequent access, even when everything happens on the same
> CPU.

This is gross, I didn't realize we had that bogosity in the
architecture...

Did you measure the performance impact ?

Cheers,
Ben.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: new patch
> 
> Note that we saw this problem when running in emulation (died early in
> boot), but when I tried just now with the mb() removed on actual
> hardware, I didn't see any problem.  But since I'm not aware of any
> change having been made in the hardware relative to this, and since it
> is architecturally required, I'd be more comfortable leaving it in
> unlesss something has changed in the kernel recently such that a sync
> is happening somewhere else along the code path.
> ---
>  arch/powerpc/include/asm/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 7d6eacf..0459077 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -143,6 +143,13 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 * cases, and 32-bit non-hash with 32-bit PTEs.
>  	 */
>  	*ptep = pte;
> +#ifdef CONFIG_PPC_BOOK3E_64
> +	/*
> +	 * With hardware tablewalk, a sync is needed to ensure that
> +	 * subsequent accesses see the PTE we just wrote.
> +	 */
> +	mb();
> +#endif
>  #endif
>  }
>  
