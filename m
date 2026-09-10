Return-Path: <linuxppc-dev+bounces-27044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A04C88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 20:46:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgqTg53xZz2yFK;
	Fri, 11 Sep 2026 06:46:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789073191;
	cv=none; b=nHtv/WMOJk9fTdB9RpEGbpVbQFA3PfQg+h/Ojs4bcoYHDOOItc1OpQdhzhNB2sNAnYZQ86PpGyD7Jk7nw6cq7/AKbxm9gV+hvg/VxKZz066c6A2lnVMJs6BDxSvbqFdsL3Yl+QeBK+wA2ft4jAIX0i1Ug3+jCVU191x3CSznnlqNPkTVv/H9wGgiVSWz8AAzwvJU/QWO9ZX7ontCvtP+P5YLPnB4hsfBv3fhyIeNm39aG7TtnFKYqpbfvgaTHXOVLjRtYC+rOjAa72AEcWRTEjsaBYjE4zJ9yln6A137sBN+8wQk9UNV8vpnRBikrleP3VYPOOJuW1AFnIM4YRf8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789073191; c=relaxed/relaxed;
	bh=D5NzLm00d+6PWFDYExUVxG0yq7opmcUTWEJmvWiRjsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msB4MGylPKa7hmCzlsdBAk4qeaJoj4T2S2kwokgBgrwL2KYLmx59yeA6N3LXwLj34mKhd7acgCXLZmQP/1RNLsxpmXkZNBxz31iEbU8Y56aZ5QYIOAuapJdVhz3ogakqpz1talGcy2BdQBWcK6VE5Tpt3m+bcGKWoxQ+k43bHr6yVTPo3ZbzXo0Rfk/GxmZf96w5OfDdZxTwX8LDoA+nECdB+yIWv1I1NYEWdnrjwVOHjWkTZNf8Irfs80Dq8ClsI34ue9CTFN9MvSSgFAdpg3vJ0Aj2/iNPofILWtsNUDXkZI3j2A2CtIYYyQBxnVcv+7RaI6Fco4bmJxqVIlxkAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oKT9J1fT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oKT9J1fT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgqTf024bz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 06:46:29 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso147568a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789073187; x=1789677987; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5NzLm00d+6PWFDYExUVxG0yq7opmcUTWEJmvWiRjsQ=;
        b=oKT9J1fTwVegb9TrKeXeTBJYF3MbsHZL5eocFEubv2pkwc73IrAAsrHD9VT+itQcib
         yQZTonxFmGqC/uRoC8EquYMSWdMYpx3K50ezP5QqhYpjLOAKgJKICGCkPbEKecj2DLE6
         uMf06ZcjyUM+9wVvM3UpGQNMtNExEU1IKsNhQim6H2JxK6IcfltIeOAx8yWgJMk4+a5k
         2UeWMgYnoZCbL34jhSWW8FQ5c+l1NcNR4S4Un7R4zsB2g7HOk3bJXwpioTVdh1Pw4azi
         i317RRf8YMVoS9ZCgPZH9dshhEdgGzIFNX7a63WpKSZOMCaAbyI8KerwMIrLJJtmrdOQ
         f9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073187; x=1789677987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5NzLm00d+6PWFDYExUVxG0yq7opmcUTWEJmvWiRjsQ=;
        b=p8U6Vz4z+RGVfTZ/Us61GNZttPmEU+eN6RXADmNFvSLhmBtsnOtwoI3QShYpc3qCaj
         hM5jKSEJu0aBcIz6e45fGeSVge+RwyFgBkj29D1APz9ShRkMzpLlSMCPumadVEjuanjE
         q7F2Sh7hFosWuusCkIYef7/fkoDaOqMWV8To4HBMdUp3AmpaS2wr2XOFMpmzJh0ReEDT
         ewG4FqknJyTKbvKO9Ebv1gEOKIPeu1tOupMBiiXqWi9afUc7R6g+ew0OhBjMNVAW0SRU
         OWWq5ZTJxtWFiVe4N+71e1kO07NwTTmrFNQMuts3QzB1h0I0uZrXtkAv4xuZP6A8QegJ
         V32g==
X-Forwarded-Encrypted: i=1; AKwUvByecmbMUorQES9qDN4osWAi5wdcPNtXR1Jt0Y3G3k+WknxF8pdKpvDLgD3nEoOArcvtUytoqf/jxvNm/go=@lists.ozlabs.org
X-Gm-Message-State: AFuF++msZ4H5Pp0nSjkptw0N9wol28SrhhhQdhxH2zDiBVQgdxB0/lZr
	IqoXvyDQqETjROIQ0FrHXnGyBje4rhm1Ce7TYN2CWO1ghB/dG3rBMCp+
X-Gm-Gg: AYBFou1Gu0jdrqsWlskIeyY9tZu4S1JRRM6hCkSYfJPrb92kv+SUWJv5ftCkJ1cnzB3
	kTxnMP3T+0sEWIs68K1kcc34TeBF8DzhwpMIAdk8H9/mWuqSqFnEi8hX6MwKP65TI0tcrEnBLv+
	pbBE08w1CtJPpSOpMsttfqC0WAe0IU2EqFYX07gN2l59zlxtQBq5buCHuGzdNdMB9nodUAwBmYP
	Olgy4Ejaun8Oc6nkYOWAMIXutXdjt36nYUhE673tHRcQjoAMAjDJhA3BCzxxLoiE7UJBF/Q56wz
	SS0Ag8sIVTdifRyhXhqmtPffzBFbejsS8md6RSlXLatjfJ/tt0EmMiZP+c/ZiUIiQpOpLMs0YiM
	EjZqc43t9noLOx3+YpaL5vrT0HRds6lwFxRd2lxsarTPOQLQZjFsWXBuN+txnXsKmEfmmqe5vLX
	s7wFsPB6sRpeD35Dool/TsPAnriWUrddKaPOxel/I9FirKgo7Sruy5MOeQP3jaBySQJ70cB3VpI
	iDnLHfTfVo//SJFlr98KwdZG1CMLCWfIfskoCwLaROb0KZYRJyyCblR7ejK4Y1shdzKmU7YNy46
	qXBE76SBDK+xJYZlyXBc8LU/wWwH7xMJTGU6RCaDg9AZb8+new==
X-Received: by 2002:a17:90b:3c89:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39d9c35047emr828915a91.21.1789073187174;
        Thu, 10 Sep 2026 13:46:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d950913a6sm1261016a91.6.2026.09.10.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:46:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Thu, 10 Sep 2026 13:46:25 -0700
Message-ID: <20260910204625.55367-1-rosenp@gmail.com>
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

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional when absent
and the driver falls back to per-channel IRQs. The corresponding
irq_dispose_mapping() calls in the probe error path and remove function
are removed.

Moved before anything else in order to handle -EPROBE_DEFER and to avoid
doing extra work. Simplifies the if statements as well.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move to the front of probe.
 drivers/dma/fsldma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index fb19c60540be..9ee8ae1aaf40 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1224,8 +1224,13 @@ static int fsldma_of_probe(struct platform_device *op)
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
+	int irq;
 	int err;
 
+	irq = platform_get_irq_optional(op, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
 	fdev = kzalloc_obj(*fdev);
 	if (!fdev) {
 		err = -ENOMEM;
@@ -1246,7 +1251,9 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = irq;
+	if (fdev->irq < 0)
+		fdev->irq = 0;
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1308,7 +1315,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1330,7 +1337,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.55.0


