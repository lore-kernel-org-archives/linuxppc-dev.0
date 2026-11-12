Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A5606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WFx08cKh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ4Gd6jcfz2yKn;
	Thu, 12 Nov 2026 13:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794450873;
	cv=none; b=nwEK/nsLXLH2AtdjX5oOnHXSQPZoTBbWhwB6os2LH4sOORJQJ/UwcMNLFAfcLXtvDSX7bHbMnJkEAhSMgofXSpPvm8TAgnzrei6MibpO+u0vxEBmuHheZYPPGM6A+6ffde7dv+J94y6+G4B7kUugWsOI7XjBkJMFNIYlTjlXieHjGicNOhjfpgiOtS75SDXLj3uAF+VYP7rJWNnl386Zi+Nyq+JIU6jW5PswLZ4PNYsMzcEefsrrV/zlouFcHY7W18WTjH2Ne0bdYi33iY/DBuS61u96gVAWUgUVIfgL/Q9tqtIeU/HgLPrjD2cgkCTPD/mopGXdjzWQNz97rhz6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794450873; c=relaxed/relaxed;
	bh=4aQHBiqJ06U37j0N40/YP+bLbY78zhD+Fcv1k2FBL0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4zyIr3QYTwakQre85FmAUuZOLXdp6o7bBkDeLsvs+b9JRpIFASCyIWFVi8HLULeFRa6j5katk9q4U0r1LhSsCGbckWPrMw0rJw0YTIfvGsPY9b1eA10PVAuC/hdo4hyQbD0vmqTlwB2iuJueqSapS9HpMGsZSmHWIyQ2i5U0WJk+vMuG4RSZjzU65WVcMAmAsM2UVQhlB1Ua2iu63EDD2wssI3cSd/9LWv7RUtyOa5uOWgyxDCl7nOnRHpF0Q9p+3RQFMh7pGd2dI7v/rQG2Y5m+aR6Y6zR593weD/DXyU0SYLUe5dcEe3r2qIwGuYVTsjClESG+I3coVGa5W3fOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WFx08cKh; dkim-atps=neutral; spf=pass (client-ip=111.22.67.135; helo=cmccmta2.chinamobile.com; envelope-from=zhujun2@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WFx08cKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.135; helo=cmccmta2.chinamobile.com; envelope-from=zhujun2@cmss.chinamobile.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 182 seconds by postgrey-1.37 at boromir; Thu, 12 Nov 2026 13:34:29 AEDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ4GY3y65z2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 13:34:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WFx08cKhj65W8B/25YY/WT4NVFKCWadtE15HrlGmeAgx+8pEvWHscA6ss2Lvt4kuzDfhGPzu97kWr
	 RNC4ikYTPlpRGuKLytaY4fSTTu0kLGO+n+8nQZ+rR+7LfXjiv276hMmfags829gatR3nIBxT3skzL9
	 oA2nKudcY/+BizMA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af524f8153-a8ae4;
	Thu, 12 Nov 2026 10:31:21 +0800 (CST)
X-RM-TRANSID:2ee36af524f8153-a8ae4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af524f610c-ef34a;
	Thu, 12 Nov 2026 10:31:20 +0800 (CST)
X-RM-TRANSID:2ee66af524f610c-ef34a
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] soc: fsl: qbman: Release the private memory node reference
Date: Thu, 12 Nov 2026 10:31:19 +0800
Message-ID: <20261112023119.118215-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qbman_init_private_mem() obtains a node reference through
of_parse_phandle() or of_find_compatible_node(), but never releases it.
The reference leaks on successful initialization and on errors after the
lookup.

Use automatic cleanup to release the reference on every return path once
the reserved memory lookup and any reg property update are complete.

OpenAI Codex assisted with analysis and patch preparation.

Fixes: 42d0349784c7 ("soc/fsl/qbman: Add common routine for QBMan private allocations")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.c b/drivers/soc/fsl/qbman/dpaa_sys.c
index 3504ff557231..e9c37c45dd58 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.c
+++ b/drivers/soc/fsl/qbman/dpaa_sys.c
@@ -37,7 +37,7 @@
 int qbman_init_private_mem(struct device *dev, int idx, const char *compat,
 			   dma_addr_t *addr, size_t *size)
 {
-	struct device_node *mem_node;
+	struct device_node *mem_node __free(device_node) = NULL;
 	struct reserved_mem *rmem;
 	int err;
 	__be32 *res_array;
-- 
2.51.0




