MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Broken arch/ppc/8260_io/uart.c
Date: Thu, 17 Jun 2004 14:24:36 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB07@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following patch broke compilation of uart.c for cases when SMC2 is
not used
(used to be doen by #define USE_SMC2 0, now is done by #undef USE_SMC2)

This breaks the following line:

#define SCC_NUM_BASE(USE_SMC2 + 1)/* SCC base tty "number" */

The patch:
11 weeks	trini@crashing.org	1.31	Change #if FOO to #ifdef
FOO.

--- 1.30/arch/ppc/8260_io/uart.c2004-06-17 12:19:25 -07:00
+++ 1.31/arch/ppc/8260_io/uart.c2004-06-17 12:19:25 -07:00
@@ -155,7 +155,7 @@
 static struct serial_state rs_table[] = {
 /* UART CLK   PORT          IRQ      FLAGS  NUM   */
 { 0,     0, PROFF_SMC1, SIU_INT_SMC1,   0,    0 },    /* SMC1 ttyS0 */
-#if USE_SMC2
+#ifdef USE_SMC2
 { 0,     0, PROFF_SMC2, SIU_INT_SMC2,   0,    1 },    /* SMC2 ttyS1 */
 #endif
 #ifndef CONFIG_SCC1_ENET
@@ -2565,7 +2565,7 @@
 io->iop_pdird |= 0x00400000;
 io->iop_pdird &= ~0x00800000;
 io->iop_psord &= ~0x00c00000;
-#if USE_SMC2
+#ifdef USE_SMC2
 io->iop_ppara |= 0x00c00000;
 io->iop_pdira |= 0x00400000;
 io->iop_pdira &= ~0x00800000;

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
