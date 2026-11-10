Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7760A3825
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vtJz28sT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP47r22Pfz3bSK;
	Tue, 10 Nov 2026 22:25:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309912;
	cv=none; b=KJ77FCOt9ffIc7V7QMEfpg5Om7Lq3W+ADcdKcNmQ7W1B1EK3VSck3NF5yuNQe4tjpgLt+Y/yN9YsXIMLc9eA1VhHn1xaSZGd8odYK4LEGOfgMvnbsdoaupsIzFwpG/vWjT4pgbEAxrf60z+6pKZt6mzE+qwZ9OzpQkctpGK18u1cl0EOJaZVz/5KzEdDMJKV1e0t4W8wAdz1i6mVuDINQyuQWqOSsKFekOgwM8GUwGWbrHtKkRxV0jH8xV81JrHa4YC/vKXnjvFrKF/qQ+gKKatTxTNkj6/MCGaypWTM9oMEq8c5gUFJQReR663QrUZUyENtl5bhKCq45heRvJTpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309912; c=relaxed/relaxed;
	bh=Ndl0Xjf9nTZN6dKbs+SZ1IK92guKL0Ouhq0SwgbwTp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRRT9f23bDXzbIpx+TmBYj9r6q7P/ER98KeZLq7E9NFAZ5w84QnTG/PzqDuJ3/iqOr+mgTswgiiFclzGh6hlwtlHIX4pL8K/OapNu5s6PQGawiHu4HP8Zi23VXNUBTB1pUnsI4Dd10VEZbEsuWNVr4035HHMcBfVfACps7H/Dbo6JhV7ySuOy4w+7sFsKkFPedAfnb0zsXr5MTFiziwU9oXVax06PlO9qI0jrJ18ZucrBJxvwNbAcfJahppIbznGBl+L3kQM05wTEm3J+L0/gDg9e2v3a1T5ehQyeRv+E+4YZamOFVhDpuol5VmAAtJtSVMhgHqswbRcq9atdHE0Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vtJz28sT; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::6; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vtJz28sT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::6; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP47q2S13z30hq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:25:11 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=NOOAGkQRj9IyYCtkbJXvFPbThNHcQSekySmu8iG/sgo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309892; v=1; x=1794914692;
 b=vtJz28sT/KVs6qZkwUmASw5+4Agm1kl9YSBP8nEC90fnr5pynQsFW7rdh2PJWOA9UHCyAvTO
 catop/zsJCGFvsaaSDK8YvsUBeUKt1svu78nLTRWQIrv0BEaEZRGTPn0wEzQ78uZ6rYonYdrYR4
 phAemA1+eIMSUqijxdKYSVrQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id a353589fd710b990;
	Tue, 10 Nov 2026 11:24:52 +0000
X-Mizu-Trace-ID: a353589fd710b990
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
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 4/9] mm/vmalloc: BUG_ON() on an unaligned range in vmap_pages_range_noflush_walk()
Date: Tue, 10 Nov 2026 19:25:41 +0800
Message-Id: <20261110112546.261415-5-hao.ge@linux.dev>
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

The pte loop of vmap_pages_pte_range() maps whole pages and stops
only when addr lands exactly on end.  An unaligned end lets addr
jump over it and the loop keeps mapping into whatever follows the
range.  An unaligned start maps the page below the range with its
first pte.  That corruption is impossible to debug afterwards, so
bug out on addr and end at the entry of
vmap_pages_range_noflush_walk().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 27f2674a5556..86fbb1d2b27a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -698,6 +698,8 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
+	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
+
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-- 
2.25.1


