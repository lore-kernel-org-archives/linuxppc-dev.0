Return-Path: <anton@samba.org>
Date: Mon, 1 Aug 2011 15:27:35 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Move kdump default base address to half RMO size
	on 64bit
Message-ID: <20110801152735.509ac873@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We are seeing boot failures on some very large boxes even with
commit b5416ca9f824 (powerpc: Move kdump default base address to
64MB on 64bit).

This patch halves the RMO so both kernels get about the same
amount of RMO memory. On large machines this region will be
at least 256MB, so each kernel will get 128MB.

We cap it at 256MB (small SLB size) since some early allocations need
to be in the bolted SLB region. We could relax this on machines with
1TB SLBs in a future patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/kdump.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/kdump.h	2011-07-26 11:11:35.583436932 +1000
+++ linux-powerpc/arch/powerpc/include/asm/kdump.h	2011-07-26 11:17:13.159317079 +1000
@@ -3,17 +3,7 @@
 
 #include <asm/page.h>
 
-/*
- * If CONFIG_RELOCATABLE is enabled we can place the kdump kernel anywhere.
- * To keep enough space in the RMO for the first stage kernel on 64bit, we
- * place it at 64MB. If CONFIG_RELOCATABLE is not enabled we must place
- * the second stage at 32MB.
- */
-#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC64)
-#define KDUMP_KERNELBASE	0x4000000
-#else
 #define KDUMP_KERNELBASE	0x2000000
-#endif
 
 /* How many bytes to reserve at zero for kdump. The reserve limit should
  * be greater or equal to the trampoline's end address.
Index: linux-powerpc/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/machine_kexec.c	2011-07-26 11:10:27.932259619 +1000
+++ linux-powerpc/arch/powerpc/kernel/machine_kexec.c	2011-07-26 11:18:17.830444562 +1000
@@ -136,12 +136,16 @@ void __init reserve_crashkernel(void)
 	crashk_res.start = KDUMP_KERNELBASE;
 #else
 	if (!crashk_res.start) {
+#ifdef CONFIG_PPC64
 		/*
-		 * unspecified address, choose a region of specified size
-		 * can overlap with initrd (ignoring corruption when retained)
-		 * ppc64 requires kernel and some stacks to be in first segemnt
+		 * On 64bit we split the RMO in half but cap it at half of
+		 * a small SLB (128MB) since the crash kernel needs to place
+		 * itself and some stacks to be in the first segment.
 		 */
+		crashk_res.start = min(0x80000000ULL, (ppc64_rma_size / 2));
+#else
 		crashk_res.start = KDUMP_KERNELBASE;
+#endif
 	}
 
 	crash_base = PAGE_ALIGN(crashk_res.start);
