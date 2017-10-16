Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFg4V57sfzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 12:01:13 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p9so882677pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 18:01:13 -0700 (PDT)
Date: Mon, 16 Oct 2017 12:01:02 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/strict_rwx: quirks for STRICT_RWX patches
Message-ID: <20171016120102.791de42e@firefly.ozlabs.ibm.com>
In-Reply-To: <8760bvqo5n.fsf@concordia.ellerman.id.au>
References: <20170927095111.10626-1-bsingharora@gmail.com>
 <8760bvqo5n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 04 Oct 2017 20:04:52 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Balbir,
> 
> Mainly I think we need to add a check in mark_initmem_nx() too don't we?
> Or should we put it somewhere common to both?
> 
> But seeing as I'm replying here are some more comments.
> 
> > Subject: [PATCH 1/2] powerpc/strict_rwx: quirks for STRICT_RWX patches  
> 
> This misses three key things, 1) it's a bug fix 2) it's for Power9 DD1,
> and 3) it only applies to radix.
> 
> So how about:
> 
> powerpc/64s: Fix crashes on Power9 DD1 with radix MMU and STRICT_RWX
> 
> 
> Balbir Singh <bsingharora@gmail.com> writes:
> > This patch disables STRICT_RWX for power9 DD1 machines
> > where due to some limitations with the way we do tlb
> > updates, we clear the TLB entry of the text that's doing
> > the update to kernel text and that does lead to a
> > crash.  
> 
> This mostly describes the patch, but I would prefer more detail, eg:
> 
>   When using the radix MMU on Power9 DD1, to work around a hardware
>   problem, radix__pte_update() is required to do a two stage update of
>   the PTE. First we write a zero value into the PTE, then we flush the
>   TLB, and then we write the new PTE value.
>   
>   In the normal case that works OK, but it does not work if we're
>   updating the PTE that maps the code we're executing, because the
>   mapping is removed by the TLB flush and we can no longer execute from
>   it. Unfortunately the STRICT_RWX code needs to do exactly that.
>   
>   The exact symptoms when we hit this case vary, sometimes we print an
>   oops and then get stuck after that, but I've also seen a machine just
>   get stuck continually page faulting with no oops printed. The variance
>   is presumably due to the exact layout of the text and the page size
>   used for the mappings. In all cases we are unable to boot to a shell.
>   
>   There are possible solutions such as creating a second mapping of the
>   TLB flush code, executing from that, and then jumping back to the
>   original. However we don't want to add that level of complexity for a
>   DD1 work around.
>   
>   So just detect that we're running on Power9 DD1 and refrain from
>   changing the permissions, effectively disabling STRICT_RWX on Power9
>   DD1.
>

I can copy this verbatim

> 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index 39c252b..c2a2b46 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -169,6 +169,18 @@ void radix__mark_rodata_ro(void)
> >  {
> >  	unsigned long start, end;
> >  
> > +	/*
> > +	 * mark_rodata_ro() will mark itself as !writable at some point  
>                                                                        ^
>                                                                        .
> > +	 * due to workaround in radix__pte_update(), we'll end up with  
>            ^     ^
>            D     the DD1
> > +	 * an invalid pte and the system will crash quite severly.  
> 
> > +	 * The alternatives are quite cumbersome and leaving out
> > +	 * the page containing the flush code is not very nice.  
> 
> Just drop the last sentence, it doesn't have enough detail to be useful
> and we chose not to implement those alternatives, so better not to
> confuse the reader by talking about them.
> 

Can and will do

> > +	 */
> > +	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> > +		pr_warn("Warning: Unable to mark rodata read only on P9 DD1\n");
> > +		return;
> > +	}  
> 
> Don't we also need to do the check in radix__mark_initmem_nx() ?

No.. not for NX, since we mark NX pages (.data and .init.text..init.end)
from .text. We don't change permissions for anything in .text in that
routine.

> 
> cheers
