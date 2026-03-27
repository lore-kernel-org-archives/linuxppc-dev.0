Return-Path: <linuxppc-dev+bounces-18856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1186F10A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhklD6Y0Mz2yjV;
	Fri, 27 Mar 2026 13:15:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577752;
	cv=none; b=NzcfB4jYZJang3RD3ch0tWs/w9k5Wkpq1mRMOJshW9Ff9YSSWsZRZ5vGfwlOHGr3JiajfqMl0hykD3YcZFrddlBqoVHoMw2xdtCnYrCDrHYS9FV2BuxerDhx3GxHn7ThS+PnyCn82YEtxzxeNiwXEwpx4VYXiB8AhAk7zwd8KACCjtX5t1geK6QKqZpyBg8VDycx91kG9cqT9YyvWi3NKKVpc2I4hZdtQI2g4fYqxvrcHuxg/tfrKwJo56saA+tNEUICijRARvlEMkU9o+z2mUQz2raccwWwKuDvV/pQ9UyV3DuMZqHwQR5imtqZ8MZW0zO7xaRNxwZOzPg4PdAVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577752; c=relaxed/relaxed;
	bh=XO0R5fX+FiXnuLY0HoKuyc3BzHok+k+2YVFrwxlOH1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpONDyesLe0PzVWAMRk2Vz9jdGh56dUgjQCZ9dLMtZldg5gebopAec6BC+KwroH06EJh1DmIHMiWH2QypfbGUuFOU1PrU3kDvMfdjgONfxGDYWYi2o/14vrTViXC6E0q9B1HHhsmXGuAmqR+BQTbVMgTB+L0uzUjFD9+0RPlHQNvgP6eswrixIhiHOmWDvR0DrEyMBn4EiUX77t7NIjXd1R0QJJrXGhESE11xtHzGinxjNTG9Y2g+HXgE06kbaN2VwiVvKzPNxEslJieaMZfCr0sI4NFjLUbLU7U1bzjucJIXSuDFwIjqMATe/bXeyaQEfEfBPHG/y6z/vcbjFDQPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ffpxHw+P; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ffpxHw+P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhklD1kPWz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:52 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XO0R5fX+FiXnuLY0HoKuyc3BzHok+k+2YVFrwxlOH1U=;
	b=ffpxHw+PDquRIY7PsBB+gYIVU0HGhnrg/lszSQI4Ss/ylyOhYh/GY54SqX/Gjmz298GChe
	CK1RQEiqAUEGH9vhPBlSkxZYbNei6tVRaaPyX3jC8Yd6BbKN5MzHnqPEqfYrvEF6cG/SMn
	RA3uLKxe+69mdcNlUOoR18d3XTq3a4c=
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
Subject: [v3 13/24] mm: proc: handle split_huge_pmd failure in pagemap_scan
Date: Thu, 26 Mar 2026 19:08:55 -0700
Message-ID: <20260327021403.214713-14-usama.arif@linux.dev>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pagemap_scan_thp_entry() splits a huge PMD when the PAGEMAP_SCAN ioctl
needs to write-protect only a portion of a THP. It then returns -ENOENT
so pagemap_scan_pmd_entry() falls through to PTE-level handling.

Check the split_huge_pmd() return value and propagate the error on
failure. Returning -ENOMEM instead of -ENOENT prevents the fallthrough
to PTE handling, and the error propagates through walk_page_range() to
do_pagemap_scan() where it becomes the ioctl return value.
pagemap_scan_backout_range() already undoes the buffered output, and
walk_end is written back to userspace so the caller knows where the
scan stopped.

If the split fails, the PMD remains huge. An alternative to the approach
in the patch is to return -ENOENT, causing the caller to proceed to
pte_offset_map_lock(). ___pte_offset_map() detects the trans_huge PMD
and returns NULL, which sets ACTION_AGAIN — restarting the walker on the
same PMD by which time the system might have enough memory to satisfy
the split from succeeding.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/proc/task_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca19..f5f459140b5c0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2714,9 +2714,13 @@ static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
 	 * needs to be performed on a portion of the huge page.
 	 */
 	if (end != start + HPAGE_SIZE) {
+		int err;
+
 		spin_unlock(ptl);
-		split_huge_pmd(vma, pmd, start);
+		err = split_huge_pmd(vma, pmd, start);
 		pagemap_scan_backout_range(p, start, end);
+		if (err)
+			return err;
 		/* Report as if there was no THP */
 		return -ENOENT;
 	}
-- 
2.52.0


