Return-Path: <dgibson@ozlabs.org>
Date: Thu, 16 Nov 2006 16:24:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Cleanup zImage handling of kernel entry with flat device tree
Message-ID: <20061116052402.GC10821@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, this applies on top of the initrd handling cleanup I just
posted.

This patch makes 2 changes to clean up the flat device tree handling
logic in the zImage wrapper.

First, there were two callbacks from the dt_ops structure used for
producing a final flat tree to pass to the kerne: dt_ops.ft_pack()
which packed the flat tree (possibly a no-op) and dt_ops.ft_addr()
which retreived the address of the final blob.  Since they were only
ever called together, this patch combines the two into a single new
callback, dt_ops.finalize().  This new callback does whatever
platform-dependent things are necessary to produce a final flat device
tree blob, and returns the blob's addres.

Second, the current logic calls the kernel with a flat device tree if
one is build into the zImage wrapper, otherwise it boots the kernel
with a PROM pointer, expecting the kernel to copy the OF device tree
itself.  This approach precludes the possibility of the platform
wrapper code building a flat device tree from whatever
platform-specific information firmware provides.  Thus, this patch
takes the more sensible approach of invoking the kernel with a flat
tree if the dt_ops.finalize callback provides one (by whatever means).

So, the dt_ops.finalize callback can be NULL, or can be a function
which returns NULL.  In either case, the zImage wrapper logic assumes
that this is a platform with OF and invokes the kernel accordingly.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/boot/flatdevtree_misc.c |    9 ++-------
 arch/powerpc/boot/main.c             |   15 +++++++++++----
 arch/powerpc/boot/ops.h              |    3 +--
 3 files changed, 14 insertions(+), 13 deletions(-)

Index: working-2.6/arch/powerpc/boot/flatdevtree_misc.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/flatdevtree_misc.c	2006-11-16 15:39:57.000000000 +1100
+++ working-2.6/arch/powerpc/boot/flatdevtree_misc.c	2006-11-16 15:39:58.000000000 +1100
@@ -33,13 +33,9 @@ static int ft_setprop(const void *phandl
 	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
 }
 
-static void ft_pack(void)
+static unsigned long ft_finalize(void)
 {
 	ft_end_tree(&cxt);
-}
-
-static unsigned long ft_addr(void)
-{
 	return (unsigned long)cxt.bph;
 }
 
@@ -48,8 +44,7 @@ int ft_init(void *dt_blob, unsigned int 
 	dt_ops.finddevice = ft_finddevice;
 	dt_ops.getprop = ft_getprop;
 	dt_ops.setprop = ft_setprop;
-	dt_ops.ft_pack = ft_pack;
-	dt_ops.ft_addr = ft_addr;
+	dt_ops.ft_finalize = ft_finalize;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2006-11-16 15:39:58.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2006-11-16 15:58:27.000000000 +1100
@@ -298,6 +298,7 @@ void start(unsigned long a1, unsigned lo
 {
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
+	unsigned long ft_addr = 0;
 
 	memset(__bss_start, 0, _end - __bss_start);
 	memset(&platform_ops, 0, sizeof(platform_ops));
@@ -328,14 +329,20 @@ void start(unsigned long a1, unsigned lo
 		set_cmdline(cmdline);
 	}
 
+	printf("Finalizing device tree...");
+	if (dt_ops.finalize)
+		ft_addr = dt_ops.finalize();
+	if (ft_addr)
+		printf(" flat tree at %lx\n\r", ft_addr);
+	else
+		printf(" using OF tree (promptr=%p)\n\r", promptr);
+
 	if (console_ops.close)
 		console_ops.close();
 
 	kentry = (kernel_entry_t) vmlinux.addr;
-	if (_dtb_end > _dtb_start) {
-		dt_ops.ft_pack();
-		kentry(dt_ops.ft_addr(), 0, NULL);
-	}
+	if (ft_addr)
+		kentry(ft_addr, 0, NULL);
 	else
 		/* XXX initrd addr/size should be passed in properties */
 		kentry(initrd.addr, initrd.size, promptr);
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2006-11-16 15:39:57.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2006-11-16 15:42:57.000000000 +1100
@@ -35,8 +35,7 @@ struct dt_ops {
 			const int buflen);
 	int	(*setprop)(const void *phandle, const char *name,
 			const void *buf, const int buflen);
-	void	(*ft_pack)(void);
-	unsigned long (*ft_addr)(void);
+	unsigned long (*finalize)(void);
 };
 extern struct dt_ops dt_ops;
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
