Return-Path: <linuxppc-dev+bounces-27057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BCAC79FBB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgvfq0LWTz2ytx;
	Fri, 11 Sep 2026 09:54:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789084483;
	cv=none; b=FWasv8rMOAg3NJX4rcmZK7FfcPdnFPC0IhXVzuQyJu0WMwj05KKjIGgvbffk+oDBT1HtPyxm2+GY95AoJ0ydDGZ1hDdzI+0R8ETri1WsMGqixVU3Q7rFyBKOn7AXRP5FVMow/RSw+QytH9cvqVWUpp7iDo7hs225dUEn07OMklmAWYIVGVjmjzwnV54ICbU/FcmJ62i9H+xrHCt+ENuyRuIEWH9gaPM1cZnCpYxd2QvuvOABofGsqpkFLIraNUYIBK/G/5EZCac83GJUYzGhKHWyROflBTuVCzjMj3k2TyNz7V8b+KOB1wmFr2/SUV7AyGVMGzB3gyLxAQI+jPdUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789084483; c=relaxed/relaxed;
	bh=imdVCDjW8TkcoAnhfj8hrX1xpu4892DD4sMcv+6zDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSsrM1wpyhRJWPX5wyKDG0HKGX4mI2DoQOY0gQC8LQeOhOIwVLL4VA2EYZHQVFY3QoHm5SYwPlekD/GrK1EjWx7IPaeW8Yv46LQlwXKRKAk6ahzeSvvTMsTyai1w0G7ekZ04SYAR8+9t78AOFLiHKjQbGJdPGHV+gl6FAZCXjP+aPIbjhnQSvF5EiVcmjjHveFwJPP1/IoMpmVncVgsvSGduFXuwAMs8pgNNeQB9ZI1LQhDrnSYH+D0IITTMe+B947tWvFMbNbmLBdJ49MF/TIKZTpt53gY/IZo8/xtPJzRTsBSSA9qDD35+1kMkEAC5diQp0Bc+7ElyI71t1hXiAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rGWNhe5h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rGWNhe5h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgvfp2JqKz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:54:42 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-52fa6005224so4480561cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084480; x=1789689280; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imdVCDjW8TkcoAnhfj8hrX1xpu4892DD4sMcv+6zDbc=;
        b=rGWNhe5hxkI5m1hYK8CKsPFpBgw43O7fNvi83wCQK4q41GafQwkoup4DQCSgxVtpkh
         Kx4TWUhrYIGaUQRBaDXd97AglN4d/ml2L0GMwopI2Hyc7srdXlNNqiL+42R/j+uq6m74
         aDD1QahbPSeABRapcj8bJGQRKtzsHWQfWqXShGr2DNel0GptA3u8OO8A/pARw9a6t+x4
         Qpi/coE+M/qZiwhh5V58WlgXgbmFhIFHGMERoAh2y7A8QD9Rks15Ex9T235Hp3vm338J
         i8XrBwLqrDo9zamePeg2g4KTrCazKswLV6lbuTA1fwZloR4xWkMUp3rtG4q46//5euaG
         gqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084480; x=1789689280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=imdVCDjW8TkcoAnhfj8hrX1xpu4892DD4sMcv+6zDbc=;
        b=AckE2YVsCjH3dIn/Lw8Pzt/9noiIjAdHNHMU/NHPVIc30A40ST7T9+xVCKSJvY7waQ
         f+ePqVUo2f8Z8/ZPw26+VdB26zlud3m9XlEi8toDvN8cTfm6ObDsactmH8BCRoLfaAiC
         q4vL9PM3saQPGg1V0LnAWp6f9AQbmXzxULc6qvznFf7tqc6TMwRv/++cWejFgiF2jt54
         Wv3KPKT8FnU9BrSMrpVMXGIrse8REe47tjcILCL8g4enHoOPkaWtxBbPnaBApvQ6LyrR
         MHJl6m1A4ESaLNxH2mYeTkNacm7xkDGKBhOcWSp9qkktpW7wWtxpmVh8uidYCCICI35t
         UBLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoPSgH4AsBxXmf0Zt0/BJDp/e30+TGM0JnjlWSlqnBMlvexOEL/842WuchXhSaD4WBIDzrf4K4GyzEkVw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nsDO3kRzFWVpMLTJaFQjQ0PvO+44w2XQCsgkRZF1v2z/poX9ps
	ttoXFq6sBEYGIaO951Qhsk9eFpYFzGW2+6Ba2gmbjiQOFfJZb4ha9bE=
X-Gm-Gg: AYBFou2OP6nB0OXtdCsniyuzSSmmveYCubgY89Sc5nFujG4LhtTSEuEkdrV84JrvunR
	l/oFVRaGrbJepVutbRMumheZ+obmkkyuMiZEOfYwQDmAoiiFA2isjRB4SPAPpfRH4m3R+8Y3Zi5
	ZwPbhTgPfP4HYddOPHuAFwK9mwR4EvNWZLtxLlmNR1zaruCsqoVqEA90JNJhWNziWq5+QAkV7mK
	Nh2xlCFCyH038P1UCoTi2CnysDTVkh5WifxdGjTngvRNBpHODQCcIDIgtuHzaUSYtQtdjgyQ22J
	es/Ape0F95TYtFlHQh0KiM96hB/FcvXW4NfeYbgP+dLZ96entIqPgWLckm43IeB43seTrHNvaiS
	QzgEvEm7hA4malsg22RYwkPEOsAPJGKqYfsxJmRM6PvEyB8kXcwI/B2jrtPQvwozcAgAZEsliI1
	FU7xFz9ML3HvX7lMV8DTmyzetz4jAiI44rzs/uvrpwOtl/Zr5lRiKwEXWbOQkmFcsPYvPb0HUZ9
	wjZx0XI7npEbyI7Y+0Sz5sYNvFb4oqnQTtmFl7ReHcAoztxh8QsDHfjnicmPOSx3IVUG9Jinlfu
	UBcTQZrE5X2g7e5AShbGoLZl2BtkcpL9bQ==
X-Received: by 2002:a05:622a:2294:b0:530:b2e4:d597 with SMTP id d75a77b69052e-530c87487damr29756721cf.50.1789084479899;
        Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 4/4] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Thu, 10 Sep 2026 19:54:30 -0400
Message-ID: <598d90cf55981c38288fab8c32dd52286090f384.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
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

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that object and its resources without unregistering or freeing the
netdev. The registered device is left with a dangling private pointer.

Unregister the HDLC device before releasing the UCC and DMA resources so
an active interface is stopped first. Free the netdev before releasing
its private object.

This patch depends on the preceding "net: wan: hdlc: close active devices
before protocol detach" fix (patch 3 of this series). Without that fix,
protocol detach clears IFF_UP before unregister can invoke ndo_stop, so
an active interface would not be stopped before its resources are freed.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260803133048.42650-1-mhun512@gmail.com
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 596f4ef053636..371150efc1a65 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.47.1

