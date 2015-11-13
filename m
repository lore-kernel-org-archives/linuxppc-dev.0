Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21D51A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:57:43 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH 1/5] powerpc: Print MSR TM bits in oops message
Date: Fri, 13 Nov 2015 15:57:28 +1100
Message-Id: <1447390652-28355-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Print the MSR TM bits in oops messages.  This appends them to the end
like this:
 MSR: 8000000502823031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[TE]>

You get the TM[] only if at least one TM MSR bit is set.  Inside the
TM[], E means Enabled (bit 32), S means Suspended (bit 33), and T
means Transactional (bit 34)

If no bits are set, you get no TM[] output.

Include rework of printbits() to handle this case.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 75b6676..5fbe5d8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -934,10 +934,12 @@ static void show_instructions(struct pt_regs *regs)
 	printk("\n");
 }
 
-static struct regbit {
+struct regbit {
 	unsigned long bit;
 	const char *name;
-} msr_bits[] = {
+};
+
+static struct regbit msr_bits[] = {
 #if defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE)
 	{MSR_SF,	"SF"},
 	{MSR_HV,	"HV"},
@@ -967,16 +969,41 @@ static struct regbit {
 	{0,		NULL}
 };
 
-static void printbits(unsigned long val, struct regbit *bits)
+static void printbits(unsigned long val, struct regbit *bits, const char *sep)
 {
-	const char *sep = "";
+	const char *s = "";
 
-	printk("<");
 	for (; bits->bit; ++bits)
 		if (val & bits->bit) {
-			printk("%s%s", sep, bits->name);
-			sep = ",";
+			printk("%s%s", s, bits->name);
+			s = sep;
 		}
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static struct regbit msr_tm_bits[] = {
+	{MSR_TS_T,	"T"},
+	{MSR_TS_S,	"S"},
+	{MSR_TM,	"E"},
+	{0,		NULL}
+};
+static void printtmbits(unsigned long val)
+{
+	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
+		printk(",TM[");
+		printbits(val, msr_tm_bits, "");
+		printk("]");
+	}
+}
+#else
+static void printtmbits(unsigned long val) {}
+#endif
+
+static void printmsrbits(unsigned long val)
+{
+	printk("<");
+	printbits(val, msr_bits, ",");
+	printtmbits(val);
 	printk(">");
 }
 
@@ -1001,7 +1028,7 @@ void show_regs(struct pt_regs * regs)
 	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
 	printk("MSR: "REG" ", regs->msr);
-	printbits(regs->msr, msr_bits);
+	printmsrbits(regs->msr);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-- 
2.5.0
