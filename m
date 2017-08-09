Return-Path: <srs0=fuyl=7l=c-s.fr=christophe.leroy@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS1Xq2rBnzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 16:27:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xS1Xq2CvGz8t8F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 16:27:55 +1000 (AEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xS1Xp6HRyz9s7v
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 16:27:54 +1000 (AEST)
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
 <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
 <2111e0d8-3b77-20a0-aab9-3572467eb0d4@c-s.fr>
 <87d185o4m7.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4c7613b9-c37e-295a-8e38-04aa34455350@c-s.fr>
Date: Wed, 9 Aug 2017 08:27:49 +0200
MIME-Version: 1.0
In-Reply-To: <87d185o4m7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/08/2017 à 04:29, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 14/07/2017 à 08:51, Michael Ellerman a écrit :
>>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>>> index c0737c86a362..3d562b210c65 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>>> @@ -1192,5 +1192,12 @@ static inline const int pud_pfn(pud_t pud)
>>>    	BUILD_BUG();
>>>    	return 0;
>>>    }
>>> +
>>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>>> +void mark_initmem_nx(void);
>>> +#else
>>> +static inline void mark_initmem_nx(void) { }
>>> +#endif
>>> +
>>
>> Why do we want to limit that to CONFIG_STRICT_KERNEL_RWX ?
>> Only the kernel text is marked X, even without CONFIG_STRICT_KERNEL_RWX
>> (at least on PPC32), so I believe we should clear X on init text in any
>> case, shouldn't we ?
> 
> You're right, but ..
> 
> On 64-bit when STRICT_KERNEL_RWX=n we make no effort to ensure the
> start/end of the init text is on a page boundary.
> 
> eg. on 64-bit hash we will typically use a 16M page to map the whole
> kernel, text/data/init_text/etc.

Some of the 32 bit also use some huge mapings like BATs or large pages, 
in which case it is pointless but not harmfull to fix the page tables 
anyway.
At least it is correct for the ones that use regular pages, and kernel 
can also be started with nobats or noltlbs at command line, in which 
case it is usefull to have the page tables correct.

> 
> So yes we *should* always mark it no-execute but in practice we can't
> because it's not page aligned.

On 32 bit it seems to always be aligned to the normal page size, so no 
problem.

> 
> But if that's different on (some?) 32-bit then we could introduce a new
> CONFIG symbol that is enabled in the right cases.

For the time being, I have added an "|| CONFIG_PPC32 " on the ifdef, is 
that OK ?
See https://patchwork.ozlabs.org/patch/796625/

Christophe
