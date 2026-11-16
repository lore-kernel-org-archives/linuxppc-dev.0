Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CFTRgDEB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfJF3vdGz2yQn;
	Mon, 16 Nov 2026 18:14:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813293;
	cv=none; b=Uc4dz5liWoyc+qYAl6CRUz+wn4FeeXUNhIf6r+boknVZFIGFoA1U3EybMIpwJEbF6oMVkaXuBM8Ys0zdi0bpou1vTDiKsJ4hgP8YWfRSOs/MAFhGI4TK2EE9odXN32+LR4T3pZi+sJ8YyIQa5Gag6wljFpLSfL1qusNB/hOb8cNBlrdMJhMvfhICTTk++CbA4+WhyuEdMP401+OkVjAfcKVodweYnXVeTDHzvfzwzTKnYiv1kRc6bspdv2sFekfFYxKQRR9jUscUQZ6noI7hi3F/w04XkeLYmRnAxWyxbY7kaGsOS+lT2TMytLpPiThnagA5TbAOaSbTWmYVQJgBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813293; c=relaxed/relaxed;
	bh=S4xwi4aHh7ZD/bHp2DRcoCULX4dT5zb31C8Z9H6qmb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b92o+Y5Yernj/wnRRYYYpm5bBekQZg3MglKISLZtRymiKHpo8x0vxAZ/3CHOKl1u+0Etx0CXV1qDXp9SUEeygomSe6Z49xvE2xN9D0kB3W0AbVGfvw5cAKumsYE7RYfGJnUhr2YgBtgfAw7uhVKi0dlqeIy1P91X1I2glm7eBtzvKnPcCVfIKqI32XK1Healls7x81JY1Cn5bYThxfex107P+fAG09xIxXgKBESQu75vnPC95sp5vxF/YZHdvDcNGj4vSqROXqTxViVI2/stcX9BON1vV4Yv57/0iPXq9ZHCE+Pcr21SZexAHpruHZaB+F8Ye4RbsJ1na6EvuTrbMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CFTRgDEB; dkim-atps=neutral; spf=pass (client-ip=95.215.58.81; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CFTRgDEB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.81; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfJD4LmDz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:52 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=EVDQOgm4eiv05oSXsLTtEpFF+tsRKuMQEvt8DaJEU2k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813274; v=1; x=1795418074;
 b=CFTRgDEBH3j6pmg1ej7njFlv3ud01xfdaOMBaTZS5DBJoWFHZXBdM8Ebo8YkQ7AyoQbXvHJk
 mGFmVZznl5qN2rMEHNFvfRCTsc8E8IoOwvYn28vfB6raIhgTC2vZ47Mamjls2WYuTAi7GiB5cM7
 bwG0TjPRZqKoCRang6O0DWVE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d81b1a6ac4fe3573;
	Mon, 16 Nov 2026 07:14:34 +0000
X-Mizu-Trace-ID: d81b1a6ac4fe3573
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
Subject: [PATCH v5 09/11] mm/vmalloc: undo what vmap_pages_range_batched() mapped on failure
Date: Mon, 16 Nov 2026 15:13:23 +0800
Message-Id: <20261116071325.263682-10-hao.ge@linux.dev>
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

vmap_pages_range_batched() maps the range batch by batch. When a
batch fails, the batches before it are installed, and the failing
one may have installed some of its pages. mapped_end follows the
end of the last installed page, and the error path undoes
[addr, mapped_end), never past the point where the walk stopped.

The KMSAN metadata is set up for the whole range up front, so it is
torn down as a whole when the mapping fails, like in
vmap_pages_range_noflush(). The only caller, vmap(), also calls
vunmap() on its error path; the double teardown only walks over PTEs
that are already cleared.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/vmalloc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 28e65073624a..aa80bc273ec0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3748,13 +3748,14 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 	const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
 	unsigned int prev_shift = 0, batch_idx = 0, nr_mapped;
 	unsigned long batch_start = addr, batch_end = addr;
+	unsigned long mapped_end = addr;
 	int err;
 
 	err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
 					     PAGE_SHIFT, GFP_KERNEL);
 
 	if (err)
-		goto out;
+		return err;
 
 	for (unsigned int i = 0; i < nr_pages; ) {
 		unsigned int shift = PAGE_SHIFT +
@@ -3764,9 +3765,10 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 			prev_shift = shift;
 
 		if (shift != prev_shift) {
-			err = vmap_pages_range_noflush_walk(batch_start, batch_end,
-					prot, pages + batch_idx, prev_shift,
-					&nr_mapped);
+			err = vmap_pages_range_noflush_walk(batch_start,
+					batch_end, prot, pages + batch_idx,
+					prev_shift, &nr_mapped);
+			mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
 			if (err)
 				goto out;
 			prev_shift = shift;
@@ -3786,13 +3788,21 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
 	}
 
 	/* Remaining */
-	if (batch_start < end)
+	if (batch_start < end) {
 		err = vmap_pages_range_noflush_walk(batch_start, end, prot,
 				pages + batch_idx, prev_shift, &nr_mapped);
+		mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
+	}
 
 out:
-	if (!err)
+	if (err) {
+		/* Undo the part the batches installed before they failed. */
+		if (mapped_end > addr)
+			__vunmap_range_noflush(addr, mapped_end, true);
+		kmsan_vunmap_range_noflush(addr, end, true);
+	} else {
 		flush_cache_vmap(addr, end);
+	}
 	return err;
 }
 
-- 
2.25.1


