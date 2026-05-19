Return-Path: <linuxppc-dev+bounces-21141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B2CD343F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 02:57:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKK8L41sgz2yCM;
	Tue, 19 May 2026 12:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779159426;
	cv=none; b=eDFzI4JuFezUMduOehKGrqwy8rhxMzC0ZIBH49VB9Voza4sxkgDSUAB9TfzpMfPeJA6gAxiVeYM+upsTI+owAFchRjwnVFFZmao1gP4GDVVtBr7Lf2VE8HFmuFS3DvURURlwseh6pX+6PLS6R/aJs2rpqDDP6mS+/A2hoP8nRnF1ivfd1cls5llkKhLt88gJxlh2/Qjfz5EkJm+Y8392Q9p000iuh6kCG5XJVvmUxfXAN92Xzbbro5+rwckv68MpYvYLyZhfDCqirU9QJV5WpD/4I3RMNZKMvzYCXm1XViF0Pl+nR0hdHiNn4E+mwIL0R1+CRrnKvrqWbiogN/MH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779159426; c=relaxed/relaxed;
	bh=VZEPDE0JhFiHBzsJZnEnOmNR0XlNNMR93C5REwadzXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z45dceW2M45m/2g11/3lcJVhSuBGY9/BluDFtds6DK15JTSohcHLWo15Ug8Pztza4sJKXka7ubfctxwjGrJy29jn454ctpRZi/aklv4KiPNCSLa43169ZR1pn3/8EgwYLE66+VRs0V94pUQhuiu/sq5cgjpIMsHpmxx/CiiU+gX5fBBrh/BMVW4fC8biD20SyepqX3TDuGrMlkN3J4p90wulPdx5QeMtuz/sdUx5oQWrxFRS17HELS4w5kax4KclylLfNBE0HHsuhQg6Zx4bOVKzQgwzE7tz1R86/aVrVueqHNTBmJe0w2ysF6JNAJSnwmirN5hMD0B46cpjuTpFSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nchkEYj8; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nchkEYj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKK8G1M8Fz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 12:57:00 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779159399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZEPDE0JhFiHBzsJZnEnOmNR0XlNNMR93C5REwadzXo=;
	b=nchkEYj83AaVfsUXxCl0AvZUaid1ISLjmEkYTd42iifdpzigk+RxNSzNQL1fmc2Ovg+CLs
	YCNmlMQHYag98UVdCm749EKUrnTkj4xmfprGZEpQ0YK2u4pxGj2UrZMgCdcEuVc9k/mZak
	7n1ZXHcwCLSVdvfIS5AVfaO+KMbAozc=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 3/8] mm/bootmem_info: stop using PG_private
Date: Tue, 19 May 2026 10:56:31 +0800
Message-Id: <20260519025631.71942-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:31PM +0200, David Hildenbrand (Arm) wrote:
>Nobody checks PG_private for these pages, and we can happily use
>set_page_private() without setting PG_private. So let's just stop
>setting/clearing PG_private.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index a0a1ecdec8d0..6e2aaab3dca9 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
> {
> 	BUG_ON(type > 0xf);
> 	BUG_ON(info > (ULONG_MAX >> 4));
>-	SetPagePrivate(page);

Right, the users classify these pages via PageReserved()/bootmem_type(),
not PagePrivate().

So makes sense to not set PG_private in the first place.

> 	set_page_private(page, info << 4 | type);
> 	page_ref_inc(page);
> }
>@@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
> 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
> 
> 	if (page_ref_dec_return(page) == 1) {
>-		ClearPagePrivate(page);

Nothing sets it anymore, so there is nothing to clear here.

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		set_page_private(page, 0);
> 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 		free_reserved_page(page);
>
>-- 
>2.43.0
>
>

