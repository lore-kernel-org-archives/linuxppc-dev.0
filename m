Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjJ0N66PRzDrMB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 23:04:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Meelis Roos <mroos@linux.ee>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
In-Reply-To: <74521488-5ddb-4fe2-f419-9a9debeaaf0f@c-s.fr>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAKTCnznviUQfizSdfMDGxO_8CFuwhPCNSkK2VagNSRvZdpLqyg@mail.gmail.com>
 <141a04c4-a236-430d-f346-ad31252e146a@c-s.fr>
 <87h8tm355i.fsf@concordia.ellerman.id.au>
 <74521488-5ddb-4fe2-f419-9a9debeaaf0f@c-s.fr>
Date: Thu, 23 Nov 2017 23:04:32 +1100
Message-ID: <8760a12obz.fsf@concordia.ellerman.id.au>
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
> Le 22/11/2017 =C3=A0 12:48, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>> Le 22/11/2017 =C3=A0 00:07, Balbir Singh a =C3=A9crit=C2=A0:
>>>> On Wed, Nov 22, 2017 at 1:28 AM, Christophe Leroy
>>>> <christophe.leroy@c-s.fr> wrote:
>>>>> On powerpc32, patch_instruction() is called by apply_feature_fixups()
>>>>> which is called from early_init()
...
>>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code=
-patching.c
>>>>> index c9de03e0c1f1..d469224c4ada 100644
>>>>> --- a/arch/powerpc/lib/code-patching.c
>>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>>> @@ -146,11 +147,8 @@ int patch_instruction(unsigned int *addr, unsign=
ed int instr)
>>>>>            * During early early boot patch_instruction is called
>>>>>            * when text_poke_area is not ready, but we still need
>>>>>            * to allow patching. We just do the plain old patching
>>>>> -        * We use slab_is_available and per cpu read * via this_cpu_r=
ead
>>>>> -        * of text_poke_area. Per-CPU areas might not be up early
>>>>> -        * this can create problems with just using this_cpu_read()
>>>>>            */
>>>>> -       if (!slab_is_available() || !this_cpu_read(text_poke_area))
>>>>> +       if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>>>>>                   return __patch_instruction(addr, instr);
>>>>
>>>> On ppc64, we call apply_feature_fixups() in early_setup() after we've
>>>> relocated ourselves. Sorry for missing the ppc32 case. I would like to
>>>> avoid PTRRELOC when unnecessary.
>>>
>>> What do you suggest then ?
>>>
>>> Some #ifdef PPC32 around that ?
>>=20
>> No I don't think that improves anything.
>>=20
>> I think the comment about per-cpu not being up is wrong, you'll just get
>> the static version of text_poke_area, which should be NULL. So we don't
>> need the slab_available() check anyway.
>>=20
>> So I'll take this as-is.
>>=20
>> Having said that I absolutely hate PTRRELOC, so if it starts spreading
>> we will have to come up with something less bug prone.
>
> Would something like that be the solution ?

I don't love that actual patch, there's a lot of churn just for one
flag.

But the idea is not so bad.

In fact I don't think we ever need to use the text_poke_area when we
call do_feature_fixups().

Most of the calls are in early boot.

The exception is for modules, but when we do the fixups *of the module*,
the module text is not mapped read only yet.

So I think we can just do something like below.

cheers


diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/includ=
e/asm/code-patching.h
index abef812de7f8..1090024e8519 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -31,6 +31,7 @@ unsigned int create_cond_branch(const unsigned int *addr,
 				unsigned long target, int flags);
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
+int raw_patch_instruction(unsigned int *addr, unsigned int instr);
=20
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patch=
ing.c
index d469224c4ada..d1eb24cbef58 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,7 +23,7 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
=20
-static int __patch_instruction(unsigned int *addr, unsigned int instr)
+int raw_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
=20
@@ -148,8 +148,8 @@ int patch_instruction(unsigned int *addr, unsigned int =
instr)
 	 * when text_poke_area is not ready, but we still need
 	 * to allow patching. We just do the plain old patching
 	 */
-	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
-		return __patch_instruction(addr, instr);
+	if (!this_cpu_read(text_poke_area))
+		return raw_patch_instruction(addr, instr);
=20
 	local_irq_save(flags);
=20
@@ -184,7 +184,7 @@ int patch_instruction(unsigned int *addr, unsigned int =
instr)
=20
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
-	return __patch_instruction(addr, instr);
+	return raw_patch_instruction(addr, instr);
 }
=20
 #endif /* CONFIG_STRICT_KERNEL_RWX */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-f=
ixups.c
index 41cf5ae273cf..0872d60ede10 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -62,7 +62,7 @@ static int patch_alt_instruction(unsigned int *src, unsig=
ned int *dest,
 		}
 	}
=20
-	patch_instruction(dest, instr);
+	raw_patch_instruction(dest, instr);
=20
 	return 0;
 }
@@ -91,7 +91,7 @@ static int patch_feature_section(unsigned long value, str=
uct fixup_entry *fcur)
 	}
=20
 	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_INST_NOP);
+		raw_patch_instruction(dest, PPC_INST_NOP);
=20
 	return 0;
 }
@@ -129,7 +129,7 @@ void do_lwsync_fixups(unsigned long value, void *fixup_=
start, void *fixup_end)
=20
 	for (; start < end; start++) {
 		dest =3D (void *)start + *start;
-		patch_instruction(dest, PPC_INST_LWSYNC);
+		raw_patch_instruction(dest, PPC_INST_LWSYNC);
 	}
 }
=20
@@ -147,7 +147,7 @@ static void do_final_fixups(void)
 	length =3D (__end_interrupts - _stext) / sizeof(int);
=20
 	while (length--) {
-		patch_instruction(dest, *src);
+		raw_patch_instruction(dest, *src);
 		src++;
 		dest++;
 	}
