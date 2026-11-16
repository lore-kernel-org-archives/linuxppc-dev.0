Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E5606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcwgdkEc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSsvV45XYz2xPb;
	Tue, 17 Nov 2026 02:57:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794844662;
	cv=none; b=DIp10qLOOLSIjcVV/RfgIL22euIHK3bTXyvrxqRMWk9UNjoycwXm4aQmQtRldc+rf48FODCyA1I3C8A5F86I+wOuKc6y1luEEyjGIwNkhHwwQsQRGbVd6nAFaNOWHHynyMWvw8BTdH2+TClcjI7isovtvHbciS1P0Lfm5rNfjlr/Pa+8Cf8cQcJ4CXNcj0UhVIJrHHHR8is/Tj98yY5t3wydBo4IFjLKlEImi0uFlsBec8ZP5U9z7wERfQ1xwyhHPbzjbuCLmvrAVuZ3RV794ixh4VNy5XgYvQbZzBR4K7ncWKyqsz7zH/TRXzX/qi44HywmQDzdw/h9Qw5K7oiyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794844662; c=relaxed/relaxed;
	bh=StvCoEr29cLHQZIiowY2SNny6e2PtWTpkfdhK1UE2dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM2AG+ULrelG1mcuRLeoaOmjG/xpg8/TcWD6wJPjm1Q/xIU8CBo9/1CmgelfqzdPm8DteUJAVs2eKcysknMPkJZOr5TcLtWftrmhzE4mioyR689x2LmOQrSFFlKwITDXbOeQ9l2qpnSl9EWTW5lsuOwyFci1u/oIwrS1SXBd1V5u+oOrBfkpvoxleP9CPtSXHt8eSIWsotURT1mGNkyUvkE3a5S0RMr34m4d4oYrgq1rJJfshhReMsuGNF4BdS7kOVJb0ephV1/CxXYKa+x2ekHlSsOTI2ThezGd3TA2VLRiV17hsu/nVlqKcmn36fac9C5KxFtIUE4n6ZJbdBuYLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcwgdkEc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcwgdkEc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSsvT0dZXz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 02:57:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B272413D2;
	Mon, 16 Nov 2026 15:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BA1F000CA;
	Mon, 16 Nov 2026 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844658;
	bh=StvCoEr29cLHQZIiowY2SNny6e2PtWTpkfdhK1UE2dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AcwgdkEcNKmC4TvycTTrQ06o5FwbouO5y/5UACUL/nVvF7Wk47ujEptRMKj3hmytU
	 lbqgPolwzYTHPSQRaCSUfOjRNlkl3YEwOlmzL1LHX1k8X9+ZPLIFw8GSTcNwYxam84
	 +Ztiq4OYGr81sSNPRZnOb7pcW3R+2vBhmLTOqZ1k1HKPcIf8TCh8UVZLghvy9IKpeL
	 CjUpwkquDDcaOGN7yMo42tIfu1bhZuhFy2ije0rZdKRR4eL6jQcORYGBTe7WuKv4EF
	 jXAe7rF7SLd3UYEskqNp5FMTAhXXfcnm9ASGl4kGFkUcghwP5S6iqrHz7cgzc6lWbA
	 FeJUhvpyoeXaA==
Date: Mon, 16 Nov 2026 17:57:32 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from
 the modules area on book3s/32
Message-ID: <avsn7Kn4a8wbB2QH@kernel.org>
References: <cover.1794572365.git.ritesh.list@gmail.com>
 <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com>
 <avltdwzlh07VZSFC@kernel.org>
 <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 04:11:07PM +0100, Christophe Leroy (CS GROUP) wrote:
