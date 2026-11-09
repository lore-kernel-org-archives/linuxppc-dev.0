Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07033606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMq0OsFY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNJkK35W2z2xdb;
	Mon, 09 Nov 2026 16:48:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::6c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794203337;
	cv=none; b=YMnLEwooJ28nyRodmtz42msZHbHHW1Bs0MLv8zwyXQ7M8tfUDoHqPWwJlwk+d8uhAIe77pRu9AqiiN1j7aAWR3XInm6lXscssLwwn4PCJjIGkjThf6oaH4MhivsfnswVLmN5fIgEwP5vsOdoBOodJwHu5r4fy7C6kh3UMXDh1Gitz0NPnv5basQPGyN45S0p8r8BzfghvRE4TfRF+dv5bCmy2LbGqidzzqN0pGaETqJ9SXjLAcDGkrrD1hToETWXJ88/uSO5hpd0VaO3+gXwPKcSUIffYhAFnP61ckLA8cAuuUZnfbcC+qNKFwOD25+QqG9zM8KxW/yW0tM1IMaAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794203337; c=relaxed/relaxed;
	bh=JSOyM4K5zrqmDFF61CwIn14s5ShEHbu2alo+0Cxugro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNZQ+C5q9tLAUran8Ucjg+dMMOcsqxUS89YTDPutJVGYYBhqCWzp/4Himg69cXzcLCpfFAbdqS9qALt8cBQQ8YW0tavWuL9GgbvQg0+K6Yk+166Ff6hqGnVjFhZ44a3lnfAByVqt4kFHVf0pBWapYwp36/3SO465ugOxVCYR6h7cqJCfXN76jrZ1dabBxRdhNGRRz8TzAWnFZSpCarphJU9DVIAReLFNPvspqL/7f/A1Gmz64UP0D1nl0fNCYZgTwDiSzLbntuaIm8oJ2IJpXpesyQBDKnOovfZI7XtIMs60f0wXANK4tP4Co8BuGRFd4dFlGxXABeVSIMQ0kxZEZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMq0OsFY; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::6c; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMq0OsFY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::6c; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-108.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNJkC2C17z2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 16:48:48 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=JSOyM4K5zrqmDFF61CwIn14s5ShEHbu2alo+0Cxugro=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794203309; v=1; x=1794808109;
 b=MMq0OsFYOeDFfLKeanMq/JRW5emG22N+JN82VeucMQQPT+M2lExIrVamS+c7q+asXdJ1pdl2
 1X0kSw1FOEdPQI/obnIvW1WVZJsWlAMtC3SyfA526L1kdBXP241tfsR5N7B2uuz87yZGgwPpUpd
 dE+PwLyiJkXRbdzGAO40uSAY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id bae7ce2de6921a50;
	Mon, 09 Nov 2026 05:48:29 +0000
X-Mizu-Trace-ID: bae7ce2de6921a50
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: david@kernel.org,
	maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	muchun.song@linux.dev,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Mon,  9 Nov 2026 13:48:23 +0800
Message-ID: <20261109054823.45056-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261107043122.25650-5-songmuchun@bytedance.com>
References: <20261107043122.25650-5-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Nov 07, 2026 at 12:31:21PM +0800, Muchun Song wrote:
>section_vmemmap_optimizable() can already decide whether a section uses
>vmemmap optimization based on the section compound order. The DAX-specific
>vmemmap_can_optimize() helper duplicates that policy, so remove it to
>simplify the code.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

With the arch fallbacks handled by the previous patches, we can just drop
vmemmap_can_optimize() now ;)

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

