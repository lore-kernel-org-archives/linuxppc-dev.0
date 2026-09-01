Return-Path: <linuxppc-dev+bounces-26420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91114C624D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZHBh62Flz2xmh;
	Wed, 02 Sep 2026 06:14:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788293660;
	cv=none; b=loBCGhXT5bryInaCm3mKd2C+L981vwB6I285k5ITi5su7H/K5ZK0nRepkBlLc1G4UdWQ7gZKYScY8Db62Yb7mzucIpVm6chdfhdF8I95HjOqETBa91zK5ezk7/FTsXhv5pNaM4H5Jqd3qjTe2ukP8WhLYEfYKWeHw0I2oHv/AGs1nE2PzETd3NZpAbpDmCnl2XYxIQekAuOx1F7pMDNfmyil2Bx3zKridQ2cxLnuzgPxWEjUQjwXrP6KhX0Kw8UfhJpuCIfZIuxYVsjSjjBG6ilpnZ7O1ymdUAss3j7So7Rp1L1FHjZXwsqlF6ixPuwCGYAMNXswH51icXw9sF/chg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788293660; c=relaxed/relaxed;
	bh=P2Y/7R1nKNC3hVgJ6HVCLjPdj/LqygKXED195b8rx8I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QefRUwBDAGFMbszePjv7sx3NUWWh35ZvGFywiTx4aHqO+KB3r7tO5tRKKsbBV9R3ZE3AhROTYfKJ4ZQYHSIL261AB6dXaG+eyJuACk3P6ZqWauue/hajkdsqBr/H1F7gmNwr8NCPdfPdBGmjZzoofpdHFoGNtGSEaxu5Sn5r+yGbZJ+XLqy3s1qGp/aingyA55H9D6GhIiDh8F/0GtVzHMkakU//Q0Zs0BF2g3T9CrwtWMokyCNuMpm/Ih14xd4IE75RH/fO5XX/c4ilEFLLzAdmlK1KPOogOP1d+Z6Cue/MKebbGLaxKv1qoDZLau21188SpiPa++Mi7LedgnB9Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEWxDwuk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEWxDwuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHBg59Zfz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 06:14:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 15579401E2;
	Tue,  1 Sep 2026 20:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3951F000E9;
	Tue,  1 Sep 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293657;
	bh=P2Y/7R1nKNC3hVgJ6HVCLjPdj/LqygKXED195b8rx8I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QEWxDwuklcAT5vpT/GCh8/tGOqL9zu9498j8F1chVU2f3pi31jaf21AraJN58Jaqg
	 StWIeODS93d+9LhmpvfaD8yifmXFmiVhcmg/ozsZbRA8KGF5cx2pdfu1sEFrxVrNlO
	 gv4OI7BfxFm9fkfmogqLl/Mllr/LdKuTAFHQsnDraEP2KJ1IOiVoXO0+IzcvwCuWLH
	 kyTvnG7vAo/5CS2uCCGCKN1FNozw6LV7BkXmCcVBXJypXbHZGwXn6L5xH4Qw0A6JaS
	 dNFnHQQDN7G6QsDXd10aYR9/IoAuU7u2pMRh5GFa8NKfwM9bJyjQIcXmoNAx7NRYYa
	 LIxDGeBk/l7UQ==
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
Subject: Re: [PATCH v3 01/17] kexec: Record allocated CMA pages to fix
 release size mismatch
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
In-Reply-To: <20260826092541.3905933-2-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-2-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.12323275610442178748.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> The CMA pages allocated for a kexec segment are released using the
> segment's memsz to calculate the number of pages. However, some
> architecture loaders modify the segment's memsz after allocation
> (e.g. arm64 subtracts text_offset), causing the release function to
> free fewer pages than were originally allocated, leaking the remaining
> CMA pages.
> 
> Add a per-segment `segment_cma_pages` array to store the number of
> pages actually allocated from CMA. Populate it during
> kexec_add_buffer() using the aligned memsz, and use it in
> kimage_free_cma() to accurately release all allocated pages.
> 
> This avoids relying on the potentially modified segment->memsz and
> prevents silent CMA memory leaks.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Brian Mak <makb@juniper.net>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Li Chen <me@linux.beauty>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0af8ae4fdd087..83c296c0eb6cc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -349,6 +349,7 @@ struct kimage {
>  	unsigned long nr_segments;
>  	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
>  	struct page *segment_cma[KEXEC_SEGMENT_MAX];
> +	unsigned int segment_cma_pages[KEXEC_SEGMENT_MAX];

Can we universally use unsigned long for number of pages?

>  
>  	struct list_head control_pages;
>  	struct list_head dest_pages;
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..611b15bb1369e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -560,7 +560,7 @@ static void kimage_free_cma(struct kimage *image)
>  
>  	for (i = 0; i < image->nr_segments; i++) {
>  		struct page *cma = image->segment_cma[i];
> -		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
> +		unsigned int nr_pages = image->segment_cma_pages[i];
>  
>  		if (!cma)
>  			continue;
> @@ -568,6 +568,7 @@ static void kimage_free_cma(struct kimage *image)
>  		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
>  		dma_release_from_contiguous(NULL, cma, nr_pages);
>  		image->segment_cma[i] = NULL;
> +		image->segment_cma_pages[i] = 0;
>  	}
>  
>  }
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d86..bfae3fee7f2f9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -670,7 +670,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
>  
>  static int kexec_alloc_contig(struct kexec_buf *kbuf)
>  {
> -	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
> +	size_t nr_pages = PFN_DOWN(kbuf->memsz);
>  	unsigned long mem;
>  	struct page *p;
>  
> @@ -756,6 +756,8 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   */
>  int kexec_add_buffer(struct kexec_buf *kbuf)
>  {
> +	unsigned long nr_segments = kbuf->image->nr_segments;
> +	size_t nr_pages;
>  	struct kexec_segment *ksegment;
>  	int ret;
>  
> @@ -763,7 +765,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	if (!kbuf->image->file_mode)
>  		return -EINVAL;
>  
> -	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
> +	if (nr_segments >= KEXEC_SEGMENT_MAX)
>  		return -EINVAL;
>  
>  	/*
> @@ -789,12 +791,18 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  		return ret;
>  
>  	/* Found a suitable memory range */
> -	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
> +	ksegment = &kbuf->image->segment[nr_segments];
>  	ksegment->kbuf = kbuf->buffer;
>  	ksegment->bufsz = kbuf->bufsz;
>  	ksegment->mem = kbuf->mem;
>  	ksegment->memsz = kbuf->memsz;
> -	kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
> +	kbuf->image->segment_cma[nr_segments] = kbuf->cma;
> +	if (kbuf->cma) {
> +		nr_pages = (unsigned int)(PFN_DOWN(kbuf->memsz));
> +		kbuf->image->segment_cma_pages[nr_segments] = nr_pages;
		kbuf->image->segment_cma_pages[nr_segments] = nr_pages;
> +	} else {
> +		kbuf->image->segment_cma_pages[nr_segments] = 0;
> +	}

I suggest to rename nr_pages to nr_cma_pages, initialize it to 0 at
declaration time and make this

	if (kbuf->cma)
		nr_cma_pages = PFN_DOWN(kbuf->memsz);
	kbuf->image->segment_cma_pages[nr_segments] = nr_cma_pages;

-- 
Sincerely yours,
Mike.


