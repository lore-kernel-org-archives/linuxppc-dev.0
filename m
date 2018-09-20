Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G4Cj2KHHzF3L2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:54:56 +1000 (AEST)
Subject: Re: [PATCH v2 4/5] powerpc: Fix duplicate const clang warning in user
 access code
To: Joel Stanley <joel@jms.id.au>, Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-5-joel@jms.id.au>
 <CAKwvOd=-22J2=QvCTOAxkWw-WV8C4VY6Yvx91Rif5STmiXMtMg@mail.gmail.com>
 <CACPK8XdF=orE8UtGu_K=p612L=iuDsnmrVrXJ6CNn6iDXi8znQ@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <af6548de-69aa-bbce-3e9e-4acdf89fb107@c-s.fr>
Date: Thu, 20 Sep 2018 06:54:51 +0200
MIME-Version: 1.0
In-Reply-To: <CACPK8XdF=orE8UtGu_K=p612L=iuDsnmrVrXJ6CNn6iDXi8znQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2018 à 09:45, Joel Stanley a écrit :
> On Sat, 15 Sep 2018 at 03:27, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> From: Anton Blanchard <anton@samba.org>
>>>
>>> This re-applies b91c1e3e7a6f which was reverted in f2ca80905929
>>> d466f6c5cac1 f84ed59a612d (powerpc/sparse: Constify the address pointer
>>> ...").
>>>
>>> We see a large number of duplicate const errors in the user access
>>> code when building with llvm/clang:
>>>
>>>    include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier
>>>        [-Wduplicate-decl-specifier]
>>>          ret = __get_user(c, uaddr);
>>>
>>> The problem is we are doing const __typeof__(*(ptr)), which will hit the
>>> warning if ptr is marked const.
>>>
>>> Removing const does not seem to have any effect on GCC code generation.
>>
>> I wouldn't expect it to for a local variable with such localized
>> usage.  I myself am quite liberal in applying `const` to everything,
>> so I will try to fix this in Clang as well, but this should silence
>> the warning for users of older versions of Clang and results in no
>> functional change.
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Nick has written a clang patch that suppresses the warning in the same
> way as GCC. Assuming it gets merged, as we depend on clang-8 we could
> chose to not merge the kernel patch.
> 
> https://reviews.llvm.org/D52248
> 

Seems like Michael has merged this patch anyway.

Christophe
