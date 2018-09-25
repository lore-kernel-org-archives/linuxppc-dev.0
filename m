Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K37b1yn1zF3Dv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 11:16:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kbuild@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
In-Reply-To: <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
References: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
 <87mus75c5m.fsf@concordia.ellerman.id.au>
 <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
Date: Tue, 25 Sep 2018 11:16:39 +1000
Message-ID: <87bm8m5qbs.fsf@concordia.ellerman.id.au>
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

> Le 24/09/2018 =C3=A0 14:10, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> I'm trying to implement TLS based stack protector in the Linux Kernel.
>>> For that I need to give to GCC the offset at which it will find the
>>> canary (register r2 is pointing to the current task struct).
>>>
>>> I have been able to do it with the below patch, but it only works when
>>> include/generated/asm-offsets.h already exists from the start of the bu=
ild.
>>>
>>> Is there a way to evaluate CANARY_OFFSET and add the stack-protector
>>> flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is bui=
lt ?
>>>
>>> Or another way of add -mstack-protector-guard-offset=3Doffsetof(struct
>>> task_struct, stack_canary) ?
>>=20
>> This seems to work, at least I see the value in CFLAGS:
>>=20
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 07d9dce..39ee113 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -404,6 +394,11 @@ archclean:
>>=20=20=20
>>   archprepare: checkbin
>>=20=20=20
>> +prepare: stack_protector_prepare
>> +
>> +stack_protector_prepare: prepare0
>> +	$(eval KBUILD_CFLAGS +=3D -mstack-protector-guard-offset=3D$(shell awk=
 '{if ($$2 =3D=3D "TSK_STACK_CANARY") print $$3;}' include/generated/asm-of=
fsets.h))
>> +
>
> Great, it works !
> Thanks, I have sent v3 of the patches.

Cool.

It would be good to here from someone who knows Kbuild better than me if
this is acceptable or just a gross hack :)

cheers
