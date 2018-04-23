Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VGqk41znzF21F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 05:34:26 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id p62-v6so15403322oie.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 12:34:26 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUsz6m14gCd79NKzKbad1e+1P_=t1-B4na7g5ob16ORQ_8g@mail.gmail.com>
References: <20180408194424.8719-1-malat@debian.org>
 <a21ced59-8cf6-b8e0-2305-fb9d040dfc5c@infradead.org>
 <CA+7wUsz6m14gCd79NKzKbad1e+1P_=t1-B4na7g5ob16ORQ_8g@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 23 Apr 2018 21:34:03 +0200
Message-ID: <CA+7wUsyRB8feJwg6bc1EE-yW5rUSrvu70xVBHxC5o-amj2YQ_g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: add missing braces for single statement
 block
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2018 at 9:31 PM, Mathieu Malaterre <malat@debian.org> wrote=
:
> On Sun, Apr 8, 2018 at 10:34 PM, Randy Dunlap <rdunlap@infradead.org> wro=
te:
>> On 04/08/2018 12:44 PM, Mathieu Malaterre wrote:
>>> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing =
for
>>> disable_radix") an `if` statement was added for a possible empty body
>>> (prom_debug).
>>>
>>> Fix the following warning, treated as error with W=3D1:
>>>
>>>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Werror=3Dempty-body]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>>  arch/powerpc/kernel/prom_init.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom=
_init.c
>>> index 5ae153b97d0a..f0e802495530 100644
>>> --- a/arch/powerpc/kernel/prom_init.c
>>> +++ b/arch/powerpc/kernel/prom_init.c
>>> @@ -652,8 +652,9 @@ static void __init early_cmdline_parse(void)
>>>               } else
>>>                       prom_radix_disable =3D true;
>>>       }
>>> -     if (prom_radix_disable)
>>> +     if (prom_radix_disable) {
>>>               prom_debug("Radix disabled from cmdline\n");
>>
>> Looks like the macro for #prom_debug() should be fixed instead.
>
> Well if I try instead:
>
> @@ -101,9 +101,9 @@ int of_workarounds;
>  } while (0)
>
>  #ifdef DEBUG_PROM
> -#define prom_debug(x...) prom_printf(x)
> +#define prom_debug(x...) do { prom_printf(x); } while (0)
>  #else
> -#define prom_debug(x...)
> +#define prom_debug(x...) do { } while (0)
>  #endif
>
>
> the checkpatch script returns:
>
> WARNING: Single statement macros should not use a do {} while (0) loop
> #33: FILE: arch/powerpc/kernel/prom_init.c:104:
> +#define prom_debug(x...) do { prom_printf(x); } while (0)
>
>
> So I suspect we cannot do much better than my original patch unfortunatel=
y.

Right, it seems I cannot read the correct line number for a warning.
An updated patch is coming.

>>> +     }
>>>  }
>>>
>>>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>>>
>>
>>
>> --
>> ~Randy
