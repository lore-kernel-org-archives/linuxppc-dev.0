Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582C606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMhZFMKJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZTFj6w2Rz2xwP;
	Thu, 26 Nov 2026 05:47:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795632473;
	cv=none; b=gKdbXImnKC+btkK1MaMfImLA6Q5Up/qV+jmqKT2YSn2nFi1izcjyvDenN06sWpKKXaRk5kWqDfe9n13xtBjVUHspb+zHKp1CvYef8EmVLwMr4m+8WIG9siP4rM6Dp0vW9zWIEKDJznIUOshQUw+8vzDcueSE9cBJo/uAGZCWnrnp00JAR8PPrdYwGkdHUJVI+CXxN27EPLuxQZrkp9K1nDIzi6Ie2JiZbFbxzucCqK2TgMALEHOcqJjWD1qSqvDacQPB+xqgnLeb/Pouuv031yPHb9J3pPjFSjUfscuZsSmyG/qL4D9hr49MfjSpDVbwSUb0SNAliYt9zpyiR3VbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795632473; c=relaxed/relaxed;
	bh=oYPXELCbDOucPNUCaZPkHgVTyWFN4meedzO+ti8IER8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnYRHUTETY6Ixj0cR4FP7yd9V7jVZxKMwjlUAX1ckAoGvJl5uLAQMOxn4cYSFXNNZ86UJ23O2nhJCng+NVsVL+EsGItAHhpAEBckkuHbqMAZhJNXfir2AH9KSLMmlblkUkt7ppo+K157xyfF20/IhQyxcgI1rtykEJqKDApTCa7A/xpl7tBPG1J1T2gp4JtyLqAe9jOLsaOFMIqfLlqGyeB7pYDmnY+/VvKnDaAUo/KnAcXTJHnsYURB8ck5IB3E9UfEgdyCM6tB9j8eTB31wPRnjIsgEiCfc7bVl+9V9kzJJ1MWxvTSHwYRegBVh0U60miTHtgZKWrchDz6cS9cng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMhZFMKJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMhZFMKJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZTFj0rP4z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:47:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9110644D6D;
	Wed, 25 Nov 2026 18:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE82E1F000CF;
	Wed, 25 Nov 2026 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632470;
	bh=oYPXELCbDOucPNUCaZPkHgVTyWFN4meedzO+ti8IER8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MMhZFMKJQCzeh9Y5S1ArGzJroSYRIv/Ve84qxhz0PRPNYgpm/eC1JGKWLl66h87Na
	 iIvwWPer2xwGdNIiaQLuXUCNtKmnd3lBQbXXroN9fEOo8rnMjhqt/5GDOqvFm97n33
	 2dZyHiNXJhpgRn7Fxxe2Txxi8W7ofGgdr1GrhbAD63dQbpF+RxBvLGvq5gj480r+u3
	 bAt6UCHI4haaWRWWpsHqHzESCQirJD+daO4n2FyOMVsCyb5jMFMixV06lqOgeC1hSM
	 bY9MK+HvYjKKbfqtTi8//WrzrKKTsppGbd0OP8k7kKnrpr5+uYsjAgNPzUaNKlnsEx
	 QrsNvhdvK4M1Q==
Message-ID: <92b40ffa-c9bd-4d1c-b60b-f27e89102f9d@kernel.org>
Date: Wed, 25 Nov 2026 19:47:44 +0100
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
Subject: Re: [PATCHv3 2/4] powerpc/execmem: Allocate kprobes insn pages from
 the modules area on book3s/32
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
References: <cover.1795625038.git.ritesh.list@gmail.com>
 <128398ae7491112604572d94778c938bf1e306c3.1795625038.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <128398ae7491112604572d94778c938bf1e306c3.1795625038.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

There is a problem with the subject of most of your patches: the space 
between "PATCH" and "v3" is missing, therefore patchwork doesn't fully 
understand and it doesn't remove the PATCH word as it does when the 
space is there. I have not checked whether b4 understands it.

Le 25/11/2026 à 17:52, Ritesh Harjani (IBM) a écrit :
> On book3s/32, a kprobe on an instruction that can't be emulated and has
> to be single stepped out of line, crashes the kernel. For e.g. with the
> following cmds...
>      ~> echo 9 > /proc/sys/kernel/printk
>      ~> mount -t debugfs debugfs /sys/kernel/debug
>      ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> 
> ...we can see the following crash:
>      kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
>      BUG: Unable to handle kernel instruction fetch
>      Faulting instruction address: 0xc02b919c
>      Vector: 400 (Instruction Access) at [f19a9d60]
>          pc: c02b919c: filldir64+0xb8/0x2dc
>          lr: c02b9148: filldir64+0x64/0x2dc
>          sp: f19a9e20
>         msr: 10029032
>        current = 0xc112e900
>          pid   = 102, comm = ls
>      enter ? for help
>      [f19a9e20] c1a8d420 (unreliable)
>      [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
>      [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
>      [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
>      [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
>      [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
>      ---- Exception: c00 (System Call) at a7596164
>      SP (af802310) is in userspace
> 
> This happens because on book3s/32 the exec permission is per segment
> (256MB), not per page. The page tables have no hardware exec bit, only
> the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
> sets N on all the kernel segments except the ones of the modules area.
> So nothing in the vmalloc area can be executed, even when the page is
> mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
> a software only bit there and the segment's N bit is what the MMU
> enforces.
> 
> Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
> allocations"), the kprobes insn pages came from module_alloc(). That
> commit moved them to the whole of the vmalloc space, on the grounds
> that kprobes use a breakpoint and don't need to be near the kernel
> text. That is fine on platforms where the exec permission is per page,
> as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
> It is not on book3s/32, where the modules area is not only close to
> the kernel text but is also the only page-mapped area whose segment is
> left executable. So the insn pages must keep coming from there.
> 
> Hence, use the modules area for EXECMEM_KPROBES on book3s/32.

The patch is now correct as it now if #ifdef MODULES_VADDR block, but 
the description is incomplete.

The description misses the 8xx for the reason explained here: 
https://lore.kernel.org/all/f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org/

And that reason also applies to book3s/32, as reminded here by yourself: 
https://lore.kernel.org/all/zev77i3i.ritesh.list@gmail.com/

> 
> Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/mm/mem.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 77b63b52d8f2..8a0fdfd028dd 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
>   	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>   	unsigned long fallback_start = 0, fallback_end = 0;
> +	unsigned long kprobes_start, kprobes_end;
>   	unsigned long start, end;
>   
>   	/*
> @@ -410,9 +411,15 @@ struct execmem_info __init *execmem_arch_setup(void)
>   	}
>   
>   	end = MODULES_END;
> +
> +	kprobes_start = MODULES_VADDR;
> +	kprobes_end = MODULES_END;
>   #else
>   	start = VMALLOC_START;
>   	end = VMALLOC_END;
> +
> +	kprobes_start = VMALLOC_START;
> +	kprobes_end = VMALLOC_END;
>   #endif
>   
>   	prealloc_execmem_pgtable();
> @@ -428,8 +435,8 @@ struct execmem_info __init *execmem_arch_setup(void)
>   				.fallback_end	= fallback_end,
>   			},
>   			[EXECMEM_KPROBES] = {
> -				.start	= VMALLOC_START,
> -				.end	= VMALLOC_END,
> +				.start	= kprobes_start,
> +				.end	= kprobes_end,
>   				.pgprot	= kprobes_prot,
>   				.alignment = 1,
>   			},


