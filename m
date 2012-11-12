Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 194512C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 08:50:24 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] drivers/virt: fix dependency on FSL booke hv management driver
Date: Mon, 12 Nov 2012 15:50:03 -0600
Message-ID: <1352757003-3070-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If built on non-booke, the build will fail looking for MSR_GS as reported here:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-November/101944.html

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Timur Tabi <timur@freescale.com>
---
Timur, I thought we were going to get rid of that MSR_GS check...

 drivers/virt/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 2dcdbc9..db5b9e6 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -14,7 +14,7 @@ if VIRT_DRIVERS
 
 config FSL_HV_MANAGER
 	tristate "Freescale hypervisor management driver"
-	depends on FSL_SOC
+	depends on FSL_SOC_BOOKE
 	help
           The Freescale hypervisor management driver provides several services
 	  to drivers and applications related to the Freescale hypervisor:
-- 
1.7.9.5
