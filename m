Return-Path: <linuxppc-dev+bounces-21073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5040DCD4F48
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 07:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqj00PqKz30FP;
	Mon, 18 May 2026 17:50:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779090611;
	cv=none; b=FM7jbps5isHxsXUscCK2zL7zIsry/aI4VhnlDHMjAiTCj35DkiYy1Ob1YxsRXFqZutorzZvrhh44xmswOt8GIDsBCc1Gpo+goyaIyfUWWlQBEtqqSQlDLrOdtm+2wkhg9WwwrXSpDKFG6cgLDZN+Elq8Uh7JI95Eam0i73/5MlMKrUlq3TME0MBAsOXW9ytKrjcz1Vl5UuHiYr64JUj8JkNsB8+HxNTbSwsqqddw1tgMsfOkw2L8iJJaGf73ekfhYoOkwN6WH8nUNL+hvZEzmgCg6BIR+Yox+rSJymPGRjo/1nUMj5V+Ow0ln2B/ei0NOgm8jUym+QFOU0+DbjgZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779090611; c=relaxed/relaxed;
	bh=fTTRIuI2xioXcBOay/WhZ57PMiS4AlcVkZHDZZirdOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4UAAqVPSuEq1XF8Hf9TTJiO9QrBUjrgHKoOcYGoxUxY51YUcxQCdXGaqAcNB8+A69KZrhANahPYcsjjjJ2Wie5Y+9E+MbikfhbQHQKCTauTo+fiC3GPkc2qfX+3R2NFAZqHDh9SKCYWGZsVliLIc0yPqtiW7FXpTIcZ0i6jYIM6FeCimPb1EnyKvEGv5ClimqVJM/a4rAmItheiTJcZMtaUEEUkNFWsOFVJN+tTQcMcSozcKIguzCWOdueCTNuY0m/zjwmiWaiXvq9/un5gsYqfQhdXVbmJ6+3bzO5uiLs/ipz0BeF8+R57khxvftiAq2vqk2JqYvtpNUgn1jAumQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sQA9gAlm; dkim-atps=neutral; spf=pass (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sQA9gAlm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 3269 seconds by postgrey-1.37 at boromir; Mon, 18 May 2026 17:50:09 AEST
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJqhx1ffYz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 17:50:08 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779090587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTTRIuI2xioXcBOay/WhZ57PMiS4AlcVkZHDZZirdOs=;
	b=sQA9gAlmLXajI0q10KUnEdN1uuZqCxucU3NRWLlR3WCTWt4IvAIwwMmL9Yv6cg1ak9LTUk
	GcZJgc51RUZJ7q5loEHLNQ7RZ6YM5RGuq2Q/7SkVZott8sl3sIvYYq4EpVgjv3FmqR41gO
	tjAWCElujIzm29k6iPaM4P/xnC8SWbI=
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
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Date: Mon, 18 May 2026 15:49:31 +0800
Message-Id: <20260518074931.34380-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
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


On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
>In the past, we used to store the type in page->lru.next, introduced by
>commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
>the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
>page->index"), we store it alongside the info in page->private.
>
>Consequently, there is no need to reset page->lru anymore.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index 3d7675a3ae04..a0a1ecdec8d0 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
> 	if (page_ref_dec_return(page) == 1) {
> 		ClearPagePrivate(page);
> 		set_page_private(page, 0);
>-		INIT_LIST_HEAD(&page->lru);

Yep, that old INIT_LIST_HEAD() call was dead cleanup. page->lru and
page->buddy_list are in the same union:

			union {
				struct list_head lru;

				/* Or, free page */
				struct list_head buddy_list;
			};

and free_reserved_page() passes the page to the buddy allocator. The
later buddy list insertion will overwrite the values written by
INIT_LIST_HEAD(&page->lru) anyway.

> 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 		free_reserved_page(page);
> 	}

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

