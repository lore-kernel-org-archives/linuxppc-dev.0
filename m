Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4255lx4WHszF38R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 00:33:17 +1000 (AEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d6216a55-307e-ce80-ea37-ca9b5de694a7@c-s.fr>
Date: Wed, 5 Sep 2018 14:32:26 +0000
MIME-Version: 1.0
In-Reply-To: <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/05/2018 02:03 PM, Aneesh Kumar K.V wrote:
> On 09/05/2018 06:06 PM, Christophe Leroy wrote:
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
>>   - All targets must define every bit, even the unsupported ones,
>>     leading to a lot of useless #define _PAGE_XXX 0
>>   - If someone forgets to take into account all possible _PAGE_XXX bits
>>     for the case, we can get unexpected behaviour on some targets.
>>
>> This becomes even more complex when we come to using _PAGE_RW.
>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>> if writable or not, because:
>>
>>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>>     a page is writable
>>   - Some targets have _PAGE_R and _PAGE_W, in which case
>>     _PAGE_RW = _PAGE_R | _PAGE_W
>>   - Even knowing whether a page is readable is not always trivial 
>> because:
>>     - Some targets requires to check that _PAGE_R is set to ensure page
>>     is readable
>>     - Some targets requires to check that _PAGE_NA is not set
>>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>
>> Etc ....
>>
>> In order to work around all those issues and minimise the risks of 
>> errors,
>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those 
>> accessors
>> are then defined in target specific parts of the kernel code.
> 
> We recently did on book3s 64.
> 
> static inline int pte_present(pte_t pte)
> {
>      /*
>       * A pte is considerent present if _PAGE_PRESENT is set.
>       * We also need to consider the pte present which is marked
>       * invalid during ptep_set_access_flags. Hence we look for 
> _PAGE_INVALID
>       * if we find _PAGE_PRESENT cleared.
>       */
>      return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
> }
> 
> So I guess with that pte_present conversion we need to be careful.
> 
> Do you have a git tree which I can use to double check?

I pushed on branch 'helpers' on https://github.com/chleroy/linux.git

Christophe
