Return-Path: <linuxppc-dev+bounces-20326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E333FF886F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 04:17:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5gqs1lJGz2xNT;
	Thu, 30 Apr 2026 14:17:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777521922;
	cv=none; b=na2Zlxuhe5SsTCMOHO0VUS+OIt4d2ibcOj3RsYjCuJxNixqS046q1EZy/kDcWTaIR2DKbmIIbQO64MbvyH+JdKAtCABTdf7xIFQb6Hr5x5RAt6kJshjD/zIK3N4Oklbw49ujEREC1cnDobUf+XMdSWPniRUfWq4Hp0xZcupuv3tGTAVENDWvqbzsTuGJw/DQUs2l798vSuNQxDcYFhvgkATQKOq2B24xJelAbtazA4Ep8k+i8ibs8dO7ebo+1fLrxFD145eP7dmyLLbPe5ziyL7f7DWURfDpn6cEQTzWmXHNv91anviEK/YBDYOwtk6m+Z99UJ41S5kwIgMHfMPqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777521922; c=relaxed/relaxed;
	bh=+yWwHlIWL+l+Dg90SDWHd1+WqElaJbqvcRn9WxFEv1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEBDrOC2HS8KWPzbz6XOOL0+tXKfweBuX0HbWXZyKNDGhIiq3PGVoKcFRqV4bIRz7nWlScvDSVcHpLD7oJ3/ZVm548dTEGb/AKkjb671aawCSFltqXFCZ3XlsyVrQ5jNp/Iw0p8dcW8wuQvUUhGyBvExZjertD7kUCORdoM3Pe1JqwVxvRNOlKFwFsq30B/wlGAT6ji5QppV2ZnwWWYfFe6nEvh5nZJ4i5XaDHf4rYloFfBBuElP3ySt1othOQY+L0M+D5Yja6/oniHU5VRHOxCmdIWWkw+JtT4QuHul8YpRHnPl+mhs06AmpK64NV8F+X7QAsK7XmvUBSVnPNeunw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ocBfK8O4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ocBfK8O4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5gYs4hnSz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 14:05:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D4925435B9;
	Thu, 30 Apr 2026 04:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E6C2BCB8;
	Thu, 30 Apr 2026 04:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521919;
	bh=pbXcAk16+rZv3mixELQ0Ipha1GpoRaVFtegxsWu8Zqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocBfK8O4Ywas1DnfVulkPf8JAygFLLLSXfSSIhFab5aPydgPGyQRMZl4VC0fcDxzh
	 ZSF8ZjBo9bGMKXhwl/M9RckUdNTcuoEDs1sQYC8HxwbacO47214ueIB5PuN5R9qPyl
	 7/vXQCjK6DhEeLKCFGPA8mBl5pi8Xir7/uhc151Nze4/YpDG2oez+rIhbMYqevbaCB
	 eLjkznrbZrf9uMIIMqF0/apYtZGMqURcRmb3l4AFBitMcYEDgyMeHrj8n9yVB0vf4O
	 no7KHvYOh/5gIxhaiyHe3dpMaQbh59rmzxY6J3CuNafpQ/IRafc5BIkfCVPTmXqOYt
	 bTDK/08BVuABA==
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
Subject: [PATCH v2 5/5] mm/filemap: Avoid retrying page faults on uptodate folios in filemap faults
Date: Thu, 30 Apr 2026 12:04:27 +0800
Message-Id: <20260430040427.4672-6-baohua@kernel.org>
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

For uptodate folios, we are not waiting on I/O. We should
be able to acquire the folio lock shortly, so there is no
need to drop per-vma locks and perform a full PF retry.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b532d6cbafc8..0d2f6af5d0fe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3533,6 +3533,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		}
 	}
 
+	/*
+	 * If the folio is uptodate, we are likely only waiting for
+	 * another concurrent PTE mapping to complete, which should
+	 * be brief. No need to drop the lock and retry the fault.
+	 */
+	if (folio_test_uptodate(folio))
+		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
 		goto out_retry;
 
-- 
2.39.3 (Apple Git-146)


