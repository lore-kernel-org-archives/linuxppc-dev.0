Return-Path: <linuxppc-dev+bounces-17082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A76CEEC2B7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 01:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKgSX5Ph9z3cBN;
	Tue, 24 Feb 2026 12:42:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771897324;
	cv=none; b=RBUygdkUOTY7DlJJDY6rUaV+qCsPN5ufmV8cBNOhrekZeqZXFLd49dySt9NUWfG1unGP1ZdYKn7X3O7gG35FbnDmnWMspIApWpp8IEF0CFNgnBSukX196N68DKMC/HCb4i0Gfxhx2VksuXFCbJSEr0u1I5ITiGV9nVqrYsmdwRTAANpHfcB9BZqFowbJ4zHHDcbWZfTUMrqTwEzzEk1QoptOpDoRaTNCDi+ZNwYypTA6/bjmRhvHGFl451dapJofSsE8ykd+m04MM17gsiDY1Xqw7tHkIC1M+NV0CnZS3msmvPrBMs3mroTTWaz1/gc4ivcr46xPvY33vBL9efHDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771897324; c=relaxed/relaxed;
	bh=6P7RESrYIJDhZprgcR69A/7lKYelhyEQG3ywd9xm4QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bubZ/2CyYus9exaJudNNi+mOJ5UMrfOn0B/i3Qex6U9IEjw2Xqu0EQD72Iqp33Y1pEmELHrAdWxR2qdiwirkNYEzDJCSciWvwQBDl9IDi/rjSoIm2VYtBbVJZQeIJun8ru9IBNZQcqZnfyGlB5aZxgkcejzwmtvydHQYHcRIKD/dudcstNSdylSY6uuIuog+QvEaRjLcoZLyDeJRk7YixyQukcAzL0Az91iJ8xiCciVxxHF62EfJxyXkRT2QWb+VcNjCp9PXdN/dYQRWnt2sWOWFDVOVZHqCxf3olFqaIbNYiUWoyplDwbl5ROXnsiWrKvAUGe4xe6d9Bk3+Rxt8tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ij9GBGq9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ij9GBGq9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKgSW4f2Rz3cB5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 12:42:02 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ad3f12a496so26488715ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 17:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897320; x=1772502120; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6P7RESrYIJDhZprgcR69A/7lKYelhyEQG3ywd9xm4QQ=;
        b=ij9GBGq9puZW4a+p7nCmq1Rn190hmUkmpu91B7eweoyZ0d8UmrLaSQFI1AezyYx4+P
         Wp2SFy+4BHYUYex5qpmiJjrymHIPXkblW6jyMnYemZDMeCqhcnAn8Wz8oUH4TvZuijDd
         xj1/JBgRSq2L8l5vvcLr6Z8nPRczeuWYae+aqB2N5Uv8cBpgcDVeygjalHcrb19QP5V/
         PSXYmj5Vlawf01PdB1UtC7shlGUKIdJMohfsIYLAZSwMC1Wc5U2j0CHY9wmCowwQY+14
         +QfzbTHDifFGjEK95/eXuASeCMH9BcAHQKVt2HHkf9nNUD7AwcQC8vLnJp3KeqIC+yzU
         X/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897320; x=1772502120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P7RESrYIJDhZprgcR69A/7lKYelhyEQG3ywd9xm4QQ=;
        b=nNHo9HdloN84h21DxMUPD0QRZZZZ+IgOSNf2QXZ/0URxoTE6HCE66iQCVxC+bsNVQF
         TNGSdh+TiIyh99p5kAcyJhBLEhPuQs1LxpbAOEmu1d9O60Hy7s3wsLQ9WBVqXfKiRbqE
         M4qqK3fFoncgucnleaw2tEkDJlw6gVJHUrC8CGbCOfzXTTB6gDGZ9q7Nm07Yvh9w8x1B
         fUQY0IBqCujmkyz2Nd9py2AZUopK1r5mpV/JyfExKjDpppzFyHOmKeX8GsCBqY3VcWaV
         K5VonRebmWOXXV4b5qGDNjxfJpfKL1bEkR29xcmfVpQjNpEJ3SZRygYfHdB5APhyBWMd
         V56g==
X-Forwarded-Encrypted: i=1; AJvYcCWSF+6BuR4sKrq4KaBol6fIUY6Z12jFRnX8YPjaAGlXLUNpGHV5m/tjHp5d7kFoPXr5vzBMDZ3r13HdoQk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBRojVurPR5HTMx9AlDpyWxfOrwsEAgUma5mJiZlxBTfF70DRX
	lg8yP7uN7uRK6mhP38ZfSHm++N0DonUy7RYFl6VToQwwxa/8dSDaC5VC
X-Gm-Gg: ATEYQzxMBrrTGKO2qYhyTvvrZ6G+b92RHBhwTXmCSfxC7w3XJcQkd0kXuIWOvzLmwSW
	UisuIPV9wDHEUn9/8Z+mO4AmejCKy39Iem4raxFI7abLjqIUCUylMNJ3RP+w7duJAQOBspUAxT/
	Z3Pmx6C5b8zIFn0K0UGkBkBDAFXN8D22XTCYiA6P+H7n8bCyrxGFiWF78f2MTd/F0phAlHkpbr4
	B98Qg2VT0xBB/JSErINU2OdmpjkchGuMbimtsd3tw5IDleBpxjtJrAma0SVGvfRcWrPRBAWTb+9
	qW+evT5xUzIzPWfWLOs0MQNMi8K8JbWtXCBQV9TjZ9bGqR0qIuIM3j0MiJq4b0WVWAhWbNQRdRg
	Y9qvzE0C1ilKdmb6zpwsbG6QJHXTqGUHHafOsZvoAG3tnTRtaSCGrrOiR0mr2S6Ib/KogWxCOie
	DNbqMffCLzqNuG+N1mNQWSy4JmvTaMXgvFdTCbv4nZPU1f+EAFZQPAOQ==
X-Received: by 2002:a17:903:2390:b0:2aa:d327:beff with SMTP id d9443c01a7336-2ad5f701d04mr164763405ad.6.1771897319835;
        Mon, 23 Feb 2026 17:41:59 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d79bf6d8sm367577a91.2.2026.02.23.17.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:41:59 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: freescale: ucc_geth: call of_node_put once
Date: Mon, 23 Feb 2026 17:41:41 -0800
Message-ID: <20260224014141.352642-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Move it up to avoid placing it in both the error and success paths.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 78d72409b6e0..4d598693d7a6 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3470,14 +3470,13 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (phy_node) {
 		prop = of_get_property(phy_node, "interface", NULL);
+		of_node_put(phy_node);
 		if (prop) {
 			dev_err(&ofdev->dev,
 				"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
-			of_node_put(phy_node);
 			err = -EINVAL;
 			goto err_put_tbi;
 		}
-		of_node_put(phy_node);
 	}

 	err = of_get_phy_mode(np, &phy_interface);
--
2.53.0


