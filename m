Return-Path: <linuxppc-dev+bounces-27056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1112AC88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgvfm4VdFz2yqd;
	Fri, 11 Sep 2026 09:54:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789084480;
	cv=none; b=Tbe6ViU/FnaE3q0ob7odFY1UXPd+XdrIa6SISkq0WASyNoBJDJc7LArijpbLjoS6aHTDbXIlQ0d1y7F75CzBhexlWejWHbukPgkCn+eiVPDAb2y9zkt23NhMSzqapex/HAjk4axgy45/xmrLhuaKK19oOoZ9CfUpuOhDj4HfiYJo9Z0p5vQBdLxB7crUT3YqknNNjFAxcGwVb99AryrHtOjZp8jds61yK5rX8rrzavD8C+z2tD8jiUBV1w9N7eMjuiJJBUqME0L32euT/plI5TksZYpjQHkvfqFLJnj8yEJkHT2S6I4JlQRO9vN2po98tiYU4KKHJ9YRKlwQ5+cXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789084480; c=relaxed/relaxed;
	bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNDzAgiPCmpeA1uBwb7f5q7BGi8ZPlEuWIAO4CGySU7DQEUYxUxUPBButhlqxY7fc5gYmPBoIL5N2r3qHydKikqq1WyVAeN3I5q6pukbISg+wzHceOyq9XdcsKDQZ/hyAqdSYgaOFpt3M5OR+0QBTaZquVst5pEW8WtseJ1UmvLXPJ7qYb+5xs+C5ouNgzkS91Wd3K+wcmJUnp8ZRzZfkxast0K3AzcsKl9gGQAvjrbAU7L27yxInMvVQetTmJmWH8iyWSlhfZyXINvTcJTqB+4pJv/MVFXfJQPNVZlIy0QmLquFmAKcGTfuV2t0l1+o/WWBKHqVrd8dkMfaDZWUyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l/OOQtB2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l/OOQtB2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgvfl4HcSz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:54:39 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5302b692c8eso4571881cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084477; x=1789689277; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=l/OOQtB2/EVG0ofMZ/8GHkYnNPCqZu7KtGAgN2tJHDgBWUFNtLytfbn/S8RlnmBbSH
         hRcYsXyZ62r49RCAWmucNtwNvYoUHpi6Jky7DQh855UBlwyAE1Wekf69ixvxPvnr0oTx
         DoiePwrEKe3QjD5X0GVHSJTzXJXDC9k6rrygMP2RkGqEK1OaHq/aJglCEJ6LqwYurW06
         U1dSxq/1HqPqbSkfT14Uo61cjPHRhtNF8+zoE2Gwa+GK9x+Gyq/Tw5JbqWFh3UGOSmig
         vXQxiQrH4Xcp9JPa90LqXR2Yzv3N1H08QUXY7yjdg/350sfsdmWnNqy0/f5rodgKqXVF
         0iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084477; x=1789689277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6Jijc6okwul17I+K9OvRXUy0M5JwDpgrdpc+hLNXWA=;
        b=jqvZd4g8OOFwAG8v8uQIJAZ/6h+BeNRo+G4ixxF3mhmBb4YHZCJu8HE8fU7WLw8L/s
         FwlqFi/KqWkhp3bAckDQCABW21Rlo3kXmirqGzwISrb1L3+BO6FTtzsYztQhJ/73Kq/s
         1mRM0IZ/H4y2ouMWLIKNwctW6WzouEw++Jz3H85xfl1hSYza6kq5X96Ew8U7SYyXpS1X
         t18E2g5JeKuIqax19NuE8S/aZJk50HOqrK290b0OwDu0KptG3qOL7oCHMWfYj7/VozXg
         tG2Y2/3f9WQ9vui/2AX1FH647rxIS95mk2mpiG2FIqa0nfShrULBG14KdmE7Mg4wcEyX
         hnqg==
