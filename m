Return-Path: <linuxppc-dev+bounces-27452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E9EC88E75
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 03:14:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl3s10Mccz2y2B;
	Wed, 16 Sep 2026 13:14:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789528468;
	cv=none; b=D/F/fCGIOYxDoo+v81zxMhN7SIM9iQzlA/Zetz7zsp1NCRWyfP0HDNGQCmvc2IhHqA7TRUQ70MiP9MwRv4qIQL1ykYglgkWXwr/N5Xtm3ve2skJLteZQCnQWvavHqPjm3c8BfAmmXmJgYS+eXmU6wpp5fWmb1vpfGXWfrFnGZZpUgqg1iGS/IRp2QMb7zwMZtjMtK3FpAr/l8HGoPuvulQa76EZv6eW3hvT9GuzLeZvQV/aor9Smg7dfeXcxlSsmvc2usB30qorpfaFivDxvr3cB70e5gTsCETIQ5oYZJcC7J0z8457aWDHVIoRJPAoxmFh34GmUOpjoj/lgryBuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789528468; c=relaxed/relaxed;
	bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npAA9VpqSxY1EzxhxKMrXzyLKhFzxmdDlGEDGnfC1uImEPB94hTTNmQa5LEbcqb1x0o869cI1t8pSZWaFv6ZFBDzu2wotwsD93evP1Bxs5ZxxQFB56SBMLI4jpLZOs8sO7L7SbcU2wV/0yJF7Wz5vCkwUX1Z4v3ZgTsgoMMJB9uqmLieJFVMyn9yLmE3PNy3cv6maBDQlnDJMC7DiGbWJzdKNbWEKUFAH4wfks744IZR2ilADwVzHdhgRLmSWFl3E9iTl2WhRDUQ+slK7sItnIB6UexLtW2ETbdUtXqaXqbzXR4+d/9XDttNflfEatra/Q5ymLHJnU/wQLTCK6R63w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q+4yQi1B; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q+4yQi1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl3s00FHNz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 13:14:26 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ee1f38so4387855ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528465; x=1790133265; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=Q+4yQi1BWAQA0lHC2ukDwj/imXE7pTdPL5/O4uH6y8CGnbQVW/juWdL+9OW84PTs4i
         3PJXQjQSoN7hAXNYZn0o3A9YE0iCFk/eAUxrIp7D+kAZmypuFi74IWNkBRll7lF5GFn6
         9nkxFPPO7CE+2CmU2KJ/MTm4wUC8sHFAMEA11e0CFs78mHzltBeJ50ci00wpZlT/R16d
         25ygmmeFOVy1o2REoJ1ZCQK2hON1y8CtLzROsLpTlKBZDjLQy858IYdOX7lyPOFcV75/
         RhNv+ytyLKGjhx2yeJ2DqXabgj13wzmok667xJhmmfKn3d8MR3sZjaW7NeqSA5cj1FxS
         84IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528465; x=1790133265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=Nw2byFXw1pMq2woDjyXxfpKBazp6Emu7IYjPsnHINm2UnVg1JCW+vLXF2uXL7It3HO
         Q+bSEoy+YZ/DhUsvHkjiNbC5pdsAo0xRl/13GGFiuCIZ6pymfSRAnb4ZTEHKU5R8Qqbe
         MzlDg5Wwjq7+Whe/02Jw0/xWhwqjOqIifbgcTH/8/qm7bBjpCX9RPoX3rl6mAfi214ZO
         YsLBmzOmuxDktOthQ0UAJnTy/ScqbnyZVx8HcCRy2su3m9tgYtgeJqNW/hYfTXcb1D7/
         NGa8r3y2HhVWFTr82FfGTuo6U6zkvIniwe/ijpsYRqcuaPpeGlvLi2VWrAZtJ0rSlYDx
         2b5w==
X-Forwarded-Encrypted: i=1; AKwUvBxPSaUzUhY9nROVwC+msoo3AMIiuLMhtuG/qtGqDr9XbrPiPJlrUJEf0MPSgKdcxvdd8tdzM3sWd6iIpF4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m5HEBpnSfJhWEj1FYJIAarUXY34x06ni50iH4WzJl/8yXuEgjN
	vywHNXQk+GWmcVtnaeMPw9SDSAk55F98UxFveuUNM/LQe+UhBoKwifdp
X-Gm-Gg: AYBFou0mEgpcRnxSIvfu1Z6uToUZW7jvbCKzU1Z46zbdWc45VsHOrHtek7I23ffbiKW
	nNHBTSNrTVL4uUZuBf5GR4OUqcFRQ0gKC0S0gPx6DFvcI/GY5AWJTkPiFUeZIhRiJdSSb1Njy+Y
	j5PwVPE7oFRFPCZRP7vEBBBjU1updI5tGFdLe9dlU6LpOmdIJVvU8pWOgK2IW8b2Ipl3DzoSI2O
	E4qzCI7lFj/TO5b0I4NwkEa13UphrIEKuF05LTp+BAYzazswXHT9oX/gENDslH8tyJ7nxec08MG
	20gOFwpcTm3ge/PSbNsSf49nbkLmZLby5Z8kOtBMH5/R83vFfYQs2eXVse6gQl7murZRsWCOtSV
	HYR8QLvLT8Nd4P2YdOzQPDnAZvzRpltobS2i64ya8lETSVzTCcnB3thpKIspRnhNzOc1XbgjCBf
	Duo0p7R9wzOfHDJmBuPK7RUZMj9V9NgGBgpLJnX4td2J0G79xserXDhA==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39e1e504f3fmr2661898a91.20.1789528464931;
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1ae99ca6sm1886986a91.0.2026.09.15.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: fs_enet: fix platform info memory leak on remove
Date: Wed, 16 Sep 2026 11:14:14 +0800
Message-ID: <20260916031414.2875022-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

fs_enet_probe() allocates the platform information structure with
kzalloc_obj() and stores it in fep->fpi.

The probe failure paths release this allocation with kfree(). However,
after a successful probe, fs_enet_remove() tears down the network
device without freeing fep->fpi, leaving the platform information
structure allocated after driver removal.

Free fep->fpi before releasing the network device.

This issue was found by manual code inspection.

Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index d3c772ed5fc9..071e3f3de78c 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1007,6 +1007,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	phylink_destroy(fep->phylink);
+	kfree(fep->fpi);
 	free_netdev(ndev);
 }
 
-- 
2.43.0


