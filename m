Return-Path: <linuxppc-dev+bounces-22276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4E7CD6E79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:39:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYyS83Syjz2yS4;
	Tue, 09 Jun 2026 02:39:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780936776;
	cv=none; b=kW0P1B9XoiUk5nyvHVizXcQK/Y2i6MWADpdkMCdIWUDU8UJ/0ldY9YRF3rC9b7nFA0MK/wFum9cbI9ylXg+bRTYeBeQHEhpzNiSVz+KwNYyk0zgdo0dsKKiOdrbn2pfbBZKfqUdO3QgOBuvR+8eTP76+feBp0xy9K6iF/sXxRom9Z73si8W7SwOMsmc8e3KiuAIlLOVyScX9jibaMl/yJyAp2rhsZ+Lue9GDi7JpDFp6lWStDWZLRN3lrITHE8ZC+tcvOFTHYRunqGlpV0/YnPqcJLDTQD0H8/vJMJSjiCyyEnghKFwxXX/YJZi94H8i7ndYiXSNOE3S5hnr3z5XwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780936776; c=relaxed/relaxed;
	bh=ZmDVilafDDCM2XqVR6EfCFicwygqY5GOG2RzM018ZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8At7J17qZgIb8vTKs+nwWZfdkYCBinjTVAh8UFeALucXuNYCsVVmelUHnOpSk6TDEaoCL1ApXsbrmeqvXv+/uZFzx1ZdkgXeJQGhHyv9ULDA7E7uwYpyId6PavFDkUoqTqtr+ooeyNjDXBZI79rWcPzybtkRd0OadfF0BNEWKZHCzYfXtTKkZx1pHsWcT/slnT65t/yjTi0ZPzl/b2q9+UBY0U0FV6BLPoShdLC66cog8jhifm18896QtVlnwvDnz+rUhDI47MRISb68ZXl+BkY4q7o0+QUBKlg3A/+z6t7cX432WVVKMhnm8Nyu3WRMyZvmNjdMN7zGlTI1dYa9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNOSsxJ+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNOSsxJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYyS72sCZz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 02:39:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C248360098;
	Mon,  8 Jun 2026 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8E1F00898;
	Mon,  8 Jun 2026 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936772;
	bh=ZmDVilafDDCM2XqVR6EfCFicwygqY5GOG2RzM018ZT4=;
	h=From:To:Cc:Subject:Date;
	b=CNOSsxJ+RafDxN1eTev0RKIF56jqPnJbRZ8KT8k4byoIuCb2klRaBtIGere13Vvk2
	 qF5MRIf0tqqpEr7qq8LAL/9HNUN5bJKuFsFUvaLMThmmr/WM4cEd2oNU0c09dl7r0k
	 tjRGlBtEsup8HLRRuv5QNc5tIibniQmMMqpG36WPJ9ooBIOeWEfOo2iT62gY6g7tU9
	 7pJ6K8O8AZg7VtZ2ShNoMo5h/7i7WQMqIYCNIQJy1zwqgrviAxTukWQX09ceoldyqZ
	 UOdTBx14jgXHL+fm4TwLz/jftOYybus8FKgJ3yqE8N+JUHSD5M4F8DIqfwamMOdBbH
	 KpZvmtBi+qSug==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Move CONFIG_QE_GPIO to SoC
Date: Mon,  8 Jun 2026 18:39:17 +0200
Message-ID: <16a187116511f5c844c43a12d09f263e77f4fd60.1780936729.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=chleroy@kernel.org; h=from:subject:message-id; bh=Z85Pe7Na13Vg562A+bBvxzrw3YJK8fRR3FwUv4hmTr4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSpfbBQ9DW6Mkn4sdCyF1fFbps6XCxX37uhtdVJsfSws ckEHgfTjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRj8cZ/hnnW5izRm/8wD8r 1d/m3gfDnHPHFiwIeNIfvlNznzVjzxSGf5bJGl6Pmnc/0q/lcVLuzV2yT8vi+6QpO/KmxnbsDGP +xwEA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
moved QE into drivers/soc including gpio.c but left CONFIG_QE_GPIO
in powerpc's Kconfig.

Move it to SoC as well as it is the only place it is used:

  drivers/soc/fsl/qe/Makefile:obj-$(CONFIG_QE_GPIO)       += gpio.o qe_ports_ic.o
  include/soc/fsl/qe/qe.h:#ifdef CONFIG_QE_GPIO
  include/soc/fsl/qe/qe.h:#endif /* CONFIG_QE_GPIO */

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
maddy I'm wondering if you can take it for 7.2 so that I can then take for 7.3 a series in preparation by Paul Louvel without impact on powerpc tree.

If it is too late can you send me you Ack and I'll take it for 7.3 in soc/fsl tree.
---
 arch/powerpc/platforms/Kconfig | 8 --------
 drivers/soc/fsl/qe/Kconfig     | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

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
-- 
2.54.0


