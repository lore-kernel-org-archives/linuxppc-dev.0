Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73350DDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 07:00:21 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAGK0Gcv031433
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 14:00:17 -0600
Date: Fri, 16 Nov 2007 13:59:03 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Add SPRN for Embedded registers specified in
	PowerISA 2.04
Message-ID: <Pine.LNX.4.64.0711161358280.24588@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Added SPRN for new architectural features added for embedded:
	- Alternate Time Base (ATB, ATBL, ATBU)
	- Doorbell Interrupts (IVOR36, IVOR37)
	- SPRG8/9
	- External Proxy (EPR)
	- External PID load/store (EPLC, EPSC)

* Added BUCSR for Freescale Embedded Processors
* Moved around MAS7 so its in numeric order

---

as normal, this is my git tree for 2.6.25

 include/asm-powerpc/reg_booke.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
index 8fdc2b4..d596439 100644
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -123,16 +123,23 @@
 #define SPRN_SPEFSCR	0x200	/* SPE & Embedded FP Status & Control */
 #define SPRN_BBEAR	0x201	/* Branch Buffer Entry Address Register */
 #define SPRN_BBTAR	0x202	/* Branch Buffer Target Address Register */
+#define SPRN_ATB	0x20E	/* Alternate Time Base */
+#define SPRN_ATBL	0x20E	/* Alternate Time Base Lower */
+#define SPRN_ATBU	0x20F	/* Alternate Time Base Upper */
 #define SPRN_IVOR32	0x210	/* Interrupt Vector Offset Register 32 */
 #define SPRN_IVOR33	0x211	/* Interrupt Vector Offset Register 33 */
 #define SPRN_IVOR34	0x212	/* Interrupt Vector Offset Register 34 */
 #define SPRN_IVOR35	0x213	/* Interrupt Vector Offset Register 35 */
+#define SPRN_IVOR36	0x214	/* Interrupt Vector Offset Register 36 */
+#define SPRN_IVOR37	0x215	/* Interrupt Vector Offset Register 37 */
 #define SPRN_MCSRR0	0x23A	/* Machine Check Save and Restore Register 0 */
 #define SPRN_MCSRR1	0x23B	/* Machine Check Save and Restore Register 1 */
 #define SPRN_MCSR	0x23C	/* Machine Check Status Register */
 #define SPRN_MCAR	0x23D	/* Machine Check Address Register */
 #define SPRN_DSRR0	0x23E	/* Debug Save and Restore Register 0 */
 #define SPRN_DSRR1	0x23F	/* Debug Save and Restore Register 1 */
+#define SPRN_SPRG8	0x25C	/* Special Purpose Register General 8 */
+#define SPRN_SPRG9	0x25D	/* Special Purpose Register General 8 */
 #define SPRN_MAS0	0x270	/* MMU Assist Register 0 */
 #define SPRN_MAS1	0x271	/* MMU Assist Register 1 */
 #define SPRN_MAS2	0x272	/* MMU Assist Register 2 */
@@ -140,15 +147,18 @@
 #define SPRN_MAS4	0x274	/* MMU Assist Register 4 */
 #define SPRN_MAS5	0x275	/* MMU Assist Register 5 */
 #define SPRN_MAS6	0x276	/* MMU Assist Register 6 */
-#define SPRN_MAS7	0x3b0	/* MMU Assist Register 7 */
 #define SPRN_PID1	0x279	/* Process ID Register 1 */
 #define SPRN_PID2	0x27A	/* Process ID Register 2 */
 #define SPRN_TLB0CFG	0x2B0	/* TLB 0 Config Register */
 #define SPRN_TLB1CFG	0x2B1	/* TLB 1 Config Register */
+#define SPRN_EPR	0x2BE	/* External Proxy Register */
 #define SPRN_CCR1	0x378	/* Core Configuration Register 1 */
 #define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
+#define SPRN_MAS7	0x3B0	/* MMU Assist Register 7 */
 #define SPRN_MMUCR	0x3B2	/* MMU Control Register */
 #define SPRN_CCR0	0x3B3	/* Core Configuration Register 0 */
+#define SPRN_EPLC	0x3B3	/* External Process ID Load Context */
+#define SPRN_EPSC	0x3B4	/* External Process ID Store Context */
 #define SPRN_SGR	0x3B9	/* Storage Guarded Register */
 #define SPRN_DCWR	0x3BA	/* Data Cache Write-thru Register */
 #define SPRN_SLER	0x3BB	/* Little-endian real mode */
@@ -159,6 +169,7 @@
 #define SPRN_L1CSR0	0x3F2	/* L1 Cache Control and Status Register 0 */
 #define SPRN_L1CSR1	0x3F3	/* L1 Cache Control and Status Register 1 */
 #define SPRN_PIT	0x3DB	/* Programmable Interval Timer */
+#define SPRN_BUCSR	0x3F5	/* Branch Unit Control and Status */
 #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
 #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
 #define SPRN_SVR	0x3FF	/* System Version Register */
-- 
1.5.3.4
