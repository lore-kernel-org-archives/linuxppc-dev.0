Return-Path: <linuxppc-dev+bounces-21991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B131FCD6E68
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 04:33:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWBXF5tk8z2xrC;
	Thu, 04 Jun 2026 14:33:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780547613;
	cv=none; b=RoKQ5fdcM2llWglcicXNWKeNFaTpWo/MrciFk2kmmBDrPEBHEYO5DFVyCSv5FfPqA2Z9xq4cEItP0mupRhqajtezHcwUMIKyVGSjMX3Hw/dYWSaRCbw7u61sXc3vXs4iq4cx+NluVFIePqkGDNWWC5YEh4IQrO9Wwa07U2dNg4+OhTewwIodWYBoqHBVvvsR1195lKI8Tx2lwydXwFHdHtbPa9XsRcUsFOOsTbut448Zk63Vla2vPmczS/eI57eo+51EOBI3QKI6EY/54OENTi+otCSFE3TPqfb8UpXQyY4kx574HK3+UQX9CaSr4BThKi6skp/dj8WYZdzKXHjWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780547613; c=relaxed/relaxed;
	bh=nzzlPlmRDjR3Sm37Uj3XzYfzUGKs2aHK4Uo/5tRTKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGKRJVrdL450RZ8//N5llxkmnX/anmsrjWHD46mYuoA4302iGQ28UD76hr5vaIlvH1k/PtqzWbkSWZ8jjgRFJsSeIyh/wfDj0iIrWimd3R/21diya2Dq3zQwadWXvrcr6Q8HnQJ0ZvpewHB7CpJiuZXiqnAny6bl3ryrNp4j23BN08MT2vYK161maOrab12nK/6SNavlrGpYraBl4XhNo8JGdY8Euab5x0kJgehe4kUSGZNKhfAbdWaacHSwrRYq9sz7SNUVZRMWBDLXAf3sXGQd79M4p0OLKtIJFYKs6L53Laba3YOO8kPfRnk7v5OX6QLTHJWK+IFmjd7eyO/Zjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cp835Bpr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cp835Bpr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWBXD3wGLz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 14:33:31 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2c0c35980fdso2698155ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 21:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780547608; x=1781152408; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzlPlmRDjR3Sm37Uj3XzYfzUGKs2aHK4Uo/5tRTKUQ=;
        b=Cp835Bprzvihv9xyHpkOgnkggQQBGwkeJxn7phVqVsKfny+XmzErbBFjg8rJZD8OLh
         4hqas0RAstjpeJFUxA5qttgUjGwm1CjJwiK2HrgEI8QASWH+uViTZFEfCDdTn8iuDXPH
         vYVMAJqAcO54JrPqiorVOuG7VzqycBmK6Q4l0BiOvoBIbBY+SGxT0c0XaBO0wfPKI7zn
         +hCQMP1dmaOhkSzBPihod4t+3ZZcuybNiVe6Dgx+E9CdVxOLeh0H1yiXwHnp3njHRnsi
         5516jwfl0j0CvBhgk3gaZAZQ/KSxJEaM19TKY7icel0sJ81o608Mtju60wSZfFXTVQJg
         36Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780547608; x=1781152408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzlPlmRDjR3Sm37Uj3XzYfzUGKs2aHK4Uo/5tRTKUQ=;
        b=VgDLJvK2YvHxTW65eD7qNNmjXQRH9uWxEMJgY5e2ZlxCx+7iWkrudMMgYMex0Z/G3O
         M/IYEcW/lczfcKkpGP+s9IAtvE1oNTOOqgnu1AY41DwxYnE/6oWV6HlLBXV5EZ9rvxyt
         j3tlw1+QlmCUbMAPO2F6C+JB1szeIsytWrDBfobA7fc5Sb2WLoEIpjCA5dmEy/dsBp3Q
         /PAwXruHKyS2oNXgOQtO8oMckQFE1MINBwezbwiOF/SXaq+GAQ6YCzNvExnfOotplFwn
         MLn2D6d3Kl0V0p1d4pk0VVWjWBZbYHnrjrplAksSEkuEJW9UPiADhKGS8DZVlItXLy3t
         rUBA==
X-Gm-Message-State: AOJu0YzjnqHhXD2Lr7ALXR8sf7+QJOJqE4StabBqnFgA8RjvEZi68YJ3
	7L/+tr3QWPnTjJkF7SNNCbF8CyCJfyz4b2km1G9W6TLcIaAHtvj1g6a2jRlf/9Yk
X-Gm-Gg: Acq92OFKE5ixEk91qhSVlrNt+oosRSu5lCDkrmZdxgRxNkYzniW5ogjuYd7PWxgbB3j
	DOsaaVdwHWYVF6zQSHIdE2tHLuhQcMtaAe7HdlMgbJGY91VcY1moWaebr3eCDC+X+RGbqdP9z3j
	9dR231M2qa3W7kzGSuPA0gWET8zYDcTfvYWYng1qdusa/fSztvL18UFdzNw+i/yJ4PVNr2LNMyZ
	rCcr40zkYTywzTEi8rlLYslBhHCoCcT+9R01sUQLsiCBJeqT5rOwa2Mp2LsdzLUGaIg+z7Tu6Js
	HFJv4XQGN/pa/uSRpzQzSAEC+IApsi+suyIN4DnF/9+GNNdbIR7p5VXHbt/FLQOWzhyt7nCroXO
	YmIQ0VXJXAztNBV04NQDwnkrD9CgJNawHYN8JcPQgOfyuck5QRPzeJdylrg+hIFYtzkPzuZQVHs
	PeOc25UwnZ0PsllNicK0DD3VJx1ruDHxzeHIqfffOmqtyb5MU9b8N+iSs+NWruPhDhxRV0KLj61
	/ch4YFTKtTGJFQE/F4cBd1Z3Ulcs6cMz5vr01HHJprl/rWtkHXL6BEP
X-Received: by 2002:a17:903:1786:b0:2c0:c38d:9d37 with SMTP id d9443c01a7336-2c163d92f23mr64816865ad.25.1780547608050;
        Wed, 03 Jun 2026 21:33:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a63b3sm3503663a12.21.2026.06.03.21.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 21:33:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/85xx: Add fsl,ifc to common device ids
Date: Wed,  3 Jun 2026 21:33:09 -0700
Message-ID: <20260604043309.91280-1-rosenp@gmail.com>
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

Add fsl,ifc to mpc85xx_common_ids so that of_platform_bus_probe
creates a platform device for the IFC node even without 'simple-bus'
in its compatible property. On P1010 and similar platforms the IFC
node is a direct child of the root, so it must be explicitly matched
to be populated.

Fixes: 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove simple-bus compatible from ifc node")

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/platforms/85xx/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 757811155587..c11deb2f50ed 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -42,6 +42,8 @@ static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{ .compatible = "fsl,fman", },
+	/* IFC NAND and NOR controllers */
+	{ .compatible = "fsl,ifc", },
 	{},
 };
 
-- 
2.54.0


