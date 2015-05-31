Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id DFD911A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:16:59 +1000 (AEST)
Message-Id: <20150531010135.589206045@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:45 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Subject: [RFC 13/24] powerpc: Cleanup nvram includes
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nvram_read_byte() and nvram_write_byte() definitions in asm/nvram.h
duplicate those in linux/nvram.h. Get rid of the former to prepare for
adoption of struct arch_nvram_ops (which is defined in linux/nvram.h for
general use).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/powerpc/include/asm/nvram.h           |    3 ---
 arch/powerpc/kernel/setup_32.c             |    1 +
 drivers/char/generic_nvram.c               |    4 +++-
 drivers/video/fbdev/matrox/matroxfb_base.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/powerpc/include/asm/nvram.h
===================================================================
--- linux.orig/arch/powerpc/include/asm/nvram.h	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/include/asm/nvram.h	2015-05-31 11:01:13.000000000 +1000
@@ -101,7 +101,4 @@ extern int nvram_write_os_partition(stru
 /* Determine NVRAM size */
 extern ssize_t nvram_get_size(void);
 
-/* Normal access to NVRAM */
-extern unsigned char nvram_read_byte(int i);
-extern void nvram_write_byte(unsigned char c, int i);
 #endif /* _ASM_POWERPC_NVRAM_H */
Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/kernel/setup_32.c	2015-05-31 11:01:13.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/memblock.h>
+#include <linux/nvram.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
Index: linux/drivers/char/generic_nvram.c
===================================================================
--- linux.orig/drivers/char/generic_nvram.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/drivers/char/generic_nvram.c	2015-05-31 11:01:13.000000000 +1000
@@ -20,9 +20,11 @@
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/nvram.h>
 #include <asm/uaccess.h>
-#include <asm/nvram.h>
+
 #ifdef CONFIG_PPC_PMAC
+#include <asm/nvram.h>
 #include <asm/machdep.h>
 #endif
 
Index: linux/drivers/video/fbdev/matrox/matroxfb_base.c
===================================================================
--- linux.orig/drivers/video/fbdev/matrox/matroxfb_base.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/drivers/video/fbdev/matrox/matroxfb_base.c	2015-05-31 11:01:13.000000000 +1000
@@ -111,12 +111,12 @@
 #include "matroxfb_g450.h"
 #include <linux/matroxfb.h>
 #include <linux/interrupt.h>
+#include <linux/nvram.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
-unsigned char nvram_read_byte(int);
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 #endif
