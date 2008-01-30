Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87819DDF8E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 03:36:55 +1100 (EST)
Date: Wed, 30 Jan 2008 10:36:44 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: configure USB clock for MPC8315E
Message-Id: <20080130103644.bbfe82a5.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SCCR USB bits are in a different location on the mpc8315.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
 arch/powerpc/platforms/83xx/usb.c     |   12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 88bb748..68065e6 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -14,6 +14,8 @@
 #define MPC83XX_SCCR_USB_DRCM_11   0x00300000
 #define MPC83XX_SCCR_USB_DRCM_01   0x00100000
 #define MPC83XX_SCCR_USB_DRCM_10   0x00200000
+#define MPC8315_SCCR_USB_MASK      0x00c00000
+#define MPC8315_SCCR_USB_DRCM_11   0x00c00000
 #define MPC837X_SCCR_USB_DRCM_11   0x00c00000
 
 /* system i/o configuration register low */
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 681230a..b3b650e 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -124,10 +124,14 @@ int mpc831x_usb_cfg(void)
 	}
 
 	/* Configure clock */
-	temp = in_be32(immap + MPC83XX_SCCR_OFFS);
-	temp &= ~MPC83XX_SCCR_USB_MASK;
-	temp |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
-	out_be32(immap + MPC83XX_SCCR_OFFS, temp);
+	if (of_find_compatible_node(NULL, NULL, "fsl,mpc8315erdb"))
+		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
+		                MPC8315_SCCR_USB_MASK,
+		                MPC8315_SCCR_USB_DRCM_11);
+	else
+		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
+		                MPC83XX_SCCR_USB_MASK,
+		                MPC83XX_SCCR_USB_DRCM_11);
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
-- 
1.5.2.2
