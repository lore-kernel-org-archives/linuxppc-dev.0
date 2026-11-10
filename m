Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3960A5BCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fRh9t9bq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP4805kbHz3bc6;
	Tue, 10 Nov 2026 22:25:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309920;
	cv=none; b=l8C/354ooACjKFMk3V/hX7DRINtdOuUmSiEnkbByopYSeZlPrfnIv+Wqi/j6/XJCXN5F0Sd9HRjYoDSi8/1H2FFQv8mLXdLRaxEpnDkw/Fq8ii+Q+F6lWU/8e6qhTUgFewnhFeWKEFRuTqos3KwckOLQwapNnDSFl6MSBU3U3FiFqdrX5CXYwK6cX1ZUZC9kvr4ve+sUSqlL9S9fMBc5dG2ozdVGKet9LrkNRzek3bIrFswlVRMNql3Uiko0WRUHlRUZnvaDpkA/LWb+rXZ2yBT+ZgrSV7oGMjnOyn/ki3c9iCNyt22SGtMpVm2Ygx+4MHzyeyYPuBbT5+6C4ms3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309920; c=relaxed/relaxed;
	bh=a4P6LhsQ/fmPy4a5lBGBrNsm6TX2VeTBD7E46ZsyMbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBO4iPSqo+ZI+Kji6Idc6coK6mpeUFEumEqvycerlkzEoy1vLsZXt+CCumYGZuxE/W3B36cFFvxm0kjMR0x81Fjza7K9FBmbtOi3vIpsdkTdHYfgYpiZYh34ElW+zE7bQjJUqD+K+6lRo0zqJhVLwQriYd6NGPyInEsyXDKy02XwTRAb5kw4LbZSDS/4cvhYuO5BWRBHLKmsnRuhbcu6fReZW4ffLgmu1rKXCuvaej/buocZAi1/a08n4DxTNgDROuAk+fPMJtIkZRBQQorEG4UiHtWE2/SB2+8PXAFvO1SxK8VrSzQom9TwcLUJRUHz0YtxgBfYbejBsHa32p11GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fRh9t9bq; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::11; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fRh9t9bq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::11; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP47z5bFGz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:25:19 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=+BC/knlX3zAYieQSABgTL8lI4HMkwqXZ9TtJrVcUkfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309901; v=1; x=1794914701;
 b=fRh9t9bqwuJwWnU5UKDpMM1ujVrKmiPY9fh0jBO+sR1zq4FW8d5SgsPHoCP/gMNOhQlCcLwg
 J9S+IpH0VFjgqCIWS/eTEMybOgf2yRlUsgxZ0djPrsYmhhFWgvbK3sl21688xRHP/8HKV5QOh8u
 tevumLT1KzR8IPOyN5eoSu6g=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 6399328dcb90171d;
	Tue, 10 Nov 2026 11:25:01 +0000
X-Mizu-Trace-ID: 6399328dcb90171d
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v4 5/9] mm/vmalloc: BUG_ON() on an unaligned range in __vunmap_range_noflush()
Date: Tue, 10 Nov 2026 19:25:42 +0800
Message-Id: <20261110112546.261415-6-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261110112546.261415-1-hao.ge@linux.dev>
References: <20261110112546.261415-1-hao.ge@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PTE loop of the unmap path stops only at addr == end.  With an
unaligned end addr never lands on end, so the loop walks past the
range and keeps clearing.  With an unaligned start the loop begins
in the page containing start, which extends below the range.  Either
way the unmap clears the mappings adjacent to the range, and that is
nearly impossible to debug afterwards.

vmap only installs page-aligned, page-granular mappings, so an
unaligned unmap request is never a legitimate teardown, and there is
no way to tell which pages the caller meant.  Check addr and end at
the entry of __vunmap_range_noflush() and bug out before any PTE is
cleared.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 86fbb1d2b27a..0565cbfe325c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -518,6 +518,8 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
+	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
+
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-- 
2.25.1


