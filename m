Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mNpS1F49zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 19:52:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] powerpc/asm: Add a patch_site macro & helpers for
 patching instructions
In-Reply-To: <831e6e06-764a-89e8-1d0a-f46c3004d24f@c-s.fr>
References: <20180723150756.11108-1-mpe@ellerman.id.au>
 <4572374a-d131-b1ad-0d2d-9564925b52cf@c-s.fr>
 <831e6e06-764a-89e8-1d0a-f46c3004d24f@c-s.fr>
Date: Thu, 09 Aug 2018 19:52:27 +1000
Message-ID: <877ekzamuc.fsf@concordia.ellerman.id.au>
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
> Le 08/08/2018 =C3=A0 18:30, Christophe LEROY a =C3=A9crit=C2=A0:
>> Le 23/07/2018 =C3=A0 17:07, Michael Ellerman a =C3=A9crit=C2=A0:
...
>>> diff --git a/arch/powerpc/include/asm/code-patching.h=20
>>> b/arch/powerpc/include/asm/code-patching.h
>>> index 812535f40124..b2051234ada8 100644
>>> --- a/arch/powerpc/include/asm/code-patching.h
>>> +++ b/arch/powerpc/include/asm/code-patching.h
>>> @@ -32,6 +32,8 @@ unsigned int create_cond_branch(const unsigned int=20
>>> *addr,
>>> =C2=A0 int patch_branch(unsigned int *addr, unsigned long target, int f=
lags);
>>> =C2=A0 int patch_instruction(unsigned int *addr, unsigned int instr);
>>> =C2=A0 int raw_patch_instruction(unsigned int *addr, unsigned int instr=
);
>>> +int patch_instruction_site(s32 *addr, unsigned int instr);
>>> +int patch_branch_site(s32 *site, unsigned long target, int flags);
>>=20
>> Why use s32* instead of unsigned int* as usual for pointer to code ?
>
> Forget my stupid question, I didn't see it was a relative address and=20
> not an absolute one.

No worries.=20

It is a bit non-obvious at first glance, it looks like the s32 * points
to the instruction. But it points to the s32 that holds the relative
offset from itself, of the instruction.

We could add a typedef to try and make that more obvious, but I
generally don't like typedefs that hide pointerness.

cheers
