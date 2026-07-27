Return-Path: <linuxppc-dev+bounces-24860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2648CC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 08:45:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7scs3yYSz2yhD;
	Mon, 27 Jul 2026 18:45:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785141949;
	cv=none; b=X7BSt5GZAcKzAchUKQFZvVgM6IIsYK+thtM5oHJxROHoqwboQO9L26FvRtvC8sRcAVYxf0oeW93U9JpPUB+A0F+xyCifxbjrsdjDuOR/q1lNWSiByKvykZGrg3O+VXKJwMW9i+2t5TE/CY9rieQLEEFxEbpGrht71qbmF7YeMNWDBwqrlswTmIB9FsFmQoHLpKGEaCi6HqxYwsMpVj37MCJ0tzE3sqHMr60ZkS/PlE0jf5hPLC+fOp4YKDSRm2tPkDEm3wKUIUtDdmSNTh9dPzEVjn8PqwT/gvbO+/dx8xmdpscVvKeEMeUKTMzYPv7ZW9V7xCLvSNlXBXZOacbf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785141949; c=relaxed/relaxed;
	bh=SCmGYQYvTEf351a469pe44RgiJyCzUCfUVrveP/GI5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpyW5ZT/GCR5yDNXGFHo2xFLfv4jdryiiZCIWEOGR3JeqOYBlAsYoEj3RPROxUu4cOPLG6qwoGLm3BgJgPAyg3W1QDh8N4OjVF82nDTKXSnFKY6ezZCuAe8IJQzC648t/kefSG9Kbb10U3+hhsoszN5cc3+Y43o0Xu8UzJ+TpLe8CuI5eKvf+ChLiYfCP32WZXdGtOCrGCDJIvdRCfv/fX4YTi1aY/50sOQjD/G0HyD94aLiNvcf+zcQjTpUZkJf7GllYXLb07n4f7eI49Fw1HyRC4NoTnFs38CZz0vX3syUDeJutlZfEKeY4Z87xbztk+USs1dhdA5Ne+n5lJSFzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFN1D11D; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFN1D11D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7scr3FF0z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 18:45:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7ADFE43261;
	Mon, 27 Jul 2026 08:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8A91F00A3A;
	Mon, 27 Jul 2026 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785141941;
	bh=SCmGYQYvTEf351a469pe44RgiJyCzUCfUVrveP/GI5I=;
	h=From:To:Cc:Subject:Date;
	b=HFN1D11DivCImlY0/SMRRS43msSnwEjSBsWPeJA40cDJ+sYtSMk5zZGVKALL/aKdU
	 UtUtFAZRFQUZgrHdPL6yjKsGwXuStdY5GzB1IPjU7UxNwadNXbuBhYNhUMfXNrTO6C
	 Xhia/lC1XEWQ+qIA3MWIESqK8LJCUu6ODBtcHm3BG9Q5ImBm7sKYPkK4NBiD1/dV33
	 jEO0vJul90izJcpGFSXXkLH19vpu5KgG7z6F09fMFQ4FZQXPeQFRvUD2r1PnYeNwdK
	 g5Nd7qgEd0kFJ2cQx5Knu2l7lIgKHK5eAcudSR11rDtXnqJdW1OH00CGoJtozNvAXZ
	 s2sIRZCFw9J0g==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2] powerpc: Move CONFIG_QE_GPIO to SoC
Date: Mon, 27 Jul 2026 10:45:37 +0200
Message-ID: <9a7131d15a94e2017877e628f0e97f9aa2e0aae9.1785140877.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=chleroy@kernel.org; h=from:subject:message-id; bh=B4hOgD0R97s0zSf2lKkhvcdFwj3V1Wug4B7VlY2ZxuE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlS229GLsr21EzqPmua63bu6XNpwWLtfwv7ot42Pxta ULxTI2pHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAi7EWMDM//Lg2rjf71ul1z 9/1Zm67yL7UOfsnCJFc+6bbMxMCMzNsM/0uL983c+T+eedXOxkl5mx+7+5zt2nbRZeLmVOE5Zs/ nybEDAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
moved QE into drivers/soc including gpio.c but left CONFIG_QE_GPIO
in powerpc's Kconfig.

Move it to SoC as well as it is the only place it is used:

  drivers/soc/fsl/qe/Makefile:obj-$(CONFIG_QE_GPIO)       += gpio.o qe_ports_ic.o
  include/soc/fsl/qe/qe.h:#ifdef CONFIG_QE_GPIO
  include/soc/fsl/qe/qe.h:#endif /* CONFIG_QE_GPIO */

There is also a dependency in USB subsystem for CONFIG_USB_FHCI_HCD:

  drivers/usb/host/Kconfig:	depends on QE_GPIO && QUICC_ENGINE

Because that USB driver selects CONFIG_FSL_GTM which is specific to
powerpc, it has to depend on CONFIG_PPC.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Add a dependency on CONFIG_PPC for CONFIG_USB_FHCI_HCD
---
 arch/powerpc/platforms/Kconfig | 8 --------
 drivers/soc/fsl/qe/Kconfig     | 8 ++++++++
 drivers/usb/host/Kconfig       | 1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index c4e61843d9d9..2f797ac6f1b3 100644
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
index eb03f42ab978..b35a8fd30ebf 100644
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
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b3b1ec696bf5..10cff12a3f31 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -611,6 +611,7 @@ config USB_UHCI_ASPEED
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
 	depends on QE_GPIO && QUICC_ENGINE
+	depends on PPC
 	select FSL_GTM
 	select QE_USB
 	help
-- 
2.54.0


