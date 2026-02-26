Return-Path: <linuxppc-dev+bounces-17254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A44FC5933
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:34:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8W15S2Tz3cJy;
	Thu, 26 Feb 2026 22:34:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105661;
	cv=none; b=SNlI0bTfHEk0qHDL3hjvOjSFaW+V46SoPV1kFKs/DoFYy85M3SAQ6c3Zm2O222Go/HUziGLDhFMm3Ojw4Rb9RpfZatpnzQnk9F1UeSAx91j7wFly4dIV/g2wE+IUwoseQCPjTnfAjMLfz5NeudKQ/2vSbvvvk6mPi0LB7o4YFFBTcadlSvlKVHl+NJVY2Jr7hZPgfvaQEGDiHQQ+yMF8RevgkwQXKXtzvOTIc3yqBEFrNupCquK5qxjoQaRzLU2Xml2zpLOEnWlLSXVmV0s8nhpte/1HRKUWVK0BIm7p7utR2R86LC67zxgubP+M9DhAgY7yjwmcVpPsrwsh9ybwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105661; c=relaxed/relaxed;
	bh=3zn8+Git0EggRmhaca5IE2gupO7ol+4qJNppzm+/Ej8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/BILL/ZH2HSp8pYgHp13qCJIpnCGqWsMivybee31Z5B8T0darEzN7wtXCIbRgtzfgv7UV9VjRoO8DVxesTazXglZjzffPgII9qhkMSfXLVlmD/UzQ9czlmTH9snNxhPwfvmGTwzZxb8gVwma8EGK5+uTb1W1bG+B5Aeem9NymTwjHB+0tE3B4sICC/NsQm7BJAoWD2X7B88fFk0/1Ddein0GTLnoDriblF70c4dYJNwpMNTqvLi3YJoynKEe4r2RzIwcMx9+vTsNIhoxuC1orxQXdhMP08XasK2FxN/w9SnGfu7wLjdgGvYGMhV6JvOUuv2Rmwq0KAEK+Kg4vA8mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C44MfwaQ; dkim-atps=neutral; spf=pass (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C44MfwaQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8W10lBvz3cHb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:34:20 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zn8+Git0EggRmhaca5IE2gupO7ol+4qJNppzm+/Ej8=;
	b=C44MfwaQZXC9xurNJm1Gj33Zxo1gLQS8k4IWyBzLJ3bDH3iEaWw2xI76yUVCOJhu+N0fjz
	uImfnhnDx1t7VDozyvgsx0dmj2PUnj69wqMG8MPzuScq2zzmXFeTbiFWn+QmycgKIMWYDT
	hh2GKNuNvA84UQEGRKDJ+AfYcSWycUg=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
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
Subject: [RFC v2 11/21] mm: thp: handle split failure in userfaultfd move_pages()
Date: Thu, 26 Feb 2026 03:23:40 -0800
Message-ID: <20260226113233.3987674-12-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
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
index e19872e518785..2728102e00c72 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1870,7 +1870,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
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
2.47.3


