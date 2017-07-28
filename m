Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJW9B4KRfzDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 11:14:54 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id d193so22022453pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 18:14:54 -0700 (PDT)
Message-ID: <1501204487.14223.3.camel@gmail.com>
Subject: Re: [PATCH v2] powerpc/mm: Check for _PAGE_PTE in *_devmap()
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, joserz@linux.vnet.ibm.com
Date: Fri, 28 Jul 2017 11:14:47 +1000
In-Reply-To: <20170727153553.9160-1-oohall@gmail.com>
References: <20170727153553.9160-1-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-28 at 01:35 +1000, Oliver O'Halloran wrote:
> The ISA radix translation tree contains two different types of entry,
s/entry/entries
> > directories and leaves. The formats of the two entries are
> different
> with the directory entries containing no spare bits for use by
> software.

Rather than saying the directory entries contain no spare bits, would
it be better to say something like: the devmap property only relates to
pte (leaf) entries and so we shouldn't perform the check on/should
always return false for page directory entries?

> As a result we need to ensure that the *_devmap() family of functions
> check fail for everything except leaf (PTE) entries.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> "i'll just tweak the mbox before i sent it, what's the worst that can
> happen"
> *completely breaks KVM*
> "..."
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d1da415..6bc6248 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -610,7 +610,9 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>  
>  static inline int pte_devmap(pte_t pte)
>  {
> -	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +	uint64_t mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
> +
> +	return (pte_raw(pte) & mask) == mask;
>  }
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
