Return-Path: <linuxppc-dev+bounces-21978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C99CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 13:26:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVpPc106Kz2ySJ;
	Wed, 03 Jun 2026 23:26:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780493188;
	cv=none; b=e6g/HWu0RqCor60GLQPCyYrmGl/N5zosiLbotboV0HGnMOB6q7Jlm0A5POHf3jhaAXAHPydKfEozxyoGBHO7aKUdr/6MUuVt9Yjap7N1QwpSdbPYYCkiMe+K3hpOuNeSUWDWGpHokCvR5JktmAnuJbmoXkDLghiHg9Q10fzA4mY3Zt5sKmu4CvNdadWgmzrDA7/9JQlxaKggr/wjfZkDX4/uPT5yz9F4HqGxIaQTupRwapdTi7eQrmz2KrMLpy09blYWClfDT2EXudfUw8JnRIXEtIVuGZJOjnC43KjNLnMA1YlBM4H4zGqJjOxOji0BYpcmW60R/kV8luhiCC6MIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780493188; c=relaxed/relaxed;
	bh=utDwPV/p1t0/Jmc7E5OVVroM+Yd4IFrNq2llOGm4i1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=JdfJJw140Iekdykep229s76XgdiUMJwuWP+Jkh8O+TM97G+LM2VD/QXP66ECfSfOqpqxcklESWsWmqAak1klj/FKxFZOoeE24pwXLwp8V/6suemLikUaIaSP9esFuWKMwsPZSBbkfBtTqnxWcC851KVRyZtNyT6P8IGoSg1Twflm/jhSImKs8DDNAVjYKLYhmmSZqaiYc0Q2A4DxzPydTbc84ZKmNJY8BmfahC3PCnb+FPAJMpC5vnX2UzWmE55ybey1SPcakPviD3QN6W/2HEKjpGgmu9/eWRvTp7yhIBDoCqiKYZ76dJDexKAeBQQ15Dr4oWDpBj1J+z8KFM1CTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJ+y7Wpy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJ+y7Wpy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVpPY72kzz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 23:26:25 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4960234f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780493181; x=1781097981; darn=lists.ozlabs.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utDwPV/p1t0/Jmc7E5OVVroM+Yd4IFrNq2llOGm4i1I=;
        b=UJ+y7WpyE3rDzmCp3YMJvZ4rvfK3IM6XM7Wtn8Q3wABn7H6Ry5k3zwj+sXpGS6OVZ6
         SoI2+sLnCS33zIhApRpGU39LI6Xq4zyvCOh8H0a+5X2vYVGzOekEfXpSS6QCvOE7S67N
         i8buGv/Q02DXcK7Ibxgq5aV7LDb5QIOi2lZhve336p8eGQmtaaLOaMq54p6tI4myWsfW
         qBgd6qI/YK46F+bzIsyqS1ZTfmJOUsc61YKFFwY0Xi4XLYiA10lAFzR2KVtQNyqf/RVM
         XMDfay/Bq/KY+VS4S/fix7jC0yk88XvPLg6WYnQvWoMZS6jJLoZAhJYCnQ/ba8rTsF2t
         +VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493181; x=1781097981;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utDwPV/p1t0/Jmc7E5OVVroM+Yd4IFrNq2llOGm4i1I=;
        b=qmkAHABCeb9WxwL+QPv0iEvmZEHGj3RQm48+Q6b6gaMT52hUOSv+0QUoMpxtaoV+wM
         I+9RNrInZzBeLDZDp90JQurbPzv1sRzY6a+rbwJYOPg9sSi+j0HDTLrvjvyVuZ8+ppF+
         J/6Vnq3Y1ThUwUplSeIdoIUerqin3tee5Np5zRiPCIod/1CPYSc1m9au7+6gEA2Jxl8P
         bEvOO1/S674hFgNXSnJn0wRPHHPR+xIQovPoIcnJWmhYaAtGKW5+LZpGxwgmTLEtREvU
         f7dRV1ezTx5/UL00Eb3eph6+9zienpiOMhs6npCvZtQoQLwekDS5KsxsTHKiIStZW3uQ
         Emow==
X-Forwarded-Encrypted: i=1; AFNElJ8xv58IOQQpOQkXuvy8wUbYT4ceq+n3bS2G5IQiAOfVZTp5JrW6HHeKEfYSrl+70iDIJHbs0RXdKyhwpf8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRcoji/zasAqwFEoVDzFuUn2A4FadRyMHGVkY7GCtR3E2LdbQ+
	kXjl0aG8bZ+e4ixXLs98D4ZO957Qp8GP6MLn/9H0rwCL4qtNpgWukpRD
X-Gm-Gg: Acq92OH99drFSOg6vzt8PaDRppR8uvAyxnZRmLa8hab98iLblyEVuSQDzYRKV5Lw6WZ
	42SSyEMWD/U3aiYzq1WDGI+jPqNGHWWemDOn9UcMNbdHcVw1oAr4CJuqLcMT2g4bCSngEvP0X+A
	cDZm8u55Cne8Bh/p3+6ejeUJ9hwzVu7Lo7ZM5BED+m4g5LOYCag5+g0Vs2uC2VL/tExmXsOxnz5
	T3Sp+wdH5ThHH6MvnI0WNL7COX62E0IuLh9HeUOPBnfh9Ns7qrQp43+IDMQLzj8FgtcXpIkB54A
	ekmTcNZGWkdIqVl7Omsjq/Onss1qLXy3kPXW5aDbp4JFMn9qIg2Y1v02W7ovuzcfLkAJuIlB7T6
	07QDePdazz7YO9C7x6601zJVdL4vzAxajdr+XU8prRJC6sLFTVRdk5S+2MZM5wjJXh7nWc5hQcd
	+NTcrA7Jd0T9jrh93fUK5s9k7jdB2xZleU
