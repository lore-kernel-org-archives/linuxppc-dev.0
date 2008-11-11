Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 858B6DDF76
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 02:31:42 +1100 (EST)
Date: Tue, 11 Nov 2008 18:31:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/qe: Move cmxgcr_lock definition from the ucc.c
	into the qe.c
Message-ID: <20081111153139.GA10871@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch we can compile the qe_lib/usb.c without the UCC
support (that is, without UCC_GETH and/or SERIAL_QE).

Fixes following link error (CONFIG_SMP should be =y to trigger this):

arch/powerpc/sysdev/built-in.o: In function `qe_usb_clock_set':
(.text+0x3cae): undefined reference to `cmxgcr_lock'
make: *** [.tmp_vmlinux1] Error 1

While at it, also add missing spinlock.h includes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is for powerpc-next since nobody enables QE_USB yet.

 arch/powerpc/sysdev/qe_lib/qe.c  |    3 +++
 arch/powerpc/sysdev/qe_lib/ucc.c |    4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index b3b73ae..01bce37 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/param.h>
 #include <linux/string.h>
+#include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/bootmem.h>
@@ -38,6 +39,8 @@ static void qe_snums_init(void);
 static int qe_sdma_init(void);
 
 static DEFINE_SPINLOCK(qe_lock);
+DEFINE_SPINLOCK(cmxgcr_lock);
+EXPORT_SYMBOL(cmxgcr_lock);
 
 /* QE snum state */
 enum qe_snum_state {
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index 1d78071..ebb442e 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/spinlock.h>
 #include <linux/module.h>
 
 #include <asm/irq.h>
@@ -26,9 +27,6 @@
 #include <asm/qe.h>
 #include <asm/ucc.h>
 
-DEFINE_SPINLOCK(cmxgcr_lock);
-EXPORT_SYMBOL(cmxgcr_lock);
-
 int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
 {
 	unsigned long flags;
-- 
1.5.6.3
