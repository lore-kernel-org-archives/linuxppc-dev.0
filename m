Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 709FF2C009F
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 06:52:48 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <paul.gortmaker@windriver.com>,
 Anatolij Gustschin <agust@denx.de>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/86xx: fsl_pcibios_fixup_bus requires CONFIG_PCI
Date: Mon, 15 Oct 2012 14:52:21 -0500
Message-ID: <1350330741-11390-2-git-send-email-timur@freescale.com>
In-Reply-To: <1350330741-11390-1-git-send-email-timur@freescale.com>
References: <1350330741-11390-1-git-send-email-timur@freescale.com>
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

Function fsl_pcibios_fixup_bus() is available only if PCI is enabled.  The
MPC8610 HPCD platform file was not protecting the assigned with an #ifdef,
which results in a link failure when PCI is disabled.  Every other platform
already has this #ifdef.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index a817398..04d9d31 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -353,5 +353,7 @@ define_machine(mpc86xx_hpcd) {
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
 };
-- 
1.7.3.4
