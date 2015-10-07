Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 009571A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:48:37 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, <kexec@lists.infradead.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v2 02/18] powerpc/fsl-corenet: Disable coreint if kexec is
 enabled
Date: Tue, 6 Oct 2015 22:48:06 -0500
Message-ID: <1444189702-17241-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
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
Previously I discussed the possibility of removing coreint entirely,
but I think we want to keep it for virtualized guests.
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index b395571..04ffbcb 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -214,7 +214,11 @@ define_machine(corenet_generic) {
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
