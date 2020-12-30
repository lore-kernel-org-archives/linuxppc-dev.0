Return-Path: <SRS0=wqjX=GC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C76C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Dec 2020 13:20:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3379217BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Dec 2020 13:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3379217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5X2k1nNYzDqKT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Dec 2020 00:20:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ohpJFGJj; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5WhB0NZczDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2020 00:04:10 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BC2F22519;
 Wed, 30 Dec 2020 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609333446;
 bh=xCZw4h1gUVy5W+RXm5Qkfjq27sAVjQQ4+42yUPxqyMY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ohpJFGJjskNCC2UBwgCIVciuZRNbP5j05JSBa15N8io9xAbi6nPGJZrkBnTl2ss8H
 4xHvpZXC8bmxW9MDhFP5Hv++WoP6THxF+2RJjwxOS7jgnK2l0fRFPrIRSKRbYSPb1V
 jNMAYc/xo/lGZaaMJj0ETXdnzC9bSgIlTJI6uhu58nMR4ccyuYTQ91yaDRPfDDZGTU
 nbsIaqoWyvQEzo2Y4DRFYqmMxU9MubrWxDQuHXUXxpvcIfKJdPxg9VhshyK4aGOq7c
 AkUu+C5dOAySGuolYYJ93RDAdUMm2XSHYUZzgSco0sXJg+yyvtGpWWJxpmfR/82Er6
 OW5vW3ZoNmwnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/17] powerpc: sysdev: add missing iounmap() on
 error in mpic_msgr_probe()
Date: Wed, 30 Dec 2020 08:03:46 -0500
Message-Id: <20201230130357.3637261-6-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201230130357.3637261-1-sashal@kernel.org>
References: <20201230130357.3637261-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
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
 Qinglang Miao <miaoqinglang@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Qinglang Miao <miaoqinglang@huawei.com>

[ Upstream commit ffa1797040c5da391859a9556be7b735acbe1242 ]

I noticed that iounmap() of msgr_block_addr before return from
mpic_msgr_probe() in the error handling case is missing. So use
devm_ioremap() instead of just ioremap() when remapping the message
register block, so the mapping will be automatically released on
probe failure.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20201028091551.136400-1-miaoqinglang@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/mpic_msgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index f6b253e2be409..36ec0bdd8b63c 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -191,7 +191,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
 
 	/* IO map the message register block. */
 	of_address_to_resource(np, 0, &rsrc);
-	msgr_block_addr = ioremap(rsrc.start, resource_size(&rsrc));
+	msgr_block_addr = devm_ioremap(&dev->dev, rsrc.start, resource_size(&rsrc));
 	if (!msgr_block_addr) {
 		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
 		return -EFAULT;
-- 
2.27.0

