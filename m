Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB3606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl8CZn1E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRLx0X9qz2xmk;
	Wed, 18 Nov 2026 01:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794924296;
	cv=none; b=n41Coo7O/MpEQ/ZFrPrhqX/8CKqH1mhDAtZcSsp8QsfgefFToA86FZAJhpIGLhoDaxfhSY3h/ayhviaDt2fIptw/V4PIKaz2Kk9CXE66tSQW1I7a26JQgoJNjRNyaTqrMWNseYvFREPcbDPQHfz7quvKe6PVRBf9jrEVnNj+G0N6PA8vHhvomAmuEMLNuLs/rQ7cpy/ZMjTLLr3IGajz+LBWbZWTbHaXo0gjo56VtHvM07ednTFxmyJGamqhnAyWUEpU0nQI7WfUjZZ2rxg2XCblT1WJR68zbDkgdnoYcYBPwoGGlYEbQ7s3W9Y9C0RH5nDby6RmTkjVUzsm0gur+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794924296; c=relaxed/relaxed;
	bh=CSO2txSeuBdzHoBjSwGk71m2cjsHMmVNxrr5Z7HFswk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngM4skrvAaP3XO0HD/2jGZp6QKSLlnbf8xWFvgpcF6KlTiQRCgmenA8ow6RqUeAUVEy4aTSPNJpCwslvUny+dDqsmTT7VhToxXwTZMJeIkHTwUmCszfAblrUb/sG+Hzy9WzgxTb6S7PO91Uy+jpwdkNcY4bFAchvYABZyrhyrpQYvbw+pbWMmWuYPSwPYGyhxMPY6WnI3Cu15FtusIHsDUga/yHB+/bky1c2pppuNnGdLFl+usjzEgZUKUST2BMUUNgiHkwZiTtKXRiR9TgjKE0CKLqcLxMcdxYIEYVXXqILjVvLRuw9ukRRXjs+lRp1o7PN8JgvaJ+q+xQfsS2ODA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl8CZn1E; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl8CZn1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRLw1QQRz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:04:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81566400B7;
	Tue, 17 Nov 2026 14:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E4F1F000C4;
	Tue, 17 Nov 2026 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924294;
	bh=CSO2txSeuBdzHoBjSwGk71m2cjsHMmVNxrr5Z7HFswk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jl8CZn1Eqxcp6loLZ2c+OCE0bUiojbDDwtau8+VV6eEeT3SeaMuvOJzwg/TTAanaa
	 iOzVRwnTypIrvSYJ/goGcFRc1qkJ6DqMFybBf30dgQv6b1DO1g0yPTEPs5c3tL0Q1K
	 9femnpNw2XPRJZzNCqArRCsU8r+a5qXLXs5ca2Hlv+3HRvL3P1To1IPq0AKjOC0AAr
	 oLGU77bG6FYDVYJJCuqHjU7U7CSIFtYUTymV0t46PhDUxS7aOchV642tOP8DXwutZb
	 mNlEva4mjfviCW7K2QRshUe3AXS9hOEsbOGSEFFNPpzBKY0BI8wCQZPbJK7EXSZvN5
	 9sOYR45OwqVBw==
Message-ID: <eb634d1f-cb08-44a8-88c9-e3b559c399a3@kernel.org>
Date: Tue, 17 Nov 2026 15:04:49 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from
 the modules area on book3s/32
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <cover.1794572365.git.ritesh.list@gmail.com>
 <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com>
 <avltdwzlh07VZSFC@kernel.org>
 <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org>
 <avsn7Kn4a8wbB2QH@kernel.org> <zev77i3i.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <zev77i3i.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 17/11/2026 à 13:33, Ritesh Harjani a écrit :
