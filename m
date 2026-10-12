Return-Path: <linuxppc-dev+bounces-29267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E764CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Kw74yH4z3bV5;
	Tue, 13 Oct 2026 01:43:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791816215;
	cv=none; b=jYbSBR01YuOoL6Il/QihqFdELamXj3FdlbjObAgklPjmvO4qr0/B4QT3RK7/Rq3w352LbFsp9ItzRSWvfz/J5g1k/24cR3VfY3BKE8WX3P8e8XqZGflcFEzYN22uhqSJniAZLpIVhqAAWLD0ZHlZRCf13MeThrv1Pxcyzvu4B36SjYYgTZj2vlOgZm5vWv59ILGg8QgOOfKU0634pwcJdjiB2GE/Tz2a5zKI/slpCCuaJF1+btlNGhrQzY77NGpiTYiKUt0Jkyi5TmFKshqHGsBjrELQ0mVAjZoop0Us+o7USiNu2WJfUkfbJh6ZvvdV+F9Rats1n5rV7cVLVQ2f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791816215; c=relaxed/relaxed;
	bh=kQsn0vmJ9Enc8KpOevs5GF67ZaQJBMeRFwUmu6G9Q+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OhTkR7ZZ3MxNL7898h4QEn4NUzyrzGXRTqXrbdZxL4t2AI53JtJwOoeNjkIYzzX3bZKjf9IwyNG0Eafr93mHJsZh4Fd8ppjKaaMItuuPrQ509KUnkzJlZjahIpGTMJopgMx1QaPSiiOR73wEXTZDcD3K1kwKigNDTzDSYr7Y05UfBOz7wAAiaz7L2eQsEShX5UY3oedm3cxmGwQ2vlM4JYpHGI6qgz8a38UYr4N2ezGQbPTzrQxPErMfmCknE4ObDqHcyT8zLST1dm8CtvOHgaM1jrsyMhTVUTPyoSBJQ+vQNFH6Uha3Jrd/6hLzuQtG8YY0VL8uyrF5BUMIh6Hu4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IM1g2mg+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IM1g2mg+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Kw653cbz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 01:43:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 57858601FB;
	Mon, 12 Oct 2026 14:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F02D1F0089B;
	Mon, 12 Oct 2026 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816211;
	bh=kQsn0vmJ9Enc8KpOevs5GF67ZaQJBMeRFwUmu6G9Q+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IM1g2mg+0ZjCqewi5D/5jQ6yvlDnaIY7CfHe3fekAL1P7K2B1Pdazo6RlILpbXA/m
	 OKWqYFRZbakcWW8wvl/IGx3jKOfhx6gG9grJCMyYTTPOO54lwG11SzZLFmYUzoHepz
	 Bifnke+sfu3+fO6tag2ROronuIV/kBdId1F4OR+RJKfkp1MNdS/0oTCG5yW7dFPBz3
	 8Pf5fLzzyjx313sPM1FT9MsaEQoe6yqsWVffDnKvbjyTeb1r8C7W54xPayKybSWynm
	 Go1/udLGAdEhxwHvF3Aq2Z7HlKWiDk2AsjEAtagV7WI5uVTJoAmPH0KF7nRtxv5YPs
	 FLSSDzFuIMwJQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "Sourabh Jain" <sourabhjain@linux.ibm.com>,
  sashiko-reviews@lists.linux.dev,  "Hari Bathini"
 <hbathini@linux.ibm.com>,  kexec@lists.infradead.org,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Michael Ellerman" <mpe@ellerman.id.au>,
  linux-kernel@vger.kernel.org,  "Alexander Graf" <graf@amazon.com>,
  linuxppc-dev@lists.ozlabs.org,  "Madhavan Srinivasan"
 <maddy@linux.ibm.com>,  "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
  "Shivang Upadhyay" <shivangu@linux.ibm.com>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Baoquan He" <baoquan.he@linux.dev>,
  "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,  "Shrikanth Hegde"
 <sshegde@linux.ibm.com>,  "Aditya Gupta" <adityag@linux.ibm.com>,  "Mike
 Rapoport" <rppt@kernel.org>,  "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  "Pasha Tatashin" <pasha.tatashin@soleen.com>,
  "Nicholas Piggin" <npiggin@gmail.com>
Subject: Re: [PATCH v1 2/2] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <20260928084310.10CDB1F00893@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Mon, 28 Sep 2026 08:43:09 +0000")
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
	<20260928083226.107807-3-sourabhjain@linux.ibm.com>
	<20260928084310.10CDB1F00893@smtp.kernel.org>
Date: Mon, 12 Oct 2026 16:43:26 +0200
Message-ID: <2vxzbj8zj7xt.fsf@kernel.org>
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

On Mon, Sep 28 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] boot: late KHO initialization allows memblock to clobber preserved memory
> --
>
> commit 2f581dec390379323e7a0b4e4badb03487eea55f
> Author: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> powerpc: add support for Kexec HandOver (KHO)
>
> Add architecture bits to enable CONFIG_KEXEC_HANDOVER on powerpc. This
> patch checks for KHO information in the device tree before unflattening it,
> allowing a kernel booted via KHO kexec to recover the FDT and scratch region.
> It also moves early_init_dt_check_kho() to be called from setup_arch().
>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 4afaba19b5867..53c2f1897bfe1 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -923,6 +923,8 @@ void __init setup_arch(char **cmdline_p)
>>  	/* Set a half-reasonable default so udelay does something sensible */
>>  	loops_per_jiffy = 500000000 / HZ;
>>  
>> +	early_init_dt_check_kho();
>> +
>>  	/* Unflatten the device-tree passed by prom_init or kexec */
>>  	unflatten_device_tree();
>
> [Severity: High]
> Does calling early_init_dt_check_kho() in setup_arch() happen too late to
> protect against early memblock allocations clobbering preserved KHO memory?
>
> The Kexec HandOver (KHO) mechanism uses a scratch memory region to strictly
> confine early boot memory allocations in the successor kernel. This prevents
> them from overwriting memory pages preserved by the previous kernel, and is
> enforced when kho_populate() invokes memblock_set_kho_scratch_only().
>
> However, setup_arch() is invoked from start_kernel() long after early_setup()
> completes. During early_setup(), substantial dynamic memblock allocations occur
> before KHO scratch memory confinement is enforced.
>
> For example, move_device_tree() allocates memory for the FDT:
>
> arch/powerpc/kernel/prom.c:move_device_tree() {
> 	...
> 	p = memblock_alloc_raw(size, PAGE_SIZE);
> 	...
> }
>
> This is called via early_init_devtree() from early_setup():
>
> arch/powerpc/kernel/setup_64.c:early_setup() {
> 	...
> 	early_init_devtree(__va(dt_ptr));
>
> 	allocate_paca_ptrs();
> 	allocate_paca(boot_cpuid);
> 	... 
> 	early_init_mmu();
> 	...
> }
>
> Because KHO scratch-only mode has not yet been enforced during these early
> allocations, could they use standard memblock policies and overwrite preserved
> KHO memory state, corrupting the handover?

Sashiko seems to have a point. early_init_devtree() (called from
early_setup()) already does a lot of initialization that x86's
setup_arch() does, including making memblock allocations, allowing
resize, etc.

So perhaps you need to move this early_init_dt_check_kho() call to
early_setup()?

-- 
Regards,
Pratyush Yadav

