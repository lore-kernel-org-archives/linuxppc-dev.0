Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429RX066X8zF31M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 02:08:00 +1000 (AEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <8736uneylc.fsf@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fe0afb3c-8b6c-fff1-47ee-4fc25c0bc8a6@c-s.fr>
Date: Wed, 12 Sep 2018 18:07:57 +0200
MIME-Version: 1.0
In-Reply-To: <8736uneylc.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/09/2018 à 11:58, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>> common parts of code.
>> Using those directly in common parts of code have proven to lead to
>> mistakes or misbehaviour, because their use is not always as trivial
>> as one could think.
>>
>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>> that a page is a kernel page, because some targets are using
>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>> This has to (bad) consequences:
>>
>>   - All targets must define every bit, even the unsupported ones,
>>     leading to a lot of useless #define _PAGE_XXX 0
>>   - If someone forgets to take into account all possible _PAGE_XXX bits
>>     for the case, we can get unexpected behaviour on some targets.
>>
>> This becomes even more complex when we come to using _PAGE_RW.
>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>> if writable or not, because:
>>
>>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>>     a page is writable
>>   - Some targets have _PAGE_R and _PAGE_W, in which case
>>     _PAGE_RW = _PAGE_R | _PAGE_W
>>   - Even knowing whether a page is readable is not always trivial because:
>>     - Some targets requires to check that _PAGE_R is set to ensure page
>>     is readable
>>     - Some targets requires to check that _PAGE_NA is not set
>>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>
>> Etc ....
>>
>> In order to work around all those issues and minimise the risks of errors,
>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
>> are then defined in target specific parts of the kernel code.
> 
> The series is really good. It also helps in code readability. Few things
> i am not sure there is a way to reduce the overhead
> 
> -		access = _PAGE_EXEC;
> +		access = pte_val(pte_mkexec(__pte(0)));
> 
> Considering we have multiple big endian to little endian coversion there
> for book3s 64.
> 
> Other thing is __ioremap_at where we do
> 
> +       pte_t pte = __pte(flags);
>   
>          /* Make sure we have the base flags */
> -       if ((flags & _PAGE_PRESENT) == 0)
> +       if (!pte_present(pte))
> 
> -               err = map_kernel_page(v+i, p+i, flags);
> +               err = map_kernel_page(v + i, p + i, pte_val(pte));
> 

Finally, for that I now ensure that all base flags are set by the 
callers and I have removed that hack which adds PAGE_KERNEL flags when 
_PAGE_PRESENT is not in the handedover flags.

> 
> But otherwise for the series.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 

Thanks, I added it to all unchanged patches of the serie. You are 
welcome to give a feedback on the new ones if you have time.

Christophe
