Return-Path: <linuxppc-dev+bounces-28416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE3DCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 16:40:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htn9C1Sqgz2yMK;
	Tue, 29 Sep 2026 02:40:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603211;
	cv=none; b=YDPmb2qzOXYna+xZ68SZhSwYW16JqxPoxCwXy6FYBptTPe5pb58pihtFvgnNaqLCbCuvlJiUEr/cy4YPZpN4esXM9IG7hI9FXq3xJgJj8Z0Yd2bBCX9bcX87cZLWUMrcO9mpyd4BuZK3swBJ6SHUDyuXaqPHPzDgylf5GDbTWXqCeY7JpTKIDZW7lHohpOmdesJpmCvH3vcWPHQv+Pv9+pb+xVZYstS2VjPzL4Y0MLRn8mr3SG/lEVKP1E043Mphfv7L/L+V1mCZecDr1mvyYWPti1Rlcr1042hhSPbBIjeMFV5dtJStm2owRCJyp+7v5JQfw1BCFGfocw48Y8xt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603211; c=relaxed/relaxed;
	bh=XOJXYA9rQ4lFRHo1EDsql4tJzWZKNZ9h7Ec4LEePgas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJxkxkORXBTTjPGwKs4m1Hb1ej9LOPwitLAGcO2RBcG8VCWVs9ZC+Ri9j7H3tLYlKqYAqQ3GjaxPeIlm3iKnxIo6oV6o9Z6SfHbD++a/6LCaeqEBqfHGN3JCxIaZG8C5lybXcXM7UFxGpB5OENgb1YtfpCzPDyaMPN5RKuX0DbtMAVD59tcntJeab50iKMv+ciLx8gXp2YWGXVtIgsjqJJOGsagmvcSU28PJFSoaUzR5rBmblpf4a/yqRfaM55SkMZaidLvx8/XIcHV8o2YJ3fRlcJL5bGd21taNKG/zZmc7HcifrEz4c8//B0nY0177szFBsRsUBWMerNvIUpgDZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=YBwLcvpF; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=YBwLcvpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 306 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 23:46:44 AEST
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjK06HLVz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:46:43 +1000 (AEST)
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f428;
	Mon, 28 Sep 2026 21:41:11 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: mahesh@linux.ibm.com,
	andrew+kernel@donnellan.id.au
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] misc: ocxl: cancel XSL fault work before freeing SPA
Date: Mon, 28 Sep 2026 21:41:10 +0800
Message-ID: <20260928134110.227-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-HM-Tid: 0aa0e83f820903a1kunmbc7156bd20018c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkJMVkpKT05IGRpPSxlPTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=YBwLcvpFi+6rs7TsdwYgfLKEl05w0FfvgiSvnPQYBvBWX92NOGzxbiY59aeIniMW6STTjTaYc2gWMLRrz2yCvdfrKRd9u+fXMl4d7LZjC7OdQ4zCJ/j+YKY0imljHsGwQBSCWUYKDQM6gCnvBJFAQ/yr09bCYf1Mx8sbyuBmNU8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=XOJXYA9rQ4lFRHo1EDsql4tJzWZKNZ9h7Ec4LEePgas=;
	h=date:mime-version:subject:message-id:from;

The XSL fault interrupt takes an mm reference and queues fault_work
embedded in the SPA. free_irq() stops new interrupt handlers but does
not drain an already queued worker, allowing free_spa() to release its
container first.

Cancel the work after freeing the interrupt. When cancellation removes a
pending instance, also drop the mm reference that the worker would have
released.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/misc/ocxl/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 7749dcd16117..8146e98e77e7 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -335,6 +335,8 @@ static void release_xsl_irq(struct ocxl_link *link)
 
 	if (spa->virq) {
 		free_irq(spa->virq, link);
+		if (cancel_work_sync(&spa->xsl_fault.fault_work))
+			mmput(spa->xsl_fault.pe_data.mm);
 		irq_dispose_mapping(spa->virq);
 	}
 	kfree(spa->irq_name);
-- 
2.50.1.windows.1


