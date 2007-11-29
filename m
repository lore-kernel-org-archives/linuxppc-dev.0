Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35F76DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 09:33:20 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: qe: change qe_setbrg() to take an enum qe_clock instead of an integer
Date: Thu, 29 Nov 2007 15:56:46 -0600
Message-Id: <1196373406380-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

qe_setbrg() currently takes an integer to indicate the BRG number.  Change that
to take an enum qe_clock instead, since this enum is intended to represent
clock sources.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies to Kumar's for-2.6.25 branch.  You might need to apply my
other patch, "qe: fix device tree lookup code in qe_muram_init()", first.

It's safe to change the parameters to qe_setbrg() because no one is using that
function yet.

 arch/powerpc/sysdev/qe_lib/qe.c |   12 +++--
 include/asm-powerpc/qe.h        |   94 +++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 298e073..8ef4690 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -167,19 +167,20 @@ unsigned int get_brg_clk(void)
 
 /* Program the BRG to the given sampling rate and multiplier
  *
- * @brg: the BRG, 1-16
+ * @brg: the BRG, QE_BRG1 - QE_BRG16
  * @rate: the desired sampling rate
  * @multiplier: corresponds to the value programmed in GUMR_L[RDCR] or
  * GUMR_L[TDCR].  E.g., if this BRG is the RX clock, and GUMR_L[RDCR]=01,
  * then 'multiplier' should be 8.
- *
- * Also note that the value programmed into the BRGC register must be even.
  */
-void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int multiplier)
+void qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 {
 	u32 divisor, tempval;
 	u32 div16 = 0;
 
+	if ((brg < QE_BRG1) || (brg > QE_BRG16))
+		return;
+
 	divisor = get_brg_clk() / (rate * multiplier);
 
 	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
@@ -196,8 +197,9 @@ void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int multiplier)
 	tempval = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
 		QE_BRGC_ENABLE | div16;
 
-	out_be32(&qe_immr->brg.brgc[brg - 1], tempval);
+	out_be32(&qe_immr->brg.brgc[brg - QE_BRG1], tempval);
 }
+EXPORT_SYMBOL(qe_setbrg);
 
 /* Initialize SNUMs (thread serial numbers) according to
  * QE Module Control chapter, SNUM table
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 0dabe46..c779033 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -28,6 +28,52 @@
 #define MEM_PART_SECONDARY	1
 #define MEM_PART_MURAM		2
 
+/* Clocks and BRGs */
+enum qe_clock {
+	QE_CLK_NONE = 0,
+	QE_BRG1,		/* Baud Rate Generator 1 */
+	QE_BRG2,		/* Baud Rate Generator 2 */
+	QE_BRG3,		/* Baud Rate Generator 3 */
+	QE_BRG4,		/* Baud Rate Generator 4 */
+	QE_BRG5,		/* Baud Rate Generator 5 */
+	QE_BRG6,		/* Baud Rate Generator 6 */
+	QE_BRG7,		/* Baud Rate Generator 7 */
+	QE_BRG8,		/* Baud Rate Generator 8 */
+	QE_BRG9,		/* Baud Rate Generator 9 */
+	QE_BRG10,		/* Baud Rate Generator 10 */
+	QE_BRG11,		/* Baud Rate Generator 11 */
+	QE_BRG12,		/* Baud Rate Generator 12 */
+	QE_BRG13,		/* Baud Rate Generator 13 */
+	QE_BRG14,		/* Baud Rate Generator 14 */
+	QE_BRG15,		/* Baud Rate Generator 15 */
+	QE_BRG16,		/* Baud Rate Generator 16 */
+	QE_CLK1,		/* Clock 1 */
+	QE_CLK2,		/* Clock 2 */
+	QE_CLK3,		/* Clock 3 */
+	QE_CLK4,		/* Clock 4 */
+	QE_CLK5,		/* Clock 5 */
+	QE_CLK6,		/* Clock 6 */
+	QE_CLK7,		/* Clock 7 */
+	QE_CLK8,		/* Clock 8 */
+	QE_CLK9,		/* Clock 9 */
+	QE_CLK10,		/* Clock 10 */
+	QE_CLK11,		/* Clock 11 */
+	QE_CLK12,		/* Clock 12 */
+	QE_CLK13,		/* Clock 13 */
+	QE_CLK14,		/* Clock 14 */
+	QE_CLK15,		/* Clock 15 */
+	QE_CLK16,		/* Clock 16 */
+	QE_CLK17,		/* Clock 17 */
+	QE_CLK18,		/* Clock 18 */
+	QE_CLK19,		/* Clock 19 */
+	QE_CLK20,		/* Clock 20 */
+	QE_CLK21,		/* Clock 21 */
+	QE_CLK22,		/* Clock 22 */
+	QE_CLK23,		/* Clock 23 */
+	QE_CLK24,		/* Clock 24 */
+	QE_CLK_DUMMY
+};
+
 /* Export QE common operations */
 extern void qe_reset(void);
 extern int par_io_init(struct device_node *np);
