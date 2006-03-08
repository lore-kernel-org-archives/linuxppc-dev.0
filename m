Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 781E8679E6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 04:22:52 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k28Hdldg019106
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 10:39:47 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k28HWoRG014985
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 11:32:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] Fix MPC8548CDS rebooting procedure
Date: Wed, 8 Mar 2006 10:22:20 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD332ECDA6@az33exm24.fsl.freescale.net>
From: "Haruki Dai-r35557" <Dai.Haruki@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the MPC8548 CDS rebooting procedure.
Without this patche, issuing reboot from shell doesn't reboot the
machine.=20

Signed-off-by: Dai Haruki <dai.haruki@freescale.com>

---

 arch/ppc/syslib/ppc85xx_setup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

8f095006923385c3546165b0e10d73d3e057c120
diff --git a/arch/ppc/syslib/ppc85xx_setup.c
b/arch/ppc/syslib/ppc85xx_setup.c
index e4dda43..45b1b2b 100644
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -115,6 +115,11 @@ mpc85xx_early_serial_map(void)
 void
 mpc85xx_restart(char *cmd)
 {
+#ifdef CONFIG_MPC8548
+	volatile unsigned int *rstcr;
+	u32 *pMem =3D (u32*) ioremap((BOARD_CCSRBAR + 0xe00b0),0x100);
+	*pMem =3D 0x2; /* Set HRESET_REQ flag */
+#endif
 	local_irq_disable();
 	abort();
 }
--=20
1.2.4
