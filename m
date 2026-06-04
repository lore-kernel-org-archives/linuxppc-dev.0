Return-Path: <linuxppc-dev+bounces-22034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF49CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:20:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCg2TdDz2yRC;
	Thu, 04 Jun 2026 23:19:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579199;
	cv=none; b=B5TyjdH491MNldofOIvuhvhaaHIkrzRuW3FsEmUGnphj7x6OzHfYL9oBRznsyo+Yxu76kgEIr3ITCCiIgjR4TtPs0XUTwYUzmW5DagDlFX6f+L43WhrccXzsvX1qbnfdwEohgoO2HYxug/Uidyu9jp+JKmtpehndYRJqOQmP0jrcXWzSnmuV9qd44YhBNukkEvoOnmpTvCj4V7yLFPu7buia2Yb15+m3V+e/CV618JoJ5Uadk/5INDrCGJyNfYMPn/NlcjIc41/IwreOiXis3sXLf8Gawy5qibAdU2Coc4tPtKcBDwnSFSH5TpeKl0kBowh9OkS2esi7l4PeASi1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579199; c=relaxed/relaxed;
	bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRxC1a06i874bLrFGkpRZejAa0tPz/id+aaMWDdE8Q2iRumtBKmy4F3DNdVsdlH3LNl9ixbljKGs/2PmbjK/DsaLwkh5yUyjnq9NEjUmPmr4vhgdQd6TpZ54+9kf8PCdjFrwQ8rqdeNVIdOqIUoGGZNYdzmYiCRnXE4BCMs84sSWu+bUZiSYhl67hiWLfe2E1+HOjN5QpQhkmKlbQLS+L1DzPRRkWyvTdr/sv7SzmyWXA9UXOMMml11lcYJgHR3+HWJJjKQnMOFEcfAQd0856woEw5mG7K5puMu5qwrX88VsT2PbFPB0iWaJSrkBThpacLdLAasGKWVn9O5tevmdkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5wJrYp3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5wJrYp3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCf2hCFz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:19:58 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso6889005e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579195; x=1781183995; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=O5wJrYp3d2mcwlKiQsY8xGnTYe+dnL9P7e6fSuRSNUchGajUE8eUWlQiMme8sb7aT2
         444K1eYmmrmM8Uc4Hu4NiX4N09p+rZv4+OWx47lcIXZ7ybIq3OExlDHTq5tyo7SgxvWo
         UTyuBjmexABb5dE/eZSfU+lC/f55zbmUhplbIYBBBmiqtPubQtPECIzZG2Hp2atDZbbx
         vvlCGIyov/V4WBKXxcNaNvNEqFjvacaQTc66rR64b8zPNxVe9Tch+I8f+LRk7bF4B5K/
         YRIGwWE4iriLqk2NL5+lxatYNf4vQtero+B5+S4tzKh9cz3Bt4K0oApUzJw+XVsjyXbR
         EI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579195; x=1781183995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=ImDrsaHAP2qg3+gj/+YZaSAg4+/srZJj476HQnBr7e0N8Qz8zNBqQUESmnarNuLhVH
         o1zTvju2q8DRyYqAe+vxT8kspEt7H7IHoLLBLx+pe7/jXlZB7SqhLGzjv1rqdIhCLZN9
         lT+LF5kvuRWyS5FcJIw1bQQTHTS8Eq9UeJ2AFsydgMO+Z4pCN8ZGwBswGJvwSmdv7tGB
         +SBGMFwMe/SFgOpSt8TBGlqEOYtpDdNZD4OZk/8e3jsnNoPfNrnl+r0VVrGlDCMyZmEg
         ZWX0timPmhN7ZUmmAJJgc2WmyIvKUuEltLjo36tQRH3BcBBdGOGTm3A1ldnAQTBzBI4K
         U3Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/Pnh4anCWLZudPJuwdMvaugHdCeQcd7zsNx2JpFhQ6J2KIyacAbAu1Wd+JJPvzQZESO9vJN9U19jvidqc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziJaIVpRI/6rgdGw9nxN3ROnDnIPyln3+k82Us5X9moKPEVwlZ
	n+vgPmeJeCrtDXz1KVlSZy5IOfpCQt8suhd1fMNjZJq2k+KPbQAuOF6P6ZohEYql
X-Gm-Gg: Acq92OE2+1vYkITu7nzM0GGtoFYVXrl7MCT04MxXoxX3+j3H/Pnqb22cpOg/x4OgiMS
	lkY+UQgmvtjDniYkeITFqmqel7sNOJRvSxxk1zWUqe3HPr/aqtHvzKQYDGrpPSxqAc7fFM0qgDR
	zvVBvNGuFM0kR7uylMTtQ/HiBRCA6v1Ldhrpa2GvB5zeBTXQdQtcgXS7Q7yQc4bSAmM5be8zYa9
	n+Th6ctU5nYIOwRq4Sm8IeRtOQrfLgVPlKbabrQCPmr4ox9K1hFD0msFwoqwOtuYqrGJfTtFLFd
	Vct1PFueuhj/9SXkmX68X4tatetiH0lDeG1TS3ZmtzaLY4gZlo/XdnPj5rQK/imvMxc4Ij7EXIQ
	dRjt8ciItTevPHP4rWg+3w3TcOTNU3q6jM7QDjkysTC3XQj7ojyY9scfWNnQiDWAh0KGiMF9t1v
	QShqDh8m58U+0N9hN38lzpSre4LJFdu30c
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490b5e9fca9mr130752605e9.1.1780579195429;
        Thu, 04 Jun 2026 06:19:55 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm15750607f8f.37.2026.06.04.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:54 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:26 +0300
Subject: [PATCH v3 3/6] mips: Remove remaining defconfig references to the
 pktcdvd driver
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
Message-Id: <20260604-remove-pktcdvd-references-v3-3-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVTc+KTYw73r5fOi9NlmJC+WWdX4szitUmdB0627
 omxYxPoKGVhEONikBVTZHlx7nrbhj1nAu4l2bXAzGFlAhnCwMUpABPpr2D4n+pW9+X+bI+0NSUc
 vy5x7l5o9GPanunid7TdhNqEmf4aRDD8jwiVUi4Nzc1l2Foqk3fBr21nj6Hhn09/0p/+W8ddte8
 cDwA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
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
 10 files changed, 10 deletions(-)

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

-- 
2.54.0