@@ -38,7 +84,7 @@ extern int par_io_data_set(u8 port, u8 pin, u8 val);
 
 /* QE internal API */
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
-void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int multiplier);
+void qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
 unsigned long qe_muram_alloc(int size, int align);
@@ -129,52 +175,6 @@ enum comm_dir {
 	COMM_DIR_RX_AND_TX = 3
 };
 
-/* Clocks and BRGs */
-enum qe_clock {
-	QE_CLK_NONE = 0,
-	QE_BRG1,		/* Baud Rate Generator 1 */
-	QE_BRG2,		/* Baud Rate Generator 2 */
-	QE_BRG3,		/* Baud Rate Generator 3 */
-	QE_BRG4,		/* Baud Rate Generator 4 */
-	QE_BRG5,		/* Baud Rate Generator 5 */
-	QE_BRG6,		/* Baud Rate Generator 6 */
-	QE_BRG7,		/* Baud Rate Generator 7 */
-	QE_BRG8,		/* Baud Rate Generator 8 */
-	QE_BRG9,		/* Baud Rate Generator 9 */
-	QE_BRG10,		/* Baud Rate Generator 10 */
-	QE_BRG11,		/* Baud Rate Generator 11 */
-	QE_BRG12,		/* Baud Rate Generator 12 */
-	QE_BRG13,		/* Baud Rate Generator 13 */
-	QE_BRG14,		/* Baud Rate Generator 14 */
-	QE_BRG15,		/* Baud Rate Generator 15 */
-	QE_BRG16,		/* Baud Rate Generator 16 */
-	QE_CLK1,		/* Clock 1 */
-	QE_CLK2,		/* Clock 2 */
-	QE_CLK3,		/* Clock 3 */
-	QE_CLK4,		/* Clock 4 */
-	QE_CLK5,		/* Clock 5 */
-	QE_CLK6,		/* Clock 6 */
-	QE_CLK7,		/* Clock 7 */
-	QE_CLK8,		/* Clock 8 */
-	QE_CLK9,		/* Clock 9 */
-	QE_CLK10,		/* Clock 10 */
-	QE_CLK11,		/* Clock 11 */
-	QE_CLK12,		/* Clock 12 */
-	QE_CLK13,		/* Clock 13 */
-	QE_CLK14,		/* Clock 14 */
-	QE_CLK15,		/* Clock 15 */
-	QE_CLK16,		/* Clock 16 */
-	QE_CLK17,		/* Clock 17 */
-	QE_CLK18,		/* Clock 18 */
-	QE_CLK19,		/* Clock 19 */
-	QE_CLK20,		/* Clock 20 */
-	QE_CLK21,		/* Clock 21 */
-	QE_CLK22,		/* Clock 22 */
-	QE_CLK23,		/* Clock 23 */
-	QE_CLK24,		/* Clock 24 */
-	QE_CLK_DUMMY,
-};
-
 /* QE CMXUCR Registers.
  * There are two UCCs represented in each of the four CMXUCR registers.
  * These values are for the UCC in the LSBs
-- 
1.5.2.4
