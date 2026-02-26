Return-Path: <linuxppc-dev+bounces-17249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFFCFC5930
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:34:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM8VW2Wltz2yLG;
	Thu, 26 Feb 2026 22:33:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772105635;
	cv=none; b=ovHoDXuSj76C6GP7MC1kbMbEj7B3kzRu0N+ft8v8HGqEkQKY8HWKmTzaz3EKoGm+m68hzu8hHOuv5Yri1HuhM9d0vMKH5ku79KXzy7O05SsAtj+8/BIYYHhW78jb/iTJFMZrIYpIw89Dckg4EZ8q7M1PQntRgpLflhuOD3S9xBY1MVpENufak0IiZ97ohGndiYy0+CuzW5oL6sWROj5cKqD2xV/4gYSvOYmrVwYuexkv7DbfFRb+W3IyG31q/hkMBjz+R1Ih3ShfaiMfmj7WNvVNvH06iYo+h9fHr+JfwpQ7yn9J/ksWSVjycuGjdYRRNafhq+TlupqZSKm0qt0c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772105635; c=relaxed/relaxed;
	bh=sEWb6ULyOrXRVye+x+KftZvBAQkL33Q0arTZiVRMt8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4NnmPne80nQXfTOCLGfuL/jlLCGJRm2McrozL5aEFp1pNJRBDKolT8CPrvn9iBAySr2cqmSvka5Y4E43QZWuiAtF7ghpOyy/f1HFk0ZBmOz/V4dS5FCyRCAc6rLht89yinSjGq6vNlk9yYhqqJPLOPH/jPaArtzBYR4E+yC6Rzikg7lroFYvTdhQbVXJq+x9KaF9YZq7ARPwmKRKFFmVL3H6hdt0jq5r3wkq3hhkkLv6031ZMPr7UhoGY+lqSSITrzZ9YJ2us7EfWY+GseScDMlCiN+4xtOkQLz0P5XUKuAuKZwO9o/r0/YJs6MAoMYnDay7QvTPOJ7XYp3upPQow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qqWTnMAd; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qqWTnMAd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM8VV51pvz3cBW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:33:54 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEWb6ULyOrXRVye+x+KftZvBAQkL33Q0arTZiVRMt8I=;
	b=qqWTnMAdq5dg5CvpyeLbGUPbMz61dA9xpNIaerVTAxRFPXhdC6tgbMB8GUGdaSb1pEj7AQ
	+ksDSA5ARHrYo0OCNpPhXKcjyhuY8ZIczmUrM/O9mt6vELpp8Kp9v5Y2Nt8i4eNS5HVweF
	CbjSJodzFuIWJHz06nT0yacW4sZIjPs=
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
Subject: [RFC v2 06/21] mm: thp: handle split failure in wp_huge_pmd()
Date: Thu, 26 Feb 2026 03:23:35 -0800
Message-ID: <20260226113233.3987674-7-usama.arif@linux.dev>
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

wp_huge_pmd() splits the PMD when COW or write-notify must be handled at
PTE level (e.g., shared/file VMAs, userfaultfd).  It then returns
VM_FAULT_FALLBACK so the fault handler retries at PTE granularity.
If the split fails, the PMD is still huge.  The PTE fault path cannot
handle a huge PMD entry.
Return VM_FAULT_OOM on split failure, which signals the fault handler to
invoke the OOM killer or return -ENOMEM to userspace. This is similar to
what __handle_mm_fault would do if p4d_alloc or pud_alloc fails.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7ba1221c63792..51d2717e3f1b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6161,8 +6161,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 split:
-	/* COW or write-notify handled on pte level: split pmd. */
-	__split_huge_pmd(vma, vmf->pmd, vmf->address, false);
+	/*
+	 * COW or write-notify handled on pte level: split pmd.
+	 * If split fails, the PMD is still huge so falling back
+	 * to PTE handling would be incorrect.
+	 */
+	if (__split_huge_pmd(vma, vmf->pmd, vmf->address, false))
+		return VM_FAULT_OOM;
 
 	return VM_FAULT_FALLBACK;
 }
-- 
2.47.3


