Return-Path: <linuxppc-dev+bounces-21311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962E0CD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhr519qWz2xmX;
	Thu, 21 May 2026 18:47:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779353269;
	cv=none; b=C7kckScUyfsk995476hs5uc4s+3o0wJ8o+rRYV0WOzEHxu8vjXj0TeTzY+FoZGnmGDQH4jr8xgv9O0SjRL0bK/ZxvqFXu0HGvIxofKSXeX9DlkGEbChO65e0JwAumQ8bVmLX6JwI383WyvIxBs4fnbJsHSae2eU/q+YjwRBvIXgB7KLwCqFdjBEiztRrV38fV6n/tzZp0Mlu84rQidV9xdQXx2BlCKHjc0m7XIo/rZ/ZrzhjCJMRA72vyBPKxb+LunCbmgD+V9VJHv2WwB5TW8AJ2qtx6pXmHNUN9BrhO+czPdKGsVMNfNSueg8yOSg76xBx4EWIhQwqvyUFP63V1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779353269; c=relaxed/relaxed;
	bh=Ce0YsJDZhijtzDvB+cpUwwO/m6mCN3ATBf0wLj4s7bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg+lEsyyifq3LsvaaxRKhVc8hgo9S9uCeboPkIOvI5ZPy5sqjZyUZM0B2sFhaKLoXCPkLGVlNMl9pZQpxmQ/GG/bkycEzf7wVGeSTpmfqU/cO5dzFN7jmI9EzHwBb/K2OcdzoPny+eKNinhb09BYpwlV3opYUQr9yy06Yb2RrRYeIkIDSiHkwMcGLP8Jzg2UPOF6jp4cdxIFdaPTLO/gjiXiqPJyKLITPkFSFIFcY4OOz6WxJBrpa2JikRY8j3C1rzZAFF2yE/YBu1HO2PtW86DTMCFQ6Nl1h8lYa+/H0SMUKqQm634O2ECA3LzpvZ/7/oHbhiumyspAsMZUowT5cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p/o56LCe; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p/o56LCe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhr35WqBz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:47:46 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779353247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0YsJDZhijtzDvB+cpUwwO/m6mCN3ATBf0wLj4s7bQ=;
	b=p/o56LCeHYPXPT9ntpy7ijsSA6U2XV1q/IBxgTL/awZNyuXPbTR8nUqPg1fOGGNvmHFIc0
	+K/9omdB3BHMb1jH0Ko3eYnwfwaqGJr9EmwxM9iQdlkJ157w8nTXKiIgoFtsoY0SjzL+uG
	hQxO7Q43dKvRrpA5oNJkOQUMed1HVEo=
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
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Date: Thu, 21 May 2026 16:47:18 +0800
Message-Id: <20260521084718.36436-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
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


On Mon, May 11, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
>register_page_bootmem_info_node() essentially only calls
>register_page_bootmem_memmap(). However, on powerpc that function is a
>nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
>anymore, let's just drop it.
>
>We can stop including bootmem_info.h.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup! Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

