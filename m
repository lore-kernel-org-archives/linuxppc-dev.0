Message-ID: <3AAD03E9.2CDE8696@intel.com>
Date: Mon, 12 Mar 2001 09:14:17 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ooops...
Content-Type: multipart/mixed;
 boundary="------------5281A4C66120F5EEFC3FBBE3"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5281A4C66120F5EEFC3FBBE3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ooops, I forgot to attach the patches... :)

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu



--------------5281A4C66120F5EEFC3FBBE3
Content-Type: text/plain; charset=us-ascii;
 name="fads.patch"
Content-Disposition: inline;
 filename="fads.patch"
Content-Transfer-Encoding: 7bit

diff -urN linuxppc_2_4.orig/arch/ppc/8xx_io/commproc.h linuxppc_2_4/arch/ppc/8xx_io/commproc.h
--- linuxppc_2_4.orig/arch/ppc/8xx_io/commproc.h	Thu Mar  8 05:00:16 2001
+++ linuxppc_2_4/arch/ppc/8xx_io/commproc.h	Fri Mar  9 15:16:17 2001
@@ -584,6 +584,45 @@
 #define SICR_ENET_CLKRT	((uint)0x00260000)
 #endif	/* CONFIG_SM850 */

+/***  FADS  **********************************************************/
+
+#ifdef CONFIG_FADS
+
+#ifdef CONFIG_SCC1_ENET
+/* Bits in parallel I/O port registers that have to be set/cleared
+ * to configure the pins for SCC1 use.
+ * TCLK - CLK1, RCLK - CLK2.
+ */
+#define PA_ENET_RXD	((ushort)0x0001)
+#define PA_ENET_TXD	((ushort)0x0002)
+#define PA_ENET_TCLK	((ushort)0x0100)
+#define PA_ENET_RCLK	((ushort)0x0200)
+#define PB_ENET_TENA	((uint)0x00001000)
+#define PC_ENET_CLSN	((ushort)0x0010)
+#define PC_ENET_RENA	((ushort)0x0020)
+
+/* Control bits in the SICR to route TCLK (CLK1) and RCLK (CLK2) to
+ * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
+ */
+#define SICR_ENET_MASK	((uint)0x000000ff)
+#define SICR_ENET_CLKRT	((uint)0x0000002c)
+#endif /* CONFIG_SCC1_ENET */
+
+#ifdef CONFIG_SCC2_ENET
+#define PA_ENET_RXD	((ushort)0x0004)
+#define PA_ENET_TXD	((ushort)0x0008)
+#define PA_ENET_TCLK	((ushort)0x0400)
+#define PA_ENET_RCLK	((ushort)0x0200)
+#define PB_ENET_TENA	((uint)0x00002000)
+#define PC_ENET_CLSN	((ushort)0x0040)
+#define PC_ENET_RENA	((ushort)0x0080)
+
+#define SICR_ENET_MASK	((uint)0x0000ff00)
+#define SICR_ENET_CLKRT	((uint)0x00002e00)
+#endif /* CONFIG_SCC2_ENET */
+
+#endif /* CONFIG_FADS */
+
 /*********************************************************************/

 /* SCC Event register as used by Ethernet.
diff -urN linuxppc_2_4.orig/arch/ppc/config.in linuxppc_2_4/arch/ppc/config.in
--- linuxppc_2_4.orig/arch/ppc/config.in	Thu Mar  8 05:00:12 2001
+++ linuxppc_2_4/arch/ppc/config.in	Fri Mar  9 15:16:17 2001
@@ -67,7 +67,8 @@
  	 IVMS8		CONFIG_IVMS8		\
  	 SM850		CONFIG_SM850		\
 	 MBX		CONFIG_MBX		\
-	 WinCept	CONFIG_WINCEPT"		RPX-Lite
+	 WinCept	CONFIG_WINCEPT		\
+	 FADS		CONFIG_FADS"		RPX-Lite

   if [ "$CONFIG_TQM823L" = "y" -o \
        "$CONFIG_TQM850L" = "y" -o \
diff -urN linuxppc_2_4.orig/include/asm-ppc/fads.h linuxppc_2_4/include/asm-ppc/fads.h
--- linuxppc_2_4.orig/include/asm-ppc/fads.h	Thu Mar  8 05:00:15 2001
+++ linuxppc_2_4/include/asm-ppc/fads.h	Fri Mar  9 15:18:57 2001
@@ -16,6 +16,8 @@
 	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
 	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
 	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
 } bd_t;

 extern bd_t m8xx_board_info;
@@ -24,16 +26,38 @@
  * I tried to follow the FADS manual, although the startup PROM
  * dictates this.
  */
