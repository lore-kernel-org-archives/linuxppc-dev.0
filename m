Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F1AC867BF6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 03:02:42 +1000 (EST)
Date: Fri, 1 Jul 2005 10:02:39 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050701170239.GA25435@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: explicitly disable 440GP IRQ compatibility mode in
	440GX setup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

the following patch adds explicit disabling of 440GP IRQ compatibility 
mode when configuring 440GX interrupt controller. This helps when 
board firmware for some reason uses this compatibility mode and 
leaves it enabled. It breaks 440GX interrupt code because it assumes 
native 440GX IRQ mode. People seems to be continuously bitten by this.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c
+++ b/arch/ppc/syslib/ppc4xx_pic.c
@@ -110,6 +110,10 @@ static int ppc4xx_pic_get_irq(struct pt_
 
 static void __init ppc4xx_pic_impl_init(void)
 {
+#if defined(CONFIG_440GX)
+	/* Disable 440GP compatibility mode if it was enabled in firmware */
+	SDR_WRITE(DCRN_SDR_MFR, SDR_READ(DCRN_SDR_MFR) & ~DCRN_SDR_MFR_PCM);
+#endif
 	/* Configure Base UIC */
 	mtdcr(DCRN_UIC_CR(UICB), 0);
 	mtdcr(DCRN_UIC_TR(UICB), 0);
