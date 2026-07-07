Return-Path: <linuxppc-dev+bounces-23713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5FFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 15:00:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvkts3vZ9z2xpn;
	Wed, 08 Jul 2026 01:00:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783436453;
	cv=none; b=dA2GVXNGzUbnLPrTc7Vov4n7jj+HJDc44Pokx7pUr4torQ2jOxT/KlGW74mR31zJ/VFi7B4NxaSJeJuQzlgZNnMiDaInUqLf7U5+GYKVlMZ9PS2+WVYa33JBcxB0cUVJONdV+BNs4pHHMkOMiANDxGyZSXCUa5ZZRvewmVdbCQDSm/eB52Tj2FSIqMwPU3VbF4QeHQ14EBwtWt/aWbWB5oD572Hfgh2x5p3e9bqzweZrt1ktufRcTDs7K05HKKdEHiNjAeGJTCSzGu2gZKYlZjJS0B/y9otU+6mNSPdRORPjV0H+ohbFec2C40wnNqDH6aZTXxd4s/ovPYYVZ+K/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783436453; c=relaxed/relaxed;
	bh=wOBcKHJQyOMU4HZK6o3IdwDSoAOxpnL1hOf/TAAIhys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfiI87cRBA826WZ24F6MWlOSUUIwGNDQ5T0N05aZOrM1YxsH6cOTZxK/KAdnXr4M0HFMMNzAQa8velWbyTnHt6luHFgkGigtnvBWMEhwahztn5jaA7lBrrFAYdR8g51jCrSAJrrDWZfM2qTtk4OQ+xlYOXbmB1yT8rRHFHk367uIagYNM/o16erZhaBFYMB8bY83fFlzxGhzA6tJ/h+UKtosoDfrL0KE5VxPBb9e27zA2mZJFdYER0TF8z0F4PN5rZEOcaXNQ6MeNXpKFKIczTbhR9Sa6VAjad5hZpvKmsS0RQgjfm7xwB4iit0NuizFUgPVo/FMoxMnmjaZaIdaqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hgkafo9n; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hgkafo9n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvktr6Bj5z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:00:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E5B7060018;
	Tue,  7 Jul 2026 15:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157531F000E9;
	Tue,  7 Jul 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436450;
	bh=wOBcKHJQyOMU4HZK6o3IdwDSoAOxpnL1hOf/TAAIhys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hgkafo9nh3j6b868H5hloDHa6TQeLPS8/oJuDEXLrC5YWas1t5XAJcfRDZ5wcOROR
	 suoJ7weC+FDxNwwzuR4ODiintZN15O8UU7UC9B+tQK9jblz1Eq9yT8e8JYzmMflLBU
	 6eFEGJrv6x1GP9Wwh2kbxqVJ97xlFJcmFBa0LN2dLOZIqTTb+Zb9kC1Xf0zRmKbbxQ
	 ZqdXOLFh2N0dcVlJRbZR3fKIsbX8B35OtssIfEL2Bcbegt4Xwcd9DhIBecnPACiTjM
	 WpVT8y4kyX6lVL91BH5YxfKYVjsS3AkDueAPa55oLvALNfsLWchBtIUYOseuevp1Z8
	 W+bZ4tyhbPn0g==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 2/2] powerpc: Move CONFIG_QE_GPIO to SoC
Date: Tue,  7 Jul 2026 17:00:45 +0200
Message-ID: <cd46aec4b325745d38ac7992e4d3d5b4f4c4e95f.1783435914.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org>
References: <b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=chleroy@kernel.org; h=from:subject:message-id; bh=+904wY+BTglsrOGG1A3VF0W9Aan7cNN/y9nA+a4QttE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWT5isy7O3/+S8/3321eHGYuipoe9bsxT9jiycEnf2ffD 9rp6rN0d0cpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYyOLbDP+9WO6suHhFt2BH m8+28OXP9Y4bdvIwyz2wFXIqXtrNEreHkWFSiOlye27DkwcXyoTpCTvuPOaU8JThnVZd/vf4f+q LDRkA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
moved QE into drivers/soc including gpio.c but left CONFIG_QE_GPIO
in powerpc's Kconfig.

Move it to SoC as well as it is the only place it is used:

  drivers/soc/fsl/qe/Makefile:obj-$(CONFIG_QE_GPIO)       += gpio.o qe_ports_ic.o
  include/soc/fsl/qe/qe.h:#ifdef CONFIG_QE_GPIO
  include/soc/fsl/qe/qe.h:#endif /* CONFIG_QE_GPIO */

Link: https://lore.kernel.org/r/16a187116511f5c844c43a12d09f263e77f4fd60.1780936729.git.chleroy@kernel.org
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/platforms/Kconfig | 8 --------
 drivers/soc/fsl/qe/Kconfig     | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index c4e61843d9d99..2f797ac6f1b3f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -228,14 +228,6 @@ config TAU_AVERAGE
 
 	  If in doubt, say N here.
 
-config QE_GPIO
-	bool "QE GPIO support"
-	depends on QUICC_ENGINE
-	select GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  QE GPIOs.
-
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on (FSL_SOC_BOOKE && PPC32) || PPC_82xx
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index eb03f42ab9781..b35a8fd30ebfb 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -67,3 +67,11 @@ config QE_USB
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
+
+config QE_GPIO
+	bool "QE GPIO support"
+	depends on QUICC_ENGINE
+	select GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  QE GPIOs.
-- 
2.54.0