X-Received: by 2002:a5d:63c8:0:b0:43d:69ff:6898 with SMTP id ffacd0b85a97d-460218c57f8mr3748207f8f.9.1780493180903;
        Wed, 03 Jun 2026 06:26:20 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm8224614f8f.35.2026.06.03.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:26:20 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Wed, 03 Jun 2026 16:27:09 +0300
Subject: [PATCH v2] scsi: core: Remove remaining references to the pktcdvd
 driver
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
Message-Id: <20260603-remove-pktcdvd-references-v2-1-c4402154d53a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ7CIBBGr9LMWkyhhaSuvIfpAmFsR21poBJNw
 92FegGXL9/P2yCgJwxwqjbwGCmQmzOIQwVm1POAjGxmELVQtWxq5nFyEdnyWI2NNuMNPc4GA+u
 sNKpRQkuLkPdLzui9f1/6H4fX9Y5mLYelMVJYnf/s8shL7x9P5IwzraXqWm7bhsvzMGl6Ho2bo
 E8pfQGcBljc1AAAAA==
X-Change-ID: 20260530-remove-pktcdvd-references-9d5c6362a5de
In-Reply-To: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8092;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=JbV17MusThKsX/XfftOIwSTO4Uf9F1T1idPmFAgjMao=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiwF7Z0Rd7zbzT7PWVCVdOLs2+ecMmtY1H+fmOClXXHz/
 +VtSxMkOkpZGMS4GGTFFFlenLvetmHPmYB7SXYtMHNYmUCGMHBxCsBETnczMjx8vTAkU2vFIgUt
 wa99KhvEpBP/7NO6YmXjZW0g8kf+0CZGhpnHb/w+9dDUNKA7w6SpS32pg/clzj2bgnWfOzFdK70
 QyggA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD* references in defconfigs and around an
export. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
Found this incidentally while looking at kernel sources to understand
what pktcdvd is
---
Changes in v2:
- Reworded commit message on John Paul Adrian's suggestion to be about
  the removed references not the export symbol
- Link to v1: https://patch.msgid.link/20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com
---
 arch/mips/configs/fuloong2e_defconfig    | 1 -
 arch/mips/configs/ip22_defconfig         | 1 -
 arch/mips/configs/ip27_defconfig         | 1 -
 arch/mips/configs/ip30_defconfig         | 1 -
 arch/mips/configs/jazz_defconfig         | 1 -
 arch/mips/configs/malta_defconfig        | 1 -
 arch/mips/configs/malta_kvm_defconfig    | 1 -
 arch/mips/configs/maltaup_xpa_defconfig  | 1 -
 arch/mips/configs/rm200_defconfig        | 1 -
 arch/mips/configs/sb1250_swarm_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig        | 1 -
 arch/powerpc/configs/ppc6xx_defconfig    | 1 -
 arch/sh/configs/sh2007_defconfig         | 1 -
 arch/sparc/configs/sparc64_defconfig     | 2 --
 drivers/scsi/scsi_lib.c                  | 8 --------
 15 files changed, 23 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index b6fe3c962464..840130a73992 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -89,7 +89,6 @@ CONFIG_MTD_CFI_STAA=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index e123848f94ab..61f09cc9ac12 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -177,7 +177,6 @@ CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_RFKILL=m
 CONFIG_CONNECTOR=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index fea0ccee6948..60da9cf71b72 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -83,7 +83,6 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/ip30_defconfig b/arch/mips/configs/ip30_defconfig
index 718f3060d9fa..5c2911ff9a87 100644
--- a/arch/mips/configs/ip30_defconfig
+++ b/arch/mips/configs/ip30_defconfig
@@ -77,7 +77,6 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SKBEDIT=m
 # CONFIG_VGA_ARB is not set
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index a790c2610fd3..dd3486b8d1fc 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -33,7 +33,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 81704ec67f09..b10dac71f400 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -224,7 +224,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 82a97f58bce1..bdd5d99884e3 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -228,7 +228,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 0f9ef20744f9..523c0ff329ac 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -226,7 +226,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index ad9fbd0cbb38..60054e54bc5a 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -177,7 +177,6 @@ CONFIG_PARIDE_ON26=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 4a25b8d3e507..a50a7c097542 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -43,7 +43,6 @@ CONFIG_FW_LOADER=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=9220
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
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
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 5d9080499485..f287a41cd38c 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -45,7 +45,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NET_PKTGEN=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=y
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 632081a262ba..4abea39281cd 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -60,8 +60,6 @@ CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
 CONFIG_ATA=y
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 85eef401925a..b67f0dc79499 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2224,14 +2224,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
-/*
- * pktcdvd should have been integrated into the SCSI layers, but for historical
- * reasons like the old IDE driver it isn't.  This export allows it to safely
- * probe if a given device is a SCSI one and only attach to that.
- */
-#ifdef CONFIG_CDROM_PKTCDVD_MODULE
-EXPORT_SYMBOL_GPL(scsi_device_from_queue);
-#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>


