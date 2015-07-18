Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421631A0CEC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:25 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>, Cristian Stoica
 <cristian.stoica@freescale.com>, Horia Geanta <horia.geanta@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>
Subject: [RFC PATCH 03/17] crypto: caam: Blacklist CAAM when kexec is enabled
Date: Sat, 18 Jul 2015 15:08:40 -0500
Message-ID: <1437250134-307-4-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver hangs the kernel on boot when loaded via kexec.

To make this driver kexec-safe, add a suspend or freeze hook, and when
probing, don't make any assumptions about the existing hardware state
(e.g. don't request_irq before quiescing the device).

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Cristian Stoica <cristian.stoica@freescale.com>
Cc: Horia Geanta <horia.geanta@freescale.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
---
 drivers/crypto/caam/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index e286e28..310e9e0 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -1,6 +1,6 @@
 config CRYPTO_DEV_FSL_CAAM
 	tristate "Freescale CAAM-Multicore driver backend"
-	depends on FSL_SOC
+	depends on FSL_SOC && !KEXEC
 	help
 	  Enables the driver module for Freescale's Cryptographic Accelerator
 	  and Assurance Module (CAAM), also known as the SEC version 4 (SEC4).
-- 
2.1.4
