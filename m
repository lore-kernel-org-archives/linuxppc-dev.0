Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5941D1A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 19:25:48 +1100 (AEDT)
In-Reply-To: <1416910128-23466-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND, V3] powerpc,
 xmon: Enable HW instruction breakpoint on POWER8
Message-Id: <20141126082548.34D5114017D@ozlabs.org>
Date: Wed, 26 Nov 2014 19:25:48 +1100 (AEDT)
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-25-11 at 10:08:48 UTC, Anshuman Khandual wrote:
> This patch enables support for hardware instruction breakpoints
> on POWER8 with the help of a new register CIABR (Completed
> Instruction Address Breakpoint Register). With this patch, single
> hardware instruction breakpoint can be added and cleared during
> any active xmon debug session. This hardware based instruction
> breakpoint mechanism works correctly along with the existing TRAP
> based instruction breakpoints available on xmon.


Hi Anshuman,

> diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
> index 5eb8e59..5d17aec 100644
> --- a/arch/powerpc/include/asm/xmon.h
> +++ b/arch/powerpc/include/asm/xmon.h
> @@ -29,5 +29,11 @@ static inline void xmon_register_spus(struct list_head *list) { };
>  extern int cpus_are_in_xmon(void);
>  #endif

This file is the exported interface *of xmon*, it's not the place to put things
that xmon needs internally.

For now just put it in xmon.c

> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_SPLPAR)
> +#include <asm/plpar_wrappers.h>
> +#else
> +static inline long plapr_set_ciabr(unsigned long ciabr) {return 0; };
> +#endif

Also the ifdef is overly verbose, CONFIG_PPC_SPLPAR essentially depends on
CONFIG_PPC_BOOK3S_64. So you can just use #ifdef CONFIG_PPC_SPLPAR.

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index b988b5a..c2f601a 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -271,6 +273,55 @@ static inline void cinval(void *p)
>  }
>  
>  /*
> + * write_ciabr
> + *
> + * This function writes a value to the
> + * CIARB register either directly through
> + * mtspr instruction if the kernel is in HV
> + * privilege mode or call a hypervisor function
> + * to achieve the same in case the kernel is in
> + * supervisor privilege mode.
> + */

I'm not really sure a function this small needs a documentation block.

But if you're going to add one, PLEASE make sure it's an actual kernel-doc
style comment.

You can check with:

$ ./scripts/kernel-doc -text arch/powerpc/xmon/xmon.c

Which you'll notice prints:

Warning(arch/powerpc/xmon/xmon.c): no structured comments found

You need something like:

/**
 * write_ciabr() - write the CIABR SPR
 * @ciabr: The value to write.
 *
 * This function writes a value to the CIABR register either directly through
 * mtspr instruction if the kernel is in HV privilege mode or calls a
 * hypervisor function to achieve the same in case the kernel is in supervisor
 * privilege mode.
 */



The rest of the patch is OK. But I was hoping you'd notice that we no longer
support any cpus that implement CPU_FTR_IABR. And so you can just repurpose all
the iabr logic for ciabr.

Something like this, untested:


diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b988b5addf86..6894650bff7f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -51,6 +51,12 @@
 #include <asm/paca.h>
 #endif
 
+#ifdef CONFIG_PPC_SPLPAR
+#include <asm/plpar_wrappers.h>
+#else
+static inline long plapr_set_ciabr(unsigned long ciabr) { return 0; };
+#endif
+
 #include "nonstdio.h"
 #include "dis-asm.h"
 
@@ -270,6 +276,31 @@ static inline void cinval(void *p)
 	asm volatile ("dcbi 0,%0; icbi 0,%0" : : "r" (p));
 }
 
+static void write_ciabr(unsigned long ciabr)
+{
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return;
+
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_CIABR, ciabr);
+		return;
+	}
+
+	plapr_set_ciabr(ciabr);
+}
+
+static void set_ciabr(unsigned long addr)
+{
+	addr &= ~CIABR_PRIV;
+
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		addr |= CIABR_PRIV_HYPER;
+	else
+		addr |= CIABR_PRIV_SUPER;
+
+	write_ciabr(addr);
+}
+
 /*
  * Disable surveillance (the service processor watchdog function)
  * while we are in xmon.
@@ -764,9 +795,9 @@ static void insert_cpu_bpts(void)
 		brk.len = 8;
 		__set_breakpoint(&brk);
 	}
-	if (iabr && cpu_has_feature(CPU_FTR_IABR))
-		mtspr(SPRN_IABR, iabr->address
-			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
+
+	if (iabr)
+		set_ciabr(iabr->address);
 }
 
 static void remove_bpts(void)
@@ -792,8 +823,7 @@ static void remove_bpts(void)
 static void remove_cpu_bpts(void)
 {
 	hw_breakpoint_disable();
-	if (cpu_has_feature(CPU_FTR_IABR))
-		mtspr(SPRN_IABR, 0);
+	write_ciabr(0);
 }
 
 /* Command interpreting routine */
@@ -1127,7 +1157,7 @@ static char *breakpoint_help_string =
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
     "bc               clear all breakpoints\n"
     "bc <n/addr>      clear breakpoint number n or at addr\n"
-    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
+    "bi <addr> [cnt]  set hardware instr breakpoint (POWER8 only)\n"
     "bd <addr> [cnt]  set hardware data breakpoint\n"
     "";
 
@@ -1166,7 +1196,7 @@ bpt_cmds(void)
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
-		if (!cpu_has_feature(CPU_FTR_IABR)) {
+		if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
 			printf("Hardware instruction breakpoint "
 			       "not supported on this cpu\n");
 			break;



cheers
