Return-Path: <R1AAHA@freescale.com>
Received: from CH1EHSOBE010.bigfish.com (ch1ehsobe006.messaging.microsoft.com
	[216.32.181.186]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90ABDB6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 08:40:15 +1000 (EST)
Received: from mail143-ch1 (localhost.localdomain [127.0.0.1])	by
	mail143-ch1-R.bigfish.com (Postfix) with ESMTP id 7F6962E02E1	for
	<linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2011 22:40:10 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.253])	by mail143-ch1.bigfish.com (Postfix) with ESMTP id
	628965E004B	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  5 Jun 2011 22:40:10 +0000 (UTC)
Date: Sun, 5 Jun 2011 17:39:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/e5500: enable caam crypto driver by default
Message-ID: <20110605173958.1073f245.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e55xx based SoCs have SEC4 h/w, so enable the SEC4 driver,
caam, and the algorithms it supports, and disable the
SEC2/3 driver, talitos.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/e55xx_smp_defconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/e55xx_smp_defconfig b/arch/powerpc/configs/e55xx_smp_defconfig
index d322835..c92c204 100644
--- a/arch/powerpc/configs/e55xx_smp_defconfig
+++ b/arch/powerpc/configs/e55xx_smp_defconfig
@@ -100,5 +100,8 @@ CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_VIRQ_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_TALITOS=y
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
-- 
1.7.5.4
