Return-Path: <linuxppc-dev+bounces-23765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB13C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:46:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw7sV1tQQz2xll;
	Wed, 08 Jul 2026 16:46:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783493166;
	cv=none; b=ViRQKw9d9obNjRT7Qd1DqsQ1QRL2oEwB8J15n5GIT58bRdjnV1snjb3MMOug5/FpTvTEB7nK2Us+tQ7gXuSNHhaw12mRBCtbzNFAOjBG/bX1l0BaR1MfWS806YDYMsllEkNJaLJkox8rxNhnePadh6Z2ek8LEPU4P7FBN9HIxQ849uyqWkcBY2u+vqJNn5+dliMgpCEtns5gc7uGzlD8g4QxW3jgK5YFg9qzt7Cua/bGbgLkFoCZq8PtXP5liY/VzDoYKTwWOjVrVtcxIKMzvpMN23qTEKetwFg3HJZKidCINlECn0GpFMLL5mIquDZ/vg+N8Axc5P5zlwTpKKC5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783493166; c=relaxed/relaxed;
	bh=WJ6VCqrU1S8vuSoFUrp/Z8LoI+05YfC2UR8mKpg8S2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OmWgzEzVKp05EsvvhPafwR/IJ4VdD5YDpLseWsIYY8LZhoe5JfRoRc3czUxMO5jHWq64k0LDoO/cxM0a8cyt++tkD/wHk7e8qh7fHkV920thC52NDhyztP6Btf0CpvAbTxqD8T/zDUo/ImnyuajxgFnS04RCWflY3f6aAFxgTA+Uvj49v4O0uWvpEi5P+2VjI9tZLGkl1m9+SBs/y46AWE2Ln9ROKHfUSqOc0+F1OLg1JN0hO7mG8lCqJpBec1ALNSgPOBzZ2aYDL8v0zEQoUnLsPzOlqKTTF4SXSpWylS3kFy+0XaGZ1+ErqqI1Tin3JmhguHXOx7RzIjq7AOxwIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=alVc/X1S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=alVc/X1S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw7sS4bF4z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 16:46:03 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cc891373e0so3231615ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493159; x=1784097959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ6VCqrU1S8vuSoFUrp/Z8LoI+05YfC2UR8mKpg8S2k=;
        b=alVc/X1SpznMG9rR8uMs4uC4+NMRGLnli86G+V3lFPBG7TlUdrTET5bnkGmnwRVRt6
         YnGDbaDTJiCftP80ObWhMlPTl3IoyxqEBFhJTzrUjTQXFE91JobZFLARhvrdS0Eglf/S
         OQbbD3Gl3PQ3c18NrdnEO3pBNPcAEZfw0SDxBE1zL5tmTHKL9ecMxb+jSttk2BO+c4aq
         vxyOieiFjoEMPiPBGfa4hOTwrtq+J7iCXe8+A8QQBI1VDI7v+McdFesd5D8NdNO849h+
         7bAMVH3UmPZUSsQGlvV1p0vTKXp5cl/tAo1SMbV7kVfoCbfSju7bsv/kxOkbh0fZc005
         zh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493159; x=1784097959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ6VCqrU1S8vuSoFUrp/Z8LoI+05YfC2UR8mKpg8S2k=;
        b=D9F0iZUe5PSOZPBs44JyNsLlZGLNRypkxmpwTIN+W68e/1D7FydWb7JBMfuXDLfti9
         NMGF0JgB4NffZJdxqfCcKH0xhuxpBZRspqNkaW5oSt6gSPjcpqysgH1JRDwZy2bkNmiO
         jpxNI2s8oPLMBLXrbDOO5zLx0m/hCCXEfR69PGbL7ObeGallrfkhQ3TBOtUft43J/OYq
         JJAnI2L+tSTj1MfgMHI+KhtBjkAUaaiaekP/hMv60628qQ5g2WWl5RZ1dMUQ2xLFIXjI
         IA0PNRYX6b3wx3O1cjGSR5qb9z4BE/F72FH+YVTa+lACAi1cs33zzIolaYjAwTRpcvl+
         IBRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFBMVHyNsvlG6qsJzrNtP48ewPgV3105dPF6bL5ak/LPbM2CHp0TzlkWG614746L695sZYGDlOFZMcH80=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDTXxVglcsJUH5PjAp6r4cicERZfK6v31zFKI6WqE0NSrKS6oS
	71zVFQdN27ZZ3zQCzB9JgzOvbFXAeUMXNpwz0Qfh+BfuMaN6vz/WjE80
X-Gm-Gg: AfdE7clYV/VNt6zap41CSL21tx+Rmi/c171vlPXe7Lg8gERiIXUFUQIHfp+OlUUMYeE
	XRqzbwhgejNWkKARRKV3rwttM+/OPC9wthvr//FpZ3r2NqC+/kVuXXL1U6hoOre7N7b6/6uGJwv
	YLvK2N5t6q8oIGVxNYm25IS3yrmYzGWXcSWmxvPrUO7p3XLPNyJ/pjaAny1N9k7cN/wEnUGPlA7
	o5PDHsDzsC8I0jre7wZAZmBG49HAqZbhWjYb6AiuwQ1TYKKeXFPZ0EjoqU9CZns3eYQmymv1odO
	YDm8aA02M3R3Fs3c7olO9gOreG55Ckb0Ww01oQC8SZscKQ+EmtkWGRZba6Db01/XMsbk2Smv3kS
	Ewm3wK3s3YPerKIrsZuc0uFyAaTZERdpMfCJvdYW5Kf7214MIYDokgKkVeBaDrH03BB4E4yPLFS
	8In3nLUidhpw==
X-Received: by 2002:a17:903:2443:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2ccea3d068cmr12460625ad.17.1783493159585;
        Tue, 07 Jul 2026 23:45:59 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm23455385ad.4.2026.07.07.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:45:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Li Yang <leoyang.li@nxp.com>,
	Anatolij Gustschin <agust@denx.de>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: phy: fsl-usb: clear fsl_otg_dev after freeing it
Date: Wed,  8 Jul 2026 14:45:49 +0800
Message-ID: <20260708064549.719147-1-lgs201920130244@gmail.com>
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

fsl_otg_dev is a file-scoped singleton pointer and is used by
fsl_otg_conf() to decide whether the OTG device has already been
initialized.

fsl_otg_remove() frees fsl_otg_dev but leaves the global pointer
unchanged. A later bind can therefore see a non-NULL dangling pointer,
skip initialization, and continue using freed memory through the global
fsl_otg_dev pointer.

Clear fsl_otg_dev after freeing it so that a later probe does not treat a
dangling pointer as an initialized device.

Fixes: 0807c500a1a6 ("USB: add Freescale USB OTG Transceiver driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 35d79f11b03d..0b5e937633f4 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -997,6 +997,7 @@ static void fsl_otg_remove(struct platform_device *pdev)
 	fsl_otg_uninit_timers();
 	kfree(fsl_otg_dev->phy.otg);
 	kfree(fsl_otg_dev);
+	fsl_otg_dev = NULL;
 
 	if (pdata->exit)
 		pdata->exit(pdev);
-- 
2.43.0


