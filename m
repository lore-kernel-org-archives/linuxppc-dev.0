Return-Path: <linuxppc-dev+bounces-18848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CBE10A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkkH1JSsz2yT0;
	Fri, 27 Mar 2026 13:15:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577703;
	cv=none; b=Wogb0kmwq2LhzcVfOp36rJRairvTucdsX+NZkbphIS2YuPCkFXats/+S5B9qWenjUATAFu7lkNUHLBE/KQEwPSEXVo+2iWTIWRXVssFcUjbRPzqZAPqaCasMRqTVh+ocJoSOewHRziVgo0kqn5wjt6N7x+qbsasfgACbflnvdoalRJlSZfKnsmrobDm+A+B/j/FgPABAyqRphVAa23ZWyVLTcytCz3jahfzlHTTUaJZhcbGWPeIjzDsVBFFBSyRgvQIEL+uDOdOwhtykj8vtsER30P7KVhqWa/u6OrSZ65VoSrcCPOP2ylyY1Hagdc864jafrRXYrnF8JQ5R7xgpug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577703; c=relaxed/relaxed;
	bh=sLE/jttxUNtNWJGXfdbfQ0fLOQxN3ImdDTn6kFnTkPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDRwPS/PlW1eVi0wv6wmj8yi3V7nAcBUxb9M+Sk+KEa4cbqGFkXrhDNMxSX/DqcXKc6SUApiCaiFAXkUKHjNz7UqDvZ1VwW7tc1zd5VIGGJyeJr0j8FQkG3jQsvOdZQeDkoxEX8oUDVonMIMhWh99McuesdJf7BEQREfpSaqRctqfHX9pgjav0zvtS+csbnbRvhyUfcdkCkBfDtdwBoXzCy9qlM03T3P+Fr52QKfV+B0OpdMwjf1pzkPgvw3Yf5SoIh2+blhcqpxCSoruhxmb3Jyt78SDhmMvh+k5CuvGltxs7HZ0tQD8Wt/740B51TtfF7e2b/JHJP1EGF9vWpoOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOqb9c3q; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOqb9c3q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkkG27ytz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:15:02 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLE/jttxUNtNWJGXfdbfQ0fLOQxN3ImdDTn6kFnTkPI=;
	b=HOqb9c3qtURSYEfsDks7zbx2QDtDTH9l8hI6RIZbNZVZjMBH564Y3pW5ZPIcsI8NKoiThq
	EoKp0vqkwqrK6t8HL7D5u0ey61UVlkvaX3oR+haZEDWM9M+SC4Ti9llRE18ryT8ip3fCx4
	H6PgMQ7rNNkpgtUJP6NJzF9wyR2yris=
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
Subject: [v3 05/24] mm: thp: handle split failure in zap_pmd_range()
Date: Thu, 26 Mar 2026 19:08:47 -0700
Message-ID: <20260327021403.214713-6-usama.arif@linux.dev>
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

zap_pmd_range() splits a huge PMD when the zap range doesn't cover the
full PMD (partial unmap).  If the split fails, the PMD stays huge.
Falling through to zap_pte_range() would dereference the huge PMD entry
as a PTE page table pointer.

Skip the range covered by the PMD on split failure instead.

The skip is safe across all call paths into zap_pmd_range():

- exit_mmap() and OOM reaper: the zap range covers entire VMAs, so
  every PMD is fully covered (next - addr == HPAGE_PMD_SIZE).  The
  zap_huge_pmd() branch handles these without splitting.  The split
  failure path is unreachable.

- munmap / mmap overlay: vma_adjust_trans_huge() (called from
  __split_vma) splits any PMD straddling the VMA boundary before the
  VMA is split.  If that PMD split fails, __split_vma() returns
  -ENOMEM and the munmap is aborted before reaching zap_pmd_range().
  The split failure path is unreachable.

- MADV_DONTNEED: advisory hint, the kernel is allowed to ignore it.
  The pages remain valid and accessible.  A subsequent access returns
  existing data without faulting.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/memory.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e44469f9cf659..caf97c48cb166 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1985,9 +1985,18 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (pmd_is_huge(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE)
-				__split_huge_pmd(vma, pmd, addr, false);
-			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
+			if (next - addr != HPAGE_PMD_SIZE) {
+				/*
+				 * If split fails, the PMD stays huge.
+				 * Skip the range to avoid falling through
+				 * to zap_pte_range, which would treat the
+				 * huge PMD entry as a page table pointer.
+				 */
+				if (__split_huge_pmd(vma, pmd, addr, false)) {
+					addr = next;
+					continue;
+				}
+			} else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
 				addr = next;
 				continue;
 			}
-- 
2.52.0


