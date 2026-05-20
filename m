Return-Path: <linuxppc-dev+bounces-21243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF21ACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 15:39:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLG1G1SY9z2xqv;
	Thu, 21 May 2026 01:39:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779291554;
	cv=none; b=B+TNSXsIltnuX1ifPWrftdn+ugWdqihDW18RGaw/ufS3uUKszOaKAe4olYCo0gBh7VkQJdjFQ1Phaq77i6aecZHVdyQ6EBSdry18dg3TNinBKSL53U90/PToTAwx3oNnpQT6Q/62YqfEEMyU1TxcU4pzTaTAL++wUGJkaoJ/z7U/MIsZwssxWqDnAbXTnc1NvdtnabqGAL18CteXDjNz2G1VZiVkaWIUxyhQlf/wI8+k6YNiqvJJUyq5kC9g2tW+JQJa6lZIvNHo128ETMiBkiWF9PUpQAt0LTth4nt0x+aFiA3NCHRdF8TnKnOwHGC5uafEuul1RS1jb2IzzBKKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779291554; c=relaxed/relaxed;
	bh=gxePXEMQDWwNnRA4fuUAEJ8toZ4JkLQ6obW+0ibr2gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW1+2spy6gLs3UKpPdvIlee3FV3TPCD1A5gm3gLeIDVbcLzwrtXa9jcoTWYVDWfB4mQoLvlGYdYHbe/RN5u5Wo40RLtwVqWODc32xShKC3dNnqyHmRhjby4L698Ea4lp7htvjHS00x1FVzeFu6xPdsVZbrgXYMmdtWwxrtkGLMd0gDdKe+xWesfrwdJS3rahsouaGV1EgErEtgz70IOU4V6kekRmORpU5a1ClN6VUopoxYbiPYL1iV6ws5qpNaOYfmzhMxbgi41XBAcd87bR2B1E1HZXLB/Heoojbw0uAaFRXEmSapTeZRkKDCo1A2/DVTg3eXc/DAZs3Sp0i3u3rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UrD4QznM; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UrD4QznM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 445 seconds by postgrey-1.37 at boromir; Thu, 21 May 2026 01:39:10 AEST
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLG1B0Ts3z2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:39:09 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779291083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxePXEMQDWwNnRA4fuUAEJ8toZ4JkLQ6obW+0ibr2gg=;
	b=UrD4QznMUDmQ0luAlbLeSSiws6nZUUkmtwBztn8k6zeWl1F6tpAnuJzA7kqzv5F400/CJu
	tsnsT0njTgvs2egS7NWnQZ3sFoLN2sNldH6aweT3nAwMm/SUsrALg/hSZ40qnAurfGkQIy
	7NDdgJx0NZYt+FVg9eFvyCYbotjwbEw=
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
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Date: Wed, 20 May 2026 23:30:55 +0800
Message-Id: <20260520153055.61173-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
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


On Mon, May 11, 2026 at 04:05:33PM +0200, David Hildenbrand (Arm) wrote:
>We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
>remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
>
>But it really was never used it besides for safety-checks ever since it was
>introduced in commit 04753278769f ("memory hotplug: register section/node
>id to free"), where we had the comment:
>
>	5) The node information like pgdat has similar issues. But, this
>	   will be able to be solved too by this.
>	   (Not implemented yet, but, remembering node id in the pages.)
>
>Of course, that never happened, and we are not planning on freeing the
>node data (pgdat/pglist_data), during memory hotunplug.
>
>So let's just stop marking the pgdat as NODE_INFO.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index 74c1116626c8..cce1d560f094 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
> 
> void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> {
>-	unsigned long i, pfn, end_pfn, nr_pages;
>+	unsigned long pfn, end_pfn;
> 	int node = pgdat->node_id;
>-	struct page *page;
>-
>-	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
>-	page = virt_to_page(pgdat);
>-
>-	for (i = 0; i < nr_pages; i++, page++)
>-		get_page_bootmem(node, page, NODE_INFO);

Cool. IIUC, pgdat isn't freed during memory hotremove. Offline nodes
stick around and can get reinitialized on hotadd, so NODE_INFO doesn't
buy us anything here :D

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

