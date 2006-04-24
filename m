Return-Path: <SRS0+7b926790237929f7f8ff+974+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B4BD67A0E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 08:22:06 +1000 (EST)
Subject: [PATCH] Use check_legacy_ioport() on ppc32 too.
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org, benh@kernel.crashing.org
Content-Type: text/plain
Date: Mon, 24 Apr 2006 23:22:17 +0100
Message-Id: <1145917338.16166.442.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some people report that we die on some Macs when we are expecting to
catch machine checks after poking at some random I/O address. I'd seen
it happen on my dual G4 with serial ports until we fixed those to use
OF, but now other users are reporting it with i8042.

This expands the use of check_legacy_ioport() to avoid that situation
even on 32-bit kernels.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1d93e73..684ab1d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -516,3 +516,11 @@ void probe_machine(void)
 
 	printk(KERN_INFO "Using %s machine description\n", ppc_md.name);
 }
+
+int check_legacy_ioport(unsigned long base_port)
+{
+	if (ppc_md.check_legacy_ioport == NULL)
+		return 0;
+	return ppc_md.check_legacy_ioport(base_port);
+}
+EXPORT_SYMBOL(check_legacy_ioport);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 13e91c4..4467c49 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -594,14 +594,6 @@ void ppc64_terminate_msg(unsigned int sr
 	printk("[terminate]%04x %s\n", src, msg);
 }
 
-int check_legacy_ioport(unsigned long base_port)
-{
-	if (ppc_md.check_legacy_ioport == NULL)
-		return 0;
-	return ppc_md.check_legacy_ioport(base_port);
-}
-EXPORT_SYMBOL(check_legacy_ioport);
-
 void cpu_die(void)
 {
 	if (ppc_md.cpu_die)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index bedb689..dff1e67 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4301,7 +4301,7 @@ #endif
 	}
 
 	use_virtual_dma = can_use_virtual_dma & 1;
-#if defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(FDC1)) {
 		del_timer(&fd_timeout);
 		err = -ENODEV;
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 9a92216..cc21914 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -67,14 +67,14 @@ static inline int i8042_platform_init(vo
  * On some platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on such boxes.
  */
-#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__) && !defined(CONFIG_PPC64)
+#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__) && !defined(CONFIG_PPC_MERGE)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return -EBUSY;
 #endif
 
         i8042_reset = 1;
 
-#if defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -EBUSY;
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 68efbea..f1c2469 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -9,6 +9,9 @@ #ifdef __KERNEL__
  * 2 of the License, or (at your option) any later version.
  */
 
+/* Check of existence of legacy devices */
+extern int check_legacy_ioport(unsigned long base_port);
+
 #ifndef CONFIG_PPC64
 #include <asm-ppc/io.h>
 #else
@@ -437,9 +440,6 @@ #define dma_cache_inv(_start,_size)		do 
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)
 
-/* Check of existence of legacy devices */
-extern int check_legacy_ioport(unsigned long base_port);
-
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem

-- 
dwmw2
