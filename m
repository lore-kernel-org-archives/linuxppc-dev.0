Return-Path: <jpoimboe@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E8D41007D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 01:53:17 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jpoimboe@linux.vnet.ibm.com>;
 Wed, 9 Nov 2011 07:53:14 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA9ErB3b144334
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 07:53:11 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA9ErA0C017476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 07:53:11 -0700
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
From: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble> <4EB3A40C.1070802@in.ibm.com>
 <1320678819.2750.15.camel@treble> <4EB8D628.2090304@in.ibm.com>
 <1320769145.5273.26.camel@treble>
 <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Nov 2011 08:53:08 -0600
Message-ID: <1320850388.3259.18.camel@treble>
Mime-Version: 1.0
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-09 at 12:03 +0530, Suzuki Poulose wrote:
> On Tue, 08 Nov 2011 10:19:05 -0600
> Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com> wrote:
> 
> > On Tue, 2011-11-08 at 12:41 +0530, Suzuki Poulose wrote:
> > > What I was suggesting is, instead of flushing the cache in
> > > relocate(), lets do it like:
> > > 
> > > for e.g, on 440x, (in head_44x.S :)
> > > 
> > > #ifdef CONFIG_RELOCATABLE
> > > 	...
> > > 	bl relocate
> > > 
> > > 	#Flush the d-cache and invalidate the i-cache here
> > > #endif
> > > 
> > > 
> > > This would let the different platforms do the the cache
> > > invalidation in their own way.
> > > 
> > > Btw, I didn't find an instruction to flush the entire d-cache in
> > > PPC440 manual. We have instructions to flush only a block
> > > corresponding to an address.
> > > 
> > > However, we have 'iccci' which would invalidate the entire i-cache
> > > which, which I think is better than 80,000 i-cache invalidates.
> > 
> > In misc_32.S there are already some platform-independent cache
> > management functions.  If we use those, then relocate() could simply
> > call them.  Then the different platforms calling relocate() wouldn't
> > have to worry about flushing/invalidating caches.
> > 
> > For example, there's a clean_dcache_range() function.  Given any range
> > twice the size of the d-cache, it should flush the entire d-cache.
> > But the only drawback is that it would require the caller to know the
> > size of the d-cache.
> > 
> > Instead, I think it would be preferable to create a new clean_dcache()
> > (or clean_dcache_all()?) function in misc_32.S, which could call
> > clean_dcache_range() with the appropriate args for flushing the entire
> > d-cache.  relocate() could then call the platform-independent
> > clean_dcache().
> > 
> 
> 
> How about using clean_dcache_range() to flush the range runtime
> address range [ _stext, _end ] ? That would flush the entire
> instructions.

Wouldn't that result in more cache flushing than the original solution? 

For example, my kernel is 3.5MB.  Assuming a 32 byte cache line size,
clean_dcache_range(_stext, _end) would result in about 115,000 dcbst's
(3.5MB / 32).


> 
> 
> > For i-cache invalidation there's already the (incorrectly named?)
> > flush_instruction_cache().  It uses the appropriate platform-specific
> > methods (e.g. iccci for 44x) to invalidate the entire i-cache.
> 
> Agreed. The only thing that worries me is the use of KERNELBASE in the 
> flush_instruction_cache() for CONFIG_4xx. Can we safely assume all 4xx
> implementations ignore the arguments passed to iccci ? 

Good question.  I don't know the answer. :-)

That also may suggest a bigger can of worms.  A grep of the powerpc code
shows many uses of KERNELBASE.  For a relocatable kernel, nobody should
be relying on KERNELBASE except for the early relocation code.  Are we
sure that all the other usages of KERNELBASE are "safe"?

For example -- the DEBUG_CRIT_EXCEPTION macro, which head_44x.S uses,
relies on KERNELBASE.  That doesn't seem right to me.


Josh
