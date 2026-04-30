Return-Path: <linuxppc-dev+bounces-20327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC11FFF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 04:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5gr003XLz2xnH;
	Thu, 30 Apr 2026 14:17:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777521916;
	cv=none; b=cyouPrc3ZayDUu3ZtQAGh3vVy0iO7uZoKctr4KLoinIe/Qb74OVNccWYnemTo489WVL7G71l0FfK4luc/tbRKlpMSgGjAijmnlYofATRFMO8a7XeJFdDx+cwL+MJN0J7p9rSxnse7CskD24UJ+QCyQ4TFX5G+DUaq1dRmqMEqG6mPBMHVtRJsrJF7sGUOZKRpA3/kSE321NRfBLm+eNLHPEQJDYzhYydqFS0VQ3QGmEpPUBWCfM96S/EmZYPUXg5iuImN3rZizZ5xv7SPbtjz/szP7QtX0dCr1XLMceCAovKBpXvDQDHDoNR6jdhDpy988cry72i/joRP2qP7rbuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777521916; c=relaxed/relaxed;
	bh=AjOwhtb3aLC8dXcF5fdBlXdpp4mSyr4Dq8lBNuOOORA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oH2hl5hpfj4ylb1bMnZ2dfufnsOnteFj4ZAfUV8pv8qxlbcRY6GohTDZrWpJ0Kj/Y6DlqwoDGmtatPRI73J+ftQGHtyoEHgcWaQ1MbhRIr8uHR3PIh7Wzi0wTnnTm1PE/atdmYv3DmRNRoqTLk8ghOKbyGt/3I3STukmnnAIi9WOP7cw96XI3AS9dxsXfAL4EjYSpUzcFSRZahaUkjL6QqNxKNlAk3h2nfx3V/ZC0ZsgaMO/wqDl0+3f6Yl1dLZ10i/f7mUSaA0nERZwMxAhH5Lc38d+4VdQYXUOMx4W/XZHv4A4vuooVxjNc8tdDnb7+Me4pDauo2o2JmG9uGIMgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJyCN/cP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJyCN/cP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5gYm2jCRz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 14:05:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 953E9417E4;
	Thu, 30 Apr 2026 04:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B00CC2BCC6;
	Thu, 30 Apr 2026 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521914;
	bh=6MPYWPf1QbIXw7VCTkYtFV9yBQTJYYcQnuchAn2u66s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJyCN/cPD0/zuU5TMG/FWh17eVTVcTCG22wyND+Ln22vdCzvScs+KeOLVG9RmOssZ
	 jDw1d8PhCAGGbMI/IFgx4Z5EBNcmkVO03z+9/CJtVz3K4wxUxjDLHuhXQrygfZY0vj
	 Mz9EPYWMtvXMUkv1GvrXcIXqYy7f2Nbz3f61nlophvJmqpD4ikN6UOlFyXJonZi3kU
	 apK9iwjy49sl7fMM6lNjIBPwaa1bmY1pG/z4xtRWqVUh4kt9XKZhnZLwyhRWE61vDF
	 fxzmTVdxergJndpikZIoTxLjBRYHAUamicyvLwT/yqUnIVLaZSAeOqCic0yYJ36c4O
	 EWCGitvEei8LA==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	willy@infradead.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	pfalcato@suse.de,
	wanglian@kylinos.cn,
	chentao@kylinos.cn,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	liyangouwen1@oppo.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"Barry Song (Xiaomi)" <baohua@kernel.org>
Subject: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate during swap-in
Date: Thu, 30 Apr 2026 12:04:26 +0800
Message-Id: <20260430040427.4672-5-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>
References: <20260430040427.4672-1-baohua@kernel.org>
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

If we are waiting for long I/O to complete, it makes sense to
avoid holding locks for too long. However, if the folio is
uptodate, we are likely only waiting for a concurrent PTE
update to finish. Retrying the entire page fault seems
excessive.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 0c740ca363cc..a2e4f2d87ec8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4949,6 +4949,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	swapcache = folio;
+	/*
+	 * If the folio is uptodate, we are likely only waiting for
+	 * another concurrent PTE mapping to complete, which should
+	 * be brief. No need to drop the lock and retry the fault.
+	 */
+	if (folio_test_uptodate(folio))
+		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
 	ret |= folio_lock_or_retry(folio, vmf);
 	if (ret & VM_FAULT_RETRY) {
 		if (fault_flag_allow_retry_first(vmf->flags) &&
-- 
2.39.3 (Apple Git-146)


