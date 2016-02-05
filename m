Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6B4A41A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 18:56:54 +1100 (AEDT)
Subject: Re: [PATCH v5 21/23] powerpc: Simplify test in __dma_sync()
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
 <42d5343703a9e67b5a2d94c8877bc0098448f71b.1454538980.git.christophe.leroy@c-s.fr>
 <CAOJe8K2qmRARai6okSXtvpkt2JOfJCrqwUOinDAyo2Qoypd7uw@mail.gmail.com>
 <56B35537.3050708@c-s.fr>
 <CAOJe8K035FFSgew8+fCHL9YBkScRZaHL_fEJFsAsVnT5qCm_ZQ@mail.gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56B455C3.6020702@c-s.fr>
Date: Fri, 5 Feb 2016 08:56:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAOJe8K035FFSgew8+fCHL9YBkScRZaHL_fEJFsAsVnT5qCm_ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/02/2016 08:52, Denis Kirjanov a écrit :
> On 2/4/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>> Le 04/02/2016 12:37, Denis Kirjanov a écrit :
>>> On 2/4/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>> This simplification helps the compiler. We now have only one test
>>>> instead of two, so it reduces the number of branches.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>> v2: new
>>>> v3: no change
>>>> v4: no change
>>>> v5: no change
>>>>
>>>>    arch/powerpc/mm/dma-noncoherent.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/mm/dma-noncoherent.c
>>>> b/arch/powerpc/mm/dma-noncoherent.c
>>>> index 169aba4..2dc74e5 100644
>>>> --- a/arch/powerpc/mm/dma-noncoherent.c
>>>> +++ b/arch/powerpc/mm/dma-noncoherent.c
>>>> @@ -327,7 +327,7 @@ void __dma_sync(void *vaddr, size_t size, int
>>>> direction)
>>>>    		 * invalidate only when cache-line aligned otherwise there is
>>>>    		 * the potential for discarding uncommitted data from the cache
>>>>    		 */
>>>> -		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
>>>> +		if ((start | end) & (L1_CACHE_BYTES - 1))
>>>>    			flush_dcache_range(start, end);
>>>>    		else
>>>>    			invalidate_dcache_range(start, end);
>>> The previous version of address cache-line aligned check reads perfectly
>>> fine.
>>> What's the benefit of this micro optimization?
>> With this optimisation we avoid one unneccessary test and two associated
>> jumps. Taking into account that __dma_sync() is one of the top ten CPU
>> consummers, I believe it is worth it:
>>
>>
> Yeah, looks better. Did you compile the kernel with default compiler flags?
>
> Thanks!
Yes I did

Christophe
