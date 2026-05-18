Return-Path: <linuxppc-dev+bounces-21068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769E9CD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:57:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpWr1Yt6z3c2V;
	Mon, 18 May 2026 16:57:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ab"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779087432;
	cv=none; b=Qy7A+Fnp1Bj02hhQECJBqofwqZakYMK0bNFteIhbmwyBHqRAVfTZYpcHlhxslXp7NxUUZII799bMMqpDgtNhCCvAs7N6zo6dUeL4kMdHNYEtQ+ftbhVdrGHaXCAqlFR5xQpbZgja+g65a5rHxr4QlpeRqrVml57tMXE0Ich+jXkrK7ay8d41wycuFY9CMTfmS3zyFRna6EgCPpwjxywGz1MSqGnaLgyIcphzKWgZ5sxp/tfBvsMR4xhEbyDCSsYKCCQLYLOSDtrFvDDkgqPOiR3K4H4nyo9YMtDPFgV4D5nha7zt+3qvjKB+U+Qkkt+t3Aq00ks4+h9TT5ucgTojGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779087432; c=relaxed/relaxed;
	bh=T6Q6narBBfa2DFEcAhiLjPk+kC15poLsjndhE7THPe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvVvMhaIOicfWUaqw7MvSeV+AEdawPu5L4M0J1nDNg/4oswjgEOxRq2khm5+mChIJXGh5GVO9BB00QbdowwgL7rdyxLd1CBw55ELogW+2e68E0+yz4D6hWQsgijKvO+sZ5sEt09BlAGym1RdvH6CLXTiN+V1nl9oETYVGHkfFDlgSwkPZIPjlGjF+PV1B8NQVcmTvgC180s1+RKX0LITl4+vHuFGhEM+YnyWmxH07yEoCvn04ZlpK4UHk+pLJ8y+mJt5JUOysx6aaELXyMgfKiiR3z5Q13nViBH4fkaQhL50NN0Iro9jIek4QlG7MGe2/HoeJlKzdhXrmAHKxvMEIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JM9d4r3u; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ab; helo=out-171.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JM9d4r3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ab; helo=out-171.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 78 seconds by postgrey-1.37 at boromir; Mon, 18 May 2026 16:57:07 AEST
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpWl2924z3c1Q
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:57:06 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6Q6narBBfa2DFEcAhiLjPk+kC15poLsjndhE7THPe4=;
	b=JM9d4r3um6vkgkiy6daR65WR78qA1MrD9d2QcfRAVl6Vzhs/8XY97LYGKJl4fqdLxvpeuH
	YEir1Mr9Ev7fsq18T4jdnS1xPmdwaStWTxOSPu+T7af5NwJa/Cjb9FifpXmLXh/R1qLVtG
	219UPF+OKh7SlV2vRBywuN9O80W4b1Y=
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
Subject: Re: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Date: Mon, 18 May 2026 14:55:06 +0800
Message-Id: <20260518065506.79263-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
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


On Mon, May 11, 2026 at 04:05:29PM +0200, David Hildenbrand (Arm) wrote:
>sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
>register_page_bootmem_info_node() is a nop.
>
>Let's just get rid of register_page_bootmem_info().
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup!

With CONFIG_NUMA=n, the removed helper did nothing.
With CONFIG_NUMA=y, it only looped over nodes and called the empty inline
stub.

So, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

