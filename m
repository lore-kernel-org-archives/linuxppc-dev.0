Return-Path: <tnt@246tNt.com>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.4.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3937167C4A
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 11:17:44 +1100 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA50HW0Z013074
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 01:17:33 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc/powerpc: Fix io.h for config with CONFIG_PCI not set
Date: Sun,  5 Nov 2006 01:17:18 +0100
Message-Id: <11626858382465-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML PPC Embedded <linuxppc-embedded@ozlabs.org>, Sven <sl@bplan-gmbh.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When CONFIG_PCI option is not set, the variables
pci_dram_offset, isa_io_base and isa_mem_base are not defined.

Currently, the test is handled in each platform header. This
patch moves the test in io.h once and for all.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 include/asm-powerpc/mpc85xx.h |    8 --------
 include/asm-ppc/io.h          |    8 +-------
 include/asm-ppc/mpc52xx.h     |   11 -----------
 include/asm-ppc/mpc83xx.h     |    8 --------
 include/asm-ppc/mpc85xx.h     |    8 --------
 5 files changed, 1 insertions(+), 42 deletions(-)

diff --git a/include/asm-powerpc/mpc85xx.h b/include/asm-powerpc/mpc85xx.h
index ccdb8a2..5414299 100644
--- a/include/asm-powerpc/mpc85xx.h
+++ b/include/asm-powerpc/mpc85xx.h
@@ -31,14 +31,6 @@ #ifdef CONFIG_MPC85xx_CDS
 #include <platforms/85xx/mpc85xx_cds.h>
 #endif
 
-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#ifdef CONFIG_PCI
-#define PCI_DRAM_OFFSET pci_dram_offset
-#else
-#define PCI_DRAM_OFFSET 0
-#endif
-
 /* Let modules/drivers get at CCSRBAR */
 extern phys_addr_t get_ccsrbar(void);
 
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index a4c411b..b744baf 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -26,17 +26,11 @@ #define PREP_PCI_DRAM_OFFSET 	0x80000000
 
 #if defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
-#elif defined(CONFIG_PPC_MPC52xx)
-#include <asm/mpc52xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_8260)
 #include <asm/mpc8260.h>
-#elif defined(CONFIG_83xx)
-#include <asm/mpc83xx.h>
-#elif defined(CONFIG_85xx)
-#include <asm/mpc85xx.h>
-#elif defined(CONFIG_APUS)
+#elif defined(CONFIG_APUS) || !defined(CONFIG_PCI)
 #define _IO_BASE	0
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index 64c8874..d9d21aa 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -29,17 +29,6 @@ struct pt_regs;
 #endif /* __ASSEMBLY__ */
 
 
-#ifdef CONFIG_PCI
-#define _IO_BASE	isa_io_base
-#define _ISA_MEM_BASE	isa_mem_base
-#define PCI_DRAM_OFFSET	pci_dram_offset
-#else
-#define _IO_BASE	0
-#define _ISA_MEM_BASE	0
-#define PCI_DRAM_OFFSET	0
-#endif
-
-
 /* ======================================================================== */
 /* PPC Sys devices definition                                               */
 /* ======================================================================== */
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index 02ed2c3..c306197 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -25,14 +25,6 @@ #ifdef CONFIG_MPC834x_SYS
 #include <platforms/83xx/mpc834x_sys.h>
 #endif
 
-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#ifdef CONFIG_PCI
-#define PCI_DRAM_OFFSET pci_dram_offset
-#else
-#define PCI_DRAM_OFFSET 0
-#endif
-
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
index 9b48511..d7e4a79 100644
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -44,14 +44,6 @@ #if defined(CONFIG_TQM8540) || defined(C
 #include <platforms/85xx/tqm85xx.h>
 #endif
 
-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#ifdef CONFIG_PCI
-#define PCI_DRAM_OFFSET pci_dram_offset
-#else
-#define PCI_DRAM_OFFSET 0
-#endif
-
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
-- 
1.4.2
