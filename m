Return-Path: <linuxppc-dev+bounces-24730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C55C531CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:00:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5WST2Py3z2ygm;
	Thu, 23 Jul 2026 23:00:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.67.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784795201;
	cv=none; b=B6vXIcQ7YMMjaXr2Yokmv6tBjYARgrKb+RZuZqb5/QtFQcgKR9g8Gi59XMctcF0KqO/PWJyiJLyN9gOZuknQkehzoybgJv1l7XOUIVYYhgTkyJVuectZQDwm8odsfRINi+XZytWhr5qHTz8a3m497nto/zhd395GK7RSGtXr+ACFBglvC2sCiFrt6GJxz5tgGwsLbBnhtz9mqgSkEemY3H6Idc8pKI8P4aZS9vJbhl308GTvVDk+OfTDlo/ANpSs1zNuEAVOAK2t6Pzfko17a/hcmTYInGNeevOb6YkjMxAGNgJXPsYzssITsS1sC3XYITSChqcwtXv+79WN/1/tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784795201; c=relaxed/relaxed;
	bh=5Ru4P6jK+Inu2P6W3ZLj3pcMa86MCoNiZGSUv0GMeE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kE8bJodmZY9zUnZt2CcpkQlJ9I5aZueqh0qkZBor+wW1CinxT8NQhxH70HO6cg+Hk7yzfh+zHjO7whDS7G95b9oMIksPKfUizdbCIFAaKoigFF+W8z6e6HLc1AlPY2YmqtFEm43gMNcaL9QV10ap8lqR59RwDrFwNhem8Cg8Jh8AGvA+L2rfT0agkiWm0/PT+TTwm4mVZTjXttEsfph5ouwdQcf+sICeN3UN8KGxzYyDnQaFoS+0yy/mi2w+dBkIcA8QiEgPYAfeVHSoMlxZeUAeOpnR/wINOZ+UUcrypw7cqPzA7D1Pn3CA0riQrzMgUe/3A/CNTKmft877t+mUrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iPwQPOZ4; dkim-atps=neutral; spf=pass (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iPwQPOZ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 392 seconds by postgrey-1.37 at boromir; Thu, 23 Jul 2026 18:26:39 AEST
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5PNb4ltGz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 18:26:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784795139;
	bh=5Ru4P6jK+Inu2P6W3ZLj3pcMa86MCoNiZGSUv0GMeE8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=iPwQPOZ443UYV9x3DqVo7UPDwNu4TZrQLKPIeDn6+tNR+EnHiLOVeHmM767BI1VqL
	 fa9hHLnM0nhod/rRVvkZPt+PgHZOUjbdzV+V8SxrsSivbWMZGOY+zIAUa690E+x9Q7
	 PTWzKTp2ad/oiX5/Sflg5zgu1FkG/jZDP15Ol0Cc=
X-QQ-mid: zesmtpip2t1784794713t01a6cdde
X-QQ-Originating-IP: HMKwZheqtj88lyEjppGtB8zm5VBw5QQ/hPZB97lqyKU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 16:18:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15366830240286596552
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	ynorov@nvidia.com,
	namcao@linutronix.de,
	mkchauras@gmail.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH 3/4] lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations
Date: Thu, 23 Jul 2026 16:18:12 +0800
Message-Id: <20260723081813.176792-4-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260723081813.176792-1-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OKkKo7I1HxIeQV9U2RZxY4bwvwvcnPjM8Vmudnc31Pybq00NapJna6N1
	c1lseRoOvgV/Xr24ORV40wHnHTnjHXB7I7E8+ig1Kp45Eupr8g0oVEgD5D50pYQJDOBvg0e
	L5KJ6R0263BrwTAsggM5rbuVfUS/DSkhJTi1ah1Lv8NtVlSKP4LRye606W2LgyGiXDA0LEd
	Xpk6acbe9fW9XsBUXZXK97Kb7cJWUuZXFML459WHwE5rlEHVexQCPZyfqboX6ZVHYHDwihH
	MCkXv5NCfT4LggvCvsLB7a1aYxUy5maA/D3A2D2/PVFp4cPV9aUNpHDskSI7cUJEnHTYvAc
	VC8lkb5668VsHEk8kknBg/r+SJVPMnC/KlOE0a42GT9uHmFJa+sRIwJ8mTiQfXETM8ijwKG
	MgOMI1y0lJnwcqSXUwJ6FMVHOcx69UUJoTfwUmu9a/U9yy5nnvRV502umokB8AUi3VwJPND
	1vcdI8n1bqOmgDZmQBqo37e8e9X9Agf/0FwlVbGX5fKHV2C6j8QMcUH8S7Bvvaa0YUAsvDE
	TL0s/9oB2e4fY7089SSmrYSgThypSWLqXw7id7FoPHCVJy6eIHddyf8qfJ+puhxfc2UTK9V
	6XSYE5uOGunRSmhlj+OKX3rrOETfUc9ATH5310qbJbqwfOoKV3MKwGSbW7qcLVSee08TsxQ
	0yE2JSVMlQJ4UJXiqkqGWu9oO0Pj7oiJeSxFYhvZyMRyle3QAPoJ0vVbEpTtFQ54V7ohB3+
	XTG9YJ5oU7WvHopvUSx+Q7hQZ18DkI2B4UX3A7y93wkBDlTTzw4KCzGK9rU9knkvRY1h1El
	7eB2zjQsx5Oz/vacCJ4fB9cEoX8yQt3fyxBR2FHxt5h7qgR00GRiyMYKa/TE0pvR9ukCtPx
	YA+7BrzqpCj9Fk8qIus4tLKFv1do1VistoaVKNZX+PBSKpKUjyvvChGhFugnNTAxmia559F
	CsaXU9rh/4rafnmWUjcDx7AygJKNrzhZOBc9pxKxPASrB5AxcFCZ2JkZ2CMXoojM/XEMNWz
	ybqOz6qZ0spBOuT/AwT50sBEth7B72gt4cwUDnjltH7C/xVg+O
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

kvcalloc with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL checks are unreachable dead code. Remove them.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 lib/test_hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 9c59d1ceb5b5..d615e4e5fc44 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1209,16 +1209,10 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 	if (!mmget_not_zero(mm))
 		return -EINVAL;
 
-	ret = -ENOMEM;
 	src_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*src_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!src_pfns)
-		goto free_mem;
-
 	dst_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*dst_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!dst_pfns)
-		goto free_mem;
 
 	ret = 0;
 	mmap_read_lock(mm);
-- 
2.20.1


