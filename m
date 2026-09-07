Return-Path: <linuxppc-dev+bounces-26626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063EAC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 00:48:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdT2j0tpgz2yft;
	Mon, 07 Sep 2026 10:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788742109;
	cv=none; b=ORM7AEWPX//AwDlxa3yy6ngKxYyAVicP5SwVqG9SOS4TYu7lAhrTPHhxZ7zIY022gfvX9vTt0HpCxlvla9D8g/BWLbgcb2Vqfv3QqbqsUmwl1VV8c6R/2338ZOwSGRyZLDfmmU42iiPx+CrLLTgvqgLknC8mJPVn7qEFoB8BxXbR1PweHe001JidH6VxnQJEUT1zJbPRBf21doStXnckcUYRt1i32Ir24O/6dzYomo4Hkvg4o2CJ0/TwojudZx0j85dogdTFDplnIRVbuqrIMX7rJBu7dCZN96IB2VeU5OJyxCDY4Zmp0DN0FBZcJbMJiYrEEXfWWFDfl3dtFFz0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788742109; c=relaxed/relaxed;
	bh=EjzyVrQd4HnZ/HqhVkU3Ug/THJKIvvL7NvTJ9zdzp98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOoAkDKRZ1k5XDVQXHmupl1HHCW+8g4uW2t3agqWQBnwrLuehyD4EnFQGS6x8bU1Z+ipbwdnzvKDuELsWwAgUw1vBeITAhfs65M+mJ/IXfVVy9EuV/59KxHwsLpAnhLZFB0bubbq/P2OAiu7H7R5osBBpl8JCpJ9r9iK3NG/TQq2yehiGstSgfIojJ4Qk5MnU9ZlUxC6yOeqscHXlULmzz+SqBSelOSVgwvsqrqKLMr3M02hCobCSXrZ5u3UeSavsYI5VFPxyapl2oFNXfx7bXuXPr3UQOxoZ5zzwBMxEd6EnuPVLFRTbDexMKZjZab3oYKYbJiKWzuOEuMPxOPZfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbjIZafH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbjIZafH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdT2g26nNz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 10:48:26 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2393899a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788742104; x=1789346904; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjzyVrQd4HnZ/HqhVkU3Ug/THJKIvvL7NvTJ9zdzp98=;
        b=mbjIZafHLmTFa5h+sjjjhcmFUJ38mvCxrKS0I393Tkgor8xTK4ICzAKYmKAu63TO6f
         uBFzVK3BbCFPd2MOLYj+xD6Cs6u7JWNovfg9/yAEg4/oPE0gDqsBjRZKOScEdSUQuwIz
         6KEtANIa/HuXVPqNMjKxx5jPSZ/LlDQfQoEYYcqcymNheOW+WeiT8rHJ5XyEewt109fo
         Qq+V2XNXXNk7B4PB/cDoZFdCWmUdcnPSO+EekRWecWTb2RZMhINGGFW5n3otsLNaTVVo
         fAz+X8tPra3V7xJx5AWAaeYbNBxeLQba9JCrze2GQPkObNgNAxPWF3PQWS7SWYOag7zT
         Feug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788742104; x=1789346904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjzyVrQd4HnZ/HqhVkU3Ug/THJKIvvL7NvTJ9zdzp98=;
        b=POdzNTAQEU6mBbWzK89p+FWbN5/CTOBKIHHdEYZHHvWiuYtzXS9+WNqqeKCd7299kO
         vUCUrR7dOxpafYstHKEutRO1jwaQD2E34EHvyRoq1cp0xY4p2syM2WSwPb/qkD/6bueW
         kByuMVtMyd+L5fSK8pzEJjosPU3VzOnCU3RGy15sToD88PNEab8Zs20feDn+RK2mhxDp
         4yZdl4k/u7mXK6b+8q5c/LiGcrN95BSeMgvbhlQqnt/gb++nlF+I+wgqKGU+myWQU1gQ
         41q/weZLP9HtP9mzoJDDoG3+A6U06HpJZRa3r7dGAz94LtaBM82hcV6o9LT4ywMKgIAU
         gIHg==
X-Forwarded-Encrypted: i=1; AKwUvBxA3ePX2h0WJXZIjcr+R0AuoqyjGveeq0uSSYHhcX5iO+yyxdi/0VMpeMt1jQwgfFeAFS/qwzhJl5/9oTI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nzihE40tojdJdFYxE3StfN3odmXjhYXxYLS1hHYzWTt+9eAqBK
	6GaJM6u4Wm4VkqFIKjhTfyrCuF+k7P9qPFyGGTS1OLu9eiCKXy5i/gWd
X-Gm-Gg: AYBFou0A++9zEa8+TdsQfmBEaPbdlnMnO7nSFb49JR95lfOfPUzgGZnAgqzcZvQxlXk
	onffq7W8DzFGSW3KhbJBDP8YHXhbAtK1dWsBRdWjAwt7WiCO1hmfqK3GhO5FAqqMCfAfjqXYfNs
	b5NDtWJqPR2UpMmSETjoeB4l91/GqPihAeK5X9M+tg+MDPQ5XQuEb7ECux2gZ9K98BzS3kEqRWc
	vAaIYE+3F5Ura+HR4np/VNErh2HIWCCk+X5bmPlbJHqPWESmR6htg02OXoPWvRaLe6gLOMGx4vb
	r2xadQuaBXFbyVFr7RpRrwRQbfTNQFrC7KFHbODYjNV7p7O3OrhkQzF4PZUmFtoD8+16G59vswx
	1WfYEcSUe7+rZ0t+y/Z0rFEvNftfpAjDAMsx0rJIQ0Ws9sw1hXbM6rHXQpIda1cUbWhqTeeWGu3
	bEJ7naBSCkvTkUPgPBNNmPI9aX9d5hf1jMVbtdM9weh3ArS9/G2BK6c7xPiswjeBb74NG+BlkrQ
	PESMVPyvfTaDdxyw2jbH4oMEI9B3LTTqAHKE1J7fDIWomoxB/Rz340tqwfeWrxxll3wHUpvxEAH
	XuPcHU+o92r8z5imM+fbVsALJrGisNpuURIalg==
X-Received: by 2002:a17:90b:4c03:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39b26130698mr27921852a91.11.1788742103701;
        Sun, 06 Sep 2026 17:48:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm20043166c88.3.2026.09.06.17.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 17:48:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: powernv_flash: fix kernel-doc for powernv_flash_release
Date: Sun,  6 Sep 2026 17:48:21 -0700
Message-ID: <20260907004821.225576-1-rosenp@gmail.com>
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

The function is powernv_flash_release, not op_release. Update the
kernel-doc comment to match.

Fixes W=1 warning:

Warning: drivers/mtd/devices/powernv_flash.c:271 expecting prototype for op_release(). Prototype was for powernv_flash_release() instead

Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mtd/devices/powernv_flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index a12427d9e20f..fe1d6684d0bd 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -263,7 +263,7 @@ static int powernv_flash_probe(struct platform_device *pdev)
 }
 
 /**
- * op_release - Release the driver
+ * powernv_flash_release - Release the driver
  * @pdev: the platform device
  *
  * Returns 0
-- 
2.55.0


