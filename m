Return-Path: <linuxppc-dev+bounces-18849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA37110A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkkN73PDz2ygY;
	Fri, 27 Mar 2026 13:15:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577708;
	cv=none; b=d9mm4lvjPTercly7TPrwtOH+IGUJWTueYIg6oF8ZIUNwZdAZqtFc4nzBFOi2LS3lqXTHDimjz+DpTBBk+wbqg51QlT7IYx1mzvGB/ekHcWxIZm1IvLOhU6+wVly/GRWdFlJTlpx0vx/3RvyBJkBaXMI9xtelhrrXG0BinMsnIER9kEpOWtXRQ34Nb20mHld7+hj4DJSUztbYuLwNw/ju3nkR+Y+NgIKNqctDD7URkh1i9AE8zAxCYEe+XN9pneNNCoIabcnqmMCVAZJ+pJvZEXbt1+yqC+chgqw0BWEiPzGRrq1D9hyv+j1V59Bue9DoQJxAxYAOTBUn7BFqXYgcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577708; c=relaxed/relaxed;
	bh=aCI7ssiILkMHWnNEWRqeaTC8kADA5FVp8TNFAvIRw20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og7GPQb2SB/NsZyR6y/NVESx8St+D23rAmkYUEfHnEzQLuiOoYubX5GGfvEwiFZTF8PAoAZdgbakUMkOZ/gNIc6Liaj3y3ZgcrhuHGXYwpXD7bFxeTwdDFA8MbzJbQpvGiACSTnSQAr84gnHLRcww/RNlMm9BNpGWGGhJIjTvoUxWa56vxFgOUZFoA6Z9vyGg4ud8se67bSqRuw2GXkv48uCwtmToM2Temm7ql4m+/AB+OuaRlYsYqX+PSIF/6o+dCOmK5N/hBWfUBjy1x5DOONkV3zEl8fvewPALMLMDkkaF2MNvmT7OC6/5g90Dwt5aTplRGcK0hx+AwkLl6+xbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qCDvFHls; dkim-atps=neutral; spf=pass (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qCDvFHls;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkkM4sYgz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:07 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCI7ssiILkMHWnNEWRqeaTC8kADA5FVp8TNFAvIRw20=;
	b=qCDvFHlsrwn4BvHyl/OogfK+SU4PjAk/orshzs5oMnmbbYqMdO8VxcJG7SBrE5JnvZqhvW
	kHDxMSY4i21WqlUHUenbjsbHJeQSPwrgThPtMRU39TVbMcqqZ2CIv39avji+vUki/1rSj8
	MrVPi7UsYpHW/i7zFvcn0mt99gsGNQA=
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
Subject: [v3 06/24] mm: thp: handle split failure in wp_huge_pmd()
Date: Thu, 26 Mar 2026 19:08:48 -0700
Message-ID: <20260327021403.214713-7-usama.arif@linux.dev>
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
index caf97c48cb166..b99ec3ffc18d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6328,8 +6328,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
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
2.52.0


