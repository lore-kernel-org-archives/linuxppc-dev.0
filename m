Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 5 May 2010 08:27:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/13] powerpc/476: add machine check handler for 47x core
Message-ID: <20100505122701.GG29593@zod.rchland.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
	<20100305204318.18424.77960.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100305204318.18424.77960.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 05, 2010 at 06:43:18AM -0700, Dave Kleikamp wrote:
>powerpc/476: add machine check handler for 47x core
>
>From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>
>The 47x core's MCSR varies from 44x, so it needs it's own machine check
>handler.
>
>Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>---
>
> arch/powerpc/include/asm/cputable.h |    1 +
> arch/powerpc/kernel/cputable.c      |    1 +
> arch/powerpc/kernel/traps.c         |   40 +++++++++++++++++++++++++++++++++++
> 3 files changed, 42 insertions(+), 0 deletions(-)
>
>
>diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>index 75b774e..9fff628 100644
>--- a/arch/powerpc/include/asm/cputable.h
>+++ b/arch/powerpc/include/asm/cputable.h
>@@ -72,6 +72,7 @@ extern int machine_check_4xx(struct pt_regs *regs);
> extern int machine_check_440A(struct pt_regs *regs);
> extern int machine_check_e500(struct pt_regs *regs);
> extern int machine_check_e200(struct pt_regs *regs);
>+extern int machine_check_47x(struct pt_regs *regs);
>
> /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
> struct cpu_spec {
>diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>index 338ac47..7b2a67c 100644
>--- a/arch/powerpc/kernel/cputable.c
>+++ b/arch/powerpc/kernel/cputable.c
>@@ -1712,6 +1712,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
> 			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
> 		.icache_bsize		= 32,
> 		.dcache_bsize		= 128,
>+		.machine_check		= machine_check_47x,
> 		.platform		= "ppc470",
> 	},
> 	{	/* default match */
>diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>index d069ff8..21ed77b 100644
>--- a/arch/powerpc/kernel/traps.c
>+++ b/arch/powerpc/kernel/traps.c
>@@ -376,6 +376,46 @@ int machine_check_440A(struct pt_regs *regs)
> 	}
> 	return 0;
> }
>+
>+int machine_check_47x(struct pt_regs *regs)
>+{
>+	unsigned long reason = get_mc_reason(regs);
>+	u32 mcsr;
>+
>+	printk(KERN_ERR "Machine check in kernel mode.\n");
>+	if (reason & ESR_IMCP) {
>+		printk(KERN_ERR
>+		       "Instruction Synchronous Machine Check exception\n");
>+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
>+		return 0;
>+	}
>+	mcsr = mfspr(SPRN_MCSR);
>+	if (mcsr & MCSR_IB)
>+		printk(KERN_ERR "Instruction Read PLB Error\n");
>+	if (mcsr & MCSR_DRB)
>+		printk(KERN_ERR "Data Read PLB Error\n");
>+	if (mcsr & MCSR_DWB)
>+		printk(KERN_ERR "Data Write PLB Error\n");
>+	if (mcsr & MCSR_TLBP)
>+		printk(KERN_ERR "TLB Parity Error\n");
>+	if (mcsr & MCSR_ICP) {
>+		flush_instruction_cache();
>+		printk(KERN_ERR "I-Cache Parity Error\n");
>+	}
>+	if (mcsr & MCSR_DCSP)
>+		printk(KERN_ERR "D-Cache Search Parity Error\n");
>+	if (mcsr & PPC47x_MCSR_GPR)
>+		printk(KERN_ERR "GPR Parity Error\n");
>+	if (mcsr & PPC47x_MCSR_FPR)
>+		printk(KERN_ERR "FPR Parity Error\n");
>+	if (mcsr & PPC47x_MCSR_IPR)
>+		printk(KERN_ERR "Machine Check exception is imprecise\n");

This function isn't guarded by CONFIG_PPC_47x, however the defines for 
PPC47x_MCSR_* are in include/asm/reg_booke.h.  They were added that way in patch
4.  As it stands, we get this when trying to build for plain 44x:

 CC      arch/powerpc/kernel/traps.o
arch/powerpc/kernel/traps.c: In function 'machine_check_47x':
arch/powerpc/kernel/traps.c:411: error: 'PPC47x_MCSR_GPR' undeclared (first use in this function)
arch/powerpc/kernel/traps.c:411: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/traps.c:411: error: for each function it appears in.)
arch/powerpc/kernel/traps.c:413: error: 'PPC47x_MCSR_FPR' undeclared (first use in this function)
arch/powerpc/kernel/traps.c:415: error: 'PPC47x_MCSR_IPR' undeclared (first use in this function)
make[1]: *** [arch/powerpc/kernel/traps.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
make: *** Waiting for unfinished jobs....


We should probably guard this function behind CONFIG_PPC_47x, right?  If so, I
can fix that up locally quickly enough.

josh
