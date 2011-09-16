Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58F40B70D6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 17:27:20 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8G7RHYU019850
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 17:27:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8G7PUEh1585316
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 17:25:30 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8G7RGsP018416
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 17:27:16 +1000
Date: Fri, 16 Sep 2011 12:57:10 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
	David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
	for new PPC ptrace flags
Message-ID: <20110916072710.GA28060@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075136.GB21817@in.ibm.com>
	<20110823050850.GS30097@yookeroo.fritz.box>
	<20110823092513.GA2962@in.ibm.com>
	<20110824035939.GB30097@yookeroo.fritz.box>
	<20110826093552.GA2301@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110826093552.GA2301@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2011 at 03:05:52PM +0530, K.Prasad wrote:
> On Wed, Aug 24, 2011 at 01:59:39PM +1000, David Gibson wrote:
> > On Tue, Aug 23, 2011 at 02:55:13PM +0530, K.Prasad wrote:
> > > On Tue, Aug 23, 2011 at 03:08:50PM +1000, David Gibson wrote:
> > > > On Fri, Aug 19, 2011 at 01:21:36PM +0530, K.Prasad wrote:
> > > > > PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
> > > > > PowerPC specific ptrace flags that use the watchpoint register. While they are
> > > > > targeted primarily towards BookE users, user-space applications such as GDB
> > > > > have started using them for BookS too.
> > > > > 
> > > > > This patch enables the use of generic hardware breakpoint interfaces for these
> > > > > new flags. The version number of the associated data structures
> > > > > "ppc_hw_breakpoint" and "ppc_debug_info" is incremented to denote new semantics.
> > > > 
> > > > So, the structure itself doesn't seem to have been extended.  I don't
> > > > understand what the semantic difference is - your patch comment needs
> > > > to explain this clearly.
> > > >
> > > 
> > > We had a request to extend the structure but thought it was dangerous to
> > > do so. For instance if the user-space used version1 of the structure,
> > > while kernel did a copy_to_user() pertaining to version2, then we'd run
> > > into problems. Unfortunately the ptrace flags weren't designed to accept
> > > a version number as input from the user through the
> > > PPC_PTRACE_GETHWDBGINFO flag (which would have solved this issue).
> > 
> > I still don't follow you.
> > 
> 
> Two things here.
> 
> One, the change of semantics warranted an increment of the version
> number. The new semantics accepts PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE on
> BookS, while the old version number did not. I've added a small comment
> in the code to this effect.
> 
> Two, regarding changes in the "ppc_hw_breakpoint" and "ppc_debug_info"
> structures - we would like to add more members to it if we can (GDB has a
> pending request to add more members to it). However the problem foreseen
> is that there could be a mismatch between the versions of the structure
> used by the user vs kernel-space i.e. if a new version of the structure,
> known to the kernel, had an extra member while the user-space still had
> the old version, then it becomes dangerous because the __copy_to_user
> function would overflow the buffer size in user-space.
> 
> This could have been avoided if PPC_PTRACE_GETHWDBGINFO was originally
> designed to accept a version number (and provide corresponding
> "struct ppc_debug_info") rather than send a populated "ppc_debug_info"
> structure along with the version number.
>

Based on further discussions with the code-reviewer (David Gibson
<dwg@au1.ibm.com>), it was decided that incrementing the version number
for the proposed changes is unnecessary as the patch only introduces new
features but not a change in semantics.

Please find a new version of the patch where the version number is
retained as 1, along with the other planned changes.

Thanks,
K.Prasad

 
    [hw-breakpoint] Use generic hw-breakpoint interfaces for new PPC ptrace flags
    
    PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
    PowerPC specific ptrace flags that use the watchpoint register. While they are
    targeted primarily towards BookE users, user-space applications such as GDB
    have started using them for BookS too.
    
    This patch enables the use of generic hardware breakpoint interfaces for these
    new flags. The version number of the associated data structures
    "ppc_hw_breakpoint" and "ppc_debug_info" is incremented to denote new semantics.
    
    Apart from the usual benefits of using generic hw-breakpoint interfaces, these
    changes allow debuggers (such as GDB) to use a common set of ptrace flags for
    their watchpoint needs and allow more precise breakpoint specification (length
    of the variable can be specified).
    
    [Edjunior: Identified an issue in the patch with the sanity check for version
    numbers]
    
    Tested-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
    Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>

diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
index f4a5499..04656ec 100644
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
+  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_EXACT;
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
index 05b7dd2..2449495 100644
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
 
@@ -1398,15 +1400,83 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		dabr |= DABR_DATA_READ;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
 		dabr |= DABR_DATA_WRITE;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (ptrace_get_breakpoints(child) < 0)
+		return -ESRCH;
 
-	child->thread.dabr = dabr;
+	bp = thread->ptrace_bps[0];
+	if (!bp_info->addr) {
+		if (bp) {
+			unregister_hw_breakpoint(bp);
+			thread->ptrace_bps[0] = NULL;
+		}
+		ptrace_put_breakpoints(child);
+		return 0;
+	}
+	/*
+	 * Check if the request is for 'range' breakpoints. We can
+	 * support it if range < 8 bytes.
+	 */
+	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
+		len = bp_info->addr2 - bp_info->addr;
+	else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
+			ptrace_put_breakpoints(child);
+			return -EINVAL;
+		}
+	if (bp) {
+		attr = bp->attr;
+		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+		arch_bp_generic_fields(dabr &
+					(DABR_DATA_WRITE | DABR_DATA_READ),
+							&attr.bp_type);
+		attr.bp_len = len;
+		ret =  modify_user_hw_breakpoint(bp, &attr);
+		if (ret) {
+			ptrace_put_breakpoints(child);
+			return ret;
+		}
+		thread->ptrace_bps[0] = bp;
+		ptrace_put_breakpoints(child);
+		thread->dabr = dabr;
+		return 0;
+	}
 
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
+
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
+	struct thread_struct *thread = &(child->thread);
+	struct perf_event *bp;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	int rc;
 
@@ -1426,10 +1496,24 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
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
+	}
+	ptrace_put_breakpoints(child);
+	return 0;
+#else /* CONFIG_HAVE_HW_BREAKPOINT */
 	if (child->thread.dabr == 0)
 		return -ENOENT;
 
 	child->thread.dabr = 0;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	return 0;
 #endif
@@ -1560,7 +1644,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		dbginfo.data_bp_alignment = 4;
 #endif
 		dbginfo.sizeof_condition = 0;
-		dbginfo.features = 0;
+		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 		if (!access_ok(VERIFY_WRITE, datavp,
