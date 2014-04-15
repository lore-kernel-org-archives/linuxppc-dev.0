Return-Path: <Dongsheng.Wang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 086D2140151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:45:56 +1000 (EST)
Received: from mail106-co9 (localhost [127.0.0.1])	by
 mail106-co9-R.bigfish.com (Postfix) with ESMTP id A87E5200459	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 07:45:14 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 2/2] fsl/pci: fix EP device sometimes hangup when system
 resume from sleep
Date: Tue, 15 Apr 2014 15:43:19 +0800
Message-ID: <1397547799-29464-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1397547799-29464-1-git-send-email-dongsheng.wang@freescale.com>
References: <1397547799-29464-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Root cause is pcie power management state transition need a delay.
The delay time define in "PCI Bus Power Management Interface Specification".

D0, D1 or D2 --> D3 need to delay 10ms.
D3 --> D0 need to delay 10ms.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4bd091a..33950ad 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1175,15 +1175,24 @@ static void send_pme_turnoff_message(struct pci_controller *hose)
 	setbits32(&pci->pex_pmcr, PEX_PMCR_PTOMR);
 
 	/* Wait trun off done */
-	for (i = 0; i < 150; i++) {
+	/* RC will get this detect quickly */
+	for (i = 0; i < 50; i++) {
 		dr = in_be32(&pci->pex_pme_mes_dr);
-		if (dr) {
+		if (dr & ENL23_DETECT_BIT) {
 			out_be32(&pci->pex_pme_mes_dr, dr);
 			break;
 		}
 
 		udelay(1000);
 	}
+
+	/*
+	 * "PCI Bus Power Management Interface Specification" define
+	 * Minimum System Software Guaranteed Delays
+	 *
+	 * D0, D1 or D2 --> D3, need delay 10ms.
+	 */
+	mdelay(10);
 }
 
 static void fsl_pci_syscore_do_suspend(struct pci_controller *hose)
@@ -1211,9 +1220,10 @@ static void fsl_pci_syscore_do_resume(struct pci_controller *hose)
 	setbits32(&pci->pex_pmcr, PEX_PMCR_EXL2S);
 
 	/* Wait exit done */
-	for (i = 0; i < 150; i++) {
+	/* RC will get this detect quickly */
+	for (i = 0; i < 50; i++) {
 		dr = in_be32(&pci->pex_pme_mes_dr);
-		if (dr) {
+		if (dr & EXL23_DETECT_BIT) {
 			out_be32(&pci->pex_pme_mes_dr, dr);
 			break;
 		}
@@ -1221,6 +1231,14 @@ static void fsl_pci_syscore_do_resume(struct pci_controller *hose)
 		udelay(1000);
 	}
 
+	/*
+	 * "PCI Bus Power Management Interface Specification" define
+	 * Minimum System Software Guaranteed Delays
+	 *
+	 * D3 hot --> D0, need delay 10ms.
+	 */
+	mdelay(10);
+
 	setup_pci_atmu(hose);
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index c1cec77..37fc644 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -39,6 +39,9 @@ struct platform_device;
 #define PME_DISR_EN_ENL23D	0x00002000
 #define PME_DISR_EN_EXL23D	0x00001000
 
+#define ENL23_DETECT_BIT        0x00002000
+#define EXL23_DETECT_BIT        0x00001000
+
 /* PCI/PCI Express outbound window reg */
 struct pci_outbound_window_regs {
 	__be32	potar;	/* 0x.0 - Outbound translation address register */
-- 
1.8.5
