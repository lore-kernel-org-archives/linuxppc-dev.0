Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A4606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tCIyRPTC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfHY5Hdlz2y8r;
	Mon, 16 Nov 2026 18:14:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::17"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813257;
	cv=none; b=W26RJ2DmoJN81bQdIM6TCzc4Tg6+BiGg4Hj+IY0QWy47Ic4Wvs70BP4KtIEfjIzF/DILsUEoGYsVwzdZRbYZjHxp7VatGs6gW9OGoqoKdJdrJjHP9zPt9B4J5Q/VK6NZmqStLsWLZc9gLqKD/2Zo5AwH99tDwbD3wqQcAVrtY1bg7Xhp1rXge7TjweHEpkg+TAPPE+sH3wfCa1A4iGnqKTR3my3VnWnY5jDi/2myV4KHnqTFCT3soDaGxE+hpyOQo65oKvZv+GdD0dX72Rq/fOBk4RvwaNzLkm2Gt/3qnr5kgJ2eneZHjXtj9G+hqRRmk+u2nzOlAUrrhLUZTe3Mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813257; c=relaxed/relaxed;
	bh=4Rz7Bn484kYxpLy98US2ixuVoAUb0FWfN9hJiW5Fifg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJFW10m7wPFJ/cQ+NJNDr3HWVHrPdkD0qM7ODDqkHzWhWBr0qdKorIEj4Kn1OduAmyflV75Mozu6UGdcA7lMP8C8FY1+RnAuYpHMABuxGBQy4oqwxtotkE5itwD4pivIZJYfMlhs+CWx8RHjhkOiVdOEp1zz9jiKiRy5wY3rq8YpwZ8sBS57zDkpaiVsl9miscrNA0lO81DsiT9kyJ6bAW7Z4yxtKMOfnOXAkUSuS2vrjtmuGHmL80QEJeskhN+cSgA07n5GZqJtOKqu9jEQ5w9oFLRa0zVQM215o5g+7IUdLGJz/M61rmt0Q3VLH8JOtZH9QKX4SqiQte0+pNWskw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tCIyRPTC; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::17; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tCIyRPTC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::17; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-23.mta1.migadu.com [IPv6:2001:41d0:203:375::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfHX5ZMxz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:16 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=4ajKl1LXghEEqa+0NKeoRTLoqb4UzlZy/QlTAAykkoM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813240; v=1; x=1795418040;
 b=tCIyRPTC63xrH+q0QBT8l7u9/woB2jGMhy/+TZBX0fGRcXnQYwaeuZH1c8ifb48wf0bZGmaU
 MUDtWgWpzHC5JTwJj7ig3NMGjBht6n4hRXay1cde0/EUVwo5xjr0e9DRXl5SDFsz70yR5ONPTdp
 fUbc0a2dlWcnFkZeSRP7zYGc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 98d69bef93d5ff80;
	Mon, 16 Nov 2026 07:14:00 +0000
X-Mizu-Trace-ID: 98d69bef93d5ff80
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
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
Subject: [PATCH v5 04/11] mm/vmalloc: reject an unaligned range in __vunmap_range_noflush()
Date: Mon, 16 Nov 2026 15:13:18 +0800
Message-Id: <20261116071325.263682-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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

The PTE loop stops only at addr == end. An unaligned end is never
reached, so the loop keeps clearing past the range. An unaligned
start clears the page below the range first. Both are caller bugs,
and the damage is hard to attribute afterwards.

vmap only installs page aligned mappings, so an unaligned unmap
request is never a legitimate teardown. Warn and bail out at the
entry of __vunmap_range_noflush(), before any PTE is cleared.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a168f6f20f4f..e2b63cb1592b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -523,6 +523,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end,
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
+		return;
+
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-- 
2.25.1


