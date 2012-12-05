Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2270C2C00BE
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2012 19:20:50 +1100 (EST)
Message-ID: <1354695642.2351.8.camel@pasglop>
Subject: Re: Understanding how kernel updates MMU hash table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pegasus11 <aijazbaig1.new@gmail.com>
Date: Wed, 05 Dec 2012 19:20:42 +1100
In-Reply-To: <34760537.post@talk.nabble.com>
References: <34760537.post@talk.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-12-04 at 21:56 -0800, Pegasus11 wrote:
> Hello.
> 
> Ive been trying to understand how an hash PTE is updated. Im on a PPC970MP
> machine which using the IBM PowerPC 604e core. 

Ah no, the 970 is a ... 970 core :-) It's a derivative of POWER4+ which
is quite different from the old 32-bit 604e.

> My Linux version is 2.6.10 (I
> am sorry I cannot migrate at the moment. Management issues and I can't help
> :-(( )
> 
> Now onto the problem:
> hpte_update is invoked to sync the on-chip MMU cache which Linux uses as its
> TLB.

It's actually in-memory cache. There's also an on-chip TLB.

>  So whenever a change is made to the PTE, it has to be propagated to the
> corresponding TLB entry. And this uses hpte_update for the same. Am I right
> here?

hpte_update takes care of tracking whether a Linux PTE was also cached
into the hash, in which case the hash is marked for invalidation. I
don't remember precisely how we did it in 2.6.10 but it's possible that
the actual invalidation of the hash and the corresponding TLB
invalidations are delayed.

> Now  http://lxr.linux.no/linux-bk+*/+code=hpte_update hpte_update  is
> declared as
>  
> ' void hpte_update(pte_t *ptep, unsigned long pte, int wrprot) '. 
> The arguments to this function is a POINTER to the PTE entry (needed to make
> a change persistent across function call right?), the PTE entry (as in the
> value) as well the wrprot flag.
> 
> Now the code snippet thats bothering me is this:
> '
>   86        ptepage = virt_to_page(ptep);
>   87        mm = (struct mm_struct *) ptepage->mapping;
>   88        addr = ptepage->index +
>   89                (((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
> '
> 
> On line 86, we get the page structure for a given PTE but we pass the
> pointer to PTE not the PTE itself whereas virt_to_page is a macro defined
> as:

I don't remember why we did that in 2.6.10 however...

> #define virt_to_page(kaddr)   pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> 
> Why are passing the POINTER to pte here? I mean are we looking for the PAGE
> that is described by the PTE or are we looking for the PAGE which contains
> the pointer to PTE? Me things it is the later since the former is given by
> the VALUE of the PTE not its POINTER. Right?

The above gets the page that contains the PTEs indeed, in order to get
the associated mapping pointer which points to the struct mm_struct, and
the index, which together are used to re-constitute the virtual address,
probably in order to perform the actual invalidation. Nowadays, we just
pass the virtual address down from the call site.

> So if it indeed the later, what trickery are we here after? Perhaps
> following the snippet will make us understand? As I see from above, after
> that we get the 'address space object' associated with this page. 
> 
> What I don't understand is the following line:
>  addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) *
> PTRS_PER_PTE);
> 
> First we get the index of the page in the file i.e. the number of pages
> preceding the page which holds the address of PTEP. Then we get the lower 12
> bits of this page. Then we shift that these bits to the left by 12 again and
> to it we add the above index. What is this doing?
> 
> There are other things in this function that I do not understand. I'd be
> glad if someone could give me a heads up on this.

It's gross, the point is to rebuild the virtual address. You should
*REALLY* update to a more recent kernel, that ancient code is broken in
many ways as far as I can tell.

Cheers,
Ben.
