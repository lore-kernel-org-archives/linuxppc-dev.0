Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x242.google.com (mail-yk0-x242.google.com
 [IPv6:2607:f8b0:4002:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3686D1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 18:52:34 +1100 (AEDT)
Received: by mail-yk0-x242.google.com with SMTP id r207so2421690ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 23:52:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B35537.3050708@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
 <42d5343703a9e67b5a2d94c8877bc0098448f71b.1454538980.git.christophe.leroy@c-s.fr>
 <CAOJe8K2qmRARai6okSXtvpkt2JOfJCrqwUOinDAyo2Qoypd7uw@mail.gmail.com>
 <56B35537.3050708@c-s.fr>
Date: Fri, 5 Feb 2016 10:52:32 +0300
Message-ID: <CAOJe8K035FFSgew8+fCHL9YBkScRZaHL_fEJFsAsVnT5qCm_ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] powerpc: Simplify test in __dma_sync()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/4/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>
> Le 04/02/2016 12:37, Denis Kirjanov a =C3=A9crit :
>> On 2/4/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>> This simplification helps the compiler. We now have only one test
>>> instead of two, so it reduces the number of branches.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>> v2: new
>>> v3: no change
>>> v4: no change
>>> v5: no change
>>>
>>>   arch/powerpc/mm/dma-noncoherent.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/mm/dma-noncoherent.c
>>> b/arch/powerpc/mm/dma-noncoherent.c
>>> index 169aba4..2dc74e5 100644
>>> --- a/arch/powerpc/mm/dma-noncoherent.c
>>> +++ b/arch/powerpc/mm/dma-noncoherent.c
>>> @@ -327,7 +327,7 @@ void __dma_sync(void *vaddr, size_t size, int
>>> direction)
>>>   		 * invalidate only when cache-line aligned otherwise there is
>>>   		 * the potential for discarding uncommitted data from the cache
>>>   		 */
>>> -		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
>>> +		if ((start | end) & (L1_CACHE_BYTES - 1))
>>>   			flush_dcache_range(start, end);
>>>   		else
>>>   			invalidate_dcache_range(start, end);
>> The previous version of address cache-line aligned check reads perfectly
>> fine.
>> What's the benefit of this micro optimization?
> With this optimisation we avoid one unneccessary test and two associated
> jumps. Taking into account that __dma_sync() is one of the top ten CPU
> consummers, I believe it is worth it:
>
> Without the patch:
>
> c000d894:    70 6a 00 0f     andi.   r10,r3,15
> c000d898:    39 29 00 0f     addi    r9,r9,15
> c000d89c:    54 63 00 36     rlwinm  r3,r3,0,0,27
> c000d8a0:    7d 23 48 50     subf    r9,r3,r9
> c000d8a4:    41 82 00 84     beq     c000d928 <__dma_sync+0xb8>
> [...]
> c000d8c0:    7c 00 04 ac     sync
> c000d8c4:    4e 80 00 20     blr
> [...]
> c000d928:    70 8a 00 0f     andi.   r10,r4,15
> c000d92c:    40 a2 ff 7c     bne     c000d8a8 <__dma_sync+0x38>
> c000d930:    55 2a e1 3f     rlwinm. r10,r9,28,4,31
> c000d934:    41 a2 ff 8c     beq     c000d8c0 <__dma_sync+0x50>
>
> With the patch:
>
> c000d894:    7c 89 1b 78     or      r9,r4,r3
> c000d898:    71 2a 00 0f     andi.   r10,r9,15
> c000d89c:    54 63 00 36     rlwinm  r3,r3,0,0,27
> c000d8a0:    38 84 00 0f     addi    r4,r4,15
> c000d8a4:    7c 83 20 50     subf    r4,r3,r4
> c000d8a8:    41 82 00 84     beq     c000d92c <__dma_sync+0xbc>
> [...]
> c000d8c4:    7c 00 04 ac     sync
> c000d8c8:    4e 80 00 20     blr
> [...]
> c000d92c:    54 89 e1 3f     rlwinm. r9,r4,28,4,31
> c000d930:    41 a2 ff 94     beq     c000d8c4 <__dma_sync+0x54>

Yeah, looks better. Did you compile the kernel with default compiler flags?

Thanks!

>
>
> Christophe
>>> --
>>> 2.1.0
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
