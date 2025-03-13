Return-Path: <linuxppc-dev+bounces-7023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93ACC35FF3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDNX52P7Mz3brV;
	Fri, 14 Mar 2025 10:10:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741907445;
	cv=none; b=FXjeUAAUWSM3h96IF9GhNIkMwL305OAMj7G38t2I5om9NNoaePdixL9mqQ+Z3B0KhV4reBv+8+6L8tK8op9BqHcfGj6l+KuuO/nPQqzBJ0XbRcs5lnSWHmb6UembnuCUEM1Nixl67YOKi5KJXlwsyHpQZ0iFLYsj8pIYLxiCzQ+RjdeaJmwgErog7Df7aoWtWPdlo2dkq9gVoIUyGgff6b/DdpdkGhCPdv+ZJnHn/ravF5XPdSfhRXWPfwX1ERfp1FM2iT4CYILbAz+oDO8SYqem83vphBkApw3gycU6fY/er+GoK5INySp9d8dZ0RAGNz5p1Fnta3WDl1tOLR/XeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741907445; c=relaxed/relaxed;
	bh=uQsUOg9Wl3GBkj34Pd/P8J4rXOI9TTuELe3xCAfOaXs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YJwy1KCyAWalHbrjm0D6p7dq+uyInlvugliKxKD4gWJufoPj7AvLaLxjBEK5Trs8dhzDLhb9MRxkaF9FkURWZFylmPBdc3+YARfN+us5H3fGk/kns+XOdN9BneEYrVWcV6G7h75DcdmnXFB+PyiJ5wRwRMyxELk/f1i3/od1OhUE85uhn5j1ry6/cf2HDRMkqWC+JZpx6h4mzHAId2fiECstN8EnkyOZSxJAXf5o8CT2VBITch+c4ir4rxOxqxYtyqpD2gzziCLUyExLikzeVEzPrTI8+vz+4cm6ZiH/hKkSW0335MkqCeBPRJuzaVpiG1Wy3ApFQMNue4Kn9AY3GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=r1LbO++h; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=r1LbO++h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDNX4084Bz3blH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2025 10:10:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5C5095C0F92;
	Thu, 13 Mar 2025 23:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839ACC4CEDD;
	Thu, 13 Mar 2025 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741907439;
	bh=85C5EaLBPcNm+VfXMxlgckNkHScFkxqfwrT4hbCXaS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1LbO++h2zt9ITOCp8zaBNp5bCW3oO8IYrW9fm3oZilRLz2OfzDBHOVialXmivLvD
	 bsPejXMhoq8EeEH1UfZGgQO5BcyfMZ6opeDWAKOUunCcWeso9WZv2uAjmotrBYRJrB
	 wRsd1Lld8tuszHDkPkn9GPUZwcBYsR4A0hlP64N8=
Date: Thu, 13 Mar 2025 16:10:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me
Subject: Re: [PATCH v13 04/11] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pud_clear()
Message-Id: <20250313161038.8bd10fa54778e984d8f849d7@linux-foundation.org>
In-Reply-To: <20250211161404.850215-5-ajd@linux.ibm.com>
References: <20250211161404.850215-1-ajd@linux.ibm.com>
	<20250211161404.850215-5-ajd@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 03:13:57 +1100 Andrew Donnellan <ajd@linux.ibm.com> wrote:

> This reverts commit 931c38e16499 ("mm/page_table_check: remove unused
> parameter in [__]page_table_check_pud_clear").
> 
> Reinstate previously unused parameters for the purpose of supporting
> powerpc platforms, as many do not encode user/kernel ownership of the
> page in the pte, but instead in the address of the access.

My x86-64 allmodconfig exploded.

./arch/x86/include/asm/pgtable.h: In function 'pudp_establish':
./arch/x86/include/asm/pgtable.h:1443:46: error: passing argument 2 of 'page_table_check_pud_set' makes integer from pointer without a cast [-Werror=int-conversion]
 1443 |         page_table_check_pud_set(vma->vm_mm, pudp, pud);
      |                                              ^~~~
      |                                              |
      |                                              pud_t *



#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
static inline pud_t pudp_establish(struct vm_area_struct *vma,
                unsigned long address, pud_t *pudp, pud_t pud)
{
	page_table_check_pud_set(vma->vm_mm, pudp, pud);
	...

