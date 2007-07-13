Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id C1E88DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:12:09 +1000 (EST)
Date: Fri, 13 Jul 2007 11:12:03 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070713091203.GE11476@nd47.coderock.org>
References: <20070711093113.GE4375@moe.telargo.com>
	<200707110856.58463.david-b@pacbell.net>
	<20070711161633.GA4846@lst.de>
	<200707111002.55119.david-b@pacbell.net>
	<20070711203454.GC2301@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070711203454.GC2301@flint.arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/07/07 21:34 +0100, Russell King wrote:
> On Wed, Jul 11, 2007 at 10:02:54AM -0700, David Brownell wrote:
> > On Wednesday 11 July 2007, Christoph Hellwig wrote:
> > > On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > > > > Umm, this is about the fifth almost identical implementation of
> > > > > the clk_ functions.  Please, please put it into common code.
> > > > > 
> > > > > And talk to the mips folks which just got a similar comment from me.
> > > > 
> > > > You mean like a lib/clock.c core, rather than an opsvector?
> > > 
> > > I mean an ops vector and surrounding wrappers.  Every architecture
> > > is reimplementing their own dispatch table which is rather annoying.
> > 
> > ARM doesn't.  :)
> > 
> > But then, nobody expects one kernel to support more than one
> > vendor's ARM chips; or usually, more than one generation of
> > that vendor's chips.  So any dispatch table is specific to
> > a given platform, and tuned to its quirks.  Not much to share
> > between OMAP and AT91, for example, except in some cases maybe
> > an arm926ejs block.
> 
> And also the information stored within a 'struct clk' is very platform
> dependent.  In the most basic situation, 'struct clk' may not actually
> be a structure, but the clock rate.  All functions with the exception of
> clk_get() and clk_get_rate() could well be no-ops, clk_get() just returns
> the 'struct clk' representing the rate and 'clk_get_rate' returns that
> as an integer.
> 
> More complex setups might want 'struct clk' to contain the address of a
> clock enable register, the bit position to enable that clock source, the
> clock rate, a refcount, and so on, all of which would be utterly useless
> for a platform which had fixed rate clocks.

The patch that triggered this discussion is at the end.
It doesn't make any assumption on struct clk, it's just a
wrapper around functions from clk.h.
Point of this patch was to abstract exported functions, since
arch/powerpc/ can support multiple platfroms in one binary.

> 
> > I've not seen a solid proposal for such a thing, and it's not
> > clear to me how that would play with with older code (e.g. any
> > of the ARM implementations).
> 
> If people are implementing their own incompatible changes without reference
> to the API they're invalid implementations as far as I'm concerned.  If
> they can't bothered to lift a finger to even _talk_ to me about their
> requirements they just don't have any say concerning any future
> developments IMO.

My changes were implemented according to clk.h API.
And honestly, I just wanted to rework clocks in some SPI driver and
others made me do all the clk work. ;-)


	Domen

> 
> IOW, talk to me and I'll talk back.  Ignore me and I'll ignore them.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:




clk interface for arch/powerpc, platforms should fill
clk_functions.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/kernel/Makefile        |    3 -
 arch/powerpc/kernel/clock.c         |   82 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/clk_interface.h |   20 ++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/kernel/clock.c
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/powerpc/kernel/clock.c
@@ -0,0 +1,82 @@
+/*
+ * Dummy clk implementations for powerpc.
+ * These need to be overridden in platform code.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <asm/clk_interface.h>
+
+struct clk_interface clk_functions;
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (clk_functions.clk_get)
+		return clk_functions.clk_get(dev, id);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+	if (clk_functions.clk_put)
+		clk_functions.clk_put(clk);
+}
+EXPORT_SYMBOL(clk_put);
+
+int clk_enable(struct clk *clk)
+{
+	if (clk_functions.clk_enable)
+		return clk_functions.clk_enable(clk);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	if (clk_functions.clk_disable)
+		clk_functions.clk_disable(clk);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (clk_functions.clk_get_rate)
+		return clk_functions.clk_get_rate(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk_functions.clk_round_rate)
+		return clk_functions.clk_round_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk_functions.clk_set_rate)
+		return clk_functions.clk_set_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (clk_functions.clk_get_parent)
+		return clk_functions.clk_get_parent(clk);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	if (clk_functions.clk_set_parent)
+		return clk_functions.clk_set_parent(clk, parent);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_parent);
Index: work-powerpc.git/include/asm-powerpc/clk_interface.h
===================================================================
--- /dev/null
+++ work-powerpc.git/include/asm-powerpc/clk_interface.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_POWERPC_CLK_INTERFACE_H
+#define __ASM_POWERPC_CLK_INTERFACE_H
+
+#include <linux/clk.h>
+
+struct clk_interface {
+	struct clk*	(*clk_get)	(struct device *dev, const char *id);
+	int		(*clk_enable)	(struct clk *clk);
+	void		(*clk_disable)	(struct clk *clk);
+	unsigned long	(*clk_get_rate)	(struct clk *clk);
+	void		(*clk_put)	(struct clk *clk);
+	long		(*clk_round_rate) (struct clk *clk, unsigned long rate);
+	int 		(*clk_set_rate)	(struct clk *clk, unsigned long rate);
+	int		(*clk_set_parent) (struct clk *clk, struct clk *parent);
+	struct clk*	(*clk_get_parent) (struct clk *clk);
+};
+
+extern struct clk_interface clk_functions;
+
+#endif /* __ASM_POWERPC_CLK_INTERFACE_H */
Index: work-powerpc.git/arch/powerpc/kernel/Makefile
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/Makefile
+++ work-powerpc.git/arch/powerpc/kernel/Makefile
@@ -12,7 +12,8 @@ endif
 
 obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   init_task.o process.o systbl.o idle.o
+				   init_task.o process.o systbl.o idle.o \
+				   clock.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
