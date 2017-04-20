Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7pGn1vfCzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 16:04:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
In-Reply-To: <694d02a4-d2bd-a276-928f-0dd5189a936a@c-s.fr>
References: <cover.1492596044.git.christophe.leroy@c-s.fr>
 <eabf767c896a023e5670adfa07398f1008756c13.1492596044.git.christophe.leroy@c-s.fr>
 <87inm05we4.fsf@concordia.ellerman.id.au>
 <d3713d6a-28b6-fb8f-ce32-c0d37958b59f@c-s.fr>
 <694d02a4-d2bd-a276-928f-0dd5189a936a@c-s.fr>
Date: Thu, 20 Apr 2017 16:04:14 +1000
Message-ID: <87shl34ntt.fsf@concordia.ellerman.id.au>
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

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 19/04/2017 =C3=A0 16:22, Christophe LEROY a =C3=A9crit :
>>
>>
>> Le 19/04/2017 =C3=A0 16:01, Michael Ellerman a =C3=A9crit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace=
.c
>>>> index 32509de6ce4c..4af81fb23653 100644
>>>> --- a/arch/powerpc/kernel/ftrace.c
>>>> +++ b/arch/powerpc/kernel/ftrace.c
>>>> @@ -526,7 +526,9 @@ void ftrace_replace_code(int enable)
>>>>   */
>>>>  void arch_ftrace_update_code(int command)
>>>>  {
>>>> +    set_kernel_text_rw();
>>>>      ftrace_modify_all_code(command);
>>>> +    set_kernel_text_ro();
>>>>  }
>>>
>>> I'm not sure that's the right place for that.
>>
>> I took arch/arm/ as model. It does the following. Is that wrong ?

It's not wrong, it's just not optimal.

You're setting all text RW to modify one instruction, which is more work
than necessary and also creates a larger attack window.

> Could you provide more details on what you have seen on other arches ? I=
=20
> didn't notice anything related in any other arches' ftrace_modify_code()

I was looking at arm64 specifically:

static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
			      bool validate)
{
...
	if (aarch64_insn_patch_text_nosync((void *)pc, new))
		return -EPERM;

	return 0;
}

int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
{
...
	ret =3D aarch64_insn_write(tp, insn);
	if (ret =3D=3D 0)
		flush_icache_range((uintptr_t)tp,
				   (uintptr_t)tp + AARCH64_INSN_SIZE);

	return ret;
}

static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
{
...
	raw_spin_lock_irqsave(&patch_lock, flags);
	waddr =3D patch_map(addr, FIX_TEXT_POKE0);

	ret =3D probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);

	patch_unmap(FIX_TEXT_POKE0);
	raw_spin_unlock_irqrestore(&patch_lock, flags);

	return ret;
}


So if I'm reading it right they actually create a new RW mapping, patch
that, and then unmap, before flushing the icache.

That's definitely the nicest approach, but is maybe more work than you
signed up for :)


But even if you just shift your logic into ftrace_modify_code(), you
then have the ip, so you can call change_page_attr() on the single page
you're patching rather than all of text.

cheers
