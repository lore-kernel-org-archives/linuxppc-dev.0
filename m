Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF5D7B6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2010 23:54:32 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id oBECsTAu024317
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2010 18:24:29 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oBECsTPC4407480
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2010 18:24:29 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oBECsSIi020949
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2010 23:54:29 +1100
Date: Tue, 14 Dec 2010 18:24:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
Message-ID: <20101214125427.GA2443@in.ibm.com>
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org> <20101201043758.GA2219@in.ibm.com>
	<20101213082619.GA6582@in.ibm.com> <m2vd2x1ojj.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2vd2x1ojj.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 13, 2010 at 08:05:36PM +0100, Andreas Schwab wrote:
> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> 
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	/* Create a new breakpoint request if one doesn't exist already */
> > +	hw_breakpoint_init(&attr);
> > +	attr.bp_addr = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > +	arch_bp_generic_fields(bp_info->addr &
> > +				(DABR_DATA_WRITE | DABR_DATA_READ),
> > +							&attr.bp_type);
> > +
> > +	bp = register_user_hw_breakpoint(&attr, ptrace_triggered, task);
> > +	if (IS_ERR(bp))
> > +		return PTR_ERR(bp);
> > +
> > +	child->thread.ptrace_bps[0] = bp;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> > +
> >  	child->thread.dabr = (unsigned long)bp_info->addr;
> 
> That cannot work, see
> <http://permalink.gmane.org/gmane.linux.ports.ppc64.devel/71418>.
>

Ok. The above patch makes it a bit easy.

How about the revised patch below? It is only compile-tested; have you
got a quick test case that I can run?

Enable PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG to use the generic
hardware breakpoint interfaces. This helps prevent conflict for the use of
DABR register in the absence of CONFIG_PPC_ADV_DEBUG_REGS and when
PTRACE_SET_DEBUGREG/PTRACE_GET_DEBUGREG flags are used by ptrace.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Index: linux-2.6.set_hwdebug/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.set_hwdebug.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6.set_hwdebug/arch/powerpc/kernel/ptrace.c
@@ -1316,6 +1316,10 @@ static int set_dac_range(struct task_str
 static long ppc_set_hwdebug(struct task_struct *child,
 		     struct ppc_hw_breakpoint *bp_info)
 {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long dabr;
 #endif
@@ -1365,6 +1369,10 @@ static long ppc_set_hwdebug(struct task_
 
 	if (child->thread.dabr)
 		return -ENOSPC;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (child->thread.ptrace_bps[0])
+		return -ENOSPC;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
@@ -1376,6 +1384,20 @@ static long ppc_set_hwdebug(struct task_
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
 		dabr |= DABR_DATA_WRITE;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/* Create a new breakpoint request if one doesn't exist already */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = dabr & ~HW_BREAKPOINT_ALIGN;
+	arch_bp_generic_fields(dabr & (DABR_DATA_WRITE | DABR_DATA_READ),
+							&attr.bp_type);
+
+	bp = register_user_hw_breakpoint(&attr, ptrace_triggered, child);
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	child->thread.ptrace_bps[0] = bp;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 	child->thread.dabr = dabr;
 
 	return 1;
@@ -1405,6 +1427,16 @@ static long ppc_del_hwdebug(struct task_
 		return -EINVAL;
 	if (child->thread.dabr == 0)
 		return -ENOENT;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/*
+	 * There is no way by which address in ptrace_bps[0] and thread.dabr
+	 * can be different. So we don't explicitly check if they're the same
+	 */
+	if (child->thread.ptrace_bps[0]) {
+		unregister_hw_breakpoint(child->thread.ptrace_bps[0]);
+		child->thread.ptrace_bps[0] = NULL;
+	}
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	child->thread.dabr = 0;
 
