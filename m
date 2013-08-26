Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D006A2C0107
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:37 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 16:25:47 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ABA392CE804D
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJVO2C459262
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:24 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJVYGV029273
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:35 +1000
Subject: [RFC PATCH v3 02/12] powerpc/book3s: Introduce exclusive emergency
 stack for machine check exception.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:01:32 +0530
Message-ID: <20130826193132.2855.85275.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch introduces exclusive emergency stack for machine check exception.
We use emergency stack to handle machine check exception so that we can save
MCE information (srr1, srr0, dar and dsisr) before turning on ME bit and be
ready for re-entrancy. This helps us to prevent clobbering of MCE information
in case of nested machine checks.

The reason for using emergency stack over normal kernel stack is that the
machine check might occur in the middle of setting up a stack frame which may
result into improper use of kernel stack.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h |    9 +++++++++
 arch/powerpc/kernel/setup_64.c  |   10 +++++++++-
 arch/powerpc/xmon/xmon.c        |    4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 77c91e7..b4ca4e9 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -147,6 +147,15 @@ struct paca_struct {
 	 */
 	struct opal_machine_check_event *opal_mc_evt;
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Exclusive emergency stack pointer for machine check exception. */
+	void *mc_emergency_sp;
+	/*
+	 * Flag to check whether we are in machine check early handler
+	 * and already using emergency stack.
+	 */
+	u16 in_mce;
+#endif
 
 	/* Stuff for accurate time accounting */
 	u64 user_time;			/* accumulated usermode TB ticks */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 389fb807..6f96af0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -529,7 +529,8 @@ static void __init exc_lvl_early_init(void)
 
 /*
  * Stack space used when we detect a bad kernel stack pointer, and
- * early in SMP boots before relocation is enabled.
+ * early in SMP boots before relocation is enabled. Exclusive emergency
+ * stack for machine checks.
  */
 static void __init emergency_stack_init(void)
 {
@@ -552,6 +553,13 @@ static void __init emergency_stack_init(void)
 		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
 		sp += THREAD_SIZE;
 		paca[i].emergency_sp = __va(sp);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+		/* emergency stack for machine check exception handling. */
+		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
+		sp += THREAD_SIZE;
+		paca[i].mc_emergency_sp = __va(sp);
+#endif
 	}
 }
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 96bf5bd..5f17adb 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2044,6 +2044,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_addr, "lx");
 #endif
 	DUMP(p, emergency_sp, "p");
+#ifdef CONFIG_PPC_BOOK3S_64
+	DUMP(p, mc_emergency_sp, "p");
+	DUMP(p, in_mce, "x");
+#endif
 	DUMP(p, data_offset, "lx");
 	DUMP(p, hw_cpu_id, "x");
 	DUMP(p, cpu_start, "x");
