Subject: Caching in the MPC107, linux 2.6
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1079088369.691.43.camel@newt>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 10:46:09 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I discovered this problem back in 2002:

http://lists.linuxppc.org/results.html?words=caching+mpc107&method=and&sort=score&restrict=linuxppc-embedded

The 2.6 kernel requires a fix to use a MPC745x along with a MPC107
bridge. My proposed patch is below - any comments?

Without this fix or something like it my boards cannot use pcnet32
ethernet.

- Adrian Cox
http://www.humboldt.co.uk/

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Fri Mar 12 10:43:37 2004
+++ b/arch/ppc/Kconfig	Fri Mar 12 10:43:37 2004
@@ -631,6 +631,11 @@
 	bool "Enable MPC10x store gathering"
 	depends on FORCE || SANDPOINT

+config CACHING_HOSTBRIDGE
+        bool
+        depends on FORCE || SANDPOINT
+	default y
+
 config CPC710_DATA_GATHERING
 	bool "Enable CPC710 data gathering"
 	depends on K2
diff -Nru a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
--- a/arch/ppc/mm/hashtable.S	Fri Mar 12 10:43:37 2004
+++ b/arch/ppc/mm/hashtable.S	Fri Mar 12 10:43:37 2004
@@ -348,6 +348,13 @@
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
 #ifdef CONFIG_SMP
 	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
+#elif defined(CONFIG_CACHING_HOSTBRIDGE)
+        /* The MPC107 PCI bridge contains a cache, which must remain
+           coherent with the CPU cache. This is only necessary for the
+           MPC745x family, as they support the shared state. */
+BEGIN_FTR_SECTION
+	ori	r8,r8,_PAGE_COHERENT
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 #endif

 	/* Construct the high word of the PPC-style PTE (r5) */
diff -Nru a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
--- a/arch/ppc/mm/ppc_mmu.c	Fri Mar 12 10:43:37 2004
+++ b/arch/ppc/mm/ppc_mmu.c	Fri Mar 12 10:43:37 2004
@@ -32,6 +32,7 @@
 #include <asm/prom.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
+#include <asm/cputable.h>

 #include "mmu_decl.h"
 #include "mem_pieces.h"
@@ -140,7 +141,12 @@
 #ifdef CONFIG_SMP
 	if ((flags & _PAGE_NO_CACHE) == 0)
 		flags |= _PAGE_COHERENT;
+#elif defined(CONFIG_CACHING_HOSTBRIDGE)
+	if ((flags & _PAGE_NO_CACHE) == 0 &&
+            (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450))
+		flags |= _PAGE_COHERENT;
 #endif
+
 	bl = (size >> 17) - 1;
 	if (PVR_VER(mfspr(PVR)) != 1) {
 		/* 603, 604, etc. */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
