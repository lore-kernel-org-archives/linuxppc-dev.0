Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 2455EDE018
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:31 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 2/7] [PPC] Merge common virtex header files
Date: Fri, 27 Apr 2007 13:50:00 -0600
Message-Id: <11777034143069-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1177703413868-git-send-email-grant.likely@secretlab.ca>
References: <11777034052773-git-send-email-grant.likely@secretlab.ca>
	<1177703413970-git-send-email-grant.likely@secretlab.ca>
	<1177703413868-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The header files for the ml403 and ml300 are virtually identical, merge
them into a single file.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/ppc/platforms/4xx/virtex.h       |   40 +++++++++++++++++++-------
 arch/ppc/platforms/4xx/xilinx_ml300.c |    1 +
 arch/ppc/platforms/4xx/xilinx_ml300.h |   45 ------------------------------
 arch/ppc/platforms/4xx/xilinx_ml403.c |    1 +
 arch/ppc/platforms/4xx/xilinx_ml403.h |   49 ---------------------------------
 include/asm-ppc/ibm4xx.h              |    8 +----
 6 files changed, 33 insertions(+), 111 deletions(-)
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml300.h
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.h

diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
index c14325d..e9f58a7 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -1,22 +1,18 @@
 /*
- * arch/ppc/platforms/4xx/virtex.h
+ * Basic Virtex platform defines, included by <asm/ibm4xx.h>
  *
- * Include file that defines the Xilinx Virtex-II Pro processor
+ * 2005-2007 (c) Secret Lab Technologies Ltd.
+ * 2002-2004 (c) MontaVista Software, Inc.
  *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
 
 #ifdef __KERNEL__
 #ifndef __ASM_VIRTEX_H__
 #define __ASM_VIRTEX_H__
 
-/* serial defines */
-
 #include <asm/ibm405.h>
 
 /* Ugly, ugly, ugly! BASE_BAUD defined here to keep 8250.c happy. */
@@ -29,7 +25,29 @@
 enum ppc_sys_devices {
 	VIRTEX_UART, NUM_PPC_SYS_DEVS,
 };
-#endif
   
+typedef struct board_info {
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal clock.
+ * the Virtex 405 does not, so just use a macro to make tbfreq match intfreq
+*/
+#define bi_tbfreq bi_intfreq
+
+extern const char* virtex_machine_name;
+#define PPC4xx_MACHINE_NAME (virtex_machine_name)
+
+#endif /* !__ASSEMBLY__ */
+
+/* We don't need anything mapped.  Size of zero will accomplish that. */
+#define PPC4xx_ONB_IO_PADDR	0u
+#define PPC4xx_ONB_IO_VADDR	0u
+#define PPC4xx_ONB_IO_SIZE	0u
+
 #endif				/* __ASM_VIRTEX_H__ */
 #endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
index fb5f0b5..4e4aca4 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -68,6 +68,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		},
 	},
 };
+const char* virtex_machine_name = "ML300 Reference Design";
 
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.h b/arch/ppc/platforms/4xx/xilinx_ml300.h
deleted file mode 100644
index 3d57332..0000000
--- a/arch/ppc/platforms/4xx/xilinx_ml300.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Include file that defines the Xilinx ML300 evaluation board
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_XILINX_ML300_H__
-#define __ASM_XILINX_ML300_H__
-
-/* ML300 has a Xilinx Virtex-II Pro processor */
-#include <platforms/4xx/virtex.h>
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
-#endif /* !__ASSEMBLY__ */
-
-/* We don't need anything mapped.  Size of zero will accomplish that. */
-#define PPC4xx_ONB_IO_PADDR	0u
-#define PPC4xx_ONB_IO_VADDR	0u
-#define PPC4xx_ONB_IO_SIZE	0u
-
-#define PPC4xx_MACHINE_NAME "Xilinx ML300 Reference System"
-
-#endif /* __ASM_XILINX_ML300_H__ */
-#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.c b/arch/ppc/platforms/4xx/xilinx_ml403.c
index cb3bf7a..c98e40a 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml403.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml403.c
@@ -72,6 +72,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		},
 	},
 };
+const char* virtex_machine_name = "ML403 Reference Design";
 
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.h b/arch/ppc/platforms/4xx/xilinx_ml403.h
deleted file mode 100644
index 4735969..0000000
--- a/arch/ppc/platforms/4xx/xilinx_ml403.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/xilinx_ml403.h
- *
- * Include file that defines the Xilinx ML403 reference design
- *
- * Author: Grant Likely <grant.likely@secretlab.ca>
- *
- * 2005 (c) Secret Lab Technologies Ltd.
- * 2002-2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_XILINX_ML403_H__
-#define __ASM_XILINX_ML403_H__
-
-/* ML403 has a Xilinx Virtex-4 FPGA with a PPC405 hard core */
-#include <platforms/4xx/virtex.h>
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
-#endif /* !__ASSEMBLY__ */
-
-/* We don't need anything mapped.  Size of zero will accomplish that. */
-#define PPC4xx_ONB_IO_PADDR	0u
-#define PPC4xx_ONB_IO_VADDR	0u
-#define PPC4xx_ONB_IO_SIZE	0u
-
-#define PPC4xx_MACHINE_NAME "Xilinx ML403 Reference Design"
-
-#endif /* __ASM_XILINX_ML403_H__ */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index 92fd02d..ed6891a 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -47,12 +47,8 @@
 #include <platforms/4xx/walnut.h>
 #endif
 
-#if defined(CONFIG_XILINX_ML300)
-#include <platforms/4xx/xilinx_ml300.h>
-#endif
-
-#if defined(CONFIG_XILINX_ML403)
-#include <platforms/4xx/xilinx_ml403.h>
+#if defined(CONFIG_XILINX_VIRTEX)
+#include <platforms/4xx/virtex.h>
 #endif
 
 #ifndef __ASSEMBLY__
-- 
1.5.1
