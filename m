Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429RT35HSfzF35q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 02:05:27 +1000 (AEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <8736uneylc.fsf@linux.ibm.com> <1f4d6cc9-5d18-b171-02b0-d715629d594f@c-s.fr>
 <8736uhsx3l.fsf@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7bf77801-9c6c-a39e-6d82-3a0b0d870b65@c-s.fr>
Date: Wed, 12 Sep 2018 18:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <8736uhsx3l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/09/2018 à 08:08, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> On 09/06/2018 09:58 AM, Aneesh Kumar K.V wrote:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>>>> common parts of code.
>>>> Using those directly in common parts of code have proven to lead to
>>>> mistakes or misbehaviour, because their use is not always as trivial
>>>> as one could think.
>>>>
>>>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>>>> that a page is a kernel page, because some targets are using
>>>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>>>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>>>> This has to (bad) consequences:
>>>>
>>>>    - All targets must define every bit, even the unsupported ones,
>>>>      leading to a lot of useless #define _PAGE_XXX 0
>>>>    - If someone forgets to take into account all possible _PAGE_XXX bits
>>>>      for the case, we can get unexpected behaviour on some targets.
>>>>
>>>> This becomes even more complex when we come to using _PAGE_RW.
>>>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>>>> if writable or not, because:
>>>>
>>>>    - Some targets have _PAGE_RO instead, which has to be unset to tell
>>>>      a page is writable
>>>>    - Some targets have _PAGE_R and _PAGE_W, in which case
>>>>      _PAGE_RW = _PAGE_R | _PAGE_W
>>>>    - Even knowing whether a page is readable is not always trivial because:
>>>>      - Some targets requires to check that _PAGE_R is set to ensure page
>>>>      is readable
>>>>      - Some targets requires to check that _PAGE_NA is not set
>>>>      - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>>>
>>>> Etc ....
>>>>
>>>> In order to work around all those issues and minimise the risks of errors,
>>>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>>>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
>>>> are then defined in target specific parts of the kernel code.
>>>
>>> The series is really good. It also helps in code readability. Few things
>>> i am not sure there is a way to reduce the overhead
>>>
>>> -		access = _PAGE_EXEC;
>>> +		access = pte_val(pte_mkexec(__pte(0)));
>>>
>>> Considering we have multiple big endian to little endian coversion there
>>> for book3s 64.
>>
>> Thanks for the review.
>>
>> For the above, I propose the following:
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c
>> b/arch/powerpc/mm/hash_utils_64.c
>> index f23a89d8e4ce..904ac9c84ea5 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct
>> *mm, unsigned long ea)
>>    #endif
>>
>>    void hash_preload(struct mm_struct *mm, unsigned long ea,
>> -		  unsigned long access, unsigned long trap)
>> +		  bool is_exec, unsigned long trap)
>>    {
>>    	int hugepage_shift;
>>    	unsigned long vsid;
>> @@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned
>> long ea,
>>    	pte_t *ptep;
>>    	unsigned long flags;
>>    	int rc, ssize, update_flags = 0;
>> +	unsigned long access = is_exec ? _PAGE_EXEC : 0;
> 
> 
> I guess it will be better if we do
> 
> unsigned long access = _PAGE_PRESENT | _PAGE_READ
> 
> if (is_exec)
>     access |= _PAGE_EXEC.
> 
> That will also bring it closer to __hash_page. I agree that we should
> always find _PAGE_PRESENT and _PAGE_READ set, because we just handled
> the page fault.
> 

Ok, I did it in v2, can you have a look (patch 11/24) ?

Christophe
