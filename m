Return-Path: <mmporter@cox.net>
Date: Tue, 8 Nov 2005 09:37:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051108093759.A26086@cox.net>
References: <20051107124917.C1671@cox.net>
	<20051107190128.68d41294.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051107190128.68d41294.akpm@osdl.org>;
	from akpm@osdl.org on Mon, Nov 07, 2005 at 07:01:28PM -0800
Cc: linuxppc64-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix perf_irq extern on e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2005 at 07:01:28PM -0800, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > Add an extern reference to perf_irq on e500.

<snip>

> >  #ifdef CONFIG_E500
> > +extern perf_irq_t perf_irq;
> > +
> >  void performance_monitor_exception(struct pt_regs *regs)
> >  {
> >  	perf_irq(regs);
> 
> extern decls are placed in header files, please.  

Here's the updated patch, addressing this for ppc64 as well.  Paul,
would you prefer that this go through the powerpc-merge tree since
the updated version modifies arch/powerpc/?

-Matt

Fixes e500 build and cleans up traps.c by moving perf_irq extern to
pmc.h.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 07e5ee4..32cd797 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -898,10 +898,6 @@ void altivec_unavailable_exception(struc
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
-#ifdef CONFIG_PPC64
-extern perf_irq_t perf_irq;
-#endif
-
 #if defined(CONFIG_PPC64) || defined(CONFIG_E500)
 void performance_monitor_exception(struct pt_regs *regs)
 {
diff --git a/include/asm-powerpc/pmc.h b/include/asm-powerpc/pmc.h
index 2f3c3fc..5f41f3a 100644
--- a/include/asm-powerpc/pmc.h
+++ b/include/asm-powerpc/pmc.h
@@ -22,6 +22,7 @@
 #include <asm/ptrace.h>
 
 typedef void (*perf_irq_t)(struct pt_regs *);
+extern perf_irq_t perf_irq;
 
 int reserve_pmc_hardware(perf_irq_t new_perf_irq);
 void release_pmc_hardware(void);
