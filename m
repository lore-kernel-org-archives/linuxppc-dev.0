Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id E0F0C2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:22:24 +1100 (EST)
Date: Wed, 12 Jan 2005 07:22:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050112142222.GR3391@smtp.west.cox.net>
References: <1102585377.41b81e218d6df@webmail.televes.com:443>
	<20050105174838.GF4213@smtp.west.cox.net>
	<71A72D18-5F4C-11D9-A045-003065F9B7DC@embeddededge.com>
	<20050112141902.GQ3391@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050112141902.GQ3391@smtp.west.cox.net>
Cc: alebas@televes.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10] ppc32: Fix mpc8272ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When I reworked the m82xx init functions, I inadvertantly broke the
callout we had from ppc_md.setup_arch() that boards can use to poke &
prod things, once mappings are set.  The following adds in a callback
and updates the one m82xx board that needs it.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.28/arch/ppc/syslib/m8260_setup.c	2004-11-24 23:42:43 -07:00
+++ edited/arch/ppc/syslib/m8260_setup.c	2005-01-12 07:18:14 -07:00
@@ -37,6 +37,12 @@
 extern void m8260_find_bridges(void);
 extern void idma_pci9_init(void);
 
+/* Place-holder for board-specific init */
+void __attribute__ ((weak)) __init
+m82xx_board_setup(void)
+{
+}
+
 static void __init
 m8260_setup_arch(void)
 {
@@ -56,6 +62,7 @@
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
 #endif
+	m82xx_board_setup();
 }
 
 /* The decrementer counts at the system (internal) clock frequency
@@ -203,7 +210,7 @@
 	io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
 }
 
-/* Place-holder for board-specific init */
+/* Place-holder for board-specific ppc_md hooking */
 void __attribute__ ((weak)) __init
 m82xx_board_init(void)
 {
--- 1.6/arch/ppc/platforms/pq2ads.c	2004-08-13 16:33:54 -07:00
+++ edited/arch/ppc/platforms/pq2ads.c	2005-01-10 16:32:52 -07:00
@@ -19,8 +19,8 @@
 #include <asm/mpc8260.h>
 
 void __init
-m82xx_board_init(void)
+m82xx_board_setup(void)
 {
 	/* Enable the 2nd UART port */
-        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
+	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
