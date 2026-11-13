Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEA606A8AF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDjzVVrU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR0F03G3Wz2xMt;
	Sat, 14 Nov 2026 01:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794580580;
	cv=none; b=S0dIZi0SE2Wt26rh1OWyCqgQ8qksCH6FCwkzlKwohMQeUAjVpLSZIByjmh/MMU8kbmWoogTJHqBe+85ODwWWXsr6PSmAldj/VhUmNrkMURAxkWGqFLtbzG5zyybBvEa5YQlD3xvu/1hFwWnRFyPr57UqS+2t6+3Sv7mZcAkL8wabrp3BIaE//vgdab6+2F5jcXe4bMWiZRWngDBYcow3RW5cQq0UX7Zg77QzDxMPEGy7IhCLoKeznXJfQkKz4Rrn0/pgiyjTa4JvmttMd/0NNNbfzwA2Se7zE0MkjvOz7a65YyjFWduIfW0AiiR6ehiQuj/dY8NVO9pD+xjjw+ocYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794580580; c=relaxed/relaxed;
	bh=w49hyKAjJNYQc0T0xEVaI68+0oF+m2dcDRcRYzEk8rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aqhrfcn2xqO2ndvjcoSjaBILFVQJbf44ZeUKmeIlkD7NGl78OamrAAmUsxA4Noyv0k1p4i5C7iNNZebzPApqbUAdi1EZzuepE1NJYHnFrPE3eCefZAG1VMQqowfmjetHG7mxeTDs6XAPiMCGOAv23Pa58VPH0Ge+o7icCaUFTiHJf6aibsTXt0xTTf+AHCcNsqd/QEKdj+qWTenT6p4l3iHsaIfYLJR15IXGVW33w+Fq40PDBPWHXRcJDdGQ/2e8HZkebRXfhhyTDdlJPYD5VVppbD5Y8fZ9QP2kVpuOcrMW3G9TLKIXYaQg8gFxirMHIukwjDyK2AQAAbJtJXvI9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDjzVVrU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDjzVVrU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR0Dz3Pfvz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 01:36:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 47A0540039;
	Fri, 13 Nov 2026 14:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B8A1F000C4;
	Fri, 13 Nov 2026 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580577;
	bh=w49hyKAjJNYQc0T0xEVaI68+0oF+m2dcDRcRYzEk8rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jDjzVVrUjcqqvOcF2zRf/R4D2SkobqauH5sB4E4FWc03X74m4jxFCQSio9YHHHuuR
	 9Ml4Tlrckfk60OSmZz+hec4p2l9kmjLvQBMrX/YWsRQQvgUFJp0NHQZIrCyw0Gwiek
	 QZbpgzhogd+cwsY3Nd25gGqUKt3Baw/aKdlCaoUNBkxmn6Z5pyPj2weF8qqKc3/A8M
	 /Hvf3OTZxfDyyZ1sLXoNdqhyld8LAWFVmEcfNS1X7e6OGeS63NUqhOrnPQq/ZF6Igj
	 DMtYYds7K9Hh4P0SFcSWYXYIJSddoBhMr/8mdEZ/t7+gx48plf7GD6vYahVdtRVM4l
	 DMbaEQTybkmNw==
Message-ID: <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org>
Date: Fri, 13 Nov 2026 15:36:01 +0100
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
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for
 kprobes allocations
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Liviu Dudau
 <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
References: <20240505160628.2323363-1-rppt@kernel.org>
 <20240505160628.2323363-12-rppt@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20240505160628.2323363-12-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

Looks like I missed this change ...

Le 05/05/2024 à 18:06, Mike Rapoport a écrit :
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> powerpc overrides kprobes::alloc_insn_page() to remove writable
> permissions when STRICT_MODULE_RWX is on.
> 
> Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
> generic kprobes::alloc_insn_page() with the desired permissions.
> 
> As powerpc uses breakpoint instructions to inject kprobes, it does not
> need to constrain kprobe allocations to the modules area and can use the
> entire vmalloc address space.

Using breakpoint means the segment must still be executable.
On book3s/32 VMALLOC segment is not executable, while module segment is.

See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules 
with STRICT_KERNEL_RWX")

See report and fix at 
https://lore.kernel.org/all/ed03d290d440d579a81ae0b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/

Christophe



> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/powerpc/kernel/kprobes.c | 20 --------------------
>   arch/powerpc/kernel/module.c  |  7 +++++++
>   2 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 9fcd01bb2ce6..14c5ddec3056 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -126,26 +126,6 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
>   	return (kprobe_opcode_t *)(addr + offset);
>   }
>   
> -void *alloc_insn_page(void)
> -{
> -	void *page;
> -
> -	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> -	if (!page)
> -		return NULL;
> -
> -	if (strict_module_rwx_enabled()) {
> -		int err = set_memory_rox((unsigned long)page, 1);
> -
> -		if (err)
> -			goto error;
> -	}
> -	return page;
> -error:
> -	execmem_free(page);
> -	return NULL;
> -}
> -
>   int arch_prepare_kprobe(struct kprobe *p)
>   {
>   	int ret = 0;
> diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
> index ac80559015a3..2a23cf7e141b 100644
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -94,6 +94,7 @@ static struct execmem_info execmem_info __ro_after_init;
>   
>   struct execmem_info __init *execmem_arch_setup(void)
>   {
> +	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>   	unsigned long fallback_start = 0, fallback_end = 0;
>   	unsigned long start, end;
> @@ -132,6 +133,12 @@ struct execmem_info __init *execmem_arch_setup(void)
>   				.fallback_start	= fallback_start,
>   				.fallback_end	= fallback_end,
>   			},
> +			[EXECMEM_KPROBES] = {
> +				.start	= VMALLOC_START,
> +				.end	= VMALLOC_END,
> +				.pgprot	= kprobes_prot,
> +				.alignment = 1,
> +			},
>   			[EXECMEM_MODULE_DATA] = {
>   				.start	= VMALLOC_START,
>   				.end	= VMALLOC_END,


