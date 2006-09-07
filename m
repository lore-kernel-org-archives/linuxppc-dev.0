Return-Path: <jdub@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0735967B7C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 04:26:35 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87IQS1C006568
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 14:26:28 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87IQSXk324992
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 12:26:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87IQSQa030470
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 12:26:28 -0600
Subject: [PATCH] [v4] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jdub@us.ibm.com>
To: mporter@embeddedalley.com, paulus@samba.org
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:27:58 -0500
Message-Id: <1157653678.6098.65.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch allows XMON to run on the 4xx platform.  Tested on
Walnut, Ebony, and Nova (440GX based) eval boards.  440EP, 440SP, and
440SPE boards should work as well.  Patch is against 2.6.18-rc6.

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 arch/ppc/xmon/start.c |   28 ++++++++++++++++++----------
 arch/ppc/xmon/xmon.c  |   26 ++++++++++++++++++++------
 2 files changed, 38 insertions(+), 16 deletions(-)

--- linux-2.6.orig/arch/ppc/xmon/xmon.c
+++ linux-2.6/arch/ppc/xmon/xmon.c
@@ -153,6 +153,12 @@ static int xmon_trace[NR_CPUS];
 #define SSTEP	1		/* stepping because of 's' command */
 #define BRSTEP	2		/* stepping over breakpoint */
 
+#ifdef CONFIG_4xx
+#define MSR_SSTEP_ENABLE 0x200
+#else
+#define MSR_SSTEP_ENABLE 0x400
+#endif
+
 static struct pt_regs *xmon_regs[NR_CPUS];
 
 extern inline void sync(void)
@@ -211,6 +217,14 @@ static void get_tb(unsigned *p)
 	p[1] = lo;
 }
 
+static inline void xmon_enable_sstep(struct pt_regs *regs)
+{
+	regs->msr |= MSR_SSTEP_ENABLE;
+#ifdef CONFIG_4xx
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#endif
+}
+
 int xmon(struct pt_regs *excp)
 {
 	struct pt_regs regs;
@@ -254,10 +268,10 @@ int xmon(struct pt_regs *excp)
 	cmd = cmds(excp);
 	if (cmd == 's') {
 		xmon_trace[smp_processor_id()] = SSTEP;
-		excp->msr |= 0x400;
+		xmon_enable_sstep(excp);
 	} else if (at_breakpoint(excp->nip)) {
 		xmon_trace[smp_processor_id()] = BRSTEP;
-		excp->msr |= 0x400;
+		xmon_enable_sstep(excp);
 	} else {
 		xmon_trace[smp_processor_id()] = 0;
 		insert_bpts();
@@ -298,7 +312,7 @@ xmon_bpt(struct pt_regs *regs)
 		remove_bpts();
 		excprint(regs);
 		xmon_trace[smp_processor_id()] = BRSTEP;
-		regs->msr |= 0x400;
+		xmon_enable_sstep(regs);
 	} else {
 		xmon(regs);
 	}
@@ -385,7 +399,7 @@ insert_bpts(void)
 		}
 		store_inst((void *) bp->address);
 	}
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	if (dabr.enabled)
 		set_dabr(dabr.address);
 	if (iabr.enabled)
@@ -400,7 +414,7 @@ remove_bpts(void)
 	struct bpt *bp;
 	unsigned instr;
 
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	set_dabr(0);
 	set_iabr(0);
 #endif
@@ -677,7 +691,7 @@ bpt_cmds(void)
 
 	cmd = inchar();
 	switch (cmd) {
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	case 'd':
 		mode = 7;
 		cmd = inchar();
--- linux-2.6.orig/arch/ppc/xmon/start.c
+++ linux-2.6/arch/ppc/xmon/start.c
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/btext.h>
+#include <asm/ibm4xx.h>
 
 static volatile unsigned char *sccc, *sccd;
 unsigned int TXRDY, RXRDY, DLAB;
@@ -57,23 +58,30 @@ static struct sysrq_key_op sysrq_xmon_op
 void
 xmon_map_scc(void)
 {
-#ifdef CONFIG_PPC_PREP
-	volatile unsigned char *base;
-
-#elif defined(CONFIG_GEMINI)
+#if defined(CONFIG_GEMINI)
 	/* should already be mapped by the kernel boot */
-	sccc = (volatile unsigned char *) 0xffeffb0d;
 	sccd = (volatile unsigned char *) 0xffeffb08;
-	TXRDY = 0x20;
-	RXRDY = 1;
-	DLAB = 0x80;
 #elif defined(CONFIG_405GP)
-	sccc = (volatile unsigned char *)0xef600305;
 	sccd = (volatile unsigned char *)0xef600300;
+#elif defined(CONFIG_440EP)
+	sccd = (volatile unsigned char *) ioremap(PPC440EP_UART0_ADDR, 8);
+#elif defined(CONFIG_440SP)
+	sccd = (volatile unsigned char *) ioremap64(PPC440SP_UART0_ADDR, 8);
+#elif defined(CONFIG_440SPE)
+	sccd = (volatile unsigned char *) ioremap64(PPC440SPE_UART0_ADDR, 8);
+#elif defined(CONFIG_44x)
+	/* This is the default for 44x platforms.  Any boards that have a
+	   different UART address need to be put in cases before this or the
+	   port will be mapped incorrectly */
+	sccd = (volatile unsigned char *) ioremap64(PPC440GP_UART0_ADDR, 8);
+#endif /* platform */
+
+#ifndef CONFIG_PPC_PREP
+	sccc = sccd + 5;
 	TXRDY = 0x20;
 	RXRDY = 1;
 	DLAB = 0x80;
-#endif /* platform */
+#endif
 
 	register_sysrq_key('x', &sysrq_xmon_op);
 }
