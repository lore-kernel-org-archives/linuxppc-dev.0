Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A5606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UQ28VxWH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmMr4j49z2yTH;
	Mon, 26 Oct 2026 19:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::75"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001800;
	cv=none; b=cTBpW0iOPesMP12LncoVMk5IonZQU/UBgUY6HFKJSJEMUjIIolJzobJkBmHv0/fBRHn4egiAww3pS6n0nV5tB9Ndu0gDtzBh8bYSKjs5CCNa1TEAi0TNkyWw488LQLa6n9ULZ3hYsX4UZiw/ZbWjw2uBEo1ApncuzZvUCBxSRNhaVsbabt5qIV5Erxmry7mdaOzS4kA+qgj1rKlSgqx9Rcyx7/mI7uG8mZ4E3VMK2JPNhBvPwxln4V5ZEH6SfjZlkpD2BXixUZiHLL0Mk3mK2fsYaZrODV4N3DfqpXVoT3FzCShPlRHbXgpWSPBWLEb4YHKY0YBoJDcOoiO177PaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001800; c=relaxed/relaxed;
	bh=F50Qplwui3CICEAhuivMriFrkJSXdydW0DAGmo57Xtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuSgvLNPHx4wmvQXcw13ItUPahnE/buXvUL1bv6z160LNucf1MZLnFmwKNFJReKeqmk2cPrzGrqyQBHEEs9ws8XcEForB01vQS1BM4TC85BbVgvn5Y6v/KcdSgVnBttfY4zIrsi+scL3To1+v3MagERR52yoce76ahi+cx9V1eWVYIBvM//Y6OMBN5E5yx/drOy/1BXERAM5MO7A5wsfvgqwJHBOOhvKfC1U8OCdxCy2fl503rbh0mBIJ3Kk2dxdcPrxyNbSYns6TVJAFmgdP6v3Iaa0V4yvZaJHnXKQSjx6A1e3/BZz37amEYhn0JV6Q/FGsOwbX7Wk6Pv9koPQaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UQ28VxWH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::75; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UQ28VxWH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::75; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-117.mta0.migadu.com [IPv6:2001:41d0:1004:224b::75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmMq52YNz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:03:19 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=pTZFl8UM3ETvokuzfL6iKKBHKQY2m3Ez9MTwzEqi/1A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001781; v=1; x=1793606581;
 b=UQ28VxWHre72gDnSeRWu3nb1iQZNIm5O3U2D7Zzy8KTK+mN1s0L8AOB27+kZM9fI0+f8G8dY
 NoxqcWBr+OpgCT72GqbU0zwZrZTbaAqWT/S/mizRTjwhFdd6OAQy9+xEfruf1UMlQGS1V5zpE9g
 LukQmeLeovX/4+EjnXt24Xqc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e2e51c17888acd15;
	Mon, 26 Oct 2026 08:03:01 +0000
X-Mizu-Trace-ID: e2e51c17888acd15
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
Subject: [PATCH v3 05/10] mm/vmalloc: reject an unaligned range in vmap_pages_pte_range()
Date: Mon, 26 Oct 2026 16:03:24 +0800
Message-Id: <20261026080329.140244-6-hao.ge@linux.dev>
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
size is not a multiple of PAGE_SIZE. Its loop only stops at
addr == end and otherwise steps over it and maps over whatever
follows the page table. vmap_pages_pte_range() has the same kind of
loop but was never given the check.

Add it there as a backstop.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d60b99b81ec9..c0f33392c6ad 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -557,6 +557,9 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	int err = 0;
 	pte_t *pte;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
+		return -EINVAL;
+
 	/*
 	 * nr is a running index into the array which helps higher level
 	 * callers keep track of where we're up to.
-- 
2.25.1


