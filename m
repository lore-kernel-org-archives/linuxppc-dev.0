Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ykqjp23JyzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 10:57:18 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id o145so15431866vkd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Nov 2017 15:57:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8760a12obz.fsf@concordia.ellerman.id.au>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAKTCnznviUQfizSdfMDGxO_8CFuwhPCNSkK2VagNSRvZdpLqyg@mail.gmail.com>
 <141a04c4-a236-430d-f346-ad31252e146a@c-s.fr>
 <87h8tm355i.fsf@concordia.ellerman.id.au>
 <74521488-5ddb-4fe2-f419-9a9debeaaf0f@c-s.fr>
 <8760a12obz.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 26 Nov 2017 10:57:15 +1100
Message-ID: <CAKTCnzm2SGGV16z+V4i3agzLTS4BA_oJxi8NkFuNbpPOrre66Q@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, Meelis Roos <mroos@linux.ee>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 23, 2017 at 11:04 PM, Michael Ellerman <mpe@ellerman.id.au> wro=
te:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 22/11/2017 =C3=A0 12:48, Michael Ellerman a =C3=A9crit :
>>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>>> Le 22/11/2017 =C3=A0 00:07, Balbir Singh a =C3=A9crit :
>>>>> On Wed, Nov 22, 2017 at 1:28 AM, Christophe Leroy
>>>>> <christophe.leroy@c-s.fr> wrote:
>>>>>> On powerpc32, patch_instruction() is called by apply_feature_fixups(=
)
>>>>>> which is called from early_init()
> ...
>>>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/cod=
e-patching.c
>>>>>> index c9de03e0c1f1..d469224c4ada 100644
>>>>>> --- a/arch/powerpc/lib/code-patching.c
>>>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>>>> @@ -146,11 +147,8 @@ int patch_instruction(unsigned int *addr, unsig=
ned int instr)
>>>>>>            * During early early boot patch_instruction is called
>>>>>>            * when text_poke_area is not ready, but we still need
>>>>>>            * to allow patching. We just do the plain old patching
>>>>>> -        * We use slab_is_available and per cpu read * via this_cpu_=
read
>>>>>> -        * of text_poke_area. Per-CPU areas might not be up early
>>>>>> -        * this can create problems with just using this_cpu_read()
>>>>>>            */
>>>>>> -       if (!slab_is_available() || !this_cpu_read(text_poke_area))
>>>>>> +       if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>>>>>>                   return __patch_instruction(addr, instr);
>>>>>
>>>>> On ppc64, we call apply_feature_fixups() in early_setup() after we've
>>>>> relocated ourselves. Sorry for missing the ppc32 case. I would like t=
o
>>>>> avoid PTRRELOC when unnecessary.
>>>>
>>>> What do you suggest then ?
>>>>
>>>> Some #ifdef PPC32 around that ?
>>>
>>> No I don't think that improves anything.
>>>
>>> I think the comment about per-cpu not being up is wrong, you'll just ge=
t
>>> the static version of text_poke_area, which should be NULL. So we don't
>>> need the slab_available() check anyway.
>>>
>>> So I'll take this as-is.
>>>
>>> Having said that I absolutely hate PTRRELOC, so if it starts spreading
>>> we will have to come up with something less bug prone.
>>
>> Would something like that be the solution ?
>
> I don't love that actual patch, there's a lot of churn just for one
> flag.
>
> But the idea is not so bad.
>
> In fact I don't think we ever need to use the text_poke_area when we
> call do_feature_fixups().
>
> Most of the calls are in early boot.
>
> The exception is for modules, but when we do the fixups *of the module*,
> the module text is not mapped read only yet.
>
> So I think we can just do something like below.
>
> cheers
>
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/incl=
ude/asm/code-patching.h
> index abef812de7f8..1090024e8519 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -31,6 +31,7 @@ unsigned int create_cond_branch(const unsigned int *add=
r,
>                                 unsigned long target, int flags);
>  int patch_branch(unsigned int *addr, unsigned long target, int flags);
>  int patch_instruction(unsigned int *addr, unsigned int instr);
> +int raw_patch_instruction(unsigned int *addr, unsigned int instr);
>
>  int instr_is_relative_branch(unsigned int instr);
>  int instr_is_branch_to_addr(const unsigned int *instr, unsigned long add=
r);
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pat=
ching.c
> index d469224c4ada..d1eb24cbef58 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -23,7 +23,7 @@
>  #include <asm/code-patching.h>
>  #include <asm/setup.h>
>
> -static int __patch_instruction(unsigned int *addr, unsigned int instr)
> +int raw_patch_instruction(unsigned int *addr, unsigned int instr)
>  {
>         int err;
>
> @@ -148,8 +148,8 @@ int patch_instruction(unsigned int *addr, unsigned in=
t instr)
>          * when text_poke_area is not ready, but we still need
>          * to allow patching. We just do the plain old patching
>          */
> -       if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
> -               return __patch_instruction(addr, instr);
> +       if (!this_cpu_read(text_poke_area))
> +               return raw_patch_instruction(addr, instr);
>
>         local_irq_save(flags);
>
> @@ -184,7 +184,7 @@ int patch_instruction(unsigned int *addr, unsigned in=
t instr)
>
>  int patch_instruction(unsigned int *addr, unsigned int instr)
>  {
> -       return __patch_instruction(addr, instr);
> +       return raw_patch_instruction(addr, instr);
>  }
>
>  #endif /* CONFIG_STRICT_KERNEL_RWX */
> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature=
-fixups.c
> index 41cf5ae273cf..0872d60ede10 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -62,7 +62,7 @@ static int patch_alt_instruction(unsigned int *src, uns=
igned int *dest,
>                 }
>         }
>
> -       patch_instruction(dest, instr);
> +       raw_patch_instruction(dest, instr);
>
>         return 0;
>  }
> @@ -91,7 +91,7 @@ static int patch_feature_section(unsigned long value, s=
truct fixup_entry *fcur)
>         }
>
>         for (; dest < end; dest++)
> -               patch_instruction(dest, PPC_INST_NOP);
> +               raw_patch_instruction(dest, PPC_INST_NOP);
>
>         return 0;
>  }
> @@ -129,7 +129,7 @@ void do_lwsync_fixups(unsigned long value, void *fixu=
p_start, void *fixup_end)
>
>         for (; start < end; start++) {
>                 dest =3D (void *)start + *start;
> -               patch_instruction(dest, PPC_INST_LWSYNC);
> +               raw_patch_instruction(dest, PPC_INST_LWSYNC);
>         }
>  }
>
> @@ -147,7 +147,7 @@ static void do_final_fixups(void)
>         length =3D (__end_interrupts - _stext) / sizeof(int);
>
>         while (length--) {
> -               patch_instruction(dest, *src);
> +               raw_patch_instruction(dest, *src);
>                 src++;
>                 dest++;
>         }

This looks more promising, but there is a subtle dependence between
marking areas as R/O/X and the raw_patch_ins* bits

I saw that Michael has merged that patch as is, I guess we get to
continue to optimise :)

Balbir