> Mike Rapoport <rppt@kernel.org> writes:
> 
>> On Mon, Nov 16, 2026 at 04:11:07PM +0100, Christophe Leroy (CS GROUP) wrote:
>>> Hi Mike,
>>>
>>> Le 15/11/2026 à 09:29, Mike Rapoport a écrit :
>>>> On Fri, Nov 13, 2026 at 06:01:37PM +0530, Ritesh Harjani (IBM) wrote:
>>>>> On book3s/32, a kprobe on an instruction that can't be emulated and has
>>>>> to be single stepped out of line, crashes the kernel. For e.g. with the
>>>>> following cmds...
>>>>>       ~> echo 9 > /proc/sys/kernel/printk
>>>>>       ~> mount -t debugfs debugfs /sys/kernel/debug
>>>>>       ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
>>>>>       ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
>>>>>       ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>>>>>
>>>>> ...we can see the following crash:
>>>>>       kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
>>>>>       BUG: Unable to handle kernel instruction fetch
>>>>>       Faulting instruction address: 0xc02b919c
>>>>>       Vector: 400 (Instruction Access) at [f19a9d60]
>>>>>           pc: c02b919c: filldir64+0xb8/0x2dc
>>>>>           lr: c02b9148: filldir64+0x64/0x2dc
>>>>>           sp: f19a9e20
>>>>>          msr: 10029032
>>>>>         current = 0xc112e900
>>>>>           pid   = 102, comm = ls
>>>>>       enter ? for help
>>>>>       [f19a9e20] c1a8d420 (unreliable)
>>>>>       [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
>>>>>       [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
>>>>>       [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
>>>>>       [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
>>>>>       [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
>>>>>       ---- Exception: c00 (System Call) at a7596164
>>>>>       SP (af802310) is in userspace
>>>>>
>>>>> This happens because on book3s/32 the exec permission is per segment
>>>>> (256MB), not per page. The page tables have no hardware exec bit, only
>>>>> the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
>>>>> sets N on all the kernel segments except the ones of the modules area.
>>>>> So nothing in the vmalloc area can be executed, even when the page is
>>>>> mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
>>>>> a software only bit there and the segment's N bit is what the MMU
>>>>> enforces.
>>>>>
>>>>> Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
>>>>> allocations"), the kprobes insn pages came from module_alloc(). That
>>>>> commit moved them to the whole of the vmalloc space, on the grounds
>>>>> that kprobes use a breakpoint and don't need to be near the kernel
>>>>> text. That is fine on platforms where the exec permission is per page,
>>>>> as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
>>>>> It is not on book3s/32, where the modules area is not only close to
>>>>> the kernel text but is also the only page-mapped area whose segment is
>>>>> left executable. So the insn pages must keep coming from there.
>>>>>
>>>>> Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
>>>> Right, I missed that on book3s/32 does vmalloc is not executable and its
>>>> protection can't be changed.
>>>>
>>>> Could it be that 8xx also need a special treatment for kprobes?
>>>
>>> Yes indeed, not for the same reasons but because 8xx ITLB-miss handler
>>> doesn't expect any instruction TLB miss on kernel addresses other than the
>>> ones from the module area:
>>>
>>> Commit 4afb0be7ccda ("powerpc/8xx: Avoid testing for kernel space in ITLB
>>> Miss.")
>>> Commit 16a71c045186 ("powerpc/8xx: Preallocate execmem page tables")
>>> Commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in ITLB
>>> misses")
>>>
> 
> Right. I looked at the above series which added all of this support [1].
> So looks like 603 might also have this related problem (other than the
> per segment N bit issue), since it's iTLB miss handler only walks the
> task's PGDIR, unlike it's dTLB handler which falls back to reloading the
> missing kernel PGD entry from swapper_pg_dir. So what I meant to say is
> that, similar to 8xx, a new PGD entry created in the kernel's vmalloc
> area for an insn page does not get copied over after the task is
> created (/PGDIR allocated), on 603 as well.
> But since MODLUES_VADDR is defined for both BOOK3S/32 and 8xx, so I guess it
> gets covered by the same change anyways.
> 
> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinuxppc-dev%2Fcover.1724173828.git.christophe.leroy%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0dc9911f0edd40821c2d08df44aea3d2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639305189016985969%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UbPfu7OsJohLOnRi3b2v67TmweDvZBTi%2BCX3qcrp3qM%3D&reserved=0
> 
>>> So at the end as MODULES_VADDR/MODULES_END only exist on book3s/32 and 8xx I
>>> think when they exist they should be used as follows:
>>>
>>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>> index b617b69452cd..856f4609c488 100644
>>> --- a/arch/powerpc/mm/mem.c
>>> +++ b/arch/powerpc/mm/mem.c
>>> @@ -428,8 +428,13 @@ struct execmem_info __init *execmem_arch_setup(void)
>>>   				.fallback_end	= fallback_end,
>>>   			},
>>>   			[EXECMEM_KPROBES] = {
>>> +#ifdef MODULES_VADDR
>>> +				.start	= MODULES_VADDR,
>>> +				.end	= MODULES_END,
>>> +#else
>>>   				.start	= VMALLOC_START,
>>>   				.end	= VMALLOC_END,
>>> +#endif
>>
>> We already have #ifdef MODULES_VADDR a few lines above, I think the
>> assignment of kprobes_start and kprobes_end could go there instead of if
>> (IS_ENABLED(CONFIG_PPC_BOOK3S_32)).
>>
> 
> Right. So let me use the following diff then?
> 
> Please let me know if this diff looks good to you? If yes, then I can
> send a v3.

My preference would go to something similar to 'start' and 'end', no 
init at declaration, kprobes_start and kprobes_end set to 
VMALLOC_START/VMALLOC_END inside the #else

Christophe

> 
> Also - it will be good to know if patch-1 and patch-3 looks ok too,
> before I spin a next revision?
> 
> Thanks Christophe & Mike, for reviewing and pointing this out!
> 
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 77b63b52d8f2..547120a30bee 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
>          pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>          pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>          unsigned long fallback_start = 0, fallback_end = 0;
> +       unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
>          unsigned long start, end;
> 
>          /*
> @@ -410,6 +411,9 @@ struct execmem_info __init *execmem_arch_setup(void)
>          }
> 
>          end = MODULES_END;
> +
> +       kprobes_start = MODULES_VADDR;
> +       kprobes_end = MODULES_END;
>   #else
>          start = VMALLOC_START;
>          end = VMALLOC_END;
> @@ -428,8 +432,8 @@ struct execmem_info __init *execmem_arch_setup(void)
>                                  .fallback_end   = fallback_end,
>                          },
>                          [EXECMEM_KPROBES] = {
> -                               .start  = VMALLOC_START,
> -                               .end    = VMALLOC_END,
> +                               .start  = kprobes_start,
> +                               .end    = kprobes_end,
>                                  .pgprot = kprobes_prot,
>                                  .alignment = 1,
>                          },
> 
> 
> 
> -ritesh
> 
> 
>>>   				.pgprot	= kprobes_prot,
>>>   				.alignment = 1,
>>>   			},
>>>
>>>
>>>>
>>>>> Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
>>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>>
>>>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>>
>>>>> ---
>>>>>    arch/powerpc/mm/mem.c | 10 ++++++++--
>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>>>> index 77b63b52d8f2..ae1bc7359353 100644
>>>>> --- a/arch/powerpc/mm/mem.c
>>>>> +++ b/arch/powerpc/mm/mem.c
>>>>> @@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
>>>>>    	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>>>>    	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>>>>>    	unsigned long fallback_start = 0, fallback_end = 0;
>>>>> +	unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
>>>>>    	unsigned long start, end;
>>>>>
>>>>>    	/*
>>>>> @@ -410,6 +411,11 @@ struct execmem_info __init *execmem_arch_setup(void)
>>>>>    	}
>>>>>
>>>>>    	end = MODULES_END;
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
>>>>> +		kprobes_start = MODULES_VADDR;
>>>>> +		kprobes_end = MODULES_END;
>>>>> +	}
>>>>>    #else
>>>>>    	start = VMALLOC_START;
>>>>>    	end = VMALLOC_END;
>>>>> @@ -428,8 +434,8 @@ struct execmem_info __init *execmem_arch_setup(void)
>>>>>    				.fallback_end	= fallback_end,
>>>>>    			},
>>>>>    			[EXECMEM_KPROBES] = {
>>>>> -				.start	= VMALLOC_START,
>>>>> -				.end	= VMALLOC_END,
>>>>> +				.start	= kprobes_start,
>>>>> +				.end	= kprobes_end,
>>>>>    				.pgprot	= kprobes_prot,
>>>>>    				.alignment = 1,
>>>>>    			},
>>>>> --
>>>>> 2.39.5
>>>>>
>>>>>
>>>>
>>>
>>
>> -- 
>> Sincerely yours,
>> Mike.


