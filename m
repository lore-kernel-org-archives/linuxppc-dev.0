Return-Path: <anton@ozlabs.org>
Date: Tue, 8 Jun 2010 11:34:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Move kdump default base address to 64MB on 64bit
Message-ID: <20100608013437.GL28295@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We are seeing boot fails on some System p machines when using the kdump
crashkernel= boot option. The default kdump base address is 32MB, so if we
reserve 256MB for kdump then we reserve all of the RMO except the first 32MB.

We really want kdump to reserve some memory in the RMO and most of it
elsewhere but that will require more significant changes. For now we can shift
the default base address to 64MB when CONFIG_PPC64 and CONFIG_RELOCATABLE are
set. This isn't quite correct since what we really care about is the kdump
kernel is relocatable, but we already make the assumption that base kernel
and kdump kernel have the same CONFIG_RELOCATABLE setting, eg:

#ifndef CONFIG_RELOCATABLE
        if (crashk_res.start != KDUMP_KERNELBASE)
                printk("Crash kernel location must be 0x%x\n",
                                KDUMP_KERNELBASE);
...

RTAS is instantiated towards the top of our RMO, so if we were to go any
higher we risk not having enough RMO memory for the kdump kernel on boxes
with a 128MB RMO.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/kdump.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/kdump.h	2010-06-01 09:05:02.847207461 +1000
+++ powerpc.git/arch/powerpc/include/asm/kdump.h	2010-06-07 15:07:58.607203883 +1000
@@ -3,8 +3,17 @@
 
 #include <asm/page.h>
 
-/* Kdump kernel runs at 32 MB, change at your peril. */
+/*
+ * If CONFIG_RELOCATABLE is enabled we can place the kdump kernel anywhere.
+ * To keep enough space in the RMO for the first stage kernel on 64bit, we
+ * place it at 64MB. If CONFIG_RELOCATABLE is not enabled we must place
+ * the second stage at 32MB.
+ */
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC64)
+#define KDUMP_KERNELBASE	0x4000000
+#else
 #define KDUMP_KERNELBASE	0x2000000
+#endif
 
 /* How many bytes to reserve at zero for kdump. The reserve limit should
  * be greater or equal to the trampoline's end address.
