Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problems using LCD with FADS 823 & denx linux 2.4.4
Date: Wed, 21 Nov 2001 14:41:08 -0200
Message-ID: <A43453F31786664ABED2E468A69079EF0F88C3@MAILSRV1.aquarius.cpqd.com.br>
From: "Sergio Massami Sakai" <Sakai@cpqd.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I´m trying to use a LCD with my FADS MPC823 board, using Linux kernel
2.4.4-2001-05-12 from denx, but I had some problems.
Using the kernel compiled with the LCD_8xx option enabled I had the
following messages when I try to boot:

INIT: version 2.77 booting
INIT: Entering runlevel: 3
Oops: kernel access of bad area, sig: 11
NIP: C000B638 XER: E000027A LR: C003DC38 SP: C06F3E40 REGS: c06f3d90
TRAP: 0300MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: D06E5000, DSISR: 00004C06
TASK = c06f2000[23] 'sh' Last syscall: 5
last math 00000000 last altivec 00000000
GPR00: 0000002F C06F3E40 C06F2000 D06E5000 10075900 00001000 D06E4FFF
3000BF24
GPR08: C01E9540 00000000 0FFFF000 00000001 30014000 100A1BD4 100A2F90
00000000
GPR16: 00000000 00000001 0075F280 1004B6F8 00009032 006F3E80 00000000
C00026D8
GPR24: C0002400 00000001 10073BD0 00000001 7FFFFE04 D06E5000 10075900
00001000
Call backtrace:
C003DBC4 C00310B0 C000245C 1000F4D0 100188C0 1000F83C 0FEE6E78
00000000
Oops: kernel access of bad area, sig: 11
NIP: C0027CF8 XER: C000027A LR: C0027CD0 SP: C01FFDE0 REGS: c01ffd30
TRAP: 0300MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 3C1F1D58, DSISR: 0000012B
TASK = c01fe000[1] 'init' Last syscall: 106
last math 00000000 last altivec 00000000
GPR24: C0002400 00000001 10010000 7FFFFFDA C01FFE48 00000009 00000007
C0171D40
Call backtrace:
C0043DD0 C003DBC4 C003F204 C003AEF0 C000245C 00000000 100049F8
100056C8 10005A20 0FF09E78 00000000
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..Oops: kernel access of bad area, sig: 11
NIP: BFFF7754 XER: C000027A LR: C001765C SP: C01FFA20 REGS: c01ff970
TRAP: 0400
MSR: 08201032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fe000[1] 'init' Last syscall: 106
last math 00000000 last altivec 00000000
GPR00: 000007E8 C01FFA20 C01FE000 00009032 00009032 00000000 C0140000
000000FB
GPR08: C0140000 C0148014 C0148004 C0148014 FFFFFFFF 1001EEB4 0079C000
0075F318
GPR16: 00000000 00000001 0075F280 10010000 00001032 001FFAC0 00000000
C00026D0
GPR24: C0003DB4 00000000 00030001 0000012B C0130000 00000000 C0099AE4
C012CACC
Call backtrace:
C01FFAD0 C0099B1C C00182C4 C0013FC0 C0013E70 C0013C88 C0002700
C000E838 C00123D0 C000287C C000A1A0 C000A068 C00026D8 C0043DD0
C003DBC4 C003F204 C003AEF0 C000245C 00000000 100049F8 100056C8
10005A20 0FF09E78 00000000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
Rebooting in 180 seconds..

If I remove the LCD driver or turn off the LCD during the boot, the
problem disappears.
Does anyone has some idea about what is the problem and how to solve
that?


	Sakai


PS: I´ve applied a patch in the denx kernel to run it in the FADS board:

diff -Naur linux-2.4.4-2001-05-12/arch/ppc/8xx_io/commproc.h
linux-2.4.4-2001-05-12.sxn/arch/ppc/8xx_io/commproc.h
--- linux-2.4.4-2001-05-12/arch/ppc/8xx_io/commproc.h	Tue May  1
14:38:59 2001
+++ linux-2.4.4-2001-05-12.sxn/arch/ppc/8xx_io/commproc.h	Sun Jun
3 19:27:32 2001
@@ -658,6 +658,27 @@

 #endif	/* CONFIG_LWMON */

