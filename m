Return-Path: <linuxppc-dev+bounces-18854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C6910A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkl32bNgz2ymg;
	Fri, 27 Mar 2026 13:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577743;
	cv=none; b=PcDQCtpm0Q4gbVwwPbh29F5n2znFoEpgEkt9Hpl3y/80yMGrdJv6C7knYQbKAWiMR6+/S0eC3J8y3fwXeVDmUIwH4qTyFUP0tP/14Iv4/RLoEW4zVsjItQE3ehjXEGaDQKsaHAlg6IplLoDX6VuNzrogmrGdfTcaQn/1SAZ/B7sLVq7+xDhTgRoMmp3ISyPJvM6opuzYTIwu5+HlYLjLYXXo8D6LLtoBOLB/I7mcEPbKRP5/MB4LXhwxIFvlFx2gb8TjH7v8vOrmOK6jX62v+yu2jNKAsLMNDY82fxjPYx0u5XLmCAGMarLCXSXMmKwtNmxfoEdj7k4+xZinq1nWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577743; c=relaxed/relaxed;
	bh=MnIHRq/fqfQAry7CsjH3C0Gk1Kzxzc2ZoqIQPSTrMd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEq45Q6vXicHfMOPwB0HY4J3YKmkELwNez1xkqz41WlpNiBcaov1kZ+NPs22yEocTqKxwsHEs8lKFC6s2XmiPnIwaDsqS2eyCfQ1idYkSwTcIjWZM9PP2fnCOfYWGy3JCAr0AchW4Ya9TrDhvm7JsKzpclIPF5YylhgFIZ/vqUWzGxKniEnH+GHQbMa7bfSLmaEHNBc0UqCGYI8SW1sonDuvuWIaUiqqKt7pve6NU+yIUgVimhIuX50AjxFalqch3+WEOtBGWKwx9Lz/fShwuIFtLF20R2Ffx2/lm88i+SkPDWRYAJChtKXQljwvYJ/CKF7jfwesTVIuYyeVe7nzwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZIxjF05t; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZIxjF05t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkl23DBDz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:42 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnIHRq/fqfQAry7CsjH3C0Gk1Kzxzc2ZoqIQPSTrMd8=;
	b=ZIxjF05tNow9dzUHFs4hqWlnAIWjdc/ZiKkgAVcRdwnfvfmpyyBGO5uiLBm/6z5QMsmkqr
	ztEHZPBtu0iiXBGTFC271TxvM49AQMco70eXk+ARnt2wNg+T9bIFsUICK9N4z8qczvq+p2
	or1an7NL4GSoQ5bKiLd41MfIKi+EWcU=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 11/24] mm: thp: handle split failure in userfaultfd move_pages()
Date: Thu, 26 Mar 2026 19:08:53 -0700
Message-ID: <20260327021403.214713-12-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

The UFFDIO_MOVE ioctl's move_pages() loop splits a huge PMD when the
folio is pinned and can't be moved at PMD granularity.

If the split fails, the PMD stays huge and move_pages_pte() can't
process individual pages. Break out of the loop on split failure
and return -ENOMEM to the caller. This is similar to how other
allocation failures (__pte_alloc, mm_alloc_pmd) are handled in
move_pages().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/userfaultfd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 481ec7eb44420..a04d62dd1e065 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1946,7 +1946,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				}
 
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
+				/*
+				 * If split fails, the PMD stays huge and
+				 * move_pages_pte can't process it.
+				 */
+				err = split_huge_pmd(src_vma, src_pmd, src_addr);
+				if (err)
+					break;
 				/* The folio will be split by move_pages_pte() */
 				continue;
 			}
-- 
2.52.0


