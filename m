Return-Path: <linuxppc-dev+bounces-24384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596A7C44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 19:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h20F35vYRz3c2v;
	Sat, 18 Jul 2026 05:23:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784316199;
	cv=none; b=MtQE2742yutdYiARpiQqHvIqjiCAz2KGdz8h1ztvONnaPbxNX9/NLUj4JmVM5GCgI3zojHU65VQn4RVqgVJCahsrzLIcejopcC7na6Fr5EjshYd51C5oZaPHEerr0ZxaD1mkKFaSVSr/tyQ+IFQYa9ky8vwjXnXDZtz+Z+lLI5gSSFXTXkDMBe/rS7qqvXAB5kUC4rLtXuPO9psOiDd9vyhPzUPLLtFD429fYLUMk/FO5qHzrHwxvDk+6iFhRdSiAGDDn/epulfh5o4hPZI9HEgwc4b5gY2E0ryXCWnB8KOY+CTuoY0v9iZemv3qQ093b7tKbDoLyl0Rwc4DjH+jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784316199; c=relaxed/relaxed;
	bh=SPdCkxlA8X74oFMkHK/ZQTZZ7JqeLcvEXL4wLlarljI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJZ8bvUuhsV9LaxDgOX8XkDebTTWJ0yLwjIbdLOt2O/ur6jncSxbqsaKJrMM7j8nI6hLnR3vz4Uz9RGVNkLWT0Tlcs2yqw408a7eZ9yYHAH+Ya3F/9lrm6+B5gvsUjC0LReQRT75SQ16Om504JPM31hcuwTbISRX+UU1TlyFhuUZ0lKZ8jpo4A7P3mLwu2BB0RGwsXbyffTnFX7A0HtNJ+x/HOkCJQg0Z4oj7dtDt2VDQhwWq8dl1XtXMN3y53g/ZbZne9ov3i0xrw5IK8moYZXBD0xrjqomlTOATefgnL70ndmzqVhzTb4FxGSTIRPekXJbTfwN41U/38ahoT51mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJoHBJyq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJoHBJyq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h20F2503xz3c2W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 05:23:18 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-848743155bcso2119003b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784316195; x=1784920995; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SPdCkxlA8X74oFMkHK/ZQTZZ7JqeLcvEXL4wLlarljI=;
        b=WJoHBJyqdS8+wEOdC9ZzL4BzvAcpuI4gp7/+EX0zB1q1MN9M7lS464dyywUpLnUF6c
         1NU/aaVcb7zkZeRbz3SwdMV45oiy3uOlG3/+vaRO9AutLvz6gdo8fGuYP7+QLai6bE9I
         K0VZx74lXRWe31BDdffyIbBJPk7khqBZeBnIg9tsWpbxMXfIVyqHJIzR4sAvrZYQldbB
         OQS2Mp2S4ibZ7S1VgCPR9a95lNf+bWeP1LK8UN1WjXtIyFoNn04QXoDhBFk4el8Gdr0X
         ZktsxATAPvfrS4mR2zjO1lFpoplecHDV7LhphiU3DXs52L/HExOtKAjWtaZ9y3A8MANn
         stwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316195; x=1784920995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SPdCkxlA8X74oFMkHK/ZQTZZ7JqeLcvEXL4wLlarljI=;
        b=A2J5X28riEn8QntX9feUY3RJzrMZ2ld0P8FhSVUDE4CxQbgMBMCbEIe9J8wZIDJSIC
         6l+8axBdvTMwIecfwI+bilnx8N3Wtv0Eh8nazf5mgywrnflbDgIGNLK932/eDhZ+jRoK
         jxcdbtlezW4TJyud8um2n2TFRvSPyaatw7YK+3ReIr1gJ78TL7iW+/HWEPymJ7S1vQ7y
         +BEz2yIpr+S5SRwlMgMroTcky7FSIVF6Chwk1KOaJMejsjStsghP79a8+h5phsUmJs8o
         j4UuaUrX/FzLrfavv0hzEEQhHc437plI5K+p8uVhPbSZv/jEc911eVikR4UMsN3WMGRs
         6jtg==
X-Gm-Message-State: AOJu0Yz6Xb2n09sCTAZHbayeBAXGEY1ePfyPvHiqy32nkbF1ekf2ytHc
	hFcF0hAPhXY8uMBBgLNTTLSHBvk6mFiBUWh7bC43NnfqMm5dhHXaNVXREEeidQ==
X-Gm-Gg: AfdE7ckPcd5wBv/O26J9fHe6On2WVLcZ56M6kEmYYawG1k7sqOvksArR/yu0cEnikKL
	nVDTFo5cCHRBT2SBZDrWwMzHQ2VuMkW0EC9ZWKoibiOM0TorgSnK2KSJq0xgafmsmqLFyaNrltM
	6QtIFJSnBU5OrYypnlBTVlCbtw1EMwabF9cIOsQ1tLdD8B/K8RIFwOfJKMTECHXyZ+q0xlODEjF
	JaYHOS5ccTquIZLKKR8q2lw0KPofy5EIdeDDshHUQ0/qdv7e3g7t5SLeJU0Js2ZsIeWMX6L+w44
	6HSD6bVeDFg5e4usNebL0g+W2eYTYXcB29dgF6YjkdqgfgmIwOiXx5hATNbEtVQw6GWdTYWYkdK
	FH8p2/4jAn5wrk+y0rActo++Wl5fdEqmNxW5hVZuKVj0JxRHgOYVb6V+9XM0RIiVlxkD/Puh/B4
	WkErGH9tFsOfzppL6YqYvRaQNVdfOv7pkZIaBxeNorAdnLvZ0W9HXZKDiQjMTM7rDTS71vbADPR
	CCTx3Q4mJ/JjaCBQICSVipacb/R1BFUxiPEm+Yrlc7obuYNspIaUJg=
X-Received: by 2002:a05:6a00:4505:b0:845:45b5:9825 with SMTP id d2e1a72fcca58-84c29501135mr4076417b3a.37.1784316195245;
        Fri, 17 Jul 2026 12:23:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm1586684b3a.27.2026.07.17.12.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:23:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/85xx: register gpio-keys devices for of_platform
Date: Fri, 17 Jul 2026 12:23:13 -0700
Message-ID: <20260717192313.108152-1-rosenp@gmail.com>
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

Add the "gpio-keys" compatible to mpc85xx_common_ids so that
gpio-keys devices described in the device tree are probed as
platform devices, matching the existing gpio-leds entry.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/platforms/85xx/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index c11deb2f50ed..50ee5f2550fa 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -31,6 +31,7 @@ static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{ .compatible = "fsl,mpc8548-guts", },
 	/* Probably unnecessary? */
 	{ .compatible = "gpio-leds", },
+	{ .compatible = "gpio-keys", },
 	/* For all PCI controllers */
 	{ .compatible = "fsl,mpc8540-pci", },
 	{ .compatible = "fsl,mpc8548-pcie", },
-- 
2.55.0