-#define BCSR_ADDR		((uint)0x02100000)
+#define BCSR_ADDR		((uint)0xff010000)
 #define BCSR_SIZE		((uint)(64 * 1024))
-#define	BCSR0			((uint)0x02100000)
-#define	BCSR1			((uint)0x02100004)
-#define	BCSR2			((uint)0x02100008)
-#define	BCSR3			((uint)0x0210000c)
-#define	BCSR4			((uint)0x02100010)
-#define IMAP_ADDR		((uint)0x02200000)
+#define	BCSR0			((uint)0xff010000)
+#define	BCSR1			((uint)0xff010004)
+#define	BCSR2			((uint)0xff010008)
+#define	BCSR3			((uint)0xff01000c)
+#define	BCSR4			((uint)0xff010010)
+#define IMAP_ADDR		((uint)0xff000000)
 #define IMAP_SIZE		((uint)(64 * 1024))
-#define PCMCIA_MEM_ADDR		((uint)0x04000000)
+#define PCMCIA_MEM_ADDR		((uint)0xe0000000)
 #define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+/* Bits of interest in the BCSRs.
+*/
+#define BCSR1_ETHEN		((uint)0x20000000)
+#define BCSR1_RS232EN_1		((uint)0x01000000)
+#define BCSR4_ETHLOOP		((uint)0x80000000)	/* EEST Loopback */
+#define BCSR4_EEFDX		((uint)0x40000000)	/* EEST FDX enable */
+#define BCSR4_FETH_EN		((uint)0x08000000)	/* PHY enable */
+#define BCSR4_FETHCFG0		((uint)0x04000000)	/* PHY autoneg mode */
+#define BCSR4_FETHFDE		((uint)0x02000000)	/* PHY FDX advertise */
+
+/* Interrupt level assignments.
+*/
+#define FEC_INTERRUPT	SIU_LEVEL1	/* FEC interrupt */
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+/* Machine type
+*/
+#define _MACH_8xx (_MACH_fads)

 #endif

--------------5281A4C66120F5EEFC3FBBE3
Content-Type: text/plain; charset=us-ascii;
 name="ppcboot.patch"
Content-Disposition: inline;
 filename="ppcboot.patch"
Content-Transfer-Encoding: 7bit

diff -urN linuxppc_2_4.orig/arch/ppc/config.in linuxppc_2_4/arch/ppc/config.in
--- linuxppc_2_4.orig/arch/ppc/config.in	Fri Mar  9 16:50:00 2001
+++ linuxppc_2_4/arch/ppc/config.in	Fri Mar  9 16:28:18 2001
@@ -86,6 +86,12 @@
 	 APUS		CONFIG_APUS"		PowerMac/PReP/MTX/CHRP
 fi

+if [ "$CONFIG_6xx" = "y" -o \
+     "$CONFIG_4xx" = "y" -o \
+     "$CONFIG_8xx" = "y" ]; then
+  bool 'PPCBoot support' CONFIG_PPCBOOT
+fi
+
 if [ "$CONFIG_PPC64BRIDGE" != "y" ]; then
   bool 'Workarounds for PPC601 bugs' CONFIG_PPC601_SYNC_FIX
 fi
Binary files linuxppc_2_4.orig/image.fads823 and linuxppc_2_4/image.fads823 differ
diff -urN linuxppc_2_4.orig/include/asm-ppc/bseip.h linuxppc_2_4/include/asm-ppc/bseip.h
--- linuxppc_2_4.orig/include/asm-ppc/bseip.h	Thu Mar  8 05:00:19 2001
+++ linuxppc_2_4/include/asm-ppc/bseip.h	Fri Mar  9 16:38:54 2001
@@ -8,6 +8,9 @@
 #ifndef __MACH_BSEIP_DEFS
 #define __MACH_BSEIP_DEFS

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -19,6 +22,7 @@
 	unsigned char	bi_enetaddr[6];
 	unsigned int	bi_baudrate;
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 extern bd_t m8xx_board_info;

diff -urN linuxppc_2_4.orig/include/asm-ppc/est8260.h linuxppc_2_4/include/asm-ppc/est8260.h
--- linuxppc_2_4.orig/include/asm-ppc/est8260.h	Thu Mar  8 05:00:11 2001
+++ linuxppc_2_4/include/asm-ppc/est8260.h	Fri Mar  9 16:39:20 2001
@@ -7,7 +7,9 @@

 #define IMAP_ADDR	((uint)0xf0000000)

