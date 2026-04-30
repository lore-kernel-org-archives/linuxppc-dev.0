Return-Path: <linuxppc-dev+bounces-20329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C5FF886F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 04:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5grF4Sxfz2xjk;
	Thu, 30 Apr 2026 14:17:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777521907;
	cv=none; b=cjLWi4DsTqvoPJuChHkuB6yoy72uQFs+HP9bNjm68N3fgbRUIQts4WWH0PbL6sBiBfFiBr9Vy4ehuaV2o1eq9eut3OuTfz0QOzfmpnGXJ23Nb1VKKX/C2uOo6WbQYRmI78T+hqAKC2GLLT/gTzEg7bWTCm/tHs3Bws5TFpnbfnoHHEHJwiqbUxeZ8YeoEENDt5urskzf/yNd29b4hOCxbMFyg0Vek6wTaRYOLmbvH6ZxkabBkCW00nEYxB5YkDO8RoO9Zvi+IM0d6v+2Cl0trl8kz5110X3K+tYjsfbp76fVdAnD214PtPLWlNqGvi2P33hmLR5rVROEyHE6c7e5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777521907; c=relaxed/relaxed;
	bh=e+UUS7GUGZaVgbrELoIxuwWRfwzqtpp9mPPWbq3QxPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyAn4hfxaERH+roI7Y89k3m1t+yuXmfVtWitQBBQ8Us11HiazUGZFpggagYOVGuWKLrLH09p5viQt6IFvGe9ULZ5LhWDAu1eUUff4wOP1N8TtOG5lpQ9QM91gUdYoctRpBo3NXKN1AcHyrXyWg3+lDBxisV/czULW/D/PqopJXy3A3CCtu9kY72YVNuUi2DR+IcsUA9/VN5MQXW1o/417vmEquCxgtfasIyVoVEeiWImgXLCbblGODg+Kv2SjtvMdk0HbnDKXQjcPWE06LXkP+RFJGWWVV2KB9yVuGilBv2YO1l512SywUqXtcey4v3gHh1F3ZRyiuqHa7D2MdiEFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mKwVglCF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mKwVglCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5gYZ45cRz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 14:05:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A3E16132D;
	Thu, 30 Apr 2026 04:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C627C2BCC4;
	Thu, 30 Apr 2026 04:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521903;
	bh=3UzddeMl13pC5cJUrT4HHkjYBFF8Z0grqJoknqLkHzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKwVglCF7XEsFftOn0BAtLwGM5IZ72wXKgPaG3s9rdnfQtx+pmDdlMhp0BTc5EYNf
	 FJboHwOiMXC33Onbze1GSoNvzLlFPIK9rhRrqSsueRkYACFW51iYCE+t5LiSSUtrDZ
	 6Zgo/egoBF46WoaKKLJpL+hNtjheakCbbtpFjT8y7TDrK7Ows6M9EqK3rdErLUzivK
	 4Ay85oZFt3iFrC53ukdn7sqXcw6md9eq3jFLK0YjDszHvyQDD9gHGtkAjd47bH+XH1
	 stGeQfEGcaAiSsSh1IY9gXD9Yt5DxgBQ/zzQ6kcBG30A7WMR3XO465Eebcb6ZNIjyv
	 BawWjDw+St+Lw==
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
Subject: [PATCH v2 2/5] mm/swapin: Retry swapin by VMA lock if the lock was released for I/O
Date: Thu, 30 Apr 2026 12:04:24 +0800
Message-Id: <20260430040427.4672-3-baohua@kernel.org>
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

If the current do_swap_page() took the per-VMA lock and we dropped it only
to wait for I/O completion (e.g., use folio_wait_locked()), then when
do_swap_page() is retried after the I/O completes, it should still qualify
for the per-VMA-lock path.

Tested-by: Wang Lian <wanglian@kylinos.cn>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Wang Lian <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 199214f8de08..00ee1599d637 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4791,6 +4791,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	unsigned long page_idx;
 	unsigned long address;
 	pte_t *ptep;
+	bool retry_by_vma_lock = false;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4896,8 +4897,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	swapcache = folio;
 	ret |= folio_lock_or_retry(folio, vmf);
-	if (ret & VM_FAULT_RETRY)
+	if (ret & VM_FAULT_RETRY) {
+		if (fault_flag_allow_retry_first(vmf->flags) &&
+		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT) &&
+		    (vmf->flags & FAULT_FLAG_VMA_LOCK))
+			retry_by_vma_lock = true;
 		goto out_release;
+	}
 
 	page = folio_file_page(folio, swp_offset(entry));
 	/*
@@ -5182,7 +5188,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 	if (si)
 		put_swap_device(si);
-	return ret;
+	return ret | (retry_by_vma_lock ? VM_FAULT_RETRY_VMA : 0);
 }
 
 static bool pte_range_none(pte_t *pte, int nr_pages)
-- 
2.39.3 (Apple Git-146)


