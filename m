Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gcmf51vvzF1qT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:21:22 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id m7-v6so24824181otd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:21:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
References: <20180322202007.23088-2-malat@debian.org>
 <20180328192717.656-1-malat@debian.org>
 <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 4 Apr 2018 22:21:00 +0200
Message-ID: <CA+7wUszBw9Jw8z7x6h-OO=-LfxSWYS08DTTBozkPg08KbAzBNA@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] powerpc/powermac: Mark variable x as unused
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2018 at 6:07 PM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Mathieu Malaterre <malat@debian.org> a =C3=A9crit :
>
>
>> Since the value of x is never intended to be read, declare it with gcc
>> attribute as unused. Fix warning treated as error with W=3D1:
>>
>>   arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable =
=E2=80=98x=E2=80=99
>> set but not used [-Werror=3Dunused-but-set-variable]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: move x variable within its local scope
>>
>>  arch/powerpc/platforms/powermac/bootx_init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c
>> b/arch/powerpc/platforms/powermac/bootx_init.c
>> index c3c9bbb3573a..d44e8571c1ec 100644
>> --- a/arch/powerpc/platforms/powermac/bootx_init.c
>> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
>> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned lo=
ng
>> r4)
>>         boot_infos_t *bi =3D (boot_infos_t *) r4;
>>         unsigned long hdr;
>>         unsigned long space;
>> -       unsigned long ptr, x;
>> +       unsigned long ptr;
>>         char *model;
>>         unsigned long offset =3D reloc_offset();
>>
>> @@ -562,6 +562,7 @@ void __init bootx_init(unsigned long r3, unsigned lo=
ng
>> r4)
>>          * MMU switched OFF, so this should not be useful anymore.
>>          */
>>         if (bi->version < 4) {
>> +               unsigned long x __maybe_unused;
>>                 bootx_printf("Touching pages...\n");
>
>
> Stylewise, there should be an empty line after your declaration.

See v3

> But I believe you should remove that ugly loop and replace it by a call t=
o
> fault_in_pages_readable()

I have no idea on how to test the the new code, and it did not look
straightforward.

> Christophe
>>
>>
>>                 /*
>> --
>> 2.11.0
>
>
>
