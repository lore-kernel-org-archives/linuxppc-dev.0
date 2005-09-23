Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id A0F0D68366
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:13:34 +1000 (EST)
In-Reply-To: <2005922203.zpZEPMsMBP43qjJI@cisco.com>
Date: Thu, 22 Sep 2005 20:03:35 -0700
Message-Id: <2005922203.92drttvd27WS9dXk@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/4] [PPC32] Allow ERPN for early serial to depend on CPU
	type
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The PowerPC 440SPe supports up to 16 GB of RAM, and therefore its IO
registers are at 0x4_xxxx_xxxx instead of being at 0x1_xxxx_xxxx like
most other PPC 440 chips.  To allow for this, this patch moves the
definition of the ERPN used for mapping UART0 from being hard-coded in
the head_44x.S assembly code to being defined in ibm44x.h.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 arch/ppc/kernel/head_44x.S |    4 ++--
 include/asm-ppc/ibm44x.h   |    7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

eb79641bc2a92b7d4c2f62e072650e20a7748f45
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -190,8 +190,8 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
-#ifndef CONFIG_440EP
-	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
+#ifdef UART0_PHYS_ERPN
+	ori	r4,r4,UART0_PHYS_ERPN		/* Add ERPN if above 4GB */
 #endif
 
 	/* attrib fields */
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -34,12 +34,17 @@
 /* Lowest TLB slot consumed by the default pinned TLBs */
 #define PPC44x_LOW_SLOT		63
 
-/* LS 32-bits of UART0 physical address location for early serial text debug */
+/*
+ * Least significant 32-bits and extended real page number (ERPN) of
+ * UART0 physical address location for early serial text debug
+ */
 #if defined(CONFIG_440SP)
+#define UART0_PHYS_ERPN		1
 #define UART0_PHYS_IO_BASE	0xf0000200
 #elif defined(CONFIG_440EP)
 #define UART0_PHYS_IO_BASE	0xe0000000
 #else
+#define UART0_PHYS_ERPN		1
 #define UART0_PHYS_IO_BASE	0x40000200
 #endif
 
