Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A4D7B6F70
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 19:36:04 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7Q9Z1iX005900
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 19:35:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7Q9ZwXA1966330
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 19:35:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7Q9ZvlI008802
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 19:35:57 +1000
Date: Fri, 26 Aug 2011 15:05:52 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
	for new PPC ptrace flags
Message-ID: <20110826093552.GA2301@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075136.GB21817@in.ibm.com>
	<20110823050850.GS30097@yookeroo.fritz.box>
	<20110823092513.GA2962@in.ibm.com>
	<20110824035939.GB30097@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110824035939.GB30097@yookeroo.fritz.box>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2011 at 01:59:39PM +1000, David Gibson wrote:
> On Tue, Aug 23, 2011 at 02:55:13PM +0530, K.Prasad wrote:
> > On Tue, Aug 23, 2011 at 03:08:50PM +1000, David Gibson wrote:
> > > On Fri, Aug 19, 2011 at 01:21:36PM +0530, K.Prasad wrote:
> > > > PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
> > > > PowerPC specific ptrace flags that use the watchpoint register. While they are
> > > > targeted primarily towards BookE users, user-space applications such as GDB
> > > > have started using them for BookS too.
> > > > 
> > > > This patch enables the use of generic hardware breakpoint interfaces for these
> > > > new flags. The version number of the associated data structures
> > > > "ppc_hw_breakpoint" and "ppc_debug_info" is incremented to denote new semantics.
> > > 
> > > So, the structure itself doesn't seem to have been extended.  I don't
> > > understand what the semantic difference is - your patch comment needs
> > > to explain this clearly.
> > >
> > 
> > We had a request to extend the structure but thought it was dangerous to
> > do so. For instance if the user-space used version1 of the structure,
> > while kernel did a copy_to_user() pertaining to version2, then we'd run
> > into problems. Unfortunately the ptrace flags weren't designed to accept
> > a version number as input from the user through the
> > PPC_PTRACE_GETHWDBGINFO flag (which would have solved this issue).
> 
> I still don't follow you.
> 

Two things here.

One, the change of semantics warranted an increment of the version
number. The new semantics accepts PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE on
BookS, while the old version number did not. I've added a small comment
in the code to this effect.

Two, regarding changes in the "ppc_hw_breakpoint" and "ppc_debug_info"
structures - we would like to add more members to it if we can (GDB has a
pending request to add more members to it). However the problem foreseen
is that there could be a mismatch between the versions of the structure
used by the user vs kernel-space i.e. if a new version of the structure,
known to the kernel, had an extra member while the user-space still had
the old version, then it becomes dangerous because the __copy_to_user
function would overflow the buffer size in user-space.

This could have been avoided if PPC_PTRACE_GETHWDBGINFO was originally
designed to accept a version number (and provide corresponding
"struct ppc_debug_info") rather than send a populated "ppc_debug_info"
structure along with the version number.

> > I'll add a comment w.r.t change in semantics - such as the ability to
> > accept 'range' breakpoints in BookS.
> >  
> > > > Apart from the usual benefits of using generic hw-breakpoint interfaces, these
> > > > changes allow debuggers (such as GDB) to use a common set of ptrace flags for
> > > > their watchpoint needs and allow more precise breakpoint specification (length
> > > > of the variable can be specified).
> > > 
> > > What is the mechanism for implementing the range breakpoint on book3s?
> > > 
> > 
> > The hw-breakpoint interface, accepts length as an argument in BookS (any
> > value <= 8 Bytes) and would filter out extraneous interrupts arising out
> > of accesses outside the range comprising <addr, addr + len> inside
> > hw_breakpoint_handler function.
> > 
> > We put that ability to use here.
> 
> Ah, so in hardware the breakpoints are always 8 bytes long, but you
> filter out false hits on a shorter range?  Of course, the utility of
> range breakpoints is questionable when length <=8, but the start must
> be aligned on an 8-byte boundary.
> 

Yes, we ensure that through 
+	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;

> [snip]
> > > >  	if ((unsigned long)bp_info->addr >= TASK_SIZE)
> > > >  		return -EIO;
> > > >  
> > > > @@ -1398,15 +1400,86 @@ static long ppc_set_hwdebug(struct task_struct *child,
> > > >  		dabr |= DABR_DATA_READ;
> > > >  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> > > >  		dabr |= DABR_DATA_WRITE;
> > > > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > > > +	if (bp_info->version == 1)
> > > > +		goto version_one;
> > > 
> > > There are several legitimate uses of goto in the kernel, but this is
> > > definitely not one of them.  You're essentially using it to put the
> > > old and new versions of the same function in one block.  Nasty.
> > > 
> > 
> > Maybe it's the label that's causing bother here. It might look elegant
> > if it was called something like exit_* or error_* :-)
> > 
> > The goto here helps reduce code, is similar to the error exits we use
> > everywhere.
> 
> Rubbish, it is not an exception exit at all, it is two separate code
> paths for the different versions which would be much clearer as two
> different functions.
> 

I've re-written this part of the code to avoid a goto statement.

