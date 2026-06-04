Return-Path: <linuxppc-dev+bounces-22035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DD9CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:20:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCk5yGNz2ytv;
	Thu, 04 Jun 2026 23:20:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579202;
	cv=none; b=ohDKOOn6yrrNoeHwpCPvnNGgBVbwBRD93QU/Fy5YGf1mCfhXomX5g69KO+VS4EktHJjKo44xY1bwcTXE2+qvIYoarkgLXRwq9xJ/n1eF2QztuhGQq/l4sjZ/5290iTROiWD2lkwJUh6kwQNifT0yfR7oON4yeMXAOGDKyFdh+wKWAx8m4V4QY3rA0UmSHoV6fY1vY7gU2qgc+H/EMAQzrqmbh/BWttuiswM9cc2rV26AeSwiUeD4lOzMcxGphWaso32hfyqY/X94Go1K//isKX09OO5Zq4ePl5XSQewoTfY4+ZIyiQRiXilvZAsv8c39DvE8Q3iIpGuQJu2/vSvvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579202; c=relaxed/relaxed;
	bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY6S+j+AGtlrRDjSK7AFHdwxPXuT2UBb3/uvpVwF4/PJwNcm66otA9gCC09nIj4EK09VOfxkWrWAog1lz6m/0rmhaQ/WJL7Md/JAgbmWPzhTu1sqhlpYtllw9pSEMoeVxe6t3Jlz6G3+KCw/akq6kOlA0QzUVPDd4NL1whhgd44P4FWZo/H6JddKn5zhskOFYbIBAXYZx/jjxAxRpWAVMVHngP+TnymtzsIf4Furer4H0/F5JfPXJeAn+/oS0j7jjWlO4Bpb3W8GZWDe+YHXo989yew6dzU1d/h/KzweF3t7nnr68ItLZbeVz3MQn04uOF6r9YOqAib3T+wBa7++JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGRXbfgN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGRXbfgN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCj6Bk0z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:20:01 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso5987565e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579199; x=1781183999; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=MGRXbfgNF6vhNAcLocp9dUKatm3HRtLBHT+7aI1z1XeYRv1BUKP2t0rMWP5k5GO9EZ
         4qMtfEwz7BtK4GzmQDLqY82GZYInvwWETM/HXYQkHThv89rcvnkoQlr7UzZoQg17VP0B
         b/ugJ802OyINjpegtWUtEHKLJY93ZleVEzjonhhHPO2YCnuz3esLao1MKCGnBUMLgTur
         ewrYvML4zvQDm55VNpLfQbF/T13cEUd3D0MklGOrLdfKH3MmdozQq02SsKzrlPImRzy8
         h+UDlxtcyINwCR2bcclDRkA9Ghmy0p18/OrBr8wvlrE5MB9ZyX6yJ740PLg5SR8xC5hr
         QgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579199; x=1781183999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=a0XF3JLn8q9t62RdvE+YwXi03sPTsXQ2arNHU5snbpjRZG0SNzMZr3ARgieS2bsL8z
         BSk0SFctyZ52YYu4QGCvBxwnOChoi21Hfc1+PE/XVLDO0F08BE34Ay/SO3BHaeSQGWdc
         rVts+ihTsP+6JYSm/Px3CYSMc4RHwTPzOQ2p64H5DhSdloPMWBwoErr+i9pqLyqELCsy
         1CSijcJCOBi/rzPl2emC4suHh39Bx5J/++BwSJ5Zm7aCAADMylSq+NDqrlbVzbWdxjJH
         HFvVeyY71mis8tNjMNkbXCQVAKF4xfJXpHaxQy3tj6OxOv850nY+QBlZR/gKFeo3bbup
         yiDg==
X-Forwarded-Encrypted: i=1; AFNElJ/co14XzaM4qm258CYPtagmTZ+ppELbPjcacB5syRrX/YtSEune/6xVi2JgXrB13pS7W9ryU4XAWKJEwC0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBwXDUG9Mm94lVGQEYWbr/FJhFyrDn2o05DzqV3mBjo8juC7me
	/Fqde/+vF69MteucNAtRiqYM2ZyeCLYb/Kcf7T0DrX0GjHV9kNVh21b4
X-Gm-Gg: Acq92OFKj757M4bdxMNa0xku4oJjGETEA75Xb+PUmmIKKuNe4ngCEq07SWg10HYWPBj
	2Pc/TnMnO+u5LSlOnezU34HU2/CXF+rngx3+gzD9+4uEG6gxShSj4hrJINq7DJgQQsLtdI1cHgI
	16sBHkibe1iPjLz3HEBbjjh0Jip/f6Rwuwyktf2BybsHW2LymRSJjRW377lT8pg0ps0uIPIh2HT
	SNkwArvwD2C4JyywhhHWLg2Qe9/2U+bkIhy7iMI9Up0ljsWN8jJErxlJncKmzv3nXxwIgrb3Xvj
	HVJvQVp4AQYvNQ0K9ZaxzVd5otnTqd32sXTUEz0blflKuQ+5RaEksusgl81JRZH4sTxokeNrYqo
	ZZQqdwcl/KK21OWFuBsdLwIQVaw1cmwT7+4/lLOpUInOnQnBHt7nN869uwvR2aMB3f1ez7a66gZ
	p0ZEexmqLZBaePlGQ/r0wCRrixG6Y7ImVE
X-Received: by 2002:a05:600c:871b:b0:490:b9ce:a73c with SMTP id 5b1f17b1804b1-490b9ceabdfmr108163365e9.31.1780579198642;
        Thu, 04 Jun 2026 06:19:58 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm72844695e9.14.2026.06.04.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:58 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:27 +0300
Subject: [PATCH v3 4/6] powerpc: Remove remaining defconfig references to
 the pktcdvd driver
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-4-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVWD6QfaCz/Yty56WrD98M+Qcwrrn9sqvltdV/gy
 rLrO/+96ChlYRDjYpAVU2R5ce5624Y9ZwLuJdm1wMxhZQIZwsDFKQATyWZn+GcaGSFV+FgzPX1J
 Pq8T0x35indl8xo7kg/vsHeqOp1Xm8nwzyLEgilvj/l6p2MrPYTONhpNKdtdUs7dZrS6KkNs9ok
 73AA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 5ca1676e6058..647775f6d174 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -57,7 +57,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index eda1fec7ffd9..5c3e25fd8edd 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -306,7 +306,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m

-- 
2.54.0


