Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 783FFDDFD9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 01:53:30 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] qe: add function qe_clock_source
Date: Tue,  9 Oct 2007 10:53:19 -0500
Message-Id: <1191945199488-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add function qe_clock_source() which takes a string containing the name of a
QE clock source (as is typically found in device trees) and returns the
matching enum qe_clock value.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies to Kumar's for-2.6.24 branch.

 arch/powerpc/sysdev/qe_lib/qe.c |   65 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/qe.h        |    3 ++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 3d57d38..da68534 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -199,6 +199,71 @@ void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int multiplier)
 	out_be32(&qe_immr->brg.brgc[brg - 1], tempval);
 }
 
+/* Convert a string to a QE clock source enum
+ *
+ * This function takes a string, typically from a property in the device
+ * tree, and returns the corresponding "enum qe_clock" value.
+*/
+enum qe_clock qe_clock_source(const char *source)
+{
+	/* This structure is designed so that it's 8 bytes in size */
+	static struct {
+		const char name[6];
+		u16 num;
+	} __attribute__((packed)) sources[QE_CLK_DUMMY] =
+	{
+		{"none", QE_CLK_NONE},
+		{"brg1", QE_BRG1},
+		{"brg2", QE_BRG2},
+		{"brg3", QE_BRG3},
+		{"brg4", QE_BRG4},
+		{"brg5", QE_BRG5},
+		{"brg6", QE_BRG6},
+		{"brg7", QE_BRG7},
+		{"brg8", QE_BRG8},
+		{"brg9", QE_BRG9},
+		{"brg10", QE_BRG10},
+		{"brg11", QE_BRG11},
+		{"brg12", QE_BRG12},
+		{"brg13", QE_BRG13},
+		{"brg14", QE_BRG14},
+		{"brg15", QE_BRG15},
+		{"brg16", QE_BRG16},
+		{"clk1", QE_CLK1},
+		{"clk2", QE_CLK2},
+		{"clk3", QE_CLK3},
+		{"clk4", QE_CLK4},
+		{"clk5", QE_CLK5},
+		{"clk6", QE_CLK6},
+		{"clk7", QE_CLK7},
+		{"clk8", QE_CLK8},
+		{"clk9", QE_CLK9},
+		{"clk10", QE_CLK10},
+		{"clk11", QE_CLK11},
+		{"clk12", QE_CLK12},
+		{"clk13", QE_CLK13},
+		{"clk14", QE_CLK14},
+		{"clk15", QE_CLK15},
+		{"clk16", QE_CLK16},
+		{"clk17", QE_CLK17},
+		{"clk18", QE_CLK18},
+		{"clk19", QE_CLK19},
+		{"clk20", QE_CLK20},
+		{"clk21", QE_CLK21},
+		{"clk22", QE_CLK22},
+		{"clk23", QE_CLK23},
+		{"clk24", QE_CLK24}
+	};
+	unsigned int i;
+
+	for (i = 0; i < QE_CLK_DUMMY; i++)
+		if (strcasecmp(source, sources[i].name) == 0)
+			return (enum qe_clock) sources[i].num;
+
+	return QE_CLK_DUMMY;
+}
+EXPORT_SYMBOL(qe_clock_source);
+
 /* Initialize SNUMs (thread serial numbers) according to
  * QE Module Control chapter, SNUM table
  */
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 0dabe46..d28bc85 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -175,6 +175,9 @@ enum qe_clock {
 	QE_CLK_DUMMY,
 };
 
+/* Convert a string to a QE clock source enum */
+enum qe_clock qe_clock_source(const char *source);
+
 /* QE CMXUCR Registers.
  * There are two UCCs represented in each of the four CMXUCR registers.
  * These values are for the UCC in the LSBs
-- 
1.5.2.4
