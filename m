Return-Path: <linuxppc-dev+bounces-22205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20519CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXg6D3Hz3bpx;
	Tue, 09 Jun 2026 00:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928899;
	cv=none; b=QNqJG3VgqdAS9SVe4DZK8bELUUPebD/5EkxvxvKRph0/CQf0MwicoC9YKwM1eos7cR3bjXRL2NpS+nuBUL5w7QtH1pIToFunkbYXVG+P4Q8OZ3wocQ1utfB9uVi8N4X2SUoWOqw9USAIWVwBcH0KY5rteu92eszBNIJSf3MnscMhHbFDm0OxhxueJnIaTpH3/itYOBT90ibe8xUaRqKeGvWKgPxbBARapVuLxtadD8VIJz35D9it9rnlEZrFB4dyCuUi3PqT4YdmXnWJXMIcTX0z+7REifIxZDTSoFvjnPJOxgYl87UkIbtY7swHQ4/eiBCY1bqL+4CLeNSpo/YYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928899; c=relaxed/relaxed;
	bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgHN1YDLKnlhfjxXbhyJJkKTl+Vl/CreBJP5rU42OSRtbpIyv74mF+N3ciN209H2bEQkwN3/00yblzIwqf1xtA5Os6S7uRNUHeeQXkNwoc4vilMNF7eYh6u0rF/7subz6Wilm1drPWd8C4xanVHZDAVwLbMZ26iTY8wWr8m8hm+7FnPslWuOUzGMDvfmcy7eMKXqI0ouX6rYUW6Cdl1YtAtOeu0JUC1hUX154l/Dy7omwXrIgo8++RZhZEpEcAltw5wh0FiJxxQFTrBJXzKDhhNpmEMsq75PpOcc9T84+DEcEyvU2qdXxNiF24JxtRCTRdv+XgkzY/v871ZbnLoo5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VMaJ+a2S; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VMaJ+a2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXf1kfGz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:17 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-490b64c8311so49503575e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928895; x=1781533695; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=VMaJ+a2SYtI4naDdHFtcMNpzVEcIDWHMnZEu0kVk8JWNaj9egdAdZiGHunNWu4lUc1
         iWd8AHyf0p+8O2eZQc6ACLxdrZoyudge2gzeTA0pJHw8GX/i+DxnwtcdgtweUpXX6Mmj
         HTRgBZLpbxeHI0HTAEPk3/Ll7kuAgXt1Ra9aUSDcCOh0i2dxOdlTpDs+rt8JfbZiOCZ6
         519yfyj8ZB3Qod8b0Cnal1vh0obki8JjKZ5jgpG0Red8o8stggVdQXObD2dt9AZMoHOF
         S25jJieu4KdQbAcHJ2rHrev64azKpKQw17s+lP6KMu2WgpWDCw8HwWVy4VecZvwP4huv
         8wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928895; x=1781533695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=e74vRgH7zsNjBtefZZAulrvzRWqM9kcd1VdNVW6Zkn+LxzxUJLpyA65gfuWUZ3ZHWw
         ThduxNhLVTSRhvvnVA1hUVWl7cE5l2RebA/GVCZCCxzRK+4TpRozkduZSeuLLVU/pxTj
         s9YNhAG80X6A8ClJA4+8nZahR0Aue4jR0Xk9gcMjRg8WkLhl/0MwkMm2rVRdEGTx9XB2
         62KPMmlrvSOpQ1/MLw8tiHVNIsSA2Y+thRQxpdoyHlLGI3bS0YiBEj6cec0t7GYEYabB
         SWq8ebzc/btAFTYY3tzmrwwUPWn8TCs30VrYLGZ4zxFrrIPV/C1egjqYQrbRbIlHcJND
         z/JA==
X-Forwarded-Encrypted: i=1; AFNElJ9UViNa74iZXU81sUi+t+yb0t5Up2AMMUMKIO3ROU6TywbTDrHT+gymn00dzSaxqMYdOW9jxdLNQl3PkhI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyODaduila3OZNk3U9CK91ft4Makd8g3zgXKMnsIzKbsuUIdgeU
	5mktWU95MuU2S1wLeS8W83yu66WnabDSXrK2wvK4Zf2+vTmqN+hi0mDT
X-Gm-Gg: Acq92OE8RyHRV8OzQ22dfRvdpfHlzxpNsZfxxY+Qj4d3ZgK/8sIXdTWO+6s1ma45LmQ
	C84wF35Vb2RNjAbDw1N6OIzO/X6U2wA6jousOC6lUqNqEWzzNRkU13L0MYvyEldmUGyQ12AI9NO
	XGELc62WY5XWpZ2gUk8enogEIidiLh9ZbW3hmCPZrn7uKEEfoffXwJlgn4aWlVthSCCpO508Cqp
	X/BsDJlBxD6r2mXpJ1eW6HyzQXzTFQj20R4MWIr4Y3xJxQ4T1qD4DAmeWliZ17rK3n/8nnEruKr
	IS8i04YF7z3LSwGscbtsaB3H72k4++p/0JjYFzmfl6ixV2QSeHDqK1FUwTMMBJOJQ1M7WRamBy8
	dl6PSCCKYK6HHcofCUCTEK1dVWTXMHCXdkfPBlSJfj7dWykN7ceIItRFnutEsPNdej8yzIwjoXp
	suzDXGoE3I0mBjyEdq8T1ahDj3eZcPpJUaV9fO6he9jBw=
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490c265c107mr218795335e9.1.1780928894804;
        Mon, 08 Jun 2026 07:28:14 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm342073845e9.1.2026.06.08.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:14 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:17 +0300
Subject: [PATCH v4 2/5] mips: Remove remaining defconfig references to the
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
Message-Id: <20260608-remove-pktcdvd-references-v4-2-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwc+2lbJ9etl7Yvnkz732ejVeRe5q673+RbFrRXiK
 rHpq3jQUcrCIMbFICumyPLi3PW2DXvOBNxLsmuBmcPKBDKEgYtTACZivJrhf3zBIjZR55Q8+4mz
 5CZ0NPiaRsjNeszPy8O/86y0m6B+ICPDsq5dpf3HHrUwrAsNW71D8urfbY8KrHfOEC2q3ZYy8XE
 uEwA=
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


