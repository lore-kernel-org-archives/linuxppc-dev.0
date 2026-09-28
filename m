Return-Path: <linuxppc-dev+bounces-28389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA59C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHV3394z3bbx;
	Mon, 28 Sep 2026 20:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592310;
	cv=none; b=kaHEC73adj1/h9wEN+bbocYQwxYCYce0DEPdRvrZxmg0SPJ/uLSrYigq1pF3/IJfY5wgGY73TQ0Bqy/o66Gmn00l0+9gxNUpwHYfAOR6p7FvV64AbpHGj3M9P+SxPcXDGxODDcsCulrUwN23GONZP8quzlfuZcwaMak+6ghvQAJkWdp/WPQvD8flXlMZ8bYHTIEDJAzx1Ypa734V2SCVK1e0IYfIjHmUlVqMCPTcGszZ6nyNsd1aP8yb9cMJClWeAk8pSb2wj2ILNbbIuS2c4EdOg40pEpTesA8KrB/DfIAHS20qS1H4tO8+4HoSQNAfQHlrvmEC/odYNacDBT5Zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592310; c=relaxed/relaxed;
	bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfQwSGNptFulf4tWSV1w0/38pZsAC+waK8jhlBXtizU0zFvMkWstFDz6QDNVD3H62sM8W+n6dCbYtakhl1n76uvH0KKKBf8p0oz789vDi6o6vTxk4o6mRyg/b/BE3BRn3NdH4Aav9PnsENrCZJA8Y2YX+4Vs6mxgCa/r/+MN8YLp6pUwwToCa90wczn80prVVHo2rsfoM7g6OHfMrNflOH0x/n74i0xCJpzOxvpyqfvhwXsCEsydD+uImiL33AvuVdqgh0isq6hTZAd+99L0vU9Zol6Ymj07htI5uxfhbamtRFYqFcBczHHOcjFIJpHtWpbOAVNhc0+5ZSi3cc5/UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tDxCW41K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tDxCW41K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHT5pkWz30V2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:45:09 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1467502a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592308; x=1791197108; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=tDxCW41KT1/0SFQJ4bcYIECV6/IMrqwvshnLNV3NZjJlAV0bD3ljPPQMKuTClB1rp7
         ea6uVxnqoKlPg4OxMGwUK+Ato4/b/aRBbpGXxzlyCM3S4tNVyhhaYPQeKGBqy18G7wJi
         IS9dZeHXH6YLVXZRK/nu/mCy7hiJVVpVOMFLjqQlh4Bjrx7s2hV0cg9BFOLaXyPwigY9
         HSVpwawmHdhH/3ih2iSL9+mrHqT4gpqV55SrL2PaiLQHHOW6ZeT2wSoRc6TGHlnA25yO
         gOU9FIN8PQQGGJz56kqp7uMR3VSMO02Tj/ixjIDxGc+9Gk69nrsCkYbpAbo4QHAiWXZP
         NxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592308; x=1791197108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=Xl90ok94iqxfH84THv3hOj7lZ8uZ3TsHo0Xwb6Nw6vmHgoSlKVT3PNGvstKn6Nt8Ea
         mPPnwDoII+99Ij4WYhc/GU1GzMLCRVk3TuMC4zkCSKkTZvyki8E/Qxy1LghqD4o4Si+z
         LS3RY28GY5I6Hu5HfjSOTAYUwkHHKULzbbrn92Bhr/IPOvnB3x9hkyQzcYVgDmb2Uzs1
         LsHy7jLGRuquUljRVJImWIoso3z1Fak9sZwEBmHTDEayr2qFsWOCgWlLQaexBG2xtK29
         JQpGZagFuitBEf4n+Cc7CdHNfRH5WJw9RG2TLqfy1FwJ7CsoXO5Wa9XaSBJZ5COg1kBG
         /u4w==
X-Gm-Message-State: AFq9FYIU4ueGNSnK1ZoZyI7zlGEhnphwvfK1yH0x5bBPSCN7XGXeQnO9
	p88APiKflKkMEM6YSLZApTi1APWEkr0ancX+UkJiNgJM5RR/kwi8+G1aZyl9uEuJ
X-Gm-Gg: AYBFou1lSJm4XVYKnjNELc+/uSOHj0FJYKum62ZvI0h5WN0YzpV0nnS9ix8JROs99vz
	r2Pms8/aTQSt2/s9koPn+EWZH4TugwtrUdaO4TKD4Z6SGOQFuzjUrm1AFnAPTaKmgMywxwwjnG1
	3wcYbYm57ZZtOlfEZXsf+PrF6b0ALvuf2CvUS3KW3OdFXT34XIT97Ms2XFdkk5zRmrDJiVWceHL
	rKw3UAXsGItuvkiibpPLu37HquPE0KDU3n/oM0vtx39JvAGq20vo+cGNMURa3YcITVVbPvxa9Kx
	w0ypijXHYKKGNpocCZk7TTs5pJyN65Cbn8RTNBMcsj1rmfeS3HQF3utPAFdHGI8c3JlXqEYJ8RS
	E9c7DZKFD3pQ+mEij75Jt2hDW+d2t/9HaZkl7qKDZkFVPk3FEY7GrEjP9ObtmxiES1+6xYyK69J
	geIz8UK83Mm9FrDlqLUM8OzmQbCGlYqP5XEizjaamtzkIyewhgHHclS0pRr15lHeIGxUfX39i/9
	ah2d+h4hbev0RL8bbOwUu0MFUjQvz0FkW9vbi0LH9HDyCV7oJTSm1Dn6Qlm
X-Received: by 2002:a17:90b:2f8f:b0:3a4:6ff5:777 with SMTP id 98e67ed59e1d1-3a46ff510d8mr792278a91.43.1790592307645;
        Mon, 28 Sep 2026 03:45:07 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:45:06 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/6] powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
Date: Mon, 28 Sep 2026 16:14:34 +0530
Message-Id: <fb81802909fc0e5e17506f900239f97616d2dd2c.1790590014.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790590014.git.ritesh.list@gmail.com>
References: <cover.1790590014.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  subpage_prot.c:83:2: error: releasing spinlock 'ptl' that was not held [-Werror,-Wthread-safety-analysis]

pte_offset_map_lock() holds ptl when it returns a PTE and
pte_unmap_unlock() drops it. However since the lock is taken inside the
helper, which is not annotated, so the unlock in hpte_flush_range()
looks unheld.

This patch fixes it in hpte_flush_range() by adding the needed
annotation here. IMO, should ideally be added to pte_offset_map_lock(),
once that happens (since it might need larger enablement), we can remove
it from here.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 37d47282c368..d641c35c408d 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -73,6 +73,8 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return;
+	/* pte_offset_map_lock on success returns with ptl lock held */
+	__acquire(ptl);
 	lazy_mmu_mode_enable();
 	for (; npages > 0; --npages) {
 		pte_update(mm, addr, pte, 0, 0, 0);
--
2.39.5


