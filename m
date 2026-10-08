Return-Path: <linuxppc-dev+bounces-29023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0031CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 06:42:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0gRG1gsYz2yYK;
	Thu, 08 Oct 2026 17:42:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791441770;
	cv=none; b=OKD8xupMUKonVmOicc+/f7DTy7YjJmC6vTMQ6VZrdti4aeUyS+gR/hf5D0nwGbsataHs5o5TmJo00ywa4dz8m2hYDmEtHS+YRwUYa4JcTdjpU3Ogob5t/OkHWi+zmHGAIsugBRiYPagaFQ4SJtsYDqPO6bwjp8BOaLmDm8Hjn9DuXNtZ0oMuVqRE61zbt9hlb/2MGOg1ppt+nn+Q6lKxbDjNZ4JUnSwcH5sHt5UdVLLKgd/y4tyBk0j1x5W5J/AtyFA88OGRCv0aWh2xk+sBdpeFaoY7Owm3MLHTjjtFd0wsqygHdhJ8moDFwp/wSntfMmE25E2iTxvHbqW2l8SXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791441770; c=relaxed/relaxed;
	bh=QYjlbETRxQW9RMjfplUAnmTLI8vDWVyFt6dBT1ysNAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKfrT3T2qiq+umNp7u70+LwqoDhH7LoyD7u0fnceugjy5ARoxz41XUAmkzQUjkCIyWUA551l8GntlcWsvPzNS3nL8+WTD4oNt/4hiPQmRP0XAZ9qj1jFlDtOFBBbzjPnKOvu6soisBMazft9rLjIRHLWMYwdn9UoGepwuDGJx2OeHxTcNE+fkN01mLzLitN4z9cK4bq3uG6obn0QT2BEWzHrIK+eORMI0jQ9Ep/XaZRd5LhQJiC2fH0Xqnalu5UfS8nM9Fqcx0ZIv3hwIDAFh+ysTNdtqazzIOfLF/7b6knLa4UjXOAC1JdZci/ArKdj+fdWNijPd0UIfs1e07TvIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzwrJChR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzwrJChR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0gRD4T1kz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 17:42:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EB1D41836;
	Thu,  8 Oct 2026 06:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9461F000FF;
	Thu,  8 Oct 2026 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441765;
	bh=QYjlbETRxQW9RMjfplUAnmTLI8vDWVyFt6dBT1ysNAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzwrJChRSmVjEsRakCz7KZMyALTXRiMMTQqt+Pq1DfhvTRhANdPa2qsjY85CoeKmU
	 +smyn7Lotjz8Z+6My1XtXdRcAWv0Bk3+so9601+yHD0hXOPoxrMliq4uNlyMYvPyEN
	 /KxKGNEGsRLbC5gh5Fpx/irufkYMSkObZy2nAEfpl7+01CgTBFC4KUpi+Rt44aL8Zf
	 NTIbo4/T2UBb6sZftaMcHpGWW78wNUfUZX3n+aegjkdkvaCrfhtnmdLmCzyRFXWi5O
	 KzhbRY6JsNtjGiT0SU3GKlmfmu9GhVSnGRLyWq6PEohhumSDv1uECF+lTxE7sLA503
	 DyPwUh9lm6nsw==
Date: Thu, 8 Oct 2026 08:42:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, leitao@debian.org, yeoreum.yun@arm.com,
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com,
	kees@kernel.org, tangyouling@kylinos.cn, liukexin@kylinos.cn,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn,
	maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com,
	vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com,
	thuth@redhat.com, jbouron@amazon.com, me@linux.beauty,
	mclapinski@google.com, graf@amazon.com, bgwin@google.com,
	hbathini@linux.ibm.com, eric.devolder@oracle.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	palmer@rivosinc.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	driver-core@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
Message-ID: <asc7UdlRsy7502j8@kernel.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>

Hi Jinjie,

On Thu, Oct 08, 2026 at 09:57:30AM +0800, Jinjie Ruan wrote:
> 
> 在 2026/9/21 17:04, Jinjie Ruan 写道:
> > As Baoquan and Catalin suggested, this patch set fixes
> > several pre-existing code issues found by Sashiko AI [1][2][3].
> > 
> > The major improvements and fixes included in this series are:
> > - Fix several memory leaks for arm64, and similar issues on LoongArch.
> > - Fix out-of-bounds write on 32-bit Highmem for x86.
> > - Fix TOCTOU race in crash memory range collection.
> 
> Hi all,
> 
> Gentle ping.
> 
> Could anyone take a look or let me know if there's anything
> else needed? I can rebase/resend if required.

Sorry for the delay, I was travelling for the past few weeks.
I'm planning to review this next week. 

And we do need acks from arch maintainers for most of the patches in this
series.

> > Jinjie Ruan (14):
> >   kexec: Fix CMA segment address translation with non-zero text_offset
> >   kexec: Record allocated CMA pages to fix release size mismatch
> >   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
> >   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
> >   arm64: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
> >     loops
> >   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix a modified_cmdline leak
> >   x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
> >   crash: Extract crash_get_memory_ranges() helper
> >   crash: Factor out crash_find_elfcorehdr() helper
> >   crash: Normalize the kexec_load elfcorehdr at load time
> >   driver core: Add device_hotplug_lock_assert_held() helper
> >   crash: Fix TOCTOU race in crash memory range collection

-- 
Sincerely yours,
Mike.

