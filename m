Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id DF098DDFF9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:25:19 +1000 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00GQD6A7AQA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:19 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM00DX86A61740@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 16:25:19 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00AV36A5W890@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:18 -0600 (MDT)
Date: Mon, 08 Oct 2007 16:25:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 5/6] MPC52xx: Trim includes on mpc5200 platform support code
In-reply-to: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
Message-id: <20071008222517.25840.46075.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Drop unnecessary includes for MPC5200 based boards

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/efika.c          |   21 ++-------------------
 arch/powerpc/platforms/52xx/lite5200.c       |   22 +---------------------
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    4 +---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |   12 +-----------
 4 files changed, 5 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 0b1e60a..e5bc493 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -9,33 +9,16 @@
  * kind, whether express or implied.
  */
 
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/utsrelease.h>
-#include <linux/seq_file.h>
-#include <linux/string.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/timer.h>
 #include <linux/pci.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/sections.h>
-#include <asm/pci-bridge.h>
-#include <asm/pgtable.h>
-#include <asm/prom.h>
+#include <linux/of.h>
 #include <asm/time.h>
+#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/mpc52xx.h>
 
-
 #define EFIKA_PLATFORM_NAME "Efika"
 
 
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 6469813..c1aca5e 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -15,32 +15,12 @@
 
 #undef DEBUG
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
+#include <linux/of.h>
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <asm/of_platform.h>
-
 #include <asm/mpc52xx.h>
 
 /* ************************************************************************
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 2dd415f..93e7869 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -13,10 +13,8 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
-
+#include <linux/of_platform.h>
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_platform.h>
 #include <asm/mpc52xx.h>
 
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 0f4ca8a..0cfcc42 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -18,19 +18,9 @@
 
 #undef DEBUG
 
-#include <linux/stddef.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/hardirq.h>
-
+#include <linux/of.h>
 #include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/mpc52xx.h>
 #include "mpc52xx_pic.h"
 
