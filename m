Return-Path: <jdub@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3273267B8B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 04:56:44 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k86IucCt006364
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 14:56:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k86Iuc5B240410
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 12:56:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k86IucGK008497
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 12:56:38 -0600
Subject: [PATCH] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jdub@us.ibm.com>
To: mporter@embeddedalley.com, paulus@samba.org
Content-Type: text/plain
Date: Wed, 06 Sep 2006 13:58:03 -0500
Message-Id: <1157569083.6098.29.camel@zod.rchland.ibm.com>
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

Hi All,

The following patch allows XMON to run on the 4xx platform.  Tested on
Walnut, Ebony, and Nova (440GX based) eval boards.  Patch is against
2.6.18-rc6.

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 arch/ppc/xmon/start.c |    6 ++++++
 arch/ppc/xmon/xmon.c  |   24 ++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

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
@@ -254,10 +260,16 @@ int xmon(struct pt_regs *excp)
 	cmd = cmds(excp);
 	if (cmd == 's') {
 		xmon_trace[smp_processor_id()] = SSTEP;
-		excp->msr |= 0x400;
+		excp->msr |= MSR_SSTEP_ENABLE;
+#ifdef CONFIG_4xx
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#endif
 	} else if (at_breakpoint(excp->nip)) {
 		xmon_trace[smp_processor_id()] = BRSTEP;
-		excp->msr |= 0x400;
+		excp->msr |= MSR_SSTEP_ENABLE;
+#ifdef CONFIG_4xx
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#endif
 	} else {
 		xmon_trace[smp_processor_id()] = 0;
 		insert_bpts();
@@ -298,7 +310,7 @@ xmon_bpt(struct pt_regs *regs)
 		remove_bpts();
 		excprint(regs);
 		xmon_trace[smp_processor_id()] = BRSTEP;
-		regs->msr |= 0x400;
+		regs->msr |= MSR_SSTEP_ENABLE;
 	} else {
 		xmon(regs);
 	}
@@ -385,7 +397,7 @@ insert_bpts(void)
 		}
 		store_inst((void *) bp->address);
 	}
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	if (dabr.enabled)
 		set_dabr(dabr.address);
 	if (iabr.enabled)
@@ -400,7 +412,7 @@ remove_bpts(void)
 	struct bpt *bp;
 	unsigned instr;
 
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	set_dabr(0);
 	set_iabr(0);
 #endif
@@ -677,7 +689,7 @@ bpt_cmds(void)
 
 	cmd = inchar();
 	switch (cmd) {
-#if !defined(CONFIG_8xx)
+#if ! (defined(CONFIG_8xx) || defined(CONFIG_4xx))
 	case 'd':
 		mode = 7;
 		cmd = inchar();
--- linux-2.6.orig/arch/ppc/xmon/start.c
+++ linux-2.6/arch/ppc/xmon/start.c
@@ -73,6 +73,12 @@ xmon_map_scc(void)
 	TXRDY = 0x20;
 	RXRDY = 1;
 	DLAB = 0x80;
+#elif ( defined(CONFIG_440) || defined(CONFIG_440GX) )
+	sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
+	sccc = sccd + 5;
+	TXRDY = 0x20;
+	RXRDY = 1;
+	DLAB = 0x80;
 #endif /* platform */
 
 	register_sysrq_key('x', &sysrq_xmon_op);
