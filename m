Return-Path: <linuxppc-dev+bounces-27162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF0C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 21:59:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhT3K4n3mz2y2b;
	Sat, 12 Sep 2026 07:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789163965;
	cv=none; b=Gj3NOavfUm769no6eKeV/UJx2dsvMwfcCzRRaDKsMr8uttYmFNEyCC8AndrEihHfKcKOmuM7swJaNk6nrx46qfgNAme8xvYvSnh927WN8B8ZtzhmBNc0QR6a8fezgOe23FYS7OJTvNY1Gw4f0rp+VGqiYm9TqWkycCmOW+UMwPR/XiK97y98MnFc5xJZQxgVxmgU6Wtk+CEkpR12xPFoPxTNSjjZ6ACuYviTZIbcHcE1pSf/Ey9w57GwjGjazm6WU5AHejQ7vxNqHzDVJPR7yJo/wsDO57ybMY7W0VwFi81T57roAPb764eQXOWKfK5z+LPRgsIxP7nWoDPrycnqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789163965; c=relaxed/relaxed;
	bh=2LPrONMbj0bwp/GdYN4yOukwx8bvXQe9ntAGUumY47s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNxjcPgWbbzhsaw1qmbAQZVG71zaa7mMy3fS/AoIPxn4xM+vLL9+ksK5NiiEBYXQdsF6iiQeLB/nSEtICiEGrg3Gjrj5xF4phl8VqGHgXpaBFg1jkcWTbHY2jj7xQ3HmW/sSmiMGTkBlCDF07KtbwPFC3duEV6QYUUVhcNWVJf+GJ+35bCR0tpCLNr+icThcJU67fLE8r37cV+KkXtvnFKnnq0RoBUXw7+ik2TnsD00LY9Uwkssn2rwbnzWAUzsq6QJn26dAwVwJ8oW+nLOwSn4pT85lswW/yRGdS6NB6y3gJNUHm1OI/ti6c+OcFPOL3YvM0SBa6YS8ePKmsE65qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYsrf62g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYsrf62g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com [IPv6:2607:f8b0:4864:34::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhT3H64gnz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 07:59:22 +1000 (AEST)
Received: by mail-qk2-x11.google.com with SMTP id d75a77b69052e-52fb76c9deeso522171cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789163959; x=1789768759; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LPrONMbj0bwp/GdYN4yOukwx8bvXQe9ntAGUumY47s=;
        b=MYsrf62gfjJ3rbBIqEAfC/lP3FQUCHhzeIwA0CPJEhI8DO7fzQVqLNtq46jRCTMmrs
         nDLPDunBPxQ4qDpd5jIcg99yhro2M7QCUVPImsyNzHjMokRZ9m8m5rhzeRyKx+rvQ6TF
         CRL+GM7ozrdcSx4YItx1gaKQU5VxAC+hSfsiqqGlKIe8D3H4pj0bUWtV1LFYTF4oZEQQ
         LYciw+IoDkyGeBzlo3PwIfIGhI/L5l4BcOCopVKZry+ZiNYwKHTCjpTaOoGu8BleR6LJ
         0N8YstFG4n7St8FqGQAPzFoD20uDyNP1fMQe6hlWL1PX15ouPETCBC1j6tkPK26cPs5K
         ydzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163959; x=1789768759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LPrONMbj0bwp/GdYN4yOukwx8bvXQe9ntAGUumY47s=;
        b=Jr/n6yAASybLXDEYV5LxbvIzxMrOcnbLJah7XwZZ9hvSXXZwLdyVVKqTIaw9NIgIjQ
         VMTw4qszDMVJblYMbkWcv1ZOAXj7cGPl3Y84I9AArz5i+5Te+K3B89qBtcWvUzz3EGER
         OX8NOOiSWFVBROTfMFgHLPnrVW512KVN6/XXNLU0OBaZ7hYFUay+0TPOJRfRrwgJbFPs
         PkQ1tLv0dPLi674fO4VY3Z/hV77o/RYt7BImZIq/sZkOY4D6hhoQJ1bAcPgfWP2EKGMe
         HrUhPXQHNKZsWrWAwgqJswVIgELleqd2D1dAyjYbbzvS+VemxnP6pRsshTMjneIXn4r5
         Xrfw==
X-Forwarded-Encrypted: i=1; AKwUvBwnAR8wP2z8AVYyOrBphJrY79Hplu/WoM6rFcfKkClX/R8W4LGJOM9xenMOQb/j4Fuyh3XTzxhs7Wtq9e0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kwX126CyA6VSd+BukbXaPbg8wYsR3zHlTTS78n9pfm9pC3JM3E
	8YZ0g7P5CGfUIZp2y3rjInG78HFB+6xL0VoWq+cFpU87gbkNXG+a2xfT
X-Gm-Gg: AYBFou0v4dB5DpJP9Tuf2AVkaY7WXNApomTJkImpGxMU0dEcQnqsvDA6oszJUO8s6Fu
	x4UsEyUFC3BMO6FrZpWx4Zb4JPrw88x9k6ruVE+4RrgbcJO+wJdfUXZwDmTk33spulrk2bXCeH/
	2JESYIySfVlQ1SILC01UylPd7qedvwOBmAe8XlZ8VqAgWkxetJkOUL868sbOivku05vBUsyVggV
	4pJkT4rwgD16i25c3qZRiAX3li8OW0MMcSAnI4Jd6vPG+RR7d2w9C5hjYG4JBA4S0FAgh7AwxJ9
	2gYzpRusgKseulJEWDegpbsDNKGht2bu1ihlS/qw9IyNPHPixyfU4FJo/YP7dxJYq5Mi0pbpwut
	BdOBjCUIlkU6aIsiuR1M06wsxscIqiQxZ6s1CzvqrlxiFo9jUG3WvpNIF+ZERWrrDGWcodV3vQJ
	sV0aisXzWiI225cgpJ4L0h2bgwCVrJfYpfuGhOV+a88NigrnUewnDsg3TPIsd3I6mTMwbRHbZDB
	tITXYwfYc4yYLF67Sl5NQcT7ZwDurcDSo2JW5zQDL+jEgDSFUteLHmpwqn8vSLWpxduZhZiiyNQ
	Gk+sIJXFx4FpacCJzp04MuQiWN1JIFK+PQNW+Vj/+mifN4ak3RJKctn2OCo=
X-Received: by 2002:a05:622a:4814:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-530e7edb01emr1223561cf.21.1789163959026;
        Fri, 11 Sep 2026 14:59:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530e64da059sm2568531cf.24.2026.09.11.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:59:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCH] dmaengine: bestcomm: make gen_bd init helpers static
