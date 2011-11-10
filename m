Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B69E1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 13:32:20 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 10 Nov 2011 02:18:49 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAA2Vsgj614530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 13:31:54 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAA2Vrvd026449
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 13:31:54 +1100
Message-ID: <4EBB3794.9050309@in.ibm.com>
Date: Thu, 10 Nov 2011 08:01:48 +0530
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
 <1320850388.3259.18.camel@treble>
In-Reply-To: <1320850388.3259.18.camel@treble>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/09/11 20:23, Josh Poimboeuf wrote:
> On Wed, 2011-11-09 at 12:03 +0530, Suzuki Poulose wrote:
>> On Tue, 08 Nov 2011 10:19:05 -0600
>> Josh Poimboeuf<jpoimboe@linux.vnet.ibm.com>  wrote:
>>
>>> On Tue, 2011-11-08 at 12:41 +0530, Suzuki Poulose wrote:
>>>> What I was suggesting is, instead of flushing the cache in
>>>> relocate(), lets do it like:
>>>>
>>>> for e.g, on 440x, (in head_44x.S :)
>>>>
>>>> #ifdef CONFIG_RELOCATABLE
>>>> 	...
>>>> 	bl relocate
>>>>
>>>> 	#Flush the d-cache and invalidate the i-cache here
>>>> #endif
>>>>
>>>>
>>>> This would let the different platforms do the the cache
>>>> invalidation in their own way.
>>>>
>>>> Btw, I didn't find an instruction to flush the entire d-cache in
>>>> PPC440 manual. We have instructions to flush only a block
>>>> corresponding to an address.
>>>>
>>>> However, we have 'iccci' which would invalidate the entire i-cache
>>>> which, which I think is better than 80,000 i-cache invalidates.
>>>
>>> In misc_32.S there are already some platform-independent cache
>>> management functions.  If we use those, then relocate() could simply
>>> call them.  Then the different platforms calling relocate() wouldn't
>>> have to worry about flushing/invalidating caches.
>>>
>>> For example, there's a clean_dcache_range() function.  Given any range
>>> twice the size of the d-cache, it should flush the entire d-cache.
>>> But the only drawback is that it would require the caller to know the
>>> size of the d-cache.
>>>
>>> Instead, I think it would be preferable to create a new clean_dcache()
>>> (or clean_dcache_all()?) function in misc_32.S, which could call
>>> clean_dcache_range() with the appropriate args for flushing the entire
>>> d-cache.  relocate() could then call the platform-independent
>>> clean_dcache().
>>>
>>
>>
>> How about using clean_dcache_range() to flush the range runtime
>> address range [ _stext, _end ] ? That would flush the entire
>> instructions.
>
> Wouldn't that result in more cache flushing than the original solution?
>
> For example, my kernel is 3.5MB.  Assuming a 32 byte cache line size,
> clean_dcache_range(_stext, _end) would result in about 115,000 dcbst's
> (3.5MB / 32).

Oops ! You are right. We could go back to the clean_dcache_all() or the
initial approach that you suggested. (dcbst).

I am not sure how do we flush the entire dcache(only). Could you post a
patch which does the same ?

Another option is to, change the current mapping to 'Write Through' before
calling the relocate() and revert back to the original setting after relocate().

>
>
>>
>>
>>> For i-cache invalidation there's already the (incorrectly named?)
>>> flush_instruction_cache().  It uses the appropriate platform-specific
>>> methods (e.g. iccci for 44x) to invalidate the entire i-cache.
>>
>> Agreed. The only thing that worries me is the use of KERNELBASE in the
>> flush_instruction_cache() for CONFIG_4xx. Can we safely assume all 4xx
>> implementations ignore the arguments passed to iccci ?
>
> Good question.  I don't know the answer. :-)
>
> That also may suggest a bigger can of worms.  A grep of the powerpc code
> shows many uses of KERNELBASE.  For a relocatable kernel, nobody should
> be relying on KERNELBASE except for the early relocation code.  Are we
> sure that all the other usages of KERNELBASE are "safe"?
>
I think we could simply replace the occurrences of KERNELBASE (after the relocate())
  with '_stext' which would give the virtual start address of the kernel.

Thanks
Suzuki
