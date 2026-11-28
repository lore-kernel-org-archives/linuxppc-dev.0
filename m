Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1E606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TaPwroic
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc59B1Bmtz30V2;
	Sat, 28 Nov 2026 20:49:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795859374;
	cv=none; b=PJoJOfC026MffuIpIz9sorEPVJHwOeWKfhNZh7q2GwtHmKpyOvd+ZAsn7p4joT72g76a0gpRoiQ/Z7V2eki52etH/JiqBtVYRdUyn1/e7CCF5miNz6IXDiG5PSPYsXLRxfRM0pht+cSrg2RX/UI/pGxoksyxB1uQHeBc8OOJPPkT8uLDpufllUVfb7JHZdAe00e/8AvzNX/hZLsZ+5HYrg33oT3nKa3EckDIjUR2es5/92rP/PmsuH3BJTQJGbAPnZ0685qHLnqnbn8pX2+oxKlTtbcyBibJ+McEovPcD7dTvzEsRqxev5Iv+24MSciKH46YuVWBOKsyxPe2n8wZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795859374; c=relaxed/relaxed;
	bh=a6KQkBDlOnA+9cBuc86DyZ2pfHU8+DqCe8yKhntGTCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQNIzwPen7Ipd4oH6bhCLO1NqvalWewSq5lH//xU9UHM1qxlIkz/1S72koEAlK9bordFvmmLSmulVNbUGGU3l4qMQcGn5d6x1Knl881UCu+vx/ZS4yzujkCID/hw6NkCfNd7TbokPe3f4ly8aEnjVPpyoyeKp1K3tWQchEzAFhEExyfPtG+Z8+kVFP7R+BBdhOP0oZK4BtUMRfk4oLlddIbE+t3TNuYlmJxpCfuoH8yX0RvyNMDqdAUQsUrdMXBH1yyspATtSC8PF6tnxiCEaZ8SD4UhPecbZlDDWudDyH1iD8HoYfyzNY3El1YdLdJRm5zl9cWMocGydHyJTQ7uYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TaPwroic; dkim-atps=neutral; spf=pass (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TaPwroic;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc5953zsbz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 20:49:28 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b08a4;
	Sat, 28 Nov 2026 17:47:24 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: chleroy@kernel.org,
	tglx@kernel.org,
	bigeasy@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] soc: fsl: qbman: Disable manual unbind of QMan portals
Date: Sat, 28 Nov 2026 17:47:23 +0800
Message-ID: <20261128-f81b700d6c-u20-2@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128-f81b700d6c-u20-0@mail.sdu.edu.cn>
References: <20261128-f81b700d6c-u20-0@mail.sdu.edu.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2218d643503a1kunm46250e204521f9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx1LVkNLGR0aGE9ITB0ZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=TaPwroic10OPXmLqyPUOuLy5ul37dQOaldnQbnp7SDvtY1mv3H94Bm8/KE9VxxLeRw1nmTS+htTL8ymFSyif6jXBmgncXHGtQCLfgrCrDScgk1rHGpDXNpo6O/1Ahl1gp02ZIu71P6K9qRQ6nVGVkPIza6kddz7XQoQj5sGvmsk=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=a6KQkBDlOnA+9cBuc86DyZ2pfHU8+DqCe8yKhntGTCg=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPU hotplug callbacks continue to use the per-CPU QMan portal
configuration after a manual unbind. Keep the built-in portal bound
while it participates in frame queue management and CPU migration.

This issue was found by our static analysis tool under development.

Fixes: 1f759d328f6d ("soc/fsl/qbman: Convert to hotplug state machine")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/soc/fsl/qbman/qman_portal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index d2063a86866a..a93e4fcbb63f 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -315,6 +315,7 @@ MODULE_DEVICE_TABLE(of, qman_portal_ids);
 static struct platform_driver qman_portal_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.suppress_bind_attrs = true,
 		.of_match_table = qman_portal_ids,
 	},
 	.probe = qman_portal_probe,
-- 
2.43.0