-
+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -23,6 +25,7 @@
 	unsigned int	bi_immr;	/* IMMR when called from boot rom */
 	unsigned char	bi_enetaddr[6];
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 extern bd_t m8xx_board_info;

diff -urN linuxppc_2_4.orig/include/asm-ppc/fads.h linuxppc_2_4/include/asm-ppc/fads.h
--- linuxppc_2_4.orig/include/asm-ppc/fads.h	Fri Mar  9 16:50:00 2001
+++ linuxppc_2_4/include/asm-ppc/fads.h	Fri Mar  9 16:41:53 2001
@@ -8,6 +8,9 @@
 #ifndef __MACH_FADS_DEFS
 #define __MACH_FADS_DEFS

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -19,6 +22,7 @@
 	unsigned char	bi_enetaddr[6];
 	unsigned int	bi_baudrate;
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 extern bd_t m8xx_board_info;

diff -urN linuxppc_2_4.orig/include/asm-ppc/ivms8.h linuxppc_2_4/include/asm-ppc/ivms8.h
--- linuxppc_2_4.orig/include/asm-ppc/ivms8.h	Thu Mar  8 05:00:18 2001
+++ linuxppc_2_4/include/asm-ppc/ivms8.h	Fri Mar  9 16:42:01 2001
@@ -9,6 +9,9 @@

 #ifndef __ASSEMBLY__

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 typedef	void (interrupt_handler_t)(void *);

 typedef struct serial_io {
@@ -46,6 +49,7 @@
 	 serial_io_t	bi_serial_io;	/* Addr of monitor fnc for Console I/O	*/
 	 intr_util_t	bi_interrupt;	/* Addr of monitor fnc for Interrupts	*/
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 #endif /* __ASSEMBLY__ */

diff -urN linuxppc_2_4.orig/include/asm-ppc/mbx.h linuxppc_2_4/include/asm-ppc/mbx.h
--- linuxppc_2_4.orig/include/asm-ppc/mbx.h	Thu Mar  8 05:00:12 2001
+++ linuxppc_2_4/include/asm-ppc/mbx.h	Fri Mar  9 16:42:16 2001
@@ -11,6 +11,9 @@
 #ifndef __MACH_MBX_DEFS
 #define __MACH_MBX_DEFS

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * EPPC-Bug starts it up.
  */
@@ -27,6 +30,7 @@
 	unsigned int	bi_dlun;	/* Boot device logical dev */
 	unsigned int	bi_baudrate;	/* ...to be like everyone else */
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 /* Memory map for the MBX as configured by EPPC-Bug.  We could reprogram
  * The SIU and PCI bridge, and try to use larger MMU pages, but the
diff -urN linuxppc_2_4.orig/include/asm-ppc/ppcboot.h linuxppc_2_4/include/asm-ppc/ppcboot.h
--- linuxppc_2_4.orig/include/asm-ppc/ppcboot.h	Wed Dec 31 16:00:00 1969
+++ linuxppc_2_4/include/asm-ppc/ppcboot.h	Fri Mar  9 15:59:58 2001
@@ -0,0 +1,82 @@
+/*
+ * (C) Copyright 2000
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef _PPCBOOT_H_
+#define _PPCBOOT_H_	1
+
+typedef	void (interrupt_handler_t)(void *);
+
+typedef struct monitor_functions {
+	int	(*getc)(void);
+	int	(*tstc)(void);
+	void	(*putc)(const char c);
+	void	(*puts)(const char *s);
+	void	(*printf)(const char *fmt, ...);
+	void	(*install_hdlr)(int, interrupt_handler_t *, void *);
+	void	(*free_hdlr)(int);
+	void	*(*malloc)(size_t);
+	void	(*free)(void *);
+} mon_fnc_t;
+
+/* A Board Information structure that is given to a program when
+ * ppcboot starts it up.
+ */
+typedef struct bd_info {
+	unsigned long	bi_memstart;	/* start of  DRAM memory		*/
+	unsigned long	bi_memsize;	/* size	 of  DRAM memory in bytes	*/
+	unsigned long	bi_flashstart;	/* start of FLASH memory		*/
+	unsigned long	bi_flashsize;	/* size	 of FLASH memory		*/
+	unsigned long	bi_flashoffset; /* reserved area for startup monitor	*/
+	unsigned long	bi_sramstart;	/* start of  SRAM memory		*/
+	unsigned long	bi_sramsize;	/* size	 of  SRAM memory		*/
+#if defined(CONFIG_8xx) || defined(CONFIG_8260)
+	unsigned long	bi_immr_base;	/* base of IMMR register		*/
+#endif
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS)	*/
+	unsigned long	bi_ip_addr;	/* IP Address				*/
+	unsigned char	bi_enetaddr[6]; /* Ethernet adress			*/
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps		*/
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz		*/
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz			*/
+#if defined(CONFIG_8260)
+	unsigned long	bi_cpmfreq;	/* CPM_CLK Freq, in MHz */
+	unsigned long	bi_brgfreq;	/* BRG_CLK Freq, in MHz */
+	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
+	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
+#endif
+	unsigned long	bi_baudrate;	/* Console Baudrate			*/
+#if defined(CONFIG_PPC405)
+	unsigned char	bi_s_version[4];  /* Version of this structure		*/
+	unsigned char	bi_r_version[32]; /* Version of the ROM (IBM)		*/
+	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz		*/
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address     */
+#endif
+#if defined(CONFIG_HYMOD)
+	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information	*/
+#endif
+	mon_fnc_t	*bi_mon_fnc;	/* Pointer to monitor functions		*/
+} bd_t;
+
+#endif	/* _PPCBOOT_H_ */
diff -urN linuxppc_2_4.orig/include/asm-ppc/rpxclassic.h linuxppc_2_4/include/asm-ppc/rpxclassic.h
--- linuxppc_2_4.orig/include/asm-ppc/rpxclassic.h	Thu Mar  8 05:00:35 2001
+++ linuxppc_2_4/include/asm-ppc/rpxclassic.h	Fri Mar  9 16:42:30 2001
@@ -11,6 +11,9 @@

 #include <linux/config.h>

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -22,6 +25,7 @@
 	unsigned char	bi_enetaddr[6];
 	unsigned int	bi_baudrate;
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 extern bd_t m8xx_board_info;

