Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409bJw6H9FzF2Cx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:58:24 +1100 (AEDT)
Date: Tue, 27 Mar 2018 17:58:06 +0200
Message-ID: <20180327175806.Horde.f26UMak3wqEtNtiMmJy51w2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, LKML
 <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-15-malat@debian.org>
 <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
 <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
 <20180324211020.Horde.kEO4b3mHPV88FKM0OiRT0Q1@messagerie.si.c-s.fr>
 <CA+7wUszsJUJJeb+xhzjGr8YxDt-BYruBwda7Dq-nFfyt0sU0ew@mail.gmail.com>
In-Reply-To: <CA+7wUszsJUJJeb+xhzjGr8YxDt-BYruBwda7Dq-nFfyt0sU0ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:

> Christophe,
>
> On Sat, Mar 24, 2018 at 9:10 PM, LEROY Christophe
> <christophe.leroy@c-s.fr> wrote:
>> Mathieu Malaterre <malat@debian.org> a =C3=A9crit :
>>
>>
>>> On Fri, Mar 23, 2018 at 1:19 PM, christophe leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>>
>>>>
>>>>
>>>> Le 22/03/2018 =C3=A0 21:20, Mathieu Malaterre a =C3=A9crit :
>>>>>
>>>>>
>>>>> Some functions prototypes were missing for the non-altivec code. Add =
the
>>>>> missing prototypes directly in xor_vmx, fix warnings treated as error=
s
>>>>> with
>>>>> W=3D1:
>>>>>
>>>>>    arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype
>>>>> for
>>>>> =E2=80=98xor_altivec_2=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>    arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype
>>>>> for
>>>>> =E2=80=98xor_altivec_3=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>    arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype
>>>>> for
>>>>> =E2=80=98xor_altivec_4=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>    arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype
>>>>> for
>>>>> =E2=80=98xor_altivec_5=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>
>>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>>> ---
>>>>>   arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>>>>>   1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
>>>>> index 5c2b0839b179..2173e3c84151 100644
>>>>> --- a/arch/powerpc/lib/xor_vmx.h
>>>>> +++ b/arch/powerpc/lib/xor_vmx.h
>>>>> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned
>>>>> long
>>>>> *v1_in,
>>>>>   void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>>>>                              unsigned long *v2_in, unsigned long *v3_=
in,
>>>>>                              unsigned long *v4_in, unsigned long
>>>>> *v5_in);
>>>>> +
>>>>> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>>>>> +                            unsigned long *v2_in);
>>>>> +
>>>>
>>>>
>>>>
>>>> Only used in one place, should be static instead of adding it in a .h
>>>>
>>>> Same for the other ones.
>>>
>>>
>>> $ git grep xor_altivec_2
>>> [...]
>>> arch/powerpc/lib/xor_vmx_glue.c:EXPORT_SYMBOL(xor_altivec_2);
>>>
>>> Are you sure I can change this function to static ?
>>
>>
>> Yes you are right.  But in fact those fonctions are already defined in
>> asm/xor. h
>> So you just need to add the missing #include
>
> I originally tried it, but this leads to:
>
>   CC      arch/powerpc/lib/xor_vmx_glue.o
> In file included from arch/powerpc/lib/xor_vmx_glue.c:16:0:
> ./arch/powerpc/include/asm/xor.h:39:15: error: variable
> =E2=80=98xor_block_altivec=E2=80=99 has initializer but incomplete type
>  static struct xor_block_template xor_block_altivec =3D {
>                ^~~~~~~~~~~~~~~~~~
> ./arch/powerpc/include/asm/xor.h:40:2: error: unknown field =E2=80=98name=
=E2=80=99
> specified in initializer
>   .name =3D "altivec",
>   ^
> [...]
>
> The file <asm/xor.h> (powerpc) is pretty much expected to be included
> after <include/linux/raid/xor.h>.
>
> I did not want to tweak <asm/xor.h> to test for #ifdef _XOR_H just before
>
> #ifdef _XOR_H
> static struct xor_block_template xor_block_altivec =3D {
> [...]
>
> since this seems like a hack to me.
>
> Is this ok to test for #ifdef _XOR_H in <arch/powerpc/include/asm/xor.h> =
?

What about including linux/raid/xor.h in asm/xor.h ?

Christophe
>
>> Christophe
>>
>>
>>>
>>>> Christophe
>>>>
>>>>
>>>>> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>>>>> +                            unsigned long *v2_in, unsigned long
>>>>> *v3_in);
>>>>> +
>>>>> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>>>>> +                            unsigned long *v2_in, unsigned long *v3_=
in,
>>>>> +                            unsigned long *v4_in);
>>>>> +
>>>>> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>>>> +                            unsigned long *v2_in, unsigned long *v3_=
in,
>>>>> +                            unsigned long *v4_in, unsigned long
>>>>> *v5_in);
>>>>>
>>>>
>>>> ---
>>>> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 =
v=C3=A9rifi=C3=A9e par le
>>>> logiciel antivirus Avast.
>>>> https://www.avast.com/antivirus
>>>>
>>
>>
