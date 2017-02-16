Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPRZK6yt8zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:49:45 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GJndGj023437
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:49:43 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nfhtywfx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:49:43 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 17 Feb 2017 05:49:40 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4F1912BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:49:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GJnPL433358052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:49:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GJn11i029612
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:49:01 +1100
Date: Fri, 17 Feb 2017 01:18:41 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: add support for KPROBES_ON_FTRACE
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170215042814.GA4660@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170215042814.GA4660@in.ibm.com>
Message-Id: <20170216194841.GE4515@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/15 09:58AM, Ananth N Mavinakayanahalli wrote:
> On Wed, Feb 15, 2017 at 12:28:34AM +0530, Naveen N. Rao wrote:
> > Allow kprobes to be placed on ftrace _mcount() call sites. This
> > optimization avoids the use of a trap, by riding on ftrace
> > infrastructure.
> > 
> > This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> > MPROFILE_KERNEL, which is only currently enabled on powerpc64le with
> > newer toolchains.
> > 
> > Based on the x86 code by Masami.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/Kconfig                 |   1 +
> >  arch/powerpc/include/asm/kprobes.h   |  10 ++++
> >  arch/powerpc/kernel/Makefile         |   3 ++
> >  arch/powerpc/kernel/kprobes-ftrace.c | 100 +++++++++++++++++++++++++++++++++++
> >  arch/powerpc/kernel/kprobes.c        |   4 +-
> >  arch/powerpc/kernel/optprobes.c      |   3 ++
> >  6 files changed, 120 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c
> 
> You'll also need to update
> Documentation/features/debug/kprobes-on-ftrace/arch-support.txt

Sure.

> 
> > +/* Ftrace callback handler for kprobes */
> > +void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> > +			   struct ftrace_ops *ops, struct pt_regs *regs)
> > +{
> > +	struct kprobe *p;
> > +	struct kprobe_ctlblk *kcb;
> > +	unsigned long flags;
> > +
> > +	/* Disable irq for emulating a breakpoint and avoiding preempt */
> > +	local_irq_save(flags);
> > +	hard_irq_disable();
> > +
> > +	p = get_kprobe((kprobe_opcode_t *)nip);
> > +	if (unlikely(!p) || kprobe_disabled(p))
> > +		goto end;
> > +
> > +	kcb = get_kprobe_ctlblk();
> > +	if (kprobe_running()) {
> > +		kprobes_inc_nmissed_count(p);
> > +	} else {
> > +		unsigned long orig_nip = regs->nip;
> > +		/* Kprobe handler expects regs->nip = nip + 1 as breakpoint hit */
> 
> Can you clarify this? On powerpc, the regs->nip at the time of
> breakpoint hit points to the probed instruction, not the one after.

Ah -- great catch! As it turns out, we actually need to set this back by 
an instruction due to the way ftrace works. I'll make the change.


Thanks,
Naveen
