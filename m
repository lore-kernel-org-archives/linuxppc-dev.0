Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DFCEDDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:26:00 +1000 (EST)
Date: Mon, 16 Apr 2007 18:25:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 3/4] bootwrapper: Add ppcboot.h.
Message-ID: <20070416232553.GB26693@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416232451.GA26667@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This file describes the bd_t struct, which is used by old versions of
U-boot to pass information to the kernel.  Platform code that needs to
interoperate with such firmware can use this; it should not be used for
anything new.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ppcboot.h |  108 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/ppcboot.h

diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
new file mode 100644
index 0000000..5290ff2
--- /dev/null
+++ b/arch/powerpc/boot/ppcboot.h
@@ -0,0 +1,108 @@
+/*
+ * This interface is used for compatibility with old U-boots *ONLY*.
+ * Please do not imitate or extend this.
+ */
+
+/*
+ * (C) Copyright 2000, 2001
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef __PPCBOOT_H__
+#define __PPCBOOT_H__
+
+/*
+ * Board information passed to kernel from PPCBoot
+ *
+ * include/asm-ppc/ppcboot.h
+ */
+
+#include "types.h"
+
+typedef struct bd_info {
+	unsigned long	bi_memstart;	/* start of DRAM memory */
+	unsigned long	bi_memsize;	/* size	 of DRAM memory in bytes */
+	unsigned long	bi_flashstart;	/* start of FLASH memory */
+	unsigned long	bi_flashsize;	/* size	 of FLASH memory */
+	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
+	unsigned long	bi_sramstart;	/* start of SRAM memory */
+	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
+#if defined(TARGET_8xx) || defined(TARGET_CPM2) || defined(TARGET_85xx) ||\
+	defined(TARGET_83xx)
+	unsigned long	bi_immr_base;	/* base of IMMR register */
+#endif
+#if defined(TARGET_PPC_MPC52xx)
+	unsigned long   bi_mbar_base;   /* base of internal registers */
+#endif
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
+	unsigned long	bi_ip_addr;	/* IP Address */
+	unsigned char	bi_enetaddr[6];	/* Ethernet address */
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
+#if defined(TARGET_CPM2)
+	unsigned long	bi_cpmfreq;	/* CPM_CLK Freq, in MHz */
+	unsigned long	bi_brgfreq;	/* BRG_CLK Freq, in MHz */
+	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
+	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
+#endif
+#if defined(TARGET_PPC_MPC52xx)
+	unsigned long   bi_ipbfreq;     /* IPB Bus Freq, in MHz */
+	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
+#endif
+	unsigned long	bi_baudrate;	/* Console Baudrate */
+#if defined(TARGET_4xx)
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
+	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz */
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+#endif
+#if defined(TARGET_HYMOD)
+	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
+#endif
+#if defined(TARGET_EVB64260) || defined(TARGET_405EP) || defined(TARGET_44x) || \
+	defined(TARGET_85xx) ||	defined(TARGET_83xx)
+	/* second onboard ethernet port */
+	unsigned char	bi_enet1addr[6];
+#define HAVE_ENET1ADDR
+#endif
+#if defined(TARGET_EVB64260) || defined(TARGET_440GX) || defined(TARGET_85xx)
+	/* third onboard ethernet ports */
+	unsigned char	bi_enet2addr[6];
+#define HAVE_ENET2ADDR
+#endif
+#if defined(TARGET_440GX)
+	/* fourth onboard ethernet ports */
+	unsigned char	bi_enet3addr[6];
+#define HAVE_ENET3ADDR
+#endif
+#if defined(TARGET_4xx)
+	unsigned int	bi_opbfreq;		/* OB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+#if defined(TARGET_440GX)
+	int		bi_phynum[4];		/* phy mapping */
+	int		bi_phymode[4];		/* phy mode */
+#endif
+} bd_t;
+
+#define bi_tbfreq	bi_intfreq
+
+#endif	/* __PPCBOOT_H__ */
-- 
1.5.0.3
