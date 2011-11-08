Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DF0F71007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 18:12:13 +1100 (EST)
Received: from /spool/local by e28smtp09.in.ibm.com with XMail ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 8 Nov 2011 12:42:10 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA87Bcxh2207868
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 12:41:39 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA87BbsO029641
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 18:11:38 +1100
Message-ID: <4EB8D628.2090304@in.ibm.com>
Date: Tue, 08 Nov 2011 12:41:36 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble> <4EB3A40C.1070802@in.ibm.com>
 <1320678819.2750.15.camel@treble>
In-Reply-To: <1320678819.2750.15.camel@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/07/11 20:43, Josh Poimboeuf wrote:
> On Fri, 2011-11-04 at 14:06 +0530, Suzuki Poulose wrote:
>> On 11/03/11 05:06, Josh Poimboeuf wrote:
>>> On Tue, 2011-10-25 at 17:23 +0530, Suzuki K. Poulose wrote:
>>> @@ -137,6 +137,9 @@ get_type:
>>>    	lwz	r0, 8(r9)	/* r_addend */
>>>    	add	r0, r0, r3	/* final addend */
>>>    	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
>>> +	dcbst	r4,r7		/* flush dcache line to memory */
>>> +	sync			/* wait for flush to complete */
>>> +	icbi	r4,r7		/* invalidate icache line */
>>
>> Doing it this way has two drawbacks :
>>
>> 1) Placing it here in relocate would do the flushing for each and every update.
>
> I agree.  My kernel had around 80,000 relocations, which means 80,000
> d-cache line flushes (for a 32k d-cache) and 80,000 i-cache line
> invalidates (for a 32k i-cache).  Which is obviously a little overkill.
> Although I didn't notice a performance hit during boot.
>
>
>> 2) I would like to keep this code as generic as possible for the PPC32 code.
>>
>> Could we move this to the place from relocate is called and flush the d-cache and
>> i-cache entirely ?
>
> Why not put the cache flushing code at the end of relocate?  Would some
> of the other PPC32 platforms not require the cache flushing?
What I was suggesting is, instead of flushing the cache in relocate(), lets do it
like:

for e.g, on 440x, (in head_44x.S :)

#ifdef CONFIG_RELOCATABLE
	...
	bl relocate

	#Flush the d-cache and invalidate the i-cache here
#endif


This would let the different platforms do the the cache invalidation in their
own way.

Btw, I didn't find an instruction to flush the entire d-cache in PPC440 manual.
We have instructions to flush only a block corresponding to an address.

However, we have 'iccci' which would invalidate the entire i-cache which, which
I think is better than 80,000 i-cache invalidates.

Kumar / Josh,

Do you have any suggestions here ?




>
> My PPC32 knowledge is 4xx-centric, so please feel free to rewrite the
> patch as needed to accommodate other PPC32 cores.

Same here :)

Thanks
Suzuki
