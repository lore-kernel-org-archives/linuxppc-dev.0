Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE01B2C007B
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2012 21:58:54 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] USB: ehci-fsl: Update ifdef check to work on 64-bit ppc
Date: Tue, 10 Jul 2012 06:58:48 -0500
Message-Id: <1341921528-21630-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to use CONFIG_FSL_SOC_BOOKE instead of CONFIG_PPC_85xx as
CONFIG_PPC_85xx isn't defined when we build support for 64-bit embedded
FSL PPC SoCs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/usb/host/ehci-fsl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 4336257..f002525 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -313,7 +313,7 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 	}
 
 	if (pdata->have_sysif_regs) {
-#ifdef CONFIG_PPC_85xx
+#ifdef CONFIG_FSL_SOC_BOOKE
 		out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
 		out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
 #else
-- 
1.7.3.4
