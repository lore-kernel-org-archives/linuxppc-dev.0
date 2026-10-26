Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBA606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfQi0cRB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmMx4nvXz2yKp;
	Mon, 26 Oct 2026 19:03:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::7e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001805;
	cv=none; b=OotjdSjLCXFbhvemJYfZzLNwmqSSF85l86PgjgATcoKPHjh9FjIN60wfTM+xKqIA1Cn1g6YjxF/cMnp58rAiwbcNepWxl1dz3MKCzxldRh02yhm7YbLOo87PFjE0ydt0xGly18TPiHdoXJtpQ2F1Qhdktc+BEowrVB/MCMBpbcQHEPzijaDtS9uInFseCk1WtCCsFpDetC6MPaclMExpuLoADQm1ZPCQXXfNWV4DmR90UA7BnRl4S2iMkZ8oBswQ08lHsUr+KUABxbk+thKQ+uca7IYN5+och5kndOykcgSVx9ycm3VBsiEsucz56T2Ix0w/qc1HWFqtHwynJU30Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001805; c=relaxed/relaxed;
	bh=3Fm/k61dAGn6pWXm3A71qaZX3bTJAZeBybYud9pjwD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRJJNcvnf3T2wgCAP/nvqvJqddmShcEuchSQG7bBtooQAITuXGLszmHHmUdPXbQRpus1J3+z1tN2tAEphScIdrbX2rp3v3cSQt1Oa+X8v4/GEcOEi6M0oj07LbNcK/ug3hx4wa7vTc8LD68D+9T7Dq2whze3Wdqxo0HJYft0WeTju5lzL4tbH2LmVWswHz/pCx6MCgHJAR2u9GcWZ3A787NfSHrsLoVzTAoHldtKCVoEjM3chaCM3qEh4+SHyCuYNkPxavIOCbyZprhd3IP4Q7mjeN3J04fBjcQK4j1GU+UukBe84HDAv0pSadO6k6/CAmtedMy6jHHscBD6Lg5xmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfQi0cRB; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::7e; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PfQi0cRB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::7e; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-126.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmMw4xMqz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:03:24 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=yF6bL0ko6Nsx9Q9DKdGf/DM9nR/ox6wnvQ6I+8xeA+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001786; v=1; x=1793606586;
 b=PfQi0cRBBGZFWttKVEVfRzvSfFrnLLjC7/JTTq2DHpzdWmyT6Mh/QR0lNmPkw11bVjIQz+nk
 mTNYLHfBiOxipL59Yol5IfhEFT/g7l4d02R2/Adl0qbMgWxmQ5mr2+mCIVDUiPGxoGj+Nx80R73
 /3b9NH1iAcXjd5lmT0IUZBPk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9a29ba5e27180e69;
	Mon, 26 Oct 2026 08:03:06 +0000
X-Mizu-Trace-ID: 9a29ba5e27180e69
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
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
	Uladzislau Rezki <urezki@gmail.com>,
	Hao Ge <hao.ge@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 06/10] mm/vmalloc: reject empty and unaligned ranges in __vmap_pages_range_noflush()
Date: Mon, 26 Oct 2026 16:03:25 +0800
Message-Id: <20261026080329.140244-7-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026080329.140244-1-hao.ge@linux.dev>
References: <20261026080329.140244-1-hao.ge@linux.dev>
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

__vmap_pages_range_noflush() expects a non-empty, page-aligned
[addr, end) range but does not check it.

An empty range dies in the BUG_ON(addr >= end) of
vmap_small_pages_range_noflush() on the small-page path, while the
huge-page path maps nothing and returns 0.

An unaligned range is caught by vmap_pages_pte_range() on the
small-page path, but the huge-page path misses it, because its
chunks are always page-aligned, so the check in vmap_pte_range()
passes, and the mapping just starts at the page boundary below addr.

Check both at the entry of __vmap_pages_range_noflush() and return
-EINVAL.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0f33392c6ad..4d74144dfaff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -698,6 +698,12 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
 
+	if (WARN_ON_ONCE(addr >= end))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
 		return -EINVAL;
 
-- 
2.25.1


