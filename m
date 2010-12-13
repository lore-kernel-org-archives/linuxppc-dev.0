Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A947B6F11
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2010 19:26:25 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id oBD8QLIY011733
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2010 13:56:21 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oBD8QLax3051606
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2010 13:56:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oBD8QLmI026449
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2010 13:56:21 +0530
Date: Mon, 13 Dec 2010 13:56:19 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
Message-ID: <20101213082619.GA6582@in.ibm.com>
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org> <20101201043758.GA2219@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101201043758.GA2219@in.ibm.com>
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

On Wed, Dec 01, 2010 at 10:07:58AM +0530, K.Prasad wrote:
> On Mon, Nov 29, 2010 at 11:15:51AM +0100, Andreas Schwab wrote:
> > "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> > 
> > > Although ppc_set_hwdebug() can set DABR through set_dabr() in
> > > arch/powerpc/kernel/process.c, it is good to have it converted to use
> > > register_user_hw_breakpoint().
> > 
> > What do you mean with "good to have"?  It doesn't work without it unless
> > I disable PERF_EVENTS (which is the only way to disable
> > HAVE_HW_BREAKPOINT).
> > 
> > Andreas.
> >
> 
> Let me see if I can cook up a patch for this i.e. make set_dabr() invoke
> register_user_hw_breakpoint() when CONFIG_PPC_BOOK3S is defined; before I
> head out on my vacation (starting second week of this month).
> 
> Thanks,
> K.Prasad
>

Hi,
	Can you check if the following patch (compile tested only) works
for you?

Thanks,
K.Prasad
  
Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: linux-2.6.set_hwdebug/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.set_hwdebug.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6.set_hwdebug/arch/powerpc/kernel/ptrace.c
@@ -1316,6 +1316,11 @@ static int set_dac_range(struct task_str
 static long ppc_set_hwdebug(struct task_struct *child,
 		     struct ppc_hw_breakpoint *bp_info)
 {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 	if (bp_info->version != 1)
 		return -ENOTSUPP;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -1362,10 +1367,29 @@ static long ppc_set_hwdebug(struct task_
 
 	if (child->thread.dabr)
 		return -ENOSPC;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (child->thread->ptrace_bps[0])
+		return -ENOSPC;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/* Create a new breakpoint request if one doesn't exist already */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+	arch_bp_generic_fields(bp_info->addr &
+				(DABR_DATA_WRITE | DABR_DATA_READ),
+							&attr.bp_type);
+
+	bp = register_user_hw_breakpoint(&attr, ptrace_triggered, task);
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	child->thread.ptrace_bps[0] = bp;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 	child->thread.dabr = (unsigned long)bp_info->addr;
 
 	return 1;
@@ -1395,6 +1419,16 @@ static long ppc_del_hwdebug(struct task_
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
 
