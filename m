Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjGgH6mmdzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 22:04:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v6 06/10] powerpc/lib/code-patching: Use alternate map for
 patch_instruction()
In-Reply-To: <c89803a4-3d43-d24c-171c-75a42a48f59d@c-s.fr>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
 <1499086914-25695-6-git-send-email-mpe@ellerman.id.au>
 <c89803a4-3d43-d24c-171c-75a42a48f59d@c-s.fr>
Date: Thu, 23 Nov 2017 22:04:41 +1100
Message-ID: <877euh2r3q.fsf@concordia.ellerman.id.au>
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

> Le 03/07/2017 =C3=A0 15:01, Michael Ellerman a =C3=A9crit=C2=A0:
>> From: Balbir Singh <bsingharora@gmail.com>
>>=20
>> This patch creates the window using text_poke_area, allocated via
>> get_vm_area(). text_poke_area is per CPU to avoid locking.
>> text_poke_area for each cpu is setup using late_initcall, prior to
>> setup of these alternate mapping areas, we continue to use direct
>> write to change/modify kernel text. With the ability to use alternate
>> mappings to write to kernel text, it provides us the freedom to then
>> turn text read-only and implement CONFIG_STRICT_KERNEL_RWX.
>>=20
>> This code is CPU hotplug aware to ensure that the we have mappings for
>> any new cpus as they come online and tear down mappings for any CPUs
>> that go offline.
>>=20
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   arch/powerpc/lib/code-patching.c | 171 +++++++++++++++++++++++++++++++=
+++++++-
>>   1 file changed, 167 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pa=
tching.c
>> index 500b0f6a0b64..c9de03e0c1f1 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -12,23 +12,186 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/init.h>
>>   #include <linux/mm.h>
>> -#include <asm/page.h>
>> -#include <asm/code-patching.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/slab.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/kprobes.h>
>>=20=20=20
>> +#include <asm/pgtable.h>
>> +#include <asm/tlbflush.h>
>> +#include <asm/page.h>
>> +#include <asm/code-patching.h>
>>=20=20=20
>> -int patch_instruction(unsigned int *addr, unsigned int instr)
>> +static int __patch_instruction(unsigned int *addr, unsigned int instr)
>>   {
>>   	int err;
>>=20=20=20
>>   	__put_user_size(instr, addr, 4, err);
>>   	if (err)
>>   		return err;
>> -	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
>> +
>> +	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
>> +
>> +	return 0;
>> +}
>> +
>
> [...]
>
>> +int patch_instruction(unsigned int *addr, unsigned int instr)
>> +{
>> +	int err;
>> +	unsigned int *dest =3D NULL;
>> +	unsigned long flags;
>> +	unsigned long text_poke_addr;
>> +	unsigned long kaddr =3D (unsigned long)addr;
>> +
>> +	/*
>> +	 * During early early boot patch_instruction is called
>> +	 * when text_poke_area is not ready, but we still need
>> +	 * to allow patching. We just do the plain old patching
>> +	 * We use slab_is_available and per cpu read * via this_cpu_read
>> +	 * of text_poke_area. Per-CPU areas might not be up early
>> +	 * this can create problems with just using this_cpu_read()
>> +	 */
>> +	if (!slab_is_available() || !this_cpu_read(text_poke_area))
>> +		return __patch_instruction(addr, instr);
>> +
>> +	local_irq_save(flags);
>> +
>> +	text_poke_addr =3D (unsigned long)__this_cpu_read(text_poke_area)->add=
r;
>> +	if (map_patch_area(addr, text_poke_addr)) {
>> +		err =3D -1;
>> +		goto out;
>> +	}
>> +
>> +	dest =3D (unsigned int *)(text_poke_addr) +
>> +			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
>> +
>> +	/*
>> +	 * We use __put_user_size so that we can handle faults while
>> +	 * writing to dest and return err to handle faults gracefully
>> +	 */
>> +	__put_user_size(instr, dest, 4, err);
>> +	if (!err)
>> +		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
>> +			::"r" (dest), "r"(addr));
>
> Is the second icbi really needed since the alternative area is mapped=20
> with PAGE_KERNEL which is not executable ?

The use of dest vs addr is hard to follow. The second icbi is of addr,
which is the executable mapping, so yes we need that icbi.

But the first icbi could be skipped, it's to dest which is not
executable. Is that what you meant? Or am I missing the point entirely.

> If we could avoid that, we could refactor this part as follows:

Yeah that would be a good clean up I think.

> diff --git a/arch/powerpc/lib/code-patching.c=20
> b/arch/powerpc/lib/code-patching.c
> index d469224c4ada..85031de43bb9 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -23,15 +23,17 @@
>   #include <asm/code-patching.h>
>   #include <asm/setup.h>
>
> -static int __patch_instruction(unsigned int *addr, unsigned int instr)
> +static int __patch_instruction(unsigned int *addr, unsigned int instr,
> +			       unsigned int *dest)

Renaming addr vs dest would help I think.

ie. maybe:

static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
			       unsigned int *patch_addr)

Or something.

cheers

>   {
>   	int err;
>
> -	__put_user_size(instr, addr, 4, err);
> +	__put_user_size(instr, dest, 4, err);
>   	if (err)
>   		return err;
>
> -	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
> +	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (dest),
> +							    "r" (addr));
>
>   	return 0;
>   }
> @@ -149,7 +151,7 @@ int patch_instruction(unsigned int *addr, unsigned=20
> int instr)
>   	 * to allow patching. We just do the plain old patching
>   	 */
>   	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
> -		return __patch_instruction(addr, instr);
> +		return __patch_instruction(addr, instr, addr);
>
>   	local_irq_save(flags);
>
> @@ -162,14 +164,7 @@ int patch_instruction(unsigned int *addr, unsigned=20
> int instr)
>   	dest =3D (unsigned int *)(text_poke_addr) +
>   			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
>
> -	/*
> -	 * We use __put_user_size so that we can handle faults while
> -	 * writing to dest and return err to handle faults gracefully
> -	 */
> -	__put_user_size(instr, dest, 4, err);
> -	if (!err)
> -		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
> -			::"r" (dest), "r"(addr));
> +	__patch_instruction(addr, instr, dest);
>
>   	err =3D unmap_patch_area(text_poke_addr);
>   	if (err)
> @@ -184,7 +179,7 @@ int patch_instruction(unsigned int *addr, unsigned=20
> int instr)
>
>   int patch_instruction(unsigned int *addr, unsigned int instr)
>   {
> -	return __patch_instruction(addr, instr);
> +	return __patch_instruction(addr, instr, addr);
>   }
>
>   #endif /* CONFIG_STRICT_KERNEL_RWX */
>
>
>> +
>> +	err =3D unmap_patch_area(text_poke_addr);
>> +	if (err)
>> +		pr_warn("failed to unmap %lx\n", text_poke_addr);
>> +
>> +out:
>> +	local_irq_restore(flags);
>> +
>> +	return err;
>> +}
>> +#else /* !CONFIG_STRICT_KERNEL_RWX */
>> +
>> +int patch_instruction(unsigned int *addr, unsigned int instr)
>> +{
>> +	return __patch_instruction(addr, instr);
>> +}
>> +
>> +#endif /* CONFIG_STRICT_KERNEL_RWX */
>> +NOKPROBE_SYMBOL(patch_instruction);
>> +
>>   int patch_branch(unsigned int *addr, unsigned long target, int flags)
>>   {
>>   	return patch_instruction(addr, create_branch(addr, target, flags));
>>=20
