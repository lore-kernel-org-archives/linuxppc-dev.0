Return-Path: <linuxppc-dev+bounces-26040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0AFC5DF87
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 11:56:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJgX0ng2z2yDs;
	Fri, 21 Aug 2026 21:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787313400;
	cv=none; b=ihYrafnutclOxytS+zA5vPHmPQ8nd6wvK5Hgh9kuawL6EH/XcIj3kFuW3KxS2ksnmionW7i2c8kiW8XniiXS/v1HjUFTEgIwJTcTfaDxRMekPDF6sbxzG1xj9DHPgBaYvH37IabPWlcNyhybknj9vfPxc98yTGL6tlDzaI1l04zS7yfrC3Cq648UHH9TKo/eI5UXrC98Ag4gVv74bPace4QDTfTfSaKUepLyhG4WF+eoN3SNbBH13ToePAoOyVGXzGQrcRUq6wG7uBGOMpSyrvtwQ3/UHF1df0V0AY+giNymkUmIiV34vbEJcA7oSFTqCh+wd8GHFoY0uahN4XnYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787313400; c=relaxed/relaxed;
	bh=T/nW1BCc6K6NF98RkjC+qK+gveVrIp2Ec0sQaOBBYEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cr7fsUsq1e2w6pO46rxnoSKfau9d5iu0g+bBqlqogd+XImKu7ZTVYFaWb81sY5shIk87TXRRBJbwo/l8NYGUnQDMvzfuiXaqzltNOXjg86rKv2kjWvHkFE5POe83n9ndpn34MitwRcL+sAGCtd5x5puxw0x318tUJgNtreiKEgtrolDOykAOP1KMVbpcrnvj367+OjNfhJ5P0ZnekzBCaQDRa33DKeSJC6C09b9aQaCp17r3+wnhCaaH0tW5/0G6Vo8dZgImf0I8urvZktSX4bVRAsXv2vjqIy/wD2HOOQHXwFSBreY8u91qGgM4W2loaebffAow9UUfOc8S2fk9Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjX6NrjC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjX6NrjC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRJgW155Hz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 21:56:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D88460008;
	Fri, 21 Aug 2026 11:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4241F000E9;
	Fri, 21 Aug 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313396;
	bh=T/nW1BCc6K6NF98RkjC+qK+gveVrIp2Ec0sQaOBBYEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IjX6NrjC3RkHO/JFhPapADIOyk+E1jBkTDgGo0GoE7ZhEPRwowskKlbDKrR8KzKHH
	 NY3WAiCrMWRBsUCCS4MDbfGefLGO40A+TsC75fti1YW5L7xF9zfV8l3GSHCqJrXA+k
	 ZvtdiaBXqxEmH5FkpkZ8pGtgcg3sV5ka+qHmfDChqTXrrFbzjw7BMvU3qdl7eEzE1Y
	 kTQPwpx0hfxx02L9V8Y/0q3FHrig8/mWBunoUnba/u2+RLamaV+V4o9ePaTGLoEhTC
	 afJTsCDPTUqbv3C26AEi9nsLinowo1aSZ5RFmPj/WhbIyxiP6Ar/g5AQOxqJdgCrDc
	 J89yfPLdeQOyw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,  Aditya Gupta <adityag@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Mahesh Salgaonkar <mahesh@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Mike Rapoport <rppt@kernel.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <20260821105609.983622-3-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Fri, 21 Aug 2026 16:26:08 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-3-sourabhjain@linux.ibm.com>
Date: Fri, 21 Aug 2026 13:56:31 +0200
Message-ID: <2vxza4qfznyo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 21 2026, Sourabh Jain wrote:

> Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
> powerpc.
>
> Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
> pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.
>
> On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
> properties from /chosen and pass them to kho_populate(). This lets a
> kernel booted via KHO kexec recover the FDT and scratch region left
> behind by the previous kernel. The call is placed early in
> setup_arch(), before unflatten_device_tree().
>
> Open issues:
> ============
>
> This patch also adds "depends on !CRASH_DUMP" to
> ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
> conflict between crashkernel reservation and KHO scratch reservation
> on powerpc.
>
> Crashkernel memory is reserved very early in boot, from arch-specific
> code: head.S -> early_setup() -> early_init_devtree() ->
> arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
> region is reserved later, from generic code: start_kernel() ->
> mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
> memory is always reserved first.
>
> This ordering causes a real failure. In the common case, crashkernel
> reservation on powerpc starts at a 512M offset (the exact offset can
> vary, but 512M is typical). So with crashkernel=3G, the reservation
> occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
> 4G area.
>
> Since crashkernel reservation always happens first, that 3G is
> already committed by the time kho_memory_init() runs. It then tries
> to reserve a low scratch region sized at 200% of whatever is already
> reserved below 4G. With ~75% of that 4G area already taken by
> crashkernel memory, 200% of that easily exceeds the remaining space
> -- and since the low scratch region is itself capped at 4G, there's
> no room left to fit it. The reservation fails.

crashkernel has the variant "crashkernel=size[KMG],high", which ensures
memory is allocated above 4G. Unless powerpc has some requirement for
strictly having the crashkernel below 4G, I think it will make a lot of
sense to enable support for this feature. So KHO users can specify this
to get crashkernel working with KHO.

Powerpc doesn't support this right now, but from a quick skim of the
code, I think it should be simple enough. From
arch_reserve_crashkernel() you just need to pass a bool * to
parse_crashkernel(), and then pass the result to
reserve_crashkernel_generic().

Solving the ordering of crash reservations and KHO is tricky and comes
with some difficult tradeoffs. Allocating crash from highmem should be a
lot simpler.

And on that note, I don't think you should do a depends on !CRASH_DUMP.
Even when CONFIG_KEXEC_HANDOVER is enabled, KHO isn't on by default
(well, unless KEXEC_HANDOVER_ENABLE_DEFAULT is set). You need to enable
it via cmdline. So it is entirely possible for people using KHO on PPC
to not use crash and vice versa. This decision can be made at deployment
time, not at compile time.

>
> To work around this and get KHO working on powerpc, this patch:
>
> 1. Makes KHO usable on powerpc only when CRASH_DUMP is disabled.
> 2. Calls kho_populate() from setup_arch(), so it runs before
>    kho_memory_init() reserves the scratch region.
>
> The real fix would be to reserve the KHO scratch region before
> crashkernel memory instead of after. But scratch reservation happens
> in generic code (kho_memory_init(), called from mm_core_init()), so
> this isn't something powerpc can address on its own -- it needs
> discussion on how to influence the ordering between generic scratch
> reservation and arch-specific crashkernel reservation. This patch
> doesn't attempt that; it's meant as a starting point for that
> discussion.
>
[...]
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..61350d3e7a19 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -716,6 +716,11 @@ config ARCH_SELECTS_CRASH_DUMP
>  	depends on CRASH_DUMP
>  	select RELOCATABLE if PPC64 || 44x || PPC_85xx
>  
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool y
> +	depends on PPC64
> +	depends on !CRASH_DUMP
> +
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y
>  	depends on PPC64
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 4afaba19b586..1fee743abdf2 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
[...]
>  }
>  #endif
>  
> +#ifdef CONFIG_PPC64
> +static void __init init_kho(const void *fdt)
> +{
> +	unsigned long node;
> +	u64 fdt_start, fdt_size, scratch_start, scratch_size;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
> +		return;
> +
> +	/* Find and verify the /chosen node, same as early_init_dt_scan_chosen() does */
> +	node = fdt_path_offset(fdt, "/chosen");
> +	if ((long)node < 0)
> +		node = fdt_path_offset(fdt, "/chosen@0");
> +	if ((long)node < 0)
> +		return;
> +
> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
> +				      &fdt_start, &fdt_size))
> +		return;
> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-scratch",
> +				      &scratch_start, &scratch_size))
> +		return;
> +
> +	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
> +}

This looks pretty much a duplicate of early_init_dt_check_kho(). On
arm64 this is called via early_init_dt_scan(). But from a quick search I
don't see powerpc calling it.

Would it make sense to call this function (or
early_init_dt_scan_nodes()) for powerpc?

If not, I think it would be a better idea to expose
early_init_dt_check_kho() and call it from powerpc setup_arch() instead
of duplicating the logic.

> +#endif
> +
>  /*
>   * Called into from start_kernel this initializes memblock, which is used
>   * to manage page allocation until mem_init is called.
[...]

-- 
Regards,
Pratyush Yadav

