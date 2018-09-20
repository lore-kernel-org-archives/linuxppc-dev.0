Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GGRR0w9BzF3Jc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 22:35:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Joel Stanley <joel@jms.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v2 4/5] powerpc: Fix duplicate const clang warning in user
 access code
In-Reply-To: <af6548de-69aa-bbce-3e9e-4acdf89fb107@c-s.fr>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-5-joel@jms.id.au>
 <CAKwvOd=-22J2=QvCTOAxkWw-WV8C4VY6Yvx91Rif5STmiXMtMg@mail.gmail.com>
 <CACPK8XdF=orE8UtGu_K=p612L=iuDsnmrVrXJ6CNn6iDXi8znQ@mail.gmail.com>
 <af6548de-69aa-bbce-3e9e-4acdf89fb107@c-s.fr>
Date: Thu, 20 Sep 2018 22:35:45 +1000
Message-ID: <87zhwcibxa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 19/09/2018 =C3=A0 09:45, Joel Stanley a =C3=A9crit=C2=A0:
>> On Sat, 15 Sep 2018 at 03:27, Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
>>>
>>> On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
>>>>
>>>> From: Anton Blanchard <anton@samba.org>
>>>>
>>>> This re-applies b91c1e3e7a6f which was reverted in f2ca80905929
>>>> d466f6c5cac1 f84ed59a612d (powerpc/sparse: Constify the address pointer
>>>> ...").
>>>>
>>>> We see a large number of duplicate const errors in the user access
>>>> code when building with llvm/clang:
>>>>
>>>>    include/linux/pagemap.h:576:8: warning: duplicate 'const' declarati=
on specifier
>>>>        [-Wduplicate-decl-specifier]
>>>>          ret =3D __get_user(c, uaddr);
>>>>
>>>> The problem is we are doing const __typeof__(*(ptr)), which will hit t=
he
>>>> warning if ptr is marked const.
>>>>
>>>> Removing const does not seem to have any effect on GCC code generation.
>>>
>>> I wouldn't expect it to for a local variable with such localized
>>> usage.  I myself am quite liberal in applying `const` to everything,
>>> so I will try to fix this in Clang as well, but this should silence
>>> the warning for users of older versions of Clang and results in no
>>> functional change.
>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>=20
>> Nick has written a clang patch that suppresses the warning in the same
>> way as GCC. Assuming it gets merged, as we depend on clang-8 we could
>> chose to not merge the kernel patch.
>>=20
>> https://reviews.llvm.org/D52248
>
> Seems like Michael has merged this patch anyway.

I'll happily revert it though if someone tells me to.

cheers
