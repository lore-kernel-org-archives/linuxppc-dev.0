Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 2BDEA67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 08:18:05 +1100 (EST)
Message-ID: <4241DD04.4040401@mvista.com>
Date: Wed, 23 Mar 2005 14:17:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------050806050701030405050508"
Cc: rvinson@az.mvista.com,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] ppc32: Fix Sandpoint Soft Reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------050806050701030405050508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: Fix Sandpoint Soft Reboot

This patch allows the Freescale Sandpoint to perform soft reboots. A 
write of 0x00 to the Winbond's Chip Select Control Register was clearing 
the Upper BIOS Chip Select Enable bit which unmaps the boot flash. The 
comment associated with the write noted that it was enabling the RTC and 
Keyboard address locations, but the bits in question (1 and 0) are 
reserved when the Winbond chip is in PowerPC mode. Also, the bits are 1 
for enable, 0 for disable, therefore the original code was actually 
disabling the address locations. The patch also corrects errors in the 
definitions of 2 configuration bits in the Tundra Tsi107 bridge's MAPB 
Options register.

Signed-off-by Randy Vinson <rvinson@mvista.com>
Signed-off-by Mark A. Greer <mgreer@mvista.com>
-- 

--------------050806050701030405050508
Content-Type: text/plain;
 name="sandpoint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sandpoint.patch"

===== arch/ppc/platforms/sandpoint.c 1.26 vs edited =====
--- 1.26/arch/ppc/platforms/sandpoint.c	2005-03-04 23:41:15 -07:00
+++ edited/arch/ppc/platforms/sandpoint.c	2005-03-17 14:06:15 -07:00
@@ -202,13 +202,6 @@
 				0x48, /* ISA-to-PCI Addr Decoder Control */
 				0xf0);
 
-	/* Enable RTC and Keyboard address locations.  */
-	early_write_config_byte(hose,
-				0,
-				devfn,
-				0x4d,	/* Chip Select Control Register */
-				0x00);
-
 	/* Enable Port 92.  */
 	early_write_config_byte(hose,
 				0,
===== include/asm-ppc/mpc10x.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/mpc10x.h	2005-01-30 23:22:39 -07:00
+++ edited/include/asm-ppc/mpc10x.h	2005-03-16 16:52:34 -07:00
@@ -115,8 +115,8 @@
 #define	MPC10X_CFG_MAPB_OPTIONS_CFAE	0x80	/* CPU_FD_ALIAS_EN */
 #define	MPC10X_CFG_MAPB_OPTIONS_PFAE	0x40	/* PCI_FD_ALIAS_EN */
 #define	MPC10X_CFG_MAPB_OPTIONS_DR	0x20	/* DLL_RESET */
-#define	MPC10X_CFG_MAPB_OPTIONS_PCICH	0x80	/* PCI_COMPATIBILITY_HOLE */
-#define	MPC10X_CFG_MAPB_OPTIONS_PROCCH	0x40	/* PROC_COMPATIBILITY_HOLE */
+#define	MPC10X_CFG_MAPB_OPTIONS_PCICH	0x08	/* PCI_COMPATIBILITY_HOLE */
+#define	MPC10X_CFG_MAPB_OPTIONS_PROCCH	0x04	/* PROC_COMPATIBILITY_HOLE */
 
 /* Define offsets for the memory controller registers in the config space */
 #define MPC10X_MCTLR_MEM_START_1	0x80	/* Banks 0-3 */

--------------050806050701030405050508--