X-Forwarded-Encrypted: i=1; AKwUvByx4cl4vimjFiUdU7RYAKefGaNILrkpRKWfpz2VP6m27buKUXFbDdMryByNfR/X4UQA8zcwFLrwxpj/xj8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++maFJegmBVFuQ0nH6MYkCKXkyYuaM9qWComLzxvpAazKD5bSlGC
	qYQHSoBvmD9AZfFhpz99DQfQLT9I1lSGt9/8jyVkEbwbxFGhtA7S6mE=
X-Gm-Gg: AYBFou3sdbOrekoHCgCD3+zKu/6S1WXV2eHRn+WyRLWWjkcbi92Cddbdxdt+bLG5qbS
	Da03O6rVlTheiU01fwG5Bz2nlpa8Sq1TG+JKaK8gDiGbhFIofmU9RgnT7dhM0bHdA2WfDF8LaRU
	5cNvlwNYc/AJ9yH8TNr/Wy/zRlb6p6/Bc8iBL0IK7FFq/qNyfpJpkt6gN1EdrntrfLEFQmu1hq9
	6bgqRygV+dpFLDsrrDVad19NY7zjpHfPcoEo80etgC0oOG1i6UN6FdubSmkgt4AbrmXcOANsc6m
	QRLkyH/ez2xZQrsA5+p5VSwt7nCiGd/ojjJy2BJcrTQHUH4JJUhZ0GH6XfRZ/2ifBM9Y/KtUnMa
	NOf/s+IPUGfj/YJE4Frr8SjmJKJnxHo9PWYyIrZswtXdDZUYO+UrhY5q/4v3kyjAGLicI4Cx1gy
	PRWZ2TwO3r0cEvkHb3Ihep2PvuwrZQIycceVCXj+Kwca92uSKaP9Q1Rtyg0+2yk7Goq5noqW8pj
	Thzp796J+if2t0BPQMyR2ifaDrjs4UnuZObCjvvDeZ7lHrZEazgpCuWUJKk1VaYSDFw5WQtDc2o
	EA8y5hxnnMkUWR1J4f9QGDDQu28Ma5PY0s0=
X-Received: by 2002:a05:622a:1389:b0:530:b2e4:d5a2 with SMTP id d75a77b69052e-530c87a548amr28704191cf.61.1789084476627;
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
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
Subject: [PATCH net v3 2/4] net: wan: fsl_ucc_hdlc: allocate suspend backup before quiescing
Date: Thu, 10 Sep 2026 19:54:28 -0400
Message-ID: <e83f6d9871c4110959ca234f618b3878d5c4f648.1788128904.git.mhun512@gmail.com>
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

uhdlc_suspend() detaches the netdev and disables NAPI before allocating
the parameter RAM backup. If that allocation fails, suspend returns
-ENOMEM with the interface still running but NAPI disabled. The PM core
does not call resume after a failed suspend, so a later close attempts to
disable NAPI again and can wait indefinitely.

Allocate the backup before changing the runtime state. An allocation
failure then leaves the interface attached and NAPI enabled.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 82796452e54a2..596f4ef053636 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -888,6 +888,10 @@ static int uhdlc_suspend(struct device *dev)
 	if (!netif_running(priv->ndev))
 		return 0;
 
+	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
+	if (!priv->ucc_pram_bak)
+		return -ENOMEM;
+
 	netif_device_detach(priv->ndev);
 	napi_disable(&priv->napi);
 
@@ -897,10 +901,6 @@ static int uhdlc_suspend(struct device *dev)
 	priv->gumr = ioread32be(&uf_regs->gumr);
 	priv->guemr = ioread8(&uf_regs->guemr);
 
-	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
-	if (!priv->ucc_pram_bak)
-		return -ENOMEM;
-
 	/* backup HDLC parameter */
 	memcpy_fromio(priv->ucc_pram_bak, priv->ucc_pram,
 		      sizeof(struct ucc_hdlc_param));
-- 
2.47.1

