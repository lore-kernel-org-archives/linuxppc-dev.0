Return-Path: <fkan@amcc.com>
Received: from svdc-dhcp-10-66-6-202.amcc.com (unknown [76.195.33.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1A15DE7CE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 14:54:23 +1000 (EST)
From: fkan@amcc.com
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix
Date: Thu, 21 Aug 2008 21:53:34 -0700
Message-Id: <1219380814-17229-1-git-send-email-fkan@amcc.com>
Cc: Tirumala R Marri <tmarri@amcc.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Tirumala R Marri <tmarri@amcc.com>

During recent tests with PCI-E , it has been found the
DRV + De-Emphasis values are not optimum. These new values
are tested thouroughly.

Signed-off-by: Tirumala R Marri <tmarri@amcc.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index bdb3663..0ce3f46 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -815,7 +815,7 @@ static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 	switch (port->index) {
 	case 0:
 		mtdcri(SDR0, PESDR0_460EX_L0CDRCTL, 0x00003230);
-		mtdcri(SDR0, PESDR0_460EX_L0DRV, 0x00000136);
+		mtdcri(SDR0, PESDR0_460EX_L0DRV, 0x00000130);
 		mtdcri(SDR0, PESDR0_460EX_L0CLK, 0x00000006);
 
 		mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST,0x10000000);
@@ -826,10 +826,10 @@ static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 		mtdcri(SDR0, PESDR1_460EX_L1CDRCTL, 0x00003230);
 		mtdcri(SDR0, PESDR1_460EX_L2CDRCTL, 0x00003230);
 		mtdcri(SDR0, PESDR1_460EX_L3CDRCTL, 0x00003230);
-		mtdcri(SDR0, PESDR1_460EX_L0DRV, 0x00000136);
-		mtdcri(SDR0, PESDR1_460EX_L1DRV, 0x00000136);
-		mtdcri(SDR0, PESDR1_460EX_L2DRV, 0x00000136);
-		mtdcri(SDR0, PESDR1_460EX_L3DRV, 0x00000136);
+		mtdcri(SDR0, PESDR1_460EX_L0DRV, 0x00000130);
+		mtdcri(SDR0, PESDR1_460EX_L1DRV, 0x00000130);
+		mtdcri(SDR0, PESDR1_460EX_L2DRV, 0x00000130);
+		mtdcri(SDR0, PESDR1_460EX_L3DRV, 0x00000130);
 		mtdcri(SDR0, PESDR1_460EX_L0CLK, 0x00000006);
 		mtdcri(SDR0, PESDR1_460EX_L1CLK, 0x00000006);
 		mtdcri(SDR0, PESDR1_460EX_L2CLK, 0x00000006);
-- 
1.5.5