> Hi Mike,
> 
> Le 15/11/2026 à 09:29, Mike Rapoport a écrit :
> > On Fri, Nov 13, 2026 at 06:01:37PM +0530, Ritesh Harjani (IBM) wrote:
> > > On book3s/32, a kprobe on an instruction that can't be emulated and has
> > > to be single stepped out of line, crashes the kernel. For e.g. with the
> > > following cmds...
> > >      ~> echo 9 > /proc/sys/kernel/printk
> > >      ~> mount -t debugfs debugfs /sys/kernel/debug
> > >      ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
> > >      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
> > >      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > > 
> > > ...we can see the following crash:
> > >      kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
> > >      BUG: Unable to handle kernel instruction fetch
> > >      Faulting instruction address: 0xc02b919c
> > >      Vector: 400 (Instruction Access) at [f19a9d60]
> > >          pc: c02b919c: filldir64+0xb8/0x2dc
> > >          lr: c02b9148: filldir64+0x64/0x2dc
> > >          sp: f19a9e20
> > >         msr: 10029032
> > >        current = 0xc112e900
> > >          pid   = 102, comm = ls
> > >      enter ? for help
> > >      [f19a9e20] c1a8d420 (unreliable)
> > >      [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
> > >      [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
> > >      [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
> > >      [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
> > >      [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
> > >      ---- Exception: c00 (System Call) at a7596164
> > >      SP (af802310) is in userspace
> > > 
> > > This happens because on book3s/32 the exec permission is per segment
> > > (256MB), not per page. The page tables have no hardware exec bit, only
> > > the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
> > > sets N on all the kernel segments except the ones of the modules area.
> > > So nothing in the vmalloc area can be executed, even when the page is
> > > mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
> > > a software only bit there and the segment's N bit is what the MMU
> > > enforces.
> > > 
> > > Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
> > > allocations"), the kprobes insn pages came from module_alloc(). That
> > > commit moved them to the whole of the vmalloc space, on the grounds
> > > that kprobes use a breakpoint and don't need to be near the kernel
> > > text. That is fine on platforms where the exec permission is per page,
> > > as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
> > > It is not on book3s/32, where the modules area is not only close to
> > > the kernel text but is also the only page-mapped area whose segment is
> > > left executable. So the insn pages must keep coming from there.
> > > 
> > > Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
> > Right, I missed that on book3s/32 does vmalloc is not executable and its
> > protection can't be changed.
> > 
> > Could it be that 8xx also need a special treatment for kprobes?
> 
> Yes indeed, not for the same reasons but because 8xx ITLB-miss handler
> doesn't expect any instruction TLB miss on kernel addresses other than the
> ones from the module area:
> 
> Commit 4afb0be7ccda ("powerpc/8xx: Avoid testing for kernel space in ITLB
> Miss.")
> Commit 16a71c045186 ("powerpc/8xx: Preallocate execmem page tables")
> Commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in ITLB
> misses")
> 
> So at the end as MODULES_VADDR/MODULES_END only exist on book3s/32 and 8xx I
> think when they exist they should be used as follows:
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index b617b69452cd..856f4609c488 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -428,8 +428,13 @@ struct execmem_info __init *execmem_arch_setup(void)
>  				.fallback_end	= fallback_end,
>  			},
>  			[EXECMEM_KPROBES] = {
> +#ifdef MODULES_VADDR
> +				.start	= MODULES_VADDR,
> +				.end	= MODULES_END,
> +#else
>  				.start	= VMALLOC_START,
>  				.end	= VMALLOC_END,
> +#endif

We already have #ifdef MODULES_VADDR a few lines above, I think the
assignment of kprobes_start and kprobes_end could go there instead of if
(IS_ENABLED(CONFIG_PPC_BOOK3S_32)).

>  				.pgprot	= kprobes_prot,
>  				.alignment = 1,
>  			},
> 
> 
> > 
> > > Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > > ---
> > >   arch/powerpc/mm/mem.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > > index 77b63b52d8f2..ae1bc7359353 100644
> > > --- a/arch/powerpc/mm/mem.c
> > > +++ b/arch/powerpc/mm/mem.c
> > > @@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
> > >   	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> > >   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
> > >   	unsigned long fallback_start = 0, fallback_end = 0;
> > > +	unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
> > >   	unsigned long start, end;
> > > 
> > >   	/*
> > > @@ -410,6 +411,11 @@ struct execmem_info __init *execmem_arch_setup(void)
> > >   	}
> > > 
> > >   	end = MODULES_END;
> > > +
> > > +	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
> > > +		kprobes_start = MODULES_VADDR;
> > > +		kprobes_end = MODULES_END;
> > > +	}
> > >   #else
> > >   	start = VMALLOC_START;
> > >   	end = VMALLOC_END;
> > > @@ -428,8 +434,8 @@ struct execmem_info __init *execmem_arch_setup(void)
> > >   				.fallback_end	= fallback_end,
> > >   			},
> > >   			[EXECMEM_KPROBES] = {
> > > -				.start	= VMALLOC_START,
> > > -				.end	= VMALLOC_END,
> > > +				.start	= kprobes_start,
> > > +				.end	= kprobes_end,
> > >   				.pgprot	= kprobes_prot,
> > >   				.alignment = 1,
> > >   			},
> > > --
> > > 2.39.5
> > > 
> > > 
> > 
> 

-- 
Sincerely yours,
Mike.

