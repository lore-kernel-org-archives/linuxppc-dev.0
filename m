Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 099E51007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 22:20:13 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Thu, 8 Dec 2011 09:20:02 -0200
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB8BKjcw3657786
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:20:45 -0200
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB8BJvxw025557
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:19:58 -0200
Date: Thu, 8 Dec 2011 16:49:48 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Subject: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces for
 new PPC ptrace flags
Message-ID: <20111208111948.GA24484@in.ibm.com>
References: <20111208111212.GB3720@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111208111212.GB3720@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
PowerPC specific ptrace flags that use the watchpoint register. While they are
targeted primarily towards BookE users, user-space applications such as GDB
have started using them for BookS too. This patch enables the use of generic
hardware breakpoint interfaces for these new flags.

Apart from the usual benefits of using generic hw-breakpoint interfaces, these
changes allow debuggers (such as GDB) to use a common set of ptrace flags for
their watchpoint needs and allow more precise breakpoint specification (length
of the variable can be specified).

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 Documentation/powerpc/ptrace.txt |   16 ++++++++
 arch/powerpc/kernel/ptrace.c     |   77 +++++++++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
index f4a5499..f2a7a39 100644
--- a/Documentation/powerpc/ptrace.txt
+++ b/Documentation/powerpc/ptrace.txt
@@ -127,6 +127,22 @@ Some examples of using the structure to:
   p.addr2           = (uint64_t) end_range;
   p.condition_value = 0;
 
+- set a watchpoint in server processors (BookS)
+
+  p.version         = 1;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+  or
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) begin_range;
+  /* For PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE addr2 needs to be specified, where
+   * addr2 - addr <= 8 Bytes.
+   */
+  p.addr2           = (uint64_t) end_range;
+  p.condition_value = 0;
+
 3. PTRACE_DELHWDEBUG
 
 Takes an integer which identifies an existing breakpoint or watchpoint
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 05b7dd2..cd41c78 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1339,6 +1339,12 @@ static int set_dac_range(struct task_struct *child,
 static long ppc_set_hwdebug(struct task_struct *child,
 		     struct ppc_hw_breakpoint *bp_info)
 {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	int ret, len = 0;
+	struct thread_struct *thread = &(child->thread);
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long dabr;
 #endif
@@ -1382,13 +1388,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	 */
 	if ((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0 ||
 	    (bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0 ||
-	    bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT ||
 	    bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
 		return -EINVAL;
 
-	if (child->thread.dabr)
-		return -ENOSPC;
-
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
@@ -1398,15 +1400,63 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		dabr |= DABR_DATA_READ;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
 		dabr |= DABR_DATA_WRITE;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (ptrace_get_breakpoints(child) < 0)
+		return -ESRCH;
 
-	child->thread.dabr = dabr;
+	/*
+	 * Check if the request is for 'range' breakpoints. We can
+	 * support it if range < 8 bytes.
+	 */
+	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE) {
+		len = bp_info->addr2 - bp_info->addr;
+	} else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
+		ptrace_put_breakpoints(child);
+		return -EINVAL;
+	}
+	bp = thread->ptrace_bps[0];
+	if (bp) {
+		ptrace_put_breakpoints(child);
+		return -ENOSPC;
+	}
+
+	/* Create a new breakpoint request if one doesn't exist already */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+	attr.bp_len = len;
+	arch_bp_generic_fields(dabr & (DABR_DATA_WRITE | DABR_DATA_READ),
+								&attr.bp_type);
+
+	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
+					       ptrace_triggered, NULL, child);
+	if (IS_ERR(bp)) {
+		thread->ptrace_bps[0] = NULL;
+		ptrace_put_breakpoints(child);
+		return PTR_ERR(bp);
+	}
 
+	ptrace_put_breakpoints(child);
+	return 1;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
+	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
+		return -EINVAL;
+
+	if (child->thread.dabr)
+		return -ENOSPC;
+
+	child->thread.dabr = dabr;
 	return 1;
 #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
 }
 
 static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
 {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	int ret = 0;
+	struct thread_struct *thread = &(child->thread);
+	struct perf_event *bp;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	int rc;
 
@@ -1426,10 +1476,25 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
 #else
 	if (data != 1)
 		return -EINVAL;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (ptrace_get_breakpoints(child) < 0)
+		return -ESRCH;
+
+	bp = thread->ptrace_bps[0];
+	if (bp) {
+		unregister_hw_breakpoint(bp);
+		thread->ptrace_bps[0] = NULL;
+	} else
+		ret = -ENOENT;
+	ptrace_put_breakpoints(child);
+	return ret;
+#else /* CONFIG_HAVE_HW_BREAKPOINT */
 	if (child->thread.dabr == 0)
 		return -ENOENT;
 
 	child->thread.dabr = 0;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	return 0;
 #endif
@@ -1560,7 +1625,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		dbginfo.data_bp_alignment = 4;
 #endif
 		dbginfo.sizeof_condition = 0;
-		dbginfo.features = 0;
+		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 		if (!access_ok(VERIFY_WRITE, datavp,
-- 
1.7.4.1