diff -urN linuxppc_2_4.orig/include/asm-ppc/rpxlite.h linuxppc_2_4/include/asm-ppc/rpxlite.h
--- linuxppc_2_4.orig/include/asm-ppc/rpxlite.h	Thu Mar  8 05:00:20 2001
+++ linuxppc_2_4/include/asm-ppc/rpxlite.h	Fri Mar  9 16:42:49 2001
@@ -9,6 +9,9 @@
 #ifndef __MACH_RPX_DEFS
 #define __MACH_RPX_DEFS

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -20,6 +23,7 @@
 	unsigned char	bi_enetaddr[6];
 	unsigned int	bi_baudrate;
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 extern bd_t m8xx_board_info;

diff -urN linuxppc_2_4.orig/include/asm-ppc/spd8xx.h linuxppc_2_4/include/asm-ppc/spd8xx.h
--- linuxppc_2_4.orig/include/asm-ppc/spd8xx.h	Thu Mar  8 05:00:13 2001
+++ linuxppc_2_4/include/asm-ppc/spd8xx.h	Fri Mar  9 16:43:11 2001
@@ -9,6 +9,9 @@

 #ifndef __ASSEMBLY__

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 typedef	void (interrupt_handler_t)(void *);

 typedef struct serial_io {
@@ -46,6 +49,7 @@
 	 serial_io_t	bi_serial_io;	/* Addr of monitor fnc for Console I/O	*/
 	 intr_util_t	bi_interrupt;	/* Addr of monitor fnc for Interrupts	*/
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 #endif /* __ASSEMBLY__ */

diff -urN linuxppc_2_4.orig/include/asm-ppc/tqm8xx.h linuxppc_2_4/include/asm-ppc/tqm8xx.h
--- linuxppc_2_4.orig/include/asm-ppc/tqm8xx.h	Thu Mar  8 05:00:20 2001
+++ linuxppc_2_4/include/asm-ppc/tqm8xx.h	Fri Mar  9 16:43:41 2001
@@ -14,6 +14,9 @@

 #ifndef __ASSEMBLY__

+#ifdef CONFIG_PPCBOOT
+#include <asm/ppcboot.h>
+#else
 typedef	void (interrupt_handler_t)(void *);

 typedef struct serial_io {
@@ -51,6 +54,7 @@
 	 serial_io_t	bi_serial_io;	/* Addr of monitor fnc for Console I/O	*/
 	 intr_util_t	bi_interrupt;	/* Addr of monitor fnc for Interrupts	*/
 } bd_t;
+#endif /* CONFIG_PPCBOOT */

 #endif /* __ASSEMBLY__ */


--------------5281A4C66120F5EEFC3FBBE3--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
