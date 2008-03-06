Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5481DDF84
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 02:05:33 +1100 (EST)
Date: Thu, 6 Mar 2008 17:34:52 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 4xx: Use dcri_clrset() for PCIe indirect dcr
	read/modify/write access
Message-ID: <20080306143452.GA6288@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47CFFAD0.9060609@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use dcri_clrset() for PCIe SDR0 read/modify/write access.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c
--- linux-2.6.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2008-03-06 14:39:46.000000000 +0300
+++ linux-2.6/arch/powerpc/sysdev/ppc4xx_pci.c	2008-03-06 17:20:16.000000000 +0300
@@ -645,7 +645,7 @@ static int __init ppc440spe_pciex_core_i
 	int time_out = 20;
 
 	/* Set PLL clock receiver to LVPECL */
-	mtdcri(SDR0, PESDR0_PLLLCT1, mfdcri(SDR0, PESDR0_PLLLCT1) | 1 << 28);
+	dcri_clrset(SDR0, PESDR0_PLLLCT1, 0, 1 << 28);
 
 	/* Shouldn't we do all the calibration stuff etc... here ? */
 	if (ppc440spe_pciex_check_reset(np))
@@ -659,8 +659,7 @@ static int __init ppc440spe_pciex_core_i
 	}
 
 	/* De-assert reset of PCIe PLL, wait for lock */
-	mtdcri(SDR0, PESDR0_PLLLCT1,
-	       mfdcri(SDR0, PESDR0_PLLLCT1) & ~(1 << 24));
+	dcri_clrset(SDR0, PESDR0_PLLLCT1, 1 << 24, 0);
 	udelay(3);
 
 	while (time_out) {
@@ -712,9 +711,8 @@ static int ppc440spe_pciex_init_port_hw(
 		mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL7SET1,
 		       0x35000000);
 	}
-	val = mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET);
-	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
-	       (val & ~(1 << 24 | 1 << 16)) | 1 << 12);
+	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET,
+			(1 << 24) | (1 << 16), 1 << 12);
 
 	return 0;
 }
@@ -1042,8 +1040,7 @@ static int __init ppc4xx_pciex_port_init
 		port->link = 0;
 	}
 
-	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
-	       mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) | 1 << 20);
+	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET, 0, 1 << 20);
 	msleep(100);
 
 	return 0;
