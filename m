Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4843AB708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 09:46:25 +1000 (EST)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD4E2DDDE1
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 09:46:24 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n68Nh6nn018361
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 17:43:06 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n68NkKjQ257498
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 17:46:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n68NkKRB021871
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2009 17:46:20 -0600
Subject: [PATCH] powerpc: fix booke user_disable_single_step()
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 18:46:18 -0500
Message-Id: <1247096778.22069.1.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On booke processors, gdb is seeing spurious SIGTRAPs when setting a
watchpoint.

user_disable_single_step() simply quits when the DAC is non-zero.  It should
be clearing the DBCR0_IC and DBCR0_BT bits from the dbcr0 register and
TIF_SINGLESTEP from the thread flag.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9fa2c7d..ef14988 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -736,15 +736,16 @@ void user_disable_single_step(struct task_struct *task)
 {
 	struct pt_regs *regs = task->thread.regs;
 
-
-#if defined(CONFIG_BOOKE)
-	/* If DAC then do not single step, skip */
-	if (task->thread.dabr)
-		return;
-#endif
-
 	if (regs != NULL) {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#if defined(CONFIG_BOOKE)
+		/* If DAC don't clear DBCRO_IDM or MSR_DE */
+		if (task->thread.dabr)
+			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT);
+		else {
+			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
+			regs->msr &= ~MSR_DE;
+		}
+#elif defined(CONFIG_40x)
 		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
 		regs->msr &= ~MSR_DE;
 #else

-- 
David Kleikamp
IBM Linux Technology Center
