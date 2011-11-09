Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1EF2D1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 19:42:57 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id pA98gpJJ004869
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 14:12:51 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA98gpst3207370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 14:12:51 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA98goYf015245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2011 19:42:51 +1100
Message-ID: <4EBA3D0A.5090603@in.ibm.com>
Date: Wed, 09 Nov 2011 14:12:50 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble> <4EB3A40C.1070802@in.ibm.com>
 <1320678819.2750.15.camel@treble> <4EB8D628.2090304@in.ibm.com>
 <1320769145.5273.26.camel@treble>
 <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
In-Reply-To: <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/09/11 12:03, Suzuki Poulose wrote:
> On Tue, 08 Nov 2011 10:19:05 -0600
> Josh Poimboeuf<jpoimboe@linux.vnet.ibm.com>  wrote:
>
>> On Tue, 2011-11-08 at 12:41 +0530, Suzuki Poulose wrote:
>>> What I was suggesting is, instead of flushing the cache in
>>> relocate(), lets do it like:
>>>
>>> for e.g, on 440x, (in head_44x.S :)
>>>
>>> #ifdef CONFIG_RELOCATABLE
>>> 	...
>>> 	bl relocate
>>>
>>> 	#Flush the d-cache and invalidate the i-cache here
>>> #endif
>>>
>>>
>>> This would let the different platforms do the the cache
>>> invalidation in their own way.
>>>
>>> Btw, I didn't find an instruction to flush the entire d-cache in
>>> PPC440 manual. We have instructions to flush only a block
>>> corresponding to an address.
>>>
>>> However, we have 'iccci' which would invalidate the entire i-cache
>>> which, which I think is better than 80,000 i-cache invalidates.
>>
>> In misc_32.S there are already some platform-independent cache
>> management functions.  If we use those, then relocate() could simply
>> call them.  Then the different platforms calling relocate() wouldn't
>> have to worry about flushing/invalidating caches.
>>
>> For example, there's a clean_dcache_range() function.  Given any range
>> twice the size of the d-cache, it should flush the entire d-cache.
>> But the only drawback is that it would require the caller to know the
>> size of the d-cache.
>>
>> Instead, I think it would be preferable to create a new clean_dcache()
>> (or clean_dcache_all()?) function in misc_32.S, which could call
>> clean_dcache_range() with the appropriate args for flushing the entire
>> d-cache.  relocate() could then call the platform-independent
>> clean_dcache().
>>
>
>
> How about using clean_dcache_range() to flush the range runtime
> address range [ _stext, _end ] ? That would flush the entire
> instructions.
>
>
>> For i-cache invalidation there's already the (incorrectly named?)
>> flush_instruction_cache().  It uses the appropriate platform-specific
>> methods (e.g. iccci for 44x) to invalidate the entire i-cache.
>
> Agreed. The only thing that worries me is the use of KERNELBASE in the
> flush_instruction_cache() for CONFIG_4xx. Can we safely assume all 4xx
> implementations ignore the arguments passed to iccci ?
>>
>> Suzuki, if you agree with this direction, I could work up a new patch
>> if needed.
>>
>
> I have the following (untested) patch which uses clean_dcache_range()
> and flush_instruction_cache(): I will send the next version soon
> with those changes and the DYNAMIC_MEMSTART config for oldstyle
> relocatoin, if every one agrees to this.
>
>
> diff --git a/arch/powerpc/kernel/reloc_32.S
> b/arch/powerpc/kernel/reloc_32.S index 045d61e..cce0510 100644
> --- a/arch/powerpc/kernel/reloc_32.S
> +++ b/arch/powerpc/kernel/reloc_32.S
> @@ -33,10 +33,9 @@ R_PPC_RELATIVE = 22
>
>   _GLOBAL(relocate)
>
> -	mflr	r0
> +	mflr	r14		/* Save our LR */
>   	bl	0f		/* Find our current runtime
> address */ 0:	mflr	r12		/* Make it
> accessible */
> -	mtlr	r0
>
>   	lwz	r11, (p_dyn - 0b)(r12)
>   	add	r11, r11, r12	/* runtime address of .dynamic
> section */ @@ -87,18 +86,19 @@ eodyn:				/*
> End of Dyn Table scan */
>   	 * Work out the current offset from the link time address
> of .rela
>   	 * section.
>   	 *  cur_offset[r7] = rela.run[r9] - rela.link [r7]
> -	 *  _stext.link[r10] = _stext.run[r10] - cur_offset[r7]
> -	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r10]
> +	 *  _stext.link[r12] = _stext.run[r10] - cur_offset[r7]
> +	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r12]
>   	 */
>   	subf	r7, r7, r9	/* cur_offset */
> -	subf	r10, r7, r10
> -	subf	r3, r10, r3	/* final_offset */
> +	subf	r12, r7, r10
> +	subf	r3, r12, r3	/* final_offset */
>
>   	subf	r8, r6, r8	/* relaz -= relaent */
>   	/*
>   	 * Scan through the .rela table and process each entry
>   	 * r9	- points to the current .rela table entry
>   	 * r13	- points to the symbol table
> +	 * r10  - holds the runtime address of _stext
>   	 */
>
>   	/*
> @@ -180,12 +180,23 @@ store_half:
>
>   nxtrela:
>   	cmpwi	r8, 0		/* relasz = 0 ? */
> -	ble	done
> +	ble	flush
>   	add	r9, r9, r6	/* move to next entry in
> the .rela table */ subf	r8, r6, r8	/* relasz -= relaent */
>   	b	applyrela
>
> -done:	blr
> +	/* Flush the d-cache'd instructions */
> +flush:
> +	mr	r3, r10
> +	lis	r4, (_end - _stext)@h
> +	ori	r4, r4, (_end - _stext)@l

Err ! This doesn't compile :

arch/powerpc/kernel/reloc_32.S: Assembler messages:
arch/powerpc/kernel/reloc_32.S:191: Error: can't resolve `_end' {*UND* section} - `_stext' {*UND* section}


I will fix it, but the idea remains the same.

Thanks

Suzuki
