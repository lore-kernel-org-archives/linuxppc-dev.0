Return-Path: <linuxppc-dev+bounces-26386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56038C624D4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rt3vjYz2yth;
	Tue, 01 Sep 2026 23:13:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268398;
	cv=none; b=b1ClQXFFT59My3ONuDLIj5bAQtvTLhaGOUT/UaHJ4JZiNY8+HDEKMufZGX0l4j0M4SOwJT6XnjPpUAH4HMxF61P4UI3B4EvhFXQukKijzTmUPsNxM+c6AhGdg8XR4jYXiQvfwLbFxg9iQqteJOlRIpo/10uLTmpQz4ydhuS3ZFgru3NldvfKedaz+Cx4P0Mes30Z22jBJlpGCx53ZVSsVe2V95g+FLCLWo2o3ifu+0prlii57a17pLrsCF+pqp5qaAxVGdAP8Pi4UaVw3GLPgCGGPf66JJCLGHcf02fmdRkM/UDnCZ7BlLdFaGFOCBFaqVpLmDyEEp/LQJWe2RQFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268398; c=relaxed/relaxed;
	bh=uoYKoPZ7YKPmsCHG/kXIjc+wB00oulf3PAI6t9L7dXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdAFZfKfMdnnadg7V5gJlvVrIgYfQrNOezmDtKW+k1HECsGVFBFabQ4RFUbjeToMFEO1zYG50Pcdtr+ikr4loIi+DrcekJ/CDeGjc79Sn0p41PBZcDNglbonJEbwW4bzjfmdthIbjh38l1BGt41nef3zwyM6L9cofxHvbnagAux/6ids1kc0wFJpSx6dJ9grCpxUKE//NZrPsWcBn30EtdRhjreIY6cBM8l7I5pgw6QHUgSmDf1MHkX+5g8J+IUoZcV1evjQMQxNinSmXQ0du3l44RDX90gnJg+znt1Viy30wd9UTsdLjP/XPe8BgyqhSCpkKUGEbhtuGh/r/qnNkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AjShkyBI; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AjShkyBI; dkim-atps=neutral; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AjShkyBI;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AjShkyBI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rl72rqz2y2P
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:11 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uoYKoPZ7YKPmsCHG/kXIjc+wB00oulf3PAI6t9L7dXc=;
	b=AjShkyBICAQG93Xx24uO5WkxiKPbiNgccEYEo+cH2GjESgyKEM//MZ278+F6XzwOlEUJ34IXR
	gGLmLMCdZY+TwaKIQcratPL0uQrHHNhh3oTLFnFNjRlq5slRg6HK0rXoLect9UvacjQfXAPOIG/
	AW3dbypsROzmFphzCRweR1I=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qT56Xfz126M6Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uoYKoPZ7YKPmsCHG/kXIjc+wB00oulf3PAI6t9L7dXc=;
	b=AjShkyBICAQG93Xx24uO5WkxiKPbiNgccEYEo+cH2GjESgyKEM//MZ278+F6XzwOlEUJ34IXR
	gGLmLMCdZY+TwaKIQcratPL0uQrHHNhh3oTLFnFNjRlq5slRg6HK0rXoLect9UvacjQfXAPOIG/
	AW3dbypsROzmFphzCRweR1I=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5bw237xzLlXZ;
	Tue,  1 Sep 2026 21:02:04 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id C14E04057C;
	Tue,  1 Sep 2026 21:12:53 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:52 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 2/8] jffs2: wbuf: fix space accounting in recovery secondary write failure
Date: Tue, 1 Sep 2026 21:05:43 +0800
Message-ID: <20260901130549.1761342-3-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901130549.1761342-1-zhouminqiang2@huawei.com>
References: <20260901130549.1761342-1-zhouminqiang2@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.85.155]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr100018.china.huawei.com (7.185.36.64)

In jffs2_wbuf_recover(), when the recovery write to the new erase block
also fails, the code marks the already-written portion as REF_OBSOLETE
via jffs2_add_physical_node_ref(). However, the length passed is
ref_totlen(c, jeb, first_raw), which is the length of a single node on
the old block, not retlen which is the actual number of bytes written to
the new block.

When the recovery buffer contains multiple nodes, ref_totlen only
accounts for the first node's length, which can be much smaller than
retlen. This under-deducts free_size, causing subsequent allocations to
land on already-programmed NAND pages and silently corrupt data. When
first_raw is the only node in the recovery range, ref_totlen equals the
full unaligned data size and exceeds the page-aligned retlen,
over-deducting free_size and wasting space.

Use retlen so the new block's free_size accurately reflects which NAND
pages have been programmed.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/wbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 61e3dbd4cd7b..360a291d9fd5 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -437,7 +437,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 			kfree(buf);
 
 			if (retlen)
-				jffs2_add_physical_node_ref(c, ofs | REF_OBSOLETE, ref_totlen(c, jeb, first_raw), NULL);
+				jffs2_add_physical_node_ref(c, ofs | REF_OBSOLETE, retlen, NULL);
 
 			c->wbuf_len = 0;
 			return;
-- 
2.52.0


