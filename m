Return-Path: <linuxppc-dev+bounces-22289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE08CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 19:00:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ1b84hYqz2yS4;
	Tue, 09 Jun 2026 05:00:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780945252;
	cv=none; b=gzfQHDig+oCAoOzs+p1eF6xG8FyDU6eULZ2/jUrbFZWpTdN0GLB/iEIg6rwxTFnpALhWCY/GCcWC3rgF5F1l9zDxcm7+eTyAdASZYqpQ75/Mf3dvHZ997roRpqdcHpGfAy4WWhNFAL/RT9rCAIF12px9grPjYevB9ZNLEwdiVVaAXb9k92K/0FpocSjipOlyiUp4p+Jh39foXl67ZLaq0cBVxJHUxGjyKyviEbtR4+siVMwvN9CNeiir3+/nBhgoQTGa1jY3sjgawfQNn3XGwzr4tLeryF/dOPQkow4VpXmvVj45WtqcsoAfhR773wOGpAwyjHP9/KQrUMUhBLZ+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780945252; c=relaxed/relaxed;
	bh=BoJRT4fDwZJIZj1sKJWduqL1Uc3KtHVy4pz1d5Skq5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g20YgpfuF1kYlNLpV5Iq/GF9FoXX8HEtmAs0lNKfcQ5WiUQaiG5CS0oA8HBT27duOlBSt+yA4mQ1NOcCIrIVaQr1vb7VZUIog6lDVX4OOPRQEizYi3Iay3FqOXDyWUZ5dclgtAELWi9P/7VUkGNaX30lftxw+MPLCj4iywnpOLQ2iVnwMm73XUBYLHVMmINAqwDKRi235Bzq1aICGFznj39Z0xbccnHMiZl+0WEOcIAOj4sv8+rOvDs2xDM88HsXckI0tXVD8x0ERLd13QYZTxZgAW/aiCFgtQZ4+kXx6UM0AXsnJZJ67lWUoCpLZhe+rkkuu6GgSXHasn2xUGbHCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfHoG14j; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfHoG14j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ1b42hP0z2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:00:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FA2A43B45;
	Mon,  8 Jun 2026 19:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086C71F00893;
	Mon,  8 Jun 2026 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945245;
	bh=BoJRT4fDwZJIZj1sKJWduqL1Uc3KtHVy4pz1d5Skq5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KfHoG14jTkmfniNdtVxNENuQMvpWd/NiZFxhjbAOH2qflTZKJQmKrpo5v28Wi+WAs
	 KVXrcoLV9U6kz2x6PapzUAFAESu9QX1LfppzjVC8N46Zjz4Z7sNH1yZ4d/WStaY/Db
	 /X0KZN7bD6W6UX1cOzLU6ci7UDbYfFPVdFgj4ieVJdmN5wwduOPBAUYDy3CVZ0PKTV
	 7jDWA8qALbwrzMysH63nL/ognc+jgZzyQkks66irzQLutLZp6uiVnUjco/Ovf8T61F
	 Hl+i3nfOLaRFfs63ImgogaFfuCOgrM1qeCvRY3e4N9d9jlLv5gNamEcIoZ6c2B1GDW
	 t1bYS9/awuJHw==
Date: Mon, 8 Jun 2026 22:00:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, bhe@redhat.com, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, rdunlap@infradead.org,
	peterz@infradead.org, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org,
	paulmck@kernel.org, leitao@debian.org, coxu@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, osandov@fb.com,
	jbohac@suse.cz, cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	adityag@linux.ibm.com, liaoyuanhong@vivo.com, seanjc@google.com,
	fuqiang.wang@easystack.cn, ardb@kernel.org, chenjiahao16@huawei.com,
	guoren@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <aicRRrAmuCkTI68e@kernel.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>
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
In-Reply-To: <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>

On Mon, Jun 08, 2026 at 09:10:00AM -0700, Andrew Morton wrote:
> On Mon, 8 Jun 2026 15:34:49 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
> > The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> > and crashk_cma memory are almost identical across different architectures,
> > This patch set handle them in crash core in a general way, which eliminate
> > a lot of duplication code.
> > 
> > And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> fyi, AI review might have found a bunch of issues in arch-specific
> code, all of them pre-existing.

v15 grew to 23 patches because of them and Baoquan suggested to split the
fixes into a separate series.
 
> 	https://sashiko.dev/#/patchset/20260608073459.3119290-1-ruanjinjie@huawei.com

-- 
Sincerely yours,
Mike.

