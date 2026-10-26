Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34023606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfcaYETo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmMm6kMlz2xN4;
	Mon, 26 Oct 2026 19:03:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::62"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001796;
	cv=none; b=it6acn7EMPFgMstF2pj8WLR2wubtrD4m5QvcP+1sXKjRGCFecV1LFUAU9es+GSTyQlcpYV4IBxrBDOLhuAvb+mAJf3LbH3RLR7nmIBgOZ2sarARwSL1vS1Ml5f7/tz1gt7+5GKV0pLQ20Id7Dx+KLV8X11ySnRhPSF7dRseZnBAxDiLVLCvXIeKSewvWI4OpQpJX47wDBejcuX4ACFZyWcgL7sH0vtSfF+C6d+sp9CcF1JqfBuCnBGGiwpVHL81455rixXAqYUEC0f9A1+ma6JpYpRchnIcm5EVXllHuT2h6lHXx+H0dur5tMrVc816v03mrsKjWnz+DlV9tst39jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001796; c=relaxed/relaxed;
	bh=zmy3LH0dL65AyxAOzx2otQGK/mLaqXxkxMSe8fA4quA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gkuIvVM7CXVbURRrdlsAA7odPrhH0aIB0kwPk93K+6eWCD17s/81k6fYLY5Fxu+rdFFRTAie4IH7Beno1PbK9eoc3Yv8BHzK1rvIqAjHa7LumfdUicwR6Wgv9NpfjD9IrBwQtI541+ejkVxSpBgoE9iBpf6+FOuDom1JBFqxAP8iHs5JLrgpHopY1x+CUGOuymeCdAQY49sfbz6XfQ5lDJlPx1ikxf/Q0aQ7ForL3Jpq+HDBIicd+GXVHI2Xpq7zlRfdOYzjpgG0grizOiEhMObbcJ+jTZYat2AK7SDl5qWGXnfNovyfA1kpAhJ3sU0shRHXsc0mWZDCzMW4bPpVxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfcaYETo; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::62; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfcaYETo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::62; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-98.mta0.migadu.com [IPv6:2001:41d0:1004:224b::62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmMg2YP9z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:03:10 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=rcaYfxcJJLBaD/Nimy7cPxQcpSG7l5aC5JBRtkuZ3MU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001771; v=1; x=1793606571;
 b=DfcaYEToOO05oj5XAMAuaH+q8d6pgLJ6lXHw/QEd/bWVV9BNdC9VlOhrYPLyBfBVzZ02bIlK
 hO2vnwexCD5YN6nHcqqYKLkTQtXJsMqDUoPka3SnTX2wcJyLp31rrn+cqTqMePnv7jymh8xCMvp
 DykbHKCboQtxsdddbh9NhyO4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 5dcbb4fe83952587;
	Mon, 26 Oct 2026 08:02:51 +0000
X-Mizu-Trace-ID: 5dcbb4fe83952587
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
Subject: [PATCH v3 03/10] mm/vmalloc: clamp an unaligned range in vunmap_pte_range()
Date: Mon, 26 Oct 2026 16:03:22 +0800
Message-Id: <20261026080329.140244-4-hao.ge@linux.dev>
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

commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
PAGE_SIZE aligned") made vmap_pte_range() warn and bail out when the
size is not a multiple of PAGE_SIZE. That loop steps in page
multiples and stops only at addr == end; with an unaligned size addr
never lands on end, so the loop cannot terminate and walks off the
end of the page table.

vunmap_pte_range() has the same loop without any guard, so an
unaligned range would clear PTEs past end without ever stopping,
walking off the end of the page table.

Add the check there too. The range is clamped down to the last full
page rather than dropped, and the loop is skipped when nothing is
left, so a buggy caller still gets its PTEs cleared as far as they
go.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 44e0eb32708f..7131f60d1a8e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -393,6 +393,11 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t ptent;
 	unsigned long size = PAGE_SIZE;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
+		end = addr + PAGE_ALIGN_DOWN(end - addr);
+	if (end == addr)
+		return;
+
 	pte = pte_offset_kernel(pmd, addr);
 	lazy_mmu_mode_enable();
 
-- 
2.25.1


