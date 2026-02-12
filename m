Return-Path: <linuxppc-dev+bounces-16843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A426EE3691
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBdNN2MxSz2yFm;
	Fri, 13 Feb 2026 01:44:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770907444;
	cv=none; b=WeYnadOZuiSdcHrFnkbqJRIMg5Nf6qmXMwdrs3NPpZcW9WlNPkNpXidlyQ3WEtisX1zsxXKxMNR9CMXNUMtI1oFDKKJ+TEb/ouXLwb90gY7TMO7xX6kpQ54vyK40mXxwwT2Butzaiidoe04ByRHsCqswwMU7E1eu3VKp9xAU0zR5HvbbUmrAnwCe2KY8IH5IqNVV/etmusKFI8MlqUq4JRL9zNuW9CkZSBJm+KGyYqWUHfBAM+9URk8JMGwvaCUry3MITaT8BOU9/rUpQCSMhJy3PWE9wW/Dq5JBD2jIxOfqGvXZDKKw2Cm3EYtfiHHJCV6HRReznYevtFbyO2eeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770907444; c=relaxed/relaxed;
	bh=4QNE0rmrVgUNOHM54Q6+KXIw9mcgEQxg8vQIoBdEY9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPjgDfMAZt2wt/LUfOX3LLllXZq9PO6mAIFPeMUfJKX3spz2uKwka1D4rwexCOwlWK+KrhQi6Fos4W9UWGLnJpAfr1nQIHLzwvk1brM8UTl9LY62cNIq9Ex0/URoOXzMS5GwnYfBYreHZPyCgLJc+nipLqFYxIPaVA6XSXvCivh79vLc1r29z+ZCSiSPpD9EWs47ONE2INQMcGqe4/Z+Wr4VkyFn7AVlwqD4TW1Fgw4H7Sl8QZe2iAwwLzu+Rn52gDsNHOw0WhRch0DWdxHpVjkz8yKm8bFOmAYFfkJwtzr9B6iFpa9Hlcorti4joYjwcdiU11lb6CVGgNUAbXxJgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ko6YX0yE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ko6YX0yE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBdNM1R7nz2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2026 01:44:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DEA040A48;
	Thu, 12 Feb 2026 14:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E60C4CEF7;
	Thu, 12 Feb 2026 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770907440;
	bh=JgHytrfIoVHvSrB+ZHqvgP9qOCOR6LftqPuUXmXPewE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ko6YX0yEFe4E0jrbp3XxgX4zcX+pt5kKGo3qsoUNXAjP6BmajfjaWMR7EZwObD3mv
	 RaQE4z+0+Y4Gvw1ciyp3sCoy9AWoV51k6SCkkX3HI2r8w9NGPYJAIaOZZnUH2/CyAt
	 FCBngxnZE5xc2/k3bOXFQAM1G/mpwsKy3pmOJK8ljYA+CUHAY9etU2AWnTdKmHe6kI
	 HZlhRcgRSjONrL5wCWjVGmpSaYyE8ivrPjr5pZvM5QJmgaMHdUy9DFX0Ke6voUeoPk
	 feWHia6y6PLrBYPJdAa4URtO8gt/Nen7sw+LzrielacYjoBKTAX8sR6v3rAfEPlgAn
	 olPDejjZ8fPrA==
Date: Thu, 12 Feb 2026 16:43:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	kees@kernel.org, elver@google.com, paulmck@kernel.org,
	arnd@arndb.de, fvdl@google.com, thuth@redhat.com, ardb@kernel.org,
	leitao@debian.org, osandov@fb.com, cfsworks@gmail.com,
	sourabhjain@linux.ibm.com, ryan.roberts@arm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, bjorn@rivosinc.com,
	samuel.holland@sifive.com, kevin.brodsky@arm.com,
	junhui.liu@pigmoral.tech, vishal.moola@gmail.com, dwmw@amazon.co.uk,
	pbonzini@redhat.com, kai.huang@intel.com, ubizjak@gmail.com,
	coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	brgerst@gmail.com, jbohac@suse.cz, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v5 1/4] powerpc/crash: sort crash memory ranges before
 preparing elfcorehdr
Message-ID: <aY3nGuredkMTCZIm@kernel.org>
References: <20260212101001.343158-1-ruanjinjie@huawei.com>
 <20260212101001.343158-2-ruanjinjie@huawei.com>
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
In-Reply-To: <20260212101001.343158-2-ruanjinjie@huawei.com>

On Thu, Feb 12, 2026 at 06:09:58PM +0800, Jinjie Ruan wrote:
> From: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
> the removed memory. While updating the crash memory ranges for this
> operation, the crash memory ranges array can become unsorted. This
> happens because remove_mem_range() may split a memory range into two
> parts and append the higher-address part as a separate range at the end
> of the array.
> 
> So far, no issues have been observed due to the unsorted crash memory
> ranges. However, this could lead to problems once crash memory range
> removal is handled by generic code, as introduced in the upcoming
> patches in this series.
> 
> Currently, powerpc uses a platform-specific function,
> remove_mem_range(), to exclude hot-removed memory from the crash memory
> ranges. This function performs the same task as the generic
> crash_exclude_mem_range() in crash_core.c. The generic helper also
> ensures that the crash memory ranges remain sorted. So remove the
> redundant powerpc-specific implementation and instead call
> crash_exclude_mem_range_guarded() (which internally calls
> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec_ranges.h |  4 +-
>  arch/powerpc/kexec/crash.c              |  5 +-
>  arch/powerpc/kexec/ranges.c             | 87 +------------------------
>  3 files changed, 7 insertions(+), 89 deletions(-)

This looks like a nice improvement!
FWIW

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

