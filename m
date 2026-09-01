Return-Path: <linuxppc-dev+bounces-26422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C4C624D3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZHCB2Yq5z2y2B;
	Wed, 02 Sep 2026 06:14:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788293686;
	cv=none; b=cEdNvPagxjvNucMhac40dDQiItwS9g95uxGuQV0B9qXTlf7kvGSUUoXnBBUPw2S0ChUJNIH5zs2hA//nc/ifZ0gZr3yyoSTIwyXMDoqWlz4PhPf6GFoO2/EcB0XGP8YucxwNLGpT1KipX2YUvkyzK6jYO0iLvGyaiTz9NFFjKODxcLNRbbaTUv5l44kHR20aFCWtPBcFckcpvjEX6MYC/xD+FRLSkmgUpq7F5Ijh5c+x3fkVxg4PiOfv9vzdysDkGVrGQzJs/cCzYbYl7CoI1mRCTHjEs/YzLrE0UAZnS10aKZbolxNiArCH5fXmUDXJ0aWkpL7rfZ/FSIvvx65zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788293686; c=relaxed/relaxed;
	bh=XYAL/uAoi+EN4roiOHSrXabP2vbnl7qcOw3MP41npbU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nL62jb/LhPvNoVA9tgxvvV0L/jg6m1nk4yFHiqb9MRHOc8YD3Iy7mFYDHdJSFDwxN2C/pZ64k67WzrotOiK+p4sdCG7pjKzZzytDCpvzCFuWO3voJcRz0Be7F1FU6ZS276Y+vPhJm1L6Pg/ZuE5baFjPJYRjrl309aePqnKdskJ7MrEl3VsBteQ1rrZ/qEOA52Dilw/bg4+M9g2hSfs2kVgvcc9tZo+r8IO0XLEWhoQLaes6TR3kGA83v6Dzrd7fOPJoLQdTGj8A+tmzjxKVFB0lb54Ru7GibkddXRNzlb4q0cnPu4kAv4HEp9g4CkX2uUeEtNy+7jR94yrMGpVeLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK7KIXR6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK7KIXR6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHC95JV7z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 06:14:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D443760232;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A11F000E9;
	Tue,  1 Sep 2026 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293683;
	bh=XYAL/uAoi+EN4roiOHSrXabP2vbnl7qcOw3MP41npbU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oK7KIXR6KUMFaGOJIUsL9dZOFAkwrVf2yKPCXU01KHGex01sBreWT258WZzUfcFn5
	 N93Z1YC0ijmCWwzdoNGAU4G9utTIZGp5IgWf8X4H4hbfF5zVWFBqKBg4YeUMPjN0IR
	 GRqaT6bQ/HcAeFBzveARB1bTlhtt6tGhp5xI9YMBwzO/d1SEgK960i+4ONjpEjdAwa
	 7tG2nwlX09g2Zqlhw5BescVjXG5aZz+VId6dbPlddwI3F+7kLFJCguutYFwbYGa2Rb
	 BvAnrQEVhQOr9OmQCQw70saSaDN2Yet3d9/+LJIvw+JtUjv3/nv6xht6k1tPEvBw4K
	 3vqUArPhf7QvA==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/17] crash: Extract crash_get_memory_ranges()
 helper
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-9-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-9-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.10343800427604677653.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index bc087124cd78e..619af312bd9a5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -62,6 +62,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
> +extern int crash_get_memory_ranges(struct crash_mem **mem_ranges);

No need for extern here as well.

-- 
Sincerely yours,
Mike.


