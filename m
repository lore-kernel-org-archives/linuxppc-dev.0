Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6B606A320
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MzpQ85Nr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jX2Dz44Q5z2y97;
	Sun, 22 Nov 2026 06:23:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795289027;
	cv=none; b=DqN8ydP/dkHzUv80W11j2irs9rx7uOyLUPJ/aMNNO3iRZngt3DHUPvd6SY8daCbsVn0mHTf/Jz7WhhiqX17syRFAiUZpXtljOiB4JARPeZdY1UkTcw9uMEq+ZOH8veL2llHp/nMdKY9ITSpAUWM0np34JxUHUN9tGwsG+V5P2t0MdbGNgOzR119I288wXE5kjlv1/kCgoBnj2vEheJaVYKhaWg9ap+GJmQDRpEf7oSUKvZ7wv8LXWt8PbCfvex+xHmxpMTZt17Me9/AIO4Qj83xde0XtAOKIKxqccrFJy8nUzrgG8ElbQMHH/L/5LMsksYFXKMZXmP3jDFpQ2eU2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795289027; c=relaxed/relaxed;
	bh=GqiMSWFjg1MsHTdt1zaF4HrbzuxDGISoMaceZCX5cFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMUTlTYPpCn4gYK5r2Gjn+/8PWypebCVuiM7pz0NkLu93WRa4JARl1LRNyw8IiOqUDB6Y0HDsM8maxu2Q4knRse+qmUVaTFkKB3dHFKdLpRZwBvTBLGLY5VgsOQjYrVGRlwqekIQSr3UZu2v1S6winmg8Ivp8E62GtBWFdJmq8aOT4rqg8V4zOMbqs1vxz1nkBrn5IV1FiLvqz0n2khMwAASVxmjjYLYlLUqtkUsjKshL5fniC5UKyIX8SiNavZ5TeNaSavLiOr2w7GzAVQme7US3+jcqOymxXQFKgvSJRJWdDxUcvSmMw1NhSL3PPr+bXCWLLeOmRVd8EbJg9SBNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MzpQ85Nr; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MzpQ85Nr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jX2Dy6NrJz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 06:23:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GqiMSWFjg1MsHTdt1zaF4HrbzuxDGISoMaceZCX5cFg=; b=MzpQ85NrXGWQuhq1m46Vrn4LCB
	E0dDEiNdWqXqfHX9+t3qAWNgk50PFdKqCfjcn5o2PO9uWxgem8gb4pc2ygRaWy2z+UUfRhtS/0uTD
	cIFhWYqJ3hInRNweb2Fy++vMN91o/FuImxzLyOiN2zi7x9wK1rgFv1ZMBFYw8daZOBfeo/nUgr3Et
	SJrURgbacufhVVbzSbMxYqbZpJptzyN4unntdClh2v0L6HIPkWKeHbIKogJFK07x9SRCDh23W2uPR
	t1ODUk9d8c2OZ5H5GSD/j5MupjS4ZxHBJ1SCPKQ4oAQK2YmLCGPQ6BtRU+x8HNvpE2kYUtJoIEyp6
	sgWiOJrA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUqga-000000006s9-3k4l;
	Sat, 21 Nov 2026 19:23:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ethernet: fs_enet: add missing MODULE_DESCRIPTION()s
Date: Sat, 21 Nov 2026 11:23:43 -0800
Message-ID: <20261121192343.932171-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add 2 missing MODULE_DESCRIPTION()s that are now required.

WARNING: modpost: drivers/net/ethernet/freescale/fs_enet/mii-fec.ko:
  missing MODULE_DESCRIPTION()
WARNING: modpost: drivers/net/ethernet/freescale/fs_enet/mii-bitbang.ko:
  missing MODULE_DESCRIPTION()

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>

 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c |    1 +
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c     |    1 +
 2 files changed, 2 insertions(+)

--- linux-next-20261118.orig/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ linux-next-20261118/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -218,4 +218,5 @@ static struct platform_driver fs_enet_bb
 };
 
 module_platform_driver(fs_enet_bb_mdio_driver);
+MODULE_DESCRIPTION("CPM2 Bitbanged MII driver");
 MODULE_LICENSE("GPL");
--- linux-next-20261118.orig/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
+++ linux-next-20261118/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
@@ -216,4 +216,5 @@ static struct platform_driver fs_enet_fe
 };
 
 module_platform_driver(fs_enet_fec_mdio_driver);
+MODULE_DESCRIPTION("FEC MII driver");
 MODULE_LICENSE("GPL");

