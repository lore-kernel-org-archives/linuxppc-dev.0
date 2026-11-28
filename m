Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=fHXdQPEs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc5783G1Gz3bWn;
	Sat, 28 Nov 2026 20:47:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795859268;
	cv=none; b=Menmp8cdPT/3FqRMKm2QI/h6p7KK1T9F57wnsDDo+EYVMV0xlg5LLF26tJuLfgjV/4zBF5JJfVpa6/j4F/gLBCnNMbb7xtY9kLxF3GyDIUfHSyVdVsj9W+ls+xEzwL1POBkLf5p239A9zDVwXWinHwzdK/J816oAbgWZXcmgIQ45/njX2QtDKWMJCD1RRs72nDhVZs5PZaNKttSoG1kLs76vAktZ0qQ/DMvRevHDXLUPA3TdKeZu/oAKVd/MKs15lUEy8ndHYtjh2hBkqsUOkqtFCEFdoRaChWfiT25uhb3ct140LQsVYdvitK/P6Yvnvt5pPexAm0OSN8x/YDjdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795859268; c=relaxed/relaxed;
	bh=433pLzxHkmCxN1U53BphB4Z144XEI0ZxFQ0624Fy6js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FA1jsCd1o2rlwb+1tZ1UK3TlxlOlw4ydTqXFotBJhxOCt1Sgcfx19+Eeyop9bA9L78gdgf6rvoIvPJK24NFS7ePCcy1uhLo9pjM5ynJ1HDvEJwEVNQQTxIA3MWt1DFemvxUZMOQBhqLedoqKJz8THJDE2EAB4qMJGsAMXwOL6/Of33ItERAWk+3EqkgTcKDbY4mJPh+8rEtpok0ZFA3uTxrCqDUSmbN/EPJgKB/S6HdELYNGnKGERgK3rL7sRkMELDIKLBFgLVooG9MqhqWgzjUj7VDf7NMEedPK+LtqLyzvq7xofEVI2qTh+1s57sb07KK8Ia7rfHHGwZCtMbROGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=fHXdQPEs; dkim-atps=neutral; spf=pass (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=fHXdQPEs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc5765ZjHz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 20:47:46 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b08a3;
	Sat, 28 Nov 2026 17:47:22 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: chleroy@kernel.org,
	tglx@kernel.org,
	bigeasy@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] soc: fsl: qbman: Disable manual unbind of BMan portals
Date: Sat, 28 Nov 2026 17:47:21 +0800
Message-ID: <20261128-f81b700d6c-u20-1@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa2218d5d1c03a1kunm0012fee94521f5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRlLVkgaTBkYSkpOHR9NTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=fHXdQPEsh/x3VjRr0MQQXnzc34clDx8wO91VWMovt6XEwLScNjXcwa3DJxAvmnMuuS8hodvS9wShzeTxzOHcWGYo4h2FTDqjfFoh7bdL5rmVOweqpv+ZuDOLngqctrP5rG5pAIhdbJCsDy+IvmEcG4fJY6cKIKCbzawE4TxbNj8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=433pLzxHkmCxN1U53BphB4Z144XEI0ZxFQ0624Fy6js=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per-CPU BMan portals keep their configuration for use by the CPU hotplug
callbacks. Manually unbinding a built-in portal driver frees the
configuration while the portal is still reachable. Suppress its bind and
unbind attributes.

This issue was found by our static analysis tool under development.

Fixes: fce77c3562ec ("soc/fsl/qbman: Convert to hotplug state machine")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/soc/fsl/qbman/bman_portal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 046034a7cba3..7ff6f76ea458 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -216,6 +216,7 @@ MODULE_DEVICE_TABLE(of, bman_portal_ids);
 static struct platform_driver bman_portal_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.suppress_bind_attrs = true,
 		.of_match_table = bman_portal_ids,
 	},
 	.probe = bman_portal_probe,
-- 
2.43.0


