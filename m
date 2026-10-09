Return-Path: <linuxppc-dev+bounces-29099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D6BCA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 13:33:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1SV96qhgz30Wh;
	Sat, 10 Oct 2026 00:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::44"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791527853;
	cv=none; b=JOVBVLbGjBJPLGdyPHaIupfo3cUZJVtbNGOls10Dx3/Ac2O4YdULQ6jOEjWTTfiJZ3qXyOLH/NGQC3REdCoPEXQsPEwUsT+N/i+5tPUyuHmAqztYcX57xKX2PqVhlTtrswueE0a9S3CJwQdN2p0vRenKFGoro5CcWnpoSbiis5b7kkESNkLCMWXWk+SgEkpIAcFFjrhlB6i4cTN5BBQcULx3gIVkJxf9hRCFwUSYuKlf1l+45IXM4KQaVWzKZbJm/T9B0YungVJTdiqoepMQEMpW+DWN6m9ME97nwZPJiHmspowLwuTHvDaKRiErEtiMOGNtGRs5pUBAKTC9x60/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791527853; c=relaxed/relaxed;
	bh=k3T1cwjr/qd2WwT/cXpfp9e0p3U1bnDfIv9R8Ke7D3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dh+iJulo9gX1u8UZ/3Ua46b5wV+nmGV1AydXimCG+dNJqU0Mq0Jl5J/LHKxtkpZmlg2KX6Zwp/2daq5GcjhTu2AMwdDLhmmDNGvMDSR0HX3qqqZg6PxlJdcl5t+UmE/0AFEQAdc9rDar/Rdg8hB3K+kvgLj3clnfjWRxCAJnHsF/NspRyd4s5IMX2UXNU/bfukuS4ZiIFt0CLCpfKDtb5jTAbpTbznzgxpwoyEPkOikRUhQUxA7ghqVdm01QsoF2JvQNVKe93yJA4KroiEQaTq1yRbRUOaUW2ZKBvR/QCB3yKaAfVHvuXdv6VeM/77Xee23MDmOBdbMYyolv4cRSBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZdzkGajM; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::44; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZdzkGajM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::44; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-68.mta1.migadu.com [IPv6:2001:41d0:203:375::44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1HGh1FWJz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:37:31 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Kt3m90GxEd2pntG610a36JDfeeYmcBGJyCrnR//SRJc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791527833; v=1; x=1792132633;
 b=ZdzkGajMgRwjtQNX2Nlqgblj6+t4stWskmSFmI5e9i1jsklc0leAS0iGOpmwjQWqvcHVZkfD
 e4eLTRf+7HVbE5VJ08Bxz9qLRI0jCToSfWLExqQ1kW6TkSpSK3iTSDxIVpwyX2IJEW7v0t6KjTo
 1oECAF6cscwQO1oSqOna6XNU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b474d1347a814fa6;
	Fri, 09 Oct 2026 06:35:22 +0000
X-Mizu-Trace-ID: b474d1347a814fa6
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
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
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/4] mm/kmsan: undo the shadow mapping when the origin mapping fails
Date: Fri,  9 Oct 2026 14:36:16 +0800
Message-Id: <20261009063619.112313-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261009063619.112313-1-hao.ge@linux.dev>
References: <20261009063619.112313-1-hao.ge@linux.dev>
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

kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
the origin pages. If the second mapping fails, the first one is left
mapped, and the callers do not roll it back. The next vmap of the
same metadata range hits the stale PTEs again and BUG()s on the huge
mapping path, or gets -EBUSY with a WARN_ON() on the small page one.

Undo the shadow mapping on that error path, the same way
kmsan_ioremap_page_range() cleans up after a partial failure.
__vunmap_range_noflush() only clears the PTEs; nothing has touched
the shadow mapping, so no TLB flush is needed.

Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/shadow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 0c88d89bf0d6..2166086d3dc3 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 					    o_pages, page_shift);
 	kmsan_leave_runtime();
 	if (mapped) {
+		/* Undo the shadow mapping set up above. */
+		kmsan_enter_runtime();
+		__vunmap_range_noflush(shadow_start, shadow_end);
+		kmsan_leave_runtime();
 		err = mapped;
 		goto ret;
 	}
-- 
2.25.1


