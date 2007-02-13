Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/16] powerpc: Add zImage platform hook for kernel address
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061024.A82ABDDD0C@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:24 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unlike "classic" 32 and 64-bit PowerPC processors, the early setup
code for 4xx is not able to relocate the kernel if loaded at an
address other than 0.  For 440 it's even potentially difficult to add
this support, because at entry the kernel doesn't necessarily know the
full MMU configuration.

This patch, therefore, adds a hook to the zImage wrapper code which
allows a platform to specify a function giving the address to which
the vmlinux must be moved before entering the kernel.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/main.c |   19 +++++++++++++++----
 arch/powerpc/boot/ops.h  |    1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-01-12 14:43:34.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-01-12 14:48:10.000000000 +1100
@@ -249,12 +249,23 @@ static void prep_kernel(unsigned long a1
 			vmlinuz.size);
 	}
 
-	/* Skip over the ELF header */
+	/* Move into final position */
+	if (platform_ops.vmlinux_addr) {
+		unsigned long old_addr = vmlinux.addr;
+		vmlinux.addr = platform_ops.vmlinux_addr(vmlinux.size);
 #ifdef DEBUG
-	printf("... skipping 0x%lx bytes of ELF header\n\r",
-			elfoffset);
+		printf("...moving kernel to final address 0x%lx\n\r", vmlinux.addr);
 #endif
-	vmlinux.addr += elfoffset;
+		memmove((void *)vmlinux.addr, (void *)old_addr+elfoffset,
+			vmlinux.size);
+	} else {
+		/* Just Skip over the ELF header */
+#ifdef DEBUG
+		printf("... skipping 0x%lx bytes of ELF header\n\r",
+		       elfoffset);
+#endif
+		vmlinux.addr += elfoffset;
+	}
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 }
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-01-12 14:42:11.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-01-12 14:45:43.000000000 +1100
@@ -25,6 +25,7 @@ struct platform_ops {
 	void	(*free)(void *ptr);
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
+	unsigned long (*vmlinux_addr)(unsigned long size);
 };
 extern struct platform_ops platform_ops;
 