Date: Fri, 11 Sep 2026 14:59:14 -0700
Message-ID: <20260911215914.175851-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
the PSC wrapper functions in gen_bd.c, so make them static, drop
their now-unneeded exports, and remove the corresponding header
declarations.  The reset and release variants stay exported because
sound/soc/fsl/mpc5200_dma.c calls them from a separate module.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/gen_bd.c       | 6 ++----
 include/linux/fsl/bestcomm/gen_bd.h | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
index 61b5746e1a97..b5093f7445cb 100644
--- a/drivers/dma/bestcomm/gen_bd.c
+++ b/drivers/dma/bestcomm/gen_bd.c
@@ -81,7 +81,7 @@ struct bcom_gen_bd_priv {
 /* Task support code                                                        */
 /* ======================================================================== */
 
-struct bcom_task *
+static struct bcom_task *
 bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
 			int initiator, int ipr, int maxbufsize)
 {
@@ -108,7 +108,6 @@ bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
 
 	return tsk;
 }
-EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_init);
 
 int
 bcom_gen_bd_rx_reset(struct bcom_task *tsk)
@@ -166,7 +165,7 @@ bcom_gen_bd_rx_release(struct bcom_task *tsk)
 EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_release);
 
 
-extern struct bcom_task *
+static struct bcom_task *
 bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
 			int initiator, int ipr)
 {
@@ -192,7 +191,6 @@ bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
 
 	return tsk;
 }
-EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_init);
 
 int
 bcom_gen_bd_tx_reset(struct bcom_task *tsk)
diff --git a/include/linux/fsl/bestcomm/gen_bd.h b/include/linux/fsl/bestcomm/gen_bd.h
index aeb312a1cd00..7253d308d77a 100644
--- a/include/linux/fsl/bestcomm/gen_bd.h
+++ b/include/linux/fsl/bestcomm/gen_bd.h
@@ -16,10 +16,6 @@ struct bcom_gen_bd {
 };
 
 
-extern struct bcom_task *
-bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
-			int initiator, int ipr, int maxbufsize);
-
 extern int
 bcom_gen_bd_rx_reset(struct bcom_task *tsk);
 
@@ -27,10 +23,6 @@ extern void
 bcom_gen_bd_rx_release(struct bcom_task *tsk);
 
 
-extern struct bcom_task *
-bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
-			int initiator, int ipr);
-
 extern int
 bcom_gen_bd_tx_reset(struct bcom_task *tsk);
 
-- 
2.55.0


