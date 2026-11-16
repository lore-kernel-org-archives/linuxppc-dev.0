Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F6606A33D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbIgeKT4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfJ72VtBz2yPR;
	Mon, 16 Nov 2026 18:14:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.65
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813287;
	cv=none; b=nK12I78SbmCWwbfXH9HD1qoSEHjmh/dbPqIxy1NH4UWrKbR9TWUxP8WUTJ+IKW1OwnkUHJKwZ0efhbAuVpi9sslkX92Xf7GL9cbdlj+mvGYd3UxN4FQkAmXk8YGVFQtjTEe+Z1vnN6HeWEcPKuriT/qYk1KeM5ofvWO6GvmWJdb6b33zcwHTmIVO4Cj0sqlKf26R8TJjuMxK36QV6V+ay+wFgCJ4fcflpyGyfAFGb3zQmQ37X/sk0dTxFwBWBr7hljzNeJutmiXbFjQcPifSBBtNIJvY4PZ1QranoPs2ZbgwChRtOk+1LE3D3RNZVmjJx5KxSvSKfllKJFrgL0GwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813287; c=relaxed/relaxed;
	bh=oDNNUKcQznYLFvs5X+9GzieDpnGR07oToeUGRcsD+jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W65U9hqCuDvnh7qrMEniF34RwzeLX5Heb5ogt2HvNZbxnMxSUHJLgdbw2S4JYugJhNvWRbtIYYZf/3QPQFqGdHrDkz5ibUqpY77IUxg+u8o/NolRVjCu1OsaXQiv+DcQ52IkxZiCMCaLDzbQ8s9ReIuMH69sMzyyOCW95zu0k0ymU6xPb/2Yx+6uxIAjefdUj7RXcnpjcSjEllS3LQl5wr5W1/zfQr7lCX8pal15do/7lbh+Rtz96snXi7w9u7ri6HsZ6kOYxuL5fbBOVgRdfZQ3MtFSA56lTz2w1InhTi8ULygbDb5QOYnUb2S6GpBtIxvlU1jTnzZBbV6JormDhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbIgeKT4; dkim-atps=neutral; spf=pass (client-ip=95.215.58.65; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbIgeKT4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.65; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfJ637NFz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:46 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=ox1OF4PmGlhBQ2M/eFtocGrA519OKUW6bkxfmgExDOw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813268; v=1; x=1795418068;
 b=XbIgeKT4qsJbDHNO3O6KZTrnqZwO0ummpfSNBOuRvtNbiUoxtYGItkrx6cB0AKHeRzkwxaXs
 GXKp2dzSTRD6cBaMDaQecPXbalDHjtz+qysvD/Rgn/1IUoy4E5NWJl0BOSCLoXB66NWqFloqFOw
 sGrizAKGCZTvdXTck8SMsb1g=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e7a04197984c81c5;
	Mon, 16 Nov 2026 07:14:27 +0000
X-Mizu-Trace-ID: e7a04197984c81c5
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
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v5 08/11] mm/vmalloc: drop the KMSAN metadata in vmap_pages_range_noflush() on failure
Date: Mon, 16 Nov 2026 15:13:22 +0800
Message-Id: <20261116071325.263682-9-hao.ge@linux.dev>
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

vmap_pages_range_noflush() sets up the KMSAN metadata for the whole
range before it starts mapping. If the mapping fails, the page
tables undo themselves now, but the metadata stays behind, and the
next attempt to map the same range hits the leftover shadow PTEs.

Tear the metadata down on the error path, it was fully set up before
the mapping failed. The teardown follows the page tables and skips
cond_resched() when the caller's gfp mask cannot block.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f3c320a4849..28e65073624a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -801,8 +801,18 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (ret)
 		return ret;
-	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift,
-					  gfp_mask);
+
+	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift,
+					 gfp_mask);
+	/*
+	 * The page tables undo themselves on failure. Tear down the
+	 * metadata that was fully set up before the mapping failed.
+	 */
+	if (ret)
+		kmsan_vunmap_range_noflush(addr, end,
+					   gfpflags_allow_blocking(gfp_mask));
+
+	return ret;
 }
 
 static int __vmap_pages_range(unsigned long addr, unsigned long end,
-- 
2.25.1


