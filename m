Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C9606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrhGEKA+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJgKb2h0kz2xKQ;
	Tue, 03 Nov 2026 18:33:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793691203;
	cv=none; b=fPSlj3p3c1wVX/Xy1zz+aurULCY6sytgSGhLkFeipX/RtAEHpot0DhMAjRVHOb+1avY7SwCVDONb02DWGMDorSaeRGPltu6f6iV9Yn9pv1XDUeyLVykqGQKqd7nDjka/Pqee8/GK4sIx3NF4z3bKGpRuLLSjfU38ADytc3sLPbWcRr/Lsn1FXyor2GYDkFoFLMftRJzmwU7URPtk69zgsL4Ax5qhYypTEPz+SAYlVai3J0SKEDV+iYS/iJYvytNaMgeNyFD++BhqMFjAwKM81SMbRYkFdeaC71m+fo3IW7wgM4TYRzL1G3Nt2GoWVN0R1q2u9t5etN1wkW71q2Do9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793691203; c=relaxed/relaxed;
	bh=Oa8y5a8fdB3n8SvDHO+NQ5moFBEj62kNByaWKZDpVOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQKYA2sdtJ/niq1TGXkij6IsuQxncqZDlxkNbvqR8tS1ZZ0lQiAjvLj+BuE8YGF/dDhQI2ajA4KUfsz4W1eYnYlMy1+gfiAhSYOZ5qRxmX1NKpSW8X5MUjtYdXOT+eWFNKKjFrt5gMLPZifyKJeJVonYGQkREhxlSK74UkRe5i0uNnx1d+Ks5oZ3MEZfPYgKpXQ0b2yQuzZUMpzXe+JKDbUFOIxP5F6kh3TBwld8CHnw4wGuXFVeMKZdsLT3QdzN3jnuk9e6yWN+GvEf2YIx/kA1XrS/qFq+sRXME/JGRyQUbZic/ShqSD/VrUlvtfDACDzauOylAJ+l7fmkbdn48g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrhGEKA+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrhGEKA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJgKZ23BCz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 18:33:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C168D43DA2;
	Tue,  3 Nov 2026 07:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ABC1F00A17;
	Tue,  3 Nov 2026 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691199;
	bh=Oa8y5a8fdB3n8SvDHO+NQ5moFBEj62kNByaWKZDpVOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YrhGEKA+PeuuW/jRrCPDbubJ+8MeiOB7ohkDvdn7B1hNwFrYwqw5e3Qb5ZWGhLrwJ
	 kfg6oclT46j62LrUrac0EafiAZ3+KI2zgxLX5rzfs29w8ZhNe31bRrAEPomMsmjjBa
	 lKUJd1HyqFQwUmT5p3kfctFU2ScH+pGwppSgx39XmmP6D/0uRAotq1b5O+LOfmGom1
	 npjQBjmNXeU5ErsRhK7ZIzZGG4Ba6sTrnVQmthz8YmAFn5hZtEAQhOl8e7HBB1jep1
	 vvxmOJxSyeRo0cZERgguHtmnpI1bqtkUqgEHza0pOmtVnQWvdgMcM23IuK2WJnCdcJ
	 Ge9DkpaqeAdvQ==
Message-ID: <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org>
Date: Tue, 3 Nov 2026 08:33:13 +0100
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
Subject: Re: [PATCH] powerpc/code-patching: Flush the patch area TLB entry
 locally
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Hari Bathini <hbathini@linux.ibm.com>, stable@vger.kernel.org,
 Josef Schlehofer <pepe.schlehofer@gmail.com>
References: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 03/11/2026 à 03:54, Ritesh Harjani (IBM) a écrit :
> patching functions like patch_mem() and patch_instructions(), maps the
> target page at the per-cpu text_poke_area, write it, clear the PTE and
> then flushes the tlb using flush_tlb_kernel_range(), with interrupts
> disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
> based TLB invalidation i.e -
> 
> 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
> 
> ...which will wait for other CPUs but with interrupts off. This can be
> caught by lockdep with the following warning:
> 
>    WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>    CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>    Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>    Call Trace:
>    [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>    [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>    [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>    [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>    [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>    ...
>    [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>    [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>    ...
>    hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
> 
> Josef confirmed that this was causing a hang (deadlock):
>      I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
>      CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
>      fine 9 of 9 times with jump labels off. The hang comes while static
>      keys are patched and modules are loaded, nothing is printed and the
>      watchdog resets the board. OpenWrt keeps jump labels off on these
>      boards for now.
> 
> ...which is possible if both cpus are doing similar operations with interrupts
> off and doing TLB invalidation using IPI.
> 
> Broadcast TLB invalidation is not needed here since text_poke_area is
> a per-cpu area. It is mapped and unmapped with interrupts disabled by
> it's own cpu. The only reason I think, if we would need a broadcast tlb
> invalidate is, when we want to prevent a stray or malicious write to
> this cpu text_poke_area by another CPU. This generally gets solved with
> temporary-mm path like how Radix and even x86 implements. However, booke
> doesn't implement that, so for now let's ensure we use local tlb
> flushing for correctness.

This problem was already discussed one year ago, see 
https://lore.kernel.org/all/PA3P192MB2865C07D634E3B775D003C7F8CD7A@PA3P192MB2865.EURP192.PROD.OUTLOOK.COM/

See response from Arnd, a stop_machine() should be done for completeness.


> 
> Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Closes: https://lore.kernel.org/all/20261026195644.16384-1-pepe.schlehofer@gmail.com/
> Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 44ff9f684bef..6351342fa5c3 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>   	return err;
>   }
> 
> +/*
> + * The patch area is per-CPU and only used by its own CPU, with IRQs
> + * disabled, so only the local TLB can hold an entry for it.
> + *
> + * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
> + * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
> + * flush just the local kernel (PID 0) entry.
> + * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
> + */
> +static void flush_patch_area(unsigned long addr)
> +{
> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S))

CONFIG_PPC_BOOK3S not consistant with commit message. Are you adressing 
a problem on e500 only ? on all not book3s ? What about book3s/32 ? What 
about 8xx ? Even for book3s/64, is it correct at all when 
mm_patch_enabled() returns false ?

> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	else
> +		local_flush_tlb_page(NULL, addr);
> +}
> +
>   static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>   {
>   	int err;
> @@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>   	err = __patch_mem(addr, val, patch_addr, is_dword);
> 
>   	pte_clear(&init_mm, text_poke_addr, pte);
> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
> +	flush_patch_area(text_poke_addr);
> 
>   	return err;
>   }
> @@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
>   	err = __patch_instructions(patch_addr, code, len, repeat_instr);
> 
>   	pte_clear(&init_mm, text_poke_addr, pte);
> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
> +	flush_patch_area(text_poke_addr);
> 
>   	return err;
>   }
> --
> 2.39.5
> 


