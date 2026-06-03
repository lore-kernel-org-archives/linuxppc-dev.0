Return-Path: <linuxppc-dev+bounces-21929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73036CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 00:55:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVTkt5Dxhz2xc2;
	Wed, 03 Jun 2026 10:55:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780448118;
	cv=none; b=cGWfD2JaxyFdqJdLS9UQ5HkuwE+9BL9YmRGv/n8Fc+zDAPdl9+vaCMKzKbOMwoEWxsuPnPddMjFTPZT85tvmg+rSaVP8D3dFD+KyB12FSFirq65vabp9aptX3f0I43yaI79uK2WafLO7JYMOhBWwPH8l5FnF2Vnfd06y6qEhD31G7+T8qMnHCbw+oS5gtAiH83cmLu0ps8CP96gq15sB1I2nwAJIUvOLou39/rpD3YP2kY1L3FgcEsoCKyUcZ4xILg5Vo/4RAJPntPfyOmXu37N1RMH4RgwqOV8+tokzYgfVjab9t8XSwJKLVP5OHad98VmgvA42OaBn7viwvAQFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780448118; c=relaxed/relaxed;
	bh=H0FmNiszl6LG7p+K/D+44UYsDnEcYJOWSFq2DyYSycM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZbtLW1SUSn2jgoHRavG+wLH4W8/2jdv3rCK92FnUBEEFMdqdB6qDAnvbLvL7Cq+ZSIzPzF0WxzXpLqpIWQCbEcq8ILKY3eOT7wxnMJxLNm4tCFoRJ94er7YYEDEyJFPjh8I5PBhq3A6xwiUvDOTvo6AAHRJ90FmknFLWwzUfUc/vJMXD/mV3ZOjMdCeRi5cNqS+oOfICOeCXi0k9hxaDH4Ut3J5SPzbmbyoQiLJo22yqmq+4YkDR21sQ+Wl9d9ZeV0+oC/woMJBemnG0IE2W+PINTC96eNcJPnBlDl4EUThj56PXnm1QXVWLSbtlzYA5XVOhBpWPQWpHFvYCW+1kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zwv4rUFa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zwv4rUFa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVTks4WNpz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 10:55:17 +1000 (AEST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-9156ceb55ffso199365285a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448115; x=1781052915; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0FmNiszl6LG7p+K/D+44UYsDnEcYJOWSFq2DyYSycM=;
        b=Zwv4rUFaZD7XtzdhXqvHMBN8vWEwCK/b8fkvmSZ2k6Z2lLIWLrVIMXKPOnirCaUFk9
         tLk08I41fQjql7o6qXFOTN/4ho3YiHH8Y+IahEb78j9okCny0PaP4IpbkNP8lsUh52hd
         st/rWb6BsviGVXByW6UOAVsUoIqp9ljq0ryC4fKlpFIniVGUZ2+J2Qc8wSJnrLvnG7ZH
         nnsVi0zRHwO8Zf09mvTLu142DSs+aHvhfmBj3JwCMz0PIC0nLFm2LTjA9igXYD0DIgS7
         B8dXkXvCZTJkEBm+1OFmhbCCW4QjKD0UX6vpfwEjdknB1l5ra5p3zZE6uoVCKQv1nIVu
         aqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448115; x=1781052915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0FmNiszl6LG7p+K/D+44UYsDnEcYJOWSFq2DyYSycM=;
        b=rTz0T4BLQwVmqLGPJuTnpJiVQ4uD6MCUeYuzGvXdGrNknnpzNIyyYcTMqMiXWhmd43
         QWBpoU79I71/LDA72s99bddfm9ix8UPrr9MdeFt3POI8iu5Y5MGM8hT+wwVHOTc/ucPU
         TJbKP9/5onPMBqw+B4bxL6QxAtZrbO00Z2mpzt50WL+tfD4ybmf8BQOXLG8fiRHkUvYJ
         5Qu+nm01J/B0ajOSN9rm2GYcLHiy3ZmL2ocVaFkFPTZEdNg5vkW4SZx3Q67+esyVNoiS
         wmg2DgIw4z8UYyjZGr1S4BOQBbYSg4QqvcXn2C0kQUlVGD+vWb6APlPYdtwqNWrkgRD2
         rUtw==
X-Forwarded-Encrypted: i=1; AFNElJ/dbS4B+CdG18c6NhdYpklSAqjh1EOzswf2fmMXw4cBEp0Dh2qMcbu6rZr+d9+4qMmc2R22JbzymhtDcck=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/9YlkoN6GZQTJ6qbGnS9MfijYJ2xjlm0BFsqlABwVqtTuDBjr
	JuN5589pVVBHKRtn2QDf/G7i0DaKN/FyquO5ZHBI8f7sQ5kWsp/HMFVk9JYe5McE
X-Gm-Gg: Acq92OEZ/gRzG06ZdG1imyTrp4s/VAq2NDShK5GVKSa15KyOd7m+auhl7g0DkggSH3y
	SKudkb/K6TmzHunPYppNYd1noJE/LJksD8zMV/BL7IyRDk88qShc6qvvFo/e1a/Rb0nT82jcCop
	sE5isrb/21N3H1D2jmNgOAl/QqDoAEr1k0+y5wg7xv00aOkcWj1au69CfecmAuqPZNL0ARx6cX4
	rZZShC5+NjJ2t9BWOOT2wPPZ09mq7xOwF4sJPzkAbnV8vexTUqa9VRyiCrdbNoBX1tldcnmu3Wq
	G/yDK2l+uTDU0VwXhs9jDeS9mjdnJgMB5dcg6M9M1Hf4IZjNME+jh8oWyIuMFNFKGdChJB9Fjje
	CTPY1qut6NSe5yR/+TNrNn5RuqyOFYL3BQ29H/yWprhJIyAFNKIuvwDN056rgvrY1hj9ifbQ5RP
	hunlum08miWmaxOKCWbm3w/RTuzUcPYhl02PNMpIcKMrHePC/hBsC4qpzp6AtMw3g/xMzy4KbWU
	EH9YWmpPgetvOg8eaggs9hglQVmLvGaUrYmML1xPScegX2T/KOeGpkC
X-Received: by 2002:a05:620a:1a08:b0:915:7732:ea6c with SMTP id af79cd13be357-9158a7dbaedmr249288285a.41.1780448115207;
        Tue, 02 Jun 2026 17:55:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm95701985a.27.2026.06.02.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:55:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Jochen Friedrich <jochen@scram.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE I2C CPM DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
Date: Tue,  2 Jun 2026 17:54:55 -0700
Message-ID: <20260603005455.226882-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Replace irq_of_parse_and_map() with platform_get_irq() as recommended
for device-managed IRQ lookup. Properly propagate any errors returned
from platform_get_irq(). irq_of_parse_and_map() requires
ire_dispose_mapping(), which is missing.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..23679c192edc 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
 
 	init_waitqueue_head(&cpm->i2c_wait);
 
-	cpm->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	if (!cpm->irq)
-		return -EINVAL;
+	cpm->irq = platform_get_irq(ofdev, 0);
+	if (cpm->irq < 0)
+		return cpm->irq;
 
 	/* Install interrupt handler. */
 	ret = request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",
-- 
2.54.0


