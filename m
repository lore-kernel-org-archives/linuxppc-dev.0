Subject: Re: Caching in the MPC107
From: Adrian Cox <adrian@humboldt.co.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <15742.33086.511345.798962@argo.ozlabs.ibm.com>
References: <1031581408.30396.81.camel@newt>
	<15742.33086.511345.798962@argo.ozlabs.ibm.com>
Content-Type: text/plain
Date: 11 Sep 2002 13:52:23 +0100
Message-Id: <1031748748.2685.313.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-09-11 at 00:33, Paul Mackerras wrote:
> Adrian Cox writes:

> > My current thinking is to produce a patch which introduces a new option:
> > CONFIG_CACHING_HOSTBRIDGE which boards combining the MPC107 and the
> > MPC7450 can set. This will probably be needed for Motorola's Valis or
> > Gyrus PMCs.
>
> Hmmm, it would be better to have the code just do the right thing on
> each platform.  We could for instance have platform_init set a flag to
> say "we have a caching hostbridge" and have mapin_ram and
> bat_mapin_ram set the M bit if that flag is set.

I think you're right so long as all the memory is mapped at boot time.
this should be fine for the MPC107, as that can't support highmem. Once
somebody produces a caching PCI bridge which supports more memory, we'll
have to change the flags elsewhere. Probably in create_hpte().

Is the patch below the sort of thing you're thinking of?

- Adrian Cox
http://www.humboldt.co.uk/

===== arch/ppc/kernel/cputable.c 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/cputable.c	Wed Jun  5 00:24:08 2002
+++ edited/arch/ppc/kernel/cputable.c	Wed Sep 11 12:55:00 2002
@@ -212,7 +212,7 @@
     	0xffffffff, 0x80000200, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_CACHE_SHARED,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_7450
@@ -221,7 +221,7 @@
     	0xffffffff, 0x80000201, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_CACHE_SHARED,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_7450
@@ -230,7 +230,7 @@
     	0xffff0000, 0x80000000, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_CACHE_SHARED,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_7450_23
@@ -239,7 +239,7 @@
     	0xffff0000, 0x80010000, "7455",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_CACHE_SHARED,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
 	__setup_cpu_7455
===== arch/ppc/mm/pgtable.c 1.18 vs edited =====
--- 1.18/arch/ppc/mm/pgtable.c	Sat Apr  6 22:06:49 2002
+++ edited/arch/ppc/mm/pgtable.c	Wed Sep 11 11:31:09 2002
@@ -63,6 +63,8 @@
 #endif

 extern char etext[], _stext[];
+int extra_page_flags __initdata;
+

 #ifdef HAVE_BATS
 extern unsigned long v_mapped_by_bats(unsigned long va);
@@ -371,6 +373,7 @@
 #endif /* CONFIG_PPC_STD_MMU */
 #endif /* CONFIG_KGDB || CONFIG_XMON */
 		map_page(v, p, f);
+		f |= extra_page_flags;
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
===== arch/ppc/mm/ppc_mmu.c 1.9 vs edited =====
--- 1.9/arch/ppc/mm/ppc_mmu.c	Fri Jan 25 15:41:09 2002
+++ edited/arch/ppc/mm/ppc_mmu.c	Wed Sep 11 11:29:29 2002
@@ -91,12 +91,13 @@
 	unsigned long tot, done;

 	tot = total_lowmem;
-	setbat(2, KERNELBASE, PPC_MEMSTART, bat2, _PAGE_KERNEL);
+	setbat(2, KERNELBASE, PPC_MEMSTART, bat2,
+		 _PAGE_KERNEL | extra_page_flags);
 	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
 	if ((done < tot) && !bat_addrs[3].limit && bat3) {
 		tot -= done;
 		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bat3,
-		       _PAGE_KERNEL);
+		       _PAGE_KERNEL | extra_page_flags);
 	}
 }

===== arch/ppc/platforms/sandpoint_setup.c 1.24 vs edited =====
--- 1.24/arch/ppc/platforms/sandpoint_setup.c	Mon Jun  3 21:20:31 2002
+++ edited/arch/ppc/platforms/sandpoint_setup.c	Wed Sep 11 13:01:12 2002
@@ -91,6 +91,7 @@
 #include <asm/bootinfo.h>
 #include <asm/mpc10x.h>
 #include <asm/pci-bridge.h>
+#include <asm/cputable.h>

 #include "sandpoint.h"

@@ -598,6 +599,9 @@
 	/* Map in board regs, etc. */
 	sandpoint_set_bat();

+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_CACHE_SHARED)
+    	    	extra_page_flags = _PAGE_COHERENT;
+
 	isa_io_base = MPC10X_MAPB_ISA_IO_BASE;
 	isa_mem_base = MPC10X_MAPB_ISA_MEM_BASE;
 	pci_dram_offset = MPC10X_MAPB_DRAM_OFFSET;
===== include/asm-ppc/cputable.h 1.7 vs edited =====
--- 1.7/include/asm-ppc/cputable.h	Wed Mar 20 22:04:09 2002
+++ edited/include/asm-ppc/cputable.h	Wed Sep 11 12:54:07 2002
@@ -69,6 +69,7 @@
 #define CPU_FTR_HPTE_TABLE		0x00000200
 #define CPU_FTR_CAN_NAP			0x00000400
 #define CPU_FTR_L3CR			0x00000800
+#define CPU_FTR_CACHE_SHARED	    	0x00001000

 #ifdef __ASSEMBLY__

===== include/asm-ppc/pgtable.h 1.49 vs edited =====
--- 1.49/include/asm-ppc/pgtable.h	Mon Jun  3 03:36:27 2002
+++ edited/include/asm-ppc/pgtable.h	Wed Sep 11 13:01:15 2002
@@ -112,6 +112,12 @@
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
 extern unsigned long ioremap_bot, ioremap_base;
+
+/* Some boards require extra page flags  (for example, because there is
+   another caching bus master in the system). These flags will be ored into
+   the page flags when memory is initially mapped. */
+extern int extra_page_flags;
+
 #endif /* __ASSEMBLY__ */

 /*


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
