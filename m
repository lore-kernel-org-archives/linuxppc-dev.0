Return-Path: <linuxppc-dev+bounces-27857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003B3C982EE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 12:53:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpNSQ2kgYz2y71;
	Mon, 21 Sep 2026 22:53:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789995190;
	cv=none; b=h9mF6E+7f+rDEsGMLdc89WCsnMQI7CR2Ljy3kWRIMveyAan7qjzYAYcN7ioft5LbWV65ZnI/9PcP4HGROoKbdDguaG30RdAfKksP0j57biWIBJmMrWm228yYYAZunJep+t995jmPcsQivyRRhpLVWn2rkzhyGLMvdtPJXVwfKivLvYL7YGJhR8EfNgDrHArMrKFNqM5jSWzjw087jgoOXJKmiq8HFxof34resRoC75MY0pQg9uEnh1qwmm+/yNuqf+kuiow+Nz2SLFaLsBq7PRPOfiyaWHwgT2gZ+RdHuTvI80NM8p5iA35q3hOyB7v+0bNbCeoKThqjS1U7bTVyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789995190; c=relaxed/relaxed;
	bh=SzH6oaCFG7t+R6A2JTnhFNipDr4x6RdDll0UxEV89ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYD+lyWb2hh4KrBvfG9FkWgxUihCsjHc+i+NvxEMcYOWV45JpCrP3ihttx/jJJ0vyTtLCbpNXm/UQbLr7nSvq0dnCuXLAg4/ycbmO+MYhdUMwNLqy/dyzg+nUw8ysTrUgJ5YMqwuUtpUBq86XFUpEohd+5SAkUqtUfCGfXO/Jo6QGwCJwr0F1ogqvTOlJ/8acG5cGSrRVsf2GfuvX8qtug6Oe5SKhHDY9a5ZhjGCOHSEz5LoTevu4gx0WlhfI4ZsNaAhV+d4Z0PdfYwGVKkwoFmFs9IJuaDE8BlNjhHVk6OIK6bLC5jfjil2a95dyLwCYyM0vWPVk92klXk3KJR89Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UFZe4bpR; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UFZe4bpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpNSP5Wkgz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 22:53:09 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F87176C;
	Mon, 21 Sep 2026 05:52:34 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E673F86C;
	Mon, 21 Sep 2026 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789995158; bh=K/50ZomrN1bFLTBeeVPhJwuc1yciBmPSu8YX6Qsus9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFZe4bpR5E17t5D1Lm9j6zlnOoMKygimSB1DPY+3+q0C6iJgg+EiBHxg6xnrKV8uS
	 ne9l4ZgvIvWxD6dQ7eM1P+nFVo3S70EXtWpP4Lh2XJhn7wUJFW+NV19QrXwjpC/RJ4
	 gyNTyjuCs5XZdDcvhmAKMYX8J4AXAbctL+YOlquU=
Date: Mon, 21 Sep 2026 13:52:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
Message-ID: <arEojDWvwtMZnmBx@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-4-aneesh.kumar@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921063628.362078-4-aneesh.kumar@kernel.org>

On Mon, Sep 21, 2026 at 12:06:25PM +0530, Aneesh Kumar K.V (Arm) wrote:
> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
> 
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
> 
> Explicit swiotlb= sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