> > > > +	if (ptrace_get_breakpoints(child) < 0)
> > > > +		return -ESRCH;
> > > >  
> > > > -	child->thread.dabr = dabr;
> > > > +	bp = thread->ptrace_bps[0];
> > > > +	if (!bp_info->addr) {
> > > > +		if (bp) {
> > > > +			unregister_hw_breakpoint(bp);
> > > > +			thread->ptrace_bps[0] = NULL;
> > > > +		}
> > > > +		ptrace_put_breakpoints(child);
> > > > +		return 0;
> > > 
> > > Why are you making setting a 0 watchpoint remove the existing one (I
> > > think that's what this does).  I thought there was an explicit del
> > > breakpoint operation instead.
> > 
> > We had to define the semantics for what writing a 0 to DABR could mean,
> > and I think it is intuitive to consider it as deletion
> > request...couldn't think of a case where DABR with addr=0 and RW=1 would
> > be required.
> 
> When a user space program maps pages at virtual address 0, which it
> can do.
> 

Agreed. I've removed the code under if (!bp_info->addr) branch.

> > > > +	}
> > > > +	/*
> > > > +	 * Check if the request is for 'range' breakpoints. We can
> > > > +	 * support it if range < 8 bytes.
> > > > +	 */
> > > > +	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
> > > > +		len = bp_info->addr2 - bp_info->addr;
> > > 
> > > So you compute the length here, but I don't see you ever test if it is
> > > < 8 and return an error.
> > > 
> > 
> > The hw-breakpoint interfaces would fail if the length was > 8.
> 
> Ok.
> 
> > > > +	else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
> > > > +			ptrace_put_breakpoints(child);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	if (bp) {
> > > > +		attr = bp->attr;
> > > > +		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > > > +		arch_bp_generic_fields(dabr &
> > > > +					(DABR_DATA_WRITE | DABR_DATA_READ),
> > > > +							&attr.bp_type);
> > > > +		attr.bp_len = len;
> > > > +		ret =  modify_user_hw_breakpoint(bp, &attr);
> > > > +		if (ret) {
> > > > +			ptrace_put_breakpoints(child);
> > > > +			return ret;
> > > > +		}
> > > > +		thread->ptrace_bps[0] = bp;
> > > > +		ptrace_put_breakpoints(child);
> > > > +		thread->dabr = dabr;
> > > > +		return 0;
> > > > +	}
> > > >  
> > > > +	/* Create a new breakpoint request if one doesn't exist already */
> > > > +	hw_breakpoint_init(&attr);
> > > > +	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > > 
> > > You seem to be silently masking the given address, which seems
> > > completely wrong.
> > > 
> > 
> > We have two ways of looking at the input address.
> > a) Assume that the input address is not multiplexed with the read/write
> > bits and return -EINVAL (for not confirming to the 8-byte alignment
> > requirement).
> > b) Consider the input address to be encoded with the read/write
> > watchpoint type request and align the address by default. This is how
> > the code behaves presently for the !CONFIG_HAVE_HW_BREAKPOINT case.
> 
> Hrm, ok, but this needs commenting.
> 

Added a comment to this effect.

I'm pasting the modified patch below. Kindly let me know your comments.

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

diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
index f4a5499..97301ae 100644
--- a/Documentation/powerpc/ptrace.txt
+++ b/Documentation/powerpc/ptrace.txt
@@ -127,6 +127,22 @@ Some examples of using the structure to:
   p.addr2           = (uint64_t) end_range;
   p.condition_value = 0;
 
+- set a watchpoint in server processors (BookS) using version 2
+
+  p.version         = 2;
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
index 05b7dd2..f9a4548 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1339,11 +1339,17 @@ static int set_dac_range(struct task_struct *child,
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
 
-	if (bp_info->version != 1)
+	if ((bp_info->version != 1) && (bp_info->version != 2))
 		return -ENOTSUPP;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	/*
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
 
@@ -1399,14 +1401,84 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
 		dabr |= DABR_DATA_WRITE;
 
-	child->thread.dabr = dabr;
+	if (bp_info->version == 1) {
+		if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
+			return -EINVAL;
+		if (child->thread.dabr)
+			return -ENOSPC;
+		child->thread.dabr = dabr;
+		return 1;
+	}
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/*
+	 * We will use version = 2, to denote the use of
+	 * PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE mode of watchpoints.
+	 */
+	if (bp_info->version != 2)
+		return -EINVAL;
+	if (ptrace_get_breakpoints(child) < 0)
+		return -ESRCH;
 
+	bp = thread->ptrace_bps[0];
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
+		/*
+		 * Consider the input address to be encoded with the read/write
+		 * watchpoint type request and align the address by default.
+		 */
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
+
+	ptrace_put_breakpoints(child);
 	return 1;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
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
 
@@ -1426,10 +1498,24 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
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
@@ -1536,7 +1622,8 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PPC_PTRACE_GETHWDBGINFO: {
 		struct ppc_debug_info dbginfo;
 
-		dbginfo.version = 1;
+		/* We return the highest version number supported */
+		dbginfo.version = 2;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		dbginfo.num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
 		dbginfo.num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
@@ -1560,7 +1647,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		dbginfo.data_bp_alignment = 4;
 #endif
 		dbginfo.sizeof_condition = 0;
-		dbginfo.features = 0;
+		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 		if (!access_ok(VERIFY_WRITE, datavp,
