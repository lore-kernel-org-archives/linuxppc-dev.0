Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/13] powerpc/476: add machine check handler for 47x core
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100505125905.GH29593@zod.rchland.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
	<20100305204318.18424.77960.sendpatchset@norville.austin.ibm.com>
	<20100505122701.GG29593@zod.rchland.ibm.com>
	<20100505125905.GH29593@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 05 May 2010 08:05:56 -0500
Message-Id: <1273064756.20294.22.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-05 at 08:59 -0400, Josh Boyer wrote:
> On Wed, May 05, 2010 at 08:27:01AM -0400, Josh Boyer wrote:
> >>+int machine_check_47x(struct pt_regs *regs)
> >>+{
> >>+	unsigned long reason = get_mc_reason(regs);
> >>+	u32 mcsr;
> >>+
> >>+	printk(KERN_ERR "Machine check in kernel mode.\n");
> >>+	if (reason & ESR_IMCP) {
> >>+		printk(KERN_ERR
> >>+		       "Instruction Synchronous Machine Check exception\n");
> >>+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
> >>+		return 0;
> >>+	}
> >>+	mcsr = mfspr(SPRN_MCSR);
> >>+	if (mcsr & MCSR_IB)
> >>+		printk(KERN_ERR "Instruction Read PLB Error\n");
> >>+	if (mcsr & MCSR_DRB)
> >>+		printk(KERN_ERR "Data Read PLB Error\n");
> >>+	if (mcsr & MCSR_DWB)
> >>+		printk(KERN_ERR "Data Write PLB Error\n");
> >>+	if (mcsr & MCSR_TLBP)
> >>+		printk(KERN_ERR "TLB Parity Error\n");
> >>+	if (mcsr & MCSR_ICP) {
> >>+		flush_instruction_cache();
> >>+		printk(KERN_ERR "I-Cache Parity Error\n");
> >>+	}
> >>+	if (mcsr & MCSR_DCSP)
> >>+		printk(KERN_ERR "D-Cache Search Parity Error\n");
> >>+	if (mcsr & PPC47x_MCSR_GPR)
> >>+		printk(KERN_ERR "GPR Parity Error\n");
> >>+	if (mcsr & PPC47x_MCSR_FPR)
> >>+		printk(KERN_ERR "FPR Parity Error\n");
> >>+	if (mcsr & PPC47x_MCSR_IPR)
> >>+		printk(KERN_ERR "Machine Check exception is imprecise\n");
> >
> >This function isn't guarded by CONFIG_PPC_47x, however the defines for 
> >PPC47x_MCSR_* are in include/asm/reg_booke.h.  They were added that way in patch
> >4.  As it stands, we get this when trying to build for plain 44x:
> >
> > CC      arch/powerpc/kernel/traps.o
> >arch/powerpc/kernel/traps.c: In function 'machine_check_47x':
> >arch/powerpc/kernel/traps.c:411: error: 'PPC47x_MCSR_GPR' undeclared (first use in this function)
> >arch/powerpc/kernel/traps.c:411: error: (Each undeclared identifier is reported only once
> >arch/powerpc/kernel/traps.c:411: error: for each function it appears in.)
> >arch/powerpc/kernel/traps.c:413: error: 'PPC47x_MCSR_FPR' undeclared (first use in this function)
> >arch/powerpc/kernel/traps.c:415: error: 'PPC47x_MCSR_IPR' undeclared (first use in this function)
> >make[1]: *** [arch/powerpc/kernel/traps.o] Error 1
> >make: *** [arch/powerpc/kernel] Error 2
> >make: *** Waiting for unfinished jobs....
> >
> >
> >We should probably guard this function behind CONFIG_PPC_47x, right?  If so, I
> >can fix that up locally quickly enough.
> 
> Actually, that won't work unless we wrap the .machine_check addition in cputable
> as well.  That looks ugly.  I'm guessing the easiest and cleanest fix is to
> not guard the #defines for those regs in reg_booke.h.  Anyone have problems with
> that?

I have no problems with that.  Sorry for not being diligent and building
these patches with other configs.

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
