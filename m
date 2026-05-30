Return-Path: <linuxppc-dev+bounces-21757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4ECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 12:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSKYf1ftmz2yS6;
	Sat, 30 May 2026 22:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780144256;
	cv=none; b=HOhDT2KHPWdi/Kk76AQZn8Pxf5PM4XYhwrp/tKSYVL07mZthj1AEph9UeCxFMbGOzBAFpU77xcXpdm3pPGxoD0JFQxW7L8ch24vP1EPaaCtGGmQozo8Jo2Ndi6wARKX5ROyh6p+agco0bVKdZMF5RZq25Z5qiw4rk40gWUnFpGyMc3oVlvkq6XBRQjbuTm7j1jamrEtYvWnKeg4NDwUPRf4dkQLD5tL1iytQF8W6PooMXt+PGhDNIStsnjTlwXofCnKVc5E5ievZ9nf60j/r9xlt4hr01kg2AQVguC7cfLTm459ZF3cYPNkPD26iVZ39cmYXA/8yPjtrVKJ97uasPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780144256; c=relaxed/relaxed;
	bh=3IrPF7Yf2T/CTW8tuqL+BCfM7WayAgdlVua5IFI5JOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jfCgpd/WqTCcUFbMBDFjkxuuzfGj5mi9DtMs25nBjx9e6Q4mpENh3GG+4qhxLwktBV6lCe/kXiOMMzW2WrtnmSG18rsfB8OvqDZpPs8kQubU2dhqwNNffot4Y63xw5b/Vgzy9fgVyvFVnUQzGAAaZVXIYnW92Sa9F2QhxxkreaROkbblLuRUdo/VTHABfF3wrz+mC57HUcgNz2AqGxPGR7Y+all3iltjuW2yzp0ff/qphD0FaCtoOnjqCmu+RRUhgsrSsQpH5D0PpaHA3ddy/30/PJZMVqQMdGDUuOvFaiPmS1sidyigj2Tdqj+4Hnm1nW9WIVNgQ6S7x0DOEuWd7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NqdrDnfq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NqdrDnfq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSKML3jN0z2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 22:30:53 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso90732275e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780144245; x=1780749045; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IrPF7Yf2T/CTW8tuqL+BCfM7WayAgdlVua5IFI5JOo=;
        b=NqdrDnfqauKD4no5E9ZKH2YKBxYyUymZ2QBBXWlPurQi6mfJv86rBBM22HnaqZ7Uyy
         fVKPICv8ANGBxsBl/48AGMFV2h+3LTWXZdsC2LkEFCiR6WOhPYX/zMNCAM1l1ZSIDAjG
         QGaTZVrhFzCHbsu8IlCPTzBJzXTVcgG+hZOQRGDBFw0taIfDE73GWw6Ni8/Kbbdl7h0M
         J2LVIWe/I/E45j43Ip4Gqy0JJ2C6+o5Cre/UqKp+LFLCd8vpnEwB7v6eMYqEKFCcMnCe
         0ONhMXsyUDJ8TNBUAuUz7jbj5Kx6VqitJYD+oLQ45t+LJoqU/FBsaeyMV6GAQ+P+aBxv
         06fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780144245; x=1780749045;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IrPF7Yf2T/CTW8tuqL+BCfM7WayAgdlVua5IFI5JOo=;
        b=g/BTiGelX8s9Hylag5hAQYlfpGYCrqektRi1G7v/YHgVcg8Dr3nfZHe/4PXGbmIPIk
         xl2UcxXOC8Z3l940Jf0yVNKcNszOFkVAHdt0l7Revt5JTKJ/UF4ZXzqXz7+GEBOeNCvH
         z+OFcBuA8jsO80D/5iStdsAMpcyr5o514ivLoNdn/CFJqhBqFzv+0p7MCdpsugvv8qBG
         QzOA/fGPhLJDzdcCRergvYdb1+jLmmJkm96FKd4+QxZeeqo3XdFmo7sR5bKjxDECsYj0
         LvrSLDkd8Stv2FpTbJl5mBdbdCoG4ZVrUoj0jigdfo6wLIc0Qlc/7SyG8Fly44GifieB
         c1vA==
X-Forwarded-Encrypted: i=1; AFNElJ+DnukAAlppcOU6M8dPiUjsTc0kiH+BfIjOoS0sbqOlclHc3YCJqMPuRWnU7opSLe6KerF8gtJLDFkKA44=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJZgdof6kBRHhxH8kr3CkkD6CkHheyJTQI9Xrid1j8BHmOwT9c
	RtkaPAagDQ59Pu7lRC7uIiUadjeEM6gSy9J79jNV031Q1qzgV57e9jOL
X-Gm-Gg: Acq92OHo7D5v7+qA7Am0khnaXq4F7CRVi5Jh9HFs2lpY3643Km76Ecy7/Vu0Dqe3WBk
	+Fdgvsoc5dTSFYQULifNkigN+gMIh6UWihohiGUqQX+i40lfjBLCGJpyljL18H4Gn7yIMi5nzmX
	G0X4kEKkWGqGrJsnB7Qzglmmf8s256eFlLcjOgFDsNi+L9iYhccUYWVCRAf4SCeSDsdVK9dm6aA
	QqfdTPJFW1+ZujbLH7lbSi5+tZnRveOirbcsycUHRA6tFyczBwjr4IVQ4+uQRjEUIpxDnvr+xFL
	oBg4ImHXGuMTL6CKGzyOER8UEMNDn0NpCvG0aC8nG7+V04H3kdztI/Nw9SU+jVX0ecaCa6Y4idC
	ejr2lpQb4nD3E7WuC6+4L3jh3ldvcXHTsobyrqknjnju1A3z9bAv9Tz5J2k9IvbKakMqnAr8G0S
	iGANGphz3BVNlHwPmUxwRHB3tJycK8hfaX3KktYoqMYHA=
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr46598725e9.2.1780144244852;
        Sat, 30 May 2026 05:30:44 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0c39b0sm55179475e9.2.2026.05.30.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 05:30:44 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Sat, 30 May 2026 15:31:22 +0300
Subject: [PATCH] scsi: core: Remove dead code export of
 scsi_device_from_queue
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
Message-Id: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBCE4auUfTYQUxLQq4gPNTvqKqYl2wah9
 O6u+vgxzL+SogqUjt1KFU1UxmLY7zrK96Hc4ITNFHxIPvbeVbzGBjc958yNjVdUlAx1B4459Sk
 MkUH2n2yT9699Ov+ty+WBPH+DtG0fGfyzFH0AAAA=
X-Change-ID: 20260530-remove-pktcdvd-references-9d5c6362a5de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7848;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=JOkh0VtUTMNM8R2U5kHd24sbbewIR96ibV2lt7jrRmc=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiypG6sLntvMDjCYxBM9Lyi3xOfHzogig8LdgutDb9Vf0
 nRRlLnQUcrCIMbFICumyPLi3PW2DXvOBNxLsmuBmcPKBDKEgYtTACbC8Ybhr9zTN/w1LhaSHd1W
 e+UXcJ5zF266PE9izuRDc7y1I/YvnsnIcOoo/36rKsWFmo9C9/zP2M3LESaWvmyasflW7+qD6iy
 bWQA=
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
index 6e8c7a42603e..f836212c2acf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2201,14 +2201,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
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
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>


