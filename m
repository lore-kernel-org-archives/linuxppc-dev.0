Return-Path: <jpoimboe@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1FC5F1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 08:45:40 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jpoimboe@linux.vnet.ibm.com>;
 Thu, 10 Nov 2011 16:45:35 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAALj4en250520
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 16:45:04 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAALj0qS028741
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 16:45:03 -0500
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
From: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <4EBB3794.9050309@in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble> <4EB3A40C.1070802@in.ibm.com>
 <1320678819.2750.15.camel@treble> <4EB8D628.2090304@in.ibm.com>
 <1320769145.5273.26.camel@treble>
 <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
 <1320850388.3259.18.camel@treble>  <4EBB3794.9050309@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Nov 2011 15:44:57 -0600
Message-ID: <1320961497.5535.66.camel@treble>
Mime-Version: 1.0
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Alan Modra <amodra@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-10 at 08:01 +0530, Suzuki Poulose wrote:
> >> How about using clean_dcache_range() to flush the range runtime
> >> address range [ _stext, _end ] ? That would flush the entire
> >> instructions.
> >
> > Wouldn't that result in more cache flushing than the original solution?
> >
> > For example, my kernel is 3.5MB.  Assuming a 32 byte cache line size,
> > clean_dcache_range(_stext, _end) would result in about 115,000 dcbst's
> > (3.5MB / 32).
> 
> Oops ! You are right. We could go back to the clean_dcache_all() or the
> initial approach that you suggested. (dcbst).
> 
> I am not sure how do we flush the entire dcache(only). Could you post a
> patch which does the same ?

It turns out that my original idea of giving a 64k address range to
clean_dcache_range() wouldn't work, because dcbst only flushes the line
if the given address is in the cache already.


Also, I experimented with a simple clean_dcache_all() function in
misc_32.S:

#define L1_CACHE_SIZE   (32 * 1024)
#define L1_CACHE_LINES  (L1_CACHE_SIZE / L1_CACHE_BYTES) 
_GLOBAL(clean_dcache_all)
        lis     r3, _start@h
        ori     r3, r3, _start@l
        li      r4, (L1_CACHE_LINES * 2)
        mtctr   r4
1:      lwz     r5, 0(r3)
        addi    r3, r3, L1_CACHE_BYTES
        bdnz    1b
        sync
        blr

But this approach has some issues:

1. It should probably be made more platform-independent with respect to
d-cache size.  I'm not sure the best way to achieve that.

2. The _start address is the kernel virtual address, not the physical
address, but relocate() is running without TLB address translation
enabled.  Although we could easily circumvent this problem by clearing
the d-cache directly in relocate() (or in head_44x.S) using physical
addresses.

3. Chicken/egg issue:  the _start address might be stale because we
haven't yet flushed the d-cache and invalidated the i-cache.

I also discovered that calling flush_instruction_cache() from relocate()
wouldn't work for all platforms, for similar reasons.

We could overcome these issues with more code, but the added complexity
might not be worth it (premature optimization and all).  My original
patch at least has the benefit of being simple.


> 
> Another option is to, change the current mapping to 'Write Through' before
> calling the relocate() and revert back to the original setting after relocate().

True, that's another option.  Although since TLB handling is
platform-specific, I think it would have to be handled by the caller in
head_44x.S, rather than within relocate().


> > That also may suggest a bigger can of worms.  A grep of the powerpc code
> > shows many uses of KERNELBASE.  For a relocatable kernel, nobody should
> > be relying on KERNELBASE except for the early relocation code.  Are we
> > sure that all the other usages of KERNELBASE are "safe"?
> >
> I think we could simply replace the occurrences of KERNELBASE (after the relocate())
>   with '_stext' which would give the virtual start address of the kernel.

Yeah, that would work.


Josh
