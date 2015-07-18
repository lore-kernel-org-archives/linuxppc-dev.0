Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50AD91A0DF4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:26 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 04/17] powerpc/fsl-corenet: Disable coreint if kexec is
 enabled
Date: Sat, 18 Jul 2015 15:08:41 -0500
Message-ID: <1437250134-307-5-git-send-email-scottwood@freescale.com>
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

Problems have been observed in coreint (EPR) mode if interrupts are
left pending (due to the lack of device quiescence with kdump) after
having tried to deliver to a CPU but unable to deliver due to MSR[EE]
-- interrupts no longer get reliably delivered in the new kernel.  I
tried various ways of fixing it up inside the crash kernel itself, and
none worked (including resetting the entire mpic).  Masking all
interrupts and issuing EOIs in the crashing kernel did help a lot of
the time, but the behavior was not consistent.

Thus, stick to standard IACK mode when kdump is a possibility.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Supposedly there are similar problems with certain low power states --
the SDK disables coreint when CPU hotplug is enabled -- so disabling it
for kexec as well doesn't seem like a big deal.
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index bd839dc..cddc9a2 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -212,7 +212,11 @@ define_machine(corenet_generic) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
+#ifdef CONFIG_KEXEC
+	.get_irq		= mpic_get_irq,
+#else
 	.get_irq		= mpic_get_coreint_irq,
+#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
2.1.4