+/***  FADS
***********************************************************/
+
+#ifdef CONFIG_FADS
+/* Bits in parallel I/O port registers that have to be set/cleared
+ * to configure the pins for SCC1 use.
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
+#endif	/* CONFIG_FADS */
+
 /*********************************************************************/

 /* SCC Event register as used by Ethernet.
diff -Naur linux-2.4.4-2001-05-12/arch/ppc/config.in
linux-2.4.4-2001-05-12.sxn/arch/ppc/config.in
--- linux-2.4.4-2001-05-12/arch/ppc/config.in	Tue May  1 14:38:59 2001
+++ linux-2.4.4-2001-05-12.sxn/arch/ppc/config.in	Sun Jun  3
17:33:19 2001
@@ -69,6 +69,7 @@
  	 IVMS8		CONFIG_IVMS8		\
 	 IVML24		CONFIG_IVML24		\
  	 SM850		CONFIG_SM850		\
+	 FADS		CONFIG_FADS		\
 	 HERMES		CONFIG_HERMES		\
 	 HERMES/SH	CONFIG_HERMES_SH	\
 	 IP860		CONFIG_IP860		\
diff -Naur linux-2.4.4-2001-05-12/include/asm-ppc/fads.h
linux-2.4.4-2001-05-12.sxn/include/asm-ppc/fads.h
--- linux-2.4.4-2001-05-12/include/asm-ppc/fads.h	Tue Apr 24
21:36:02 2001
+++ linux-2.4.4-2001-05-12.sxn/include/asm-ppc/fads.h	Sun Jun  3
19:20:56 2001
@@ -9,16 +9,43 @@
 #define __MACH_FADS_DEFS

 #ifndef __ASSEMBLY__
+
+typedef	void (interrupt_handler_t)(void *);
+
+typedef struct serial_io {
+	int	(*getc)(void);
+	int	(*tstc)(void);
+	void	(*putc)(const char c);
+	void	(*printf)(const char *fmt, ...);
+} serial_io_t;
+
+typedef struct intr_util {
+	void	(*install_hdlr)(int, interrupt_handler_t *, void *);
+	void	(*free_hdlr)(int);
+} intr_util_t;
+
+
 /* A Board Information structure that is given to a program when
- * prom starts it up.
+ * ppcboot starts it up.
  */
 typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
+	 unsigned long	bi_memstart;	/* start of  DRAM memory
*/
+	 unsigned long	bi_memsize;	/* size	 of  DRAM memory in
bytes	*/
+	 unsigned long	bi_flashstart;	/* start of FLASH memory
*/
+	 unsigned long	bi_flashsize;	/* size	 of FLASH memory
*/
+	 unsigned long	bi_flashoffset; /* reserved area for startup
monitor	*/
+	 unsigned long	bi_sramstart;	/* start of  SRAM memory
*/
+	 unsigned long	bi_sramsize;	/* size	 of  SRAM memory
*/
+	 unsigned long	bi_immr_base;	/* base of IMMR register
*/
+	 unsigned long	bi_bootflags;	/* boot / reboot flag (for
LynxOS)	*/
+	 unsigned long	bi_ip_addr;	/* IP Address
*/
+	 unsigned char	bi_enetaddr[6]; /* Ethernet adress
*/
+	 unsigned char	bi_reserved[2]; /* -- just for alignment --
*/
+	 unsigned long	bi_intfreq;	/* Internal Freq, in MHz
*/
+	 unsigned long	bi_busfreq;	/* Bus Freq, in MHz
*/
+	 unsigned long	bi_baudrate;	/* Console Baudrate
*/
+	 serial_io_t	bi_serial_io;	/* Addr of monitor fnc for
Console I/O	*/
+	 intr_util_t	bi_interrupt;	/* Addr of monitor fnc for
Interrupts	*/
 } bd_t;

 extern bd_t m8xx_board_info;
@@ -28,16 +55,18 @@
  * dictates this and we simply have to move some of the physical
  * addresses for Linux.
  */
-#define BCSR_ADDR		((uint)0xfe000000)
+#define BCSR_ADDR		((uint)0xff010000)
 #define BCSR_SIZE		((uint)(64 * 1024))
-#define	BCSR0			((uint)0xfe000000)
-#define	BCSR1			((uint)0xfe000004)
-#define	BCSR2			((uint)0xfe000008)
-#define	BCSR3			((uint)0xfe00000c)
-#define	BCSR4			((uint)0xfe000010)
-#define IMAP_ADDR		((uint)0xf0000000)
+#define	BCSR0			((uint)0xff010000)
+#define	BCSR1			((uint)0xff010004)
+#define	BCSR2			((uint)0xff010008)
+#define	BCSR3			((uint)0xff01000c)
+#define	BCSR4			((uint)0xff010010)
+
+#define IMAP_ADDR		((uint)0xff000000)
 #define IMAP_SIZE		((uint)(64 * 1024))
-#define PCMCIA_MEM_ADDR		((uint)0x04000000)
+
+#define PCMCIA_MEM_ADDR		((uint)0xff020000)
 #define PCMCIA_MEM_SIZE		((uint)(64 * 1024))

 /* Bits of interest in the BCSRs.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
