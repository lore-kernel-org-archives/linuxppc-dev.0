Return-Path: <linuxppc-dev+bounces-29679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC46CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 05:46:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Pfv5pQ3z2yqq;
	Mon, 19 Oct 2026 16:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::16"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792388775;
	cv=none; b=YUVvIBz3mQTtkJRxs3P9w712LJbPwJzcU3l3UEFqfawUsqr6QZm1yhmfr6Lyq7P6+SfSb7kVZhn8H2+vG/LcsZ9DQhIJOHJh1Ht70A8fr8w/5IST61Qh5aTwJMCqGi4JoU/S7H3RE8CRiiwbKC5Gd5l/hbBLT9767heUChHW7ZiKSvQ+2Ezq6d9kns/FuCtRTiUOOVFCWJdZxavMTKlaxnP1hP6tYP7WVcOz5t1zkwNgnhUzxsioGl4GY9mZGTyzTfdjgP/BO1CRnH8sa7Y3VkYmrVdMAX0NK47xOxL1+kzIbdjwFoPHPU9A1IiZbUal5uDYqKgJvdcOp0NtxS9cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792388775; c=relaxed/relaxed;
	bh=AhkHf4s7BbKXUCIlMDjh8Q2uCCWvm2zU6GzW8nRjKEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bs5DfhMmRVXD7UMwren4udF+1AUnU7VIp5MW0ZNNMdpw3N1ItxRgL7bcPywy7VjJPZDslNfz5Hr42gNZ00PrNM+MkmjDmAx+jzTrhiVWKoQrEjZWiullHvalOMHaAkbFFN1KMY3VLMm11MQJcqTcJMYvprERWcHmvWaf+Jh88gOYCZDkDkgSrJktGkSbDDfcHIgwXUbjq1HdjSj+Tu7A1eSduZW3FvFfbPKDw591/0VL0W7e8B5KwK5ra9fIQTv5Z1pSI1SuboFSqovLGoVmbaEplvDbi3yY7DUZExXNHknN/86bEQ9F9c6DPue1Qb0KN4CwuPiO53Lo/IuI8qwz0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W22OWIFl; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::16; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W22OWIFl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::16; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 86 seconds by postgrey-1.37 at boromir; Mon, 19 Oct 2026 16:46:14 AEDT
Received: from mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Pft63Zlz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 16:46:14 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=6N7uwP3rCC6GNCQQInhTH/OwMfzrHTS2Jh/5l+ygl5s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388756; v=1; x=1792993556;
 b=W22OWIFl7IHSef29ic0W+VgerpWctltUzEvtdWAIhZQLC616+N9L2E08DBZfc071KzARVTIY
 huqSlM/hA1e5WfKhlCTP6wQpb4Sathp50XFMmmHUIPrO2R0ANZSDKGiHaichmR/UEDnsTkXNmTL
 lKtqmNNm8fJ3E+Kc5L0xBPZE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d648b1f8ce06a9d5;
	Mon, 19 Oct 2026 05:44:37 +0000
X-Mizu-Trace-ID: d648b1f8ce06a9d5
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
Date: Mon, 19 Oct 2026 13:45:27 +0800
Message-Id: <20261019054531.87652-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019054531.87652-1-hao.ge@linux.dev>
References: <20261019054531.87652-1-hao.ge@linux.dev>
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
Content-Transfer-Encoding: 8bit

kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
false.  The unmap side does not, so it still walks the shadow and
origin page tables even though KMSAN never installed any metadata
there.

Add the matching early return.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index a706666db097..107f66841274 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
 
 void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
 {
+	if (!kmsan_enabled)
+		return;
+
 	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
 	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
 	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
-- 
2.25.1


