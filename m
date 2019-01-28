Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F6C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:20:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E00420989
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2GfFH5pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E00420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pGc91wcwzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:20:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="2GfFH5pS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pFGT6gLbzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 03:20:17 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B7242084A;
 Mon, 28 Jan 2019 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548692416;
 bh=L5/1m/X95CcbAQso51NCqtgdeSG+iOixxSGjOyNX78s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2GfFH5pSSCYoh6adltoUSyr/9gHhbCFB1CCWyl5gYc0STBPpm+pZLylmqihM8d35P
 WPyLLnnk7Gebka0xrirXUUnMtUwWdEAFrmJxTi4CNjlAlbnxW7U7jq0HomVJheeD9Y
 VYZ6OgOjLbWFCHCVCmtkcnlxRWZLDhtTed5VVxmM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 011/107] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Mon, 28 Jan 2019 11:18:11 -0500
Message-Id: <20190128161947.57405-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Frank Rowand <frank.rowand@sony.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit 5b3f5c408d8cc59b87e47f1ab9803dbd006e4a91 ]

The previous commit, "of: overlay: add missing of_node_get() in
__of_attach_node_sysfs" added a missing of_node_get() to
__of_attach_node_sysfs().  This results in a refcount imbalance
for nodes attached with dlpar_attach_node().  The calling sequence
from dlpar_attach_node() to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

For more detailed description of the node refcount, see
commit 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow
during DLPAR remove").

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 72ae2cdbcd6a..999b04819d69 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -288,6 +288,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
2.19.1

