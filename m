Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BHZ33HYhzF2K6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 06:12:11 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id q71-v6so3091833oic.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:12:11 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-12-malat@debian.org>
 <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 28 Mar 2018 21:11:48 +0200
Message-ID: <CA+7wUsxtWCoE1rxP6e57MEfB_zjLUzTa36CD=TyZS4_DkrQ81Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] powerpc/powermac: Move pmac_pfunc_base_install
 prototype to header file
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2018 at 1:13 PM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 22/03/2018 =C3=A0 21:19, Mathieu Malaterre a =C3=A9crit :
>>
>> The pmac_pfunc_base_install prototype was declared in powermac/smp.c sin=
ce
>> function was used there, move it to pmac_pfunc.h header to be visible in
>> pfunc_base.c. Fix a warning treated as error with W=3D1:
>>
>>    arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previo=
us
>> prototype for =E2=80=98pmac_pfunc_base_install=E2=80=99 [-Werror=3Dmissi=
ng-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/pmac_pfunc.h | 1 +
>>   arch/powerpc/platforms/powermac/smp.c | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/pmac_pfunc.h
>> b/arch/powerpc/include/asm/pmac_pfunc.h
>> index 73bd8f28f2a8..99f7a288789a 100644
>> --- a/arch/powerpc/include/asm/pmac_pfunc.h
>> +++ b/arch/powerpc/include/asm/pmac_pfunc.h
>> @@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function
>> *func);
>>     extern int pmf_call_one(struct pmf_function *func, struct pmf_args
>> *args);
>>   +extern int pmac_pfunc_base_install(void);
>
>
>
> extern keyword is not needed

I understand; but for consistency every single protoypes in this
header file actually use the extern keyword. Is there a guide/best
practice to refer to in this case ?

> Christophe
>
>>     /* Suspend/resume code called by via-pmu directly for now */
>>   extern void pmac_pfunc_base_suspend(void);
>> diff --git a/arch/powerpc/platforms/powermac/smp.c
>> b/arch/powerpc/platforms/powermac/smp.c
>> index 95275e0e2efa..447da6db450a 100644
>> --- a/arch/powerpc/platforms/powermac/smp.c
>> +++ b/arch/powerpc/platforms/powermac/smp.c
>> @@ -65,7 +65,6 @@
>>   #endif
>>     extern void __secondary_start_pmac_0(void);
>> -extern int pmac_pfunc_base_install(void);
>>     static void (*pmac_tb_freeze)(int freeze);
>>   static u64 timebase;
>>
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
