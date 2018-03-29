Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bq4C1b3pzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 02:51:39 +1100 (AEDT)
Date: Thu, 29 Mar 2018 17:51:16 +0200
Message-ID: <20180329175116.Horde.jk-Ax19FyXhtLB_VgKxDAg9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras
 <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH 11/19] powerpc/powermac: Move pmac_pfunc_base_install
 prototype to header file
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-12-malat@debian.org>
 <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
 <CA+7wUsxtWCoE1rxP6e57MEfB_zjLUzTa36CD=TyZS4_DkrQ81Q@mail.gmail.com>
In-Reply-To: <CA+7wUsxtWCoE1rxP6e57MEfB_zjLUzTa36CD=TyZS4_DkrQ81Q@mail.gmail.com>
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

> On Fri, Mar 23, 2018 at 1:13 PM, christophe leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>> Le 22/03/2018 =C3=A0 21:19, Mathieu Malaterre a =C3=A9crit :
>>>
>>> The pmac_pfunc_base_install prototype was declared in powermac/smp.c si=
nce
>>> function was used there, move it to pmac_pfunc.h header to be visible i=
n
>>> pfunc_base.c. Fix a warning treated as error with W=3D1:
>>>
>>>    arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previ=
ous
>>> prototype for =E2=80=98pmac_pfunc_base_install=E2=80=99 [-Werror=3Dmiss=
ing-prototypes]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>>   arch/powerpc/include/asm/pmac_pfunc.h | 1 +
>>>   arch/powerpc/platforms/powermac/smp.c | 1 -
>>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/pmac_pfunc.h
>>> b/arch/powerpc/include/asm/pmac_pfunc.h
>>> index 73bd8f28f2a8..99f7a288789a 100644
>>> --- a/arch/powerpc/include/asm/pmac_pfunc.h
>>> +++ b/arch/powerpc/include/asm/pmac_pfunc.h
>>> @@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function
>>> *func);
>>>     extern int pmf_call_one(struct pmf_function *func, struct pmf_args
>>> *args);
>>>   +extern int pmac_pfunc_base_install(void);
>>
>>
>>
>> extern keyword is not needed
>
> I understand; but for consistency every single protoypes in this
> header file actually use the extern keyword. Is there a guide/best
> practice to refer to in this case ?

Consistancy is not a valid reason to continue bad practice. Every=20=20
single=20modufication is an opportunity to clean things up

You should run script/checkpatch.pl --strict on all your patches=20=20
before=20submitting.
And follow as much as possible the linux codying style

Christophe

>
>> Christophe
>>
>>>     /* Suspend/resume code called by via-pmu directly for now */
>>>   extern void pmac_pfunc_base_suspend(void);
>>> diff --git a/arch/powerpc/platforms/powermac/smp.c
>>> b/arch/powerpc/platforms/powermac/smp.c
>>> index 95275e0e2efa..447da6db450a 100644
>>> --- a/arch/powerpc/platforms/powermac/smp.c
>>> +++ b/arch/powerpc/platforms/powermac/smp.c
>>> @@ -65,7 +65,6 @@
>>>   #endif
>>>     extern void __secondary_start_pmac_0(void);
>>> -extern int pmac_pfunc_base_install(void);
>>>     static void (*pmac_tb_freeze)(int freeze);
>>>   static u64 timebase;
>>>
>>
>> ---
>> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
>> logiciel antivirus Avast.
>> https://www.avast.com/antivirus
>>
