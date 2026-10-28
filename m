Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148C606A323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WjKtksBM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDvyc3LMbz2xN4;
	Wed, 28 Oct 2026 15:48:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793162936;
	cv=none; b=G/qTyWbOeO+NyKdX308kjJS19E9uZMAddr/edwAcS+49rgWpnfyJFYLOUWuoO9Gb3sc069kbBf9/fGQU/DBSM4S/m+0cJgSGcrNF7jx65OVNJg1aPDS0cuphy5kedtBpRkIY0zlEFOmBoWq6At9d7co07RHACLQ4t8PszM1RAUz3l7KoLjlyRBXfHSRsx4FE0JZ/p9+b8yfBuKkAkHoq5VxDLidWIq8E5tUSMFc70RvMjbMlFXDP2o8nQq8FNwt8yMMo7wPv/b6Z3T636JHZ1+An9E3c/rl9p4V5ZCZAl15clfuzlZWL7RYZMeAvMAL9QhtFOy/bGHPMlhtFNrxp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793162936; c=relaxed/relaxed;
	bh=lAppreIDaRBwp2bJc0C8P4KcAycTbVej2XgNIS+hMVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gU82SqFU27YERPSHQv0Hepq6yYo8swuAnH2YrHM2gqscdRsU/bN5mvahR/Eoag0zwPQxX6zFqSpvKmHcvzaMl1tBT/wkuBeqfuKJbP1U5IE2vIUx9AH43KzkIeT153XTkpidiQkqtgui4bD5KosrUlKOy6MSeRK6zpSLcz3I6vBFp6N8Tx/dMo3YCPehVSoc4pvmXeiKkteHYRMCFVzaK7dVgB0S8FB5DwjxoQVwA00FcRGtDLW0LEVeUyN/4Lo1YUItf54miwHfxs3gYygcFeHoJrBncJVL2xg2f1zwNYeXDzK/SMo/8m7ROm6sumi0rWKHpItkKUQz97hml3+71w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WjKtksBM; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WjKtksBM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDvyX3Vgjz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 15:48:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lA
	ppreIDaRBwp2bJc0C8P4KcAycTbVej2XgNIS+hMVU=; b=WjKtksBMImFt1+BQzo
	4Ck2tsm/b7AYROXtZP42ZTKA3mlCVH1sE/EslO0Ge10WpHXLe6obKRkd390jiW5k
	HwF2A7u/AoJ5x8jj2YOKlRjEsHZfAoGiz5hLwLyLA6yiq1iAjLKjTr8zVZVVM7Ef
	Udbn4J0rfv/v2aHjanF5+Jva8=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S4;
	Wed, 28 Oct 2026 12:48:33 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/6] bus: fsl-mc: initialize UAPI state before device registration
Date: Wed, 28 Oct 2026 12:48:22 +0800
Message-Id: <20261028044828.96177-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3trW7GFykGF4UGr1rJFb_yoW8JFyUpF
	srX348Cryjvw47Jr4DXF4Uua15Wa4xXayUAFyIka4rCa15CrZ0vF1UG34Y9F18JrWru3WY
	vF4Dur15W34vyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3UUUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AHaFWrhfqETDgAA33
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

misc_register() exposes the fsl-mc UAPI device before its mutex and
static portal pointer are initialized. A userspace open racing device
creation can consequently lock an uninitialized mutex or observe
incomplete state.

Initialize the UAPI state before registering the misc device.

Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index aaa14f17aef4..2c586dd787f3 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -586,15 +586,13 @@ int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
 	mc_uapi->misc.minor = MISC_DYNAMIC_MINOR;
 	mc_uapi->misc.name = dev_name(&mc_dev->dev);
 	mc_uapi->misc.fops = &fsl_mc_uapi_dev_fops;
+	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
+	mutex_init(&mc_uapi->mutex);
 
 	error = misc_register(&mc_uapi->misc);
 	if (error)
 		return error;
 
-	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
-
-	mutex_init(&mc_uapi->mutex);
-
 	return 0;
 }
 
-- 
2.34.1


