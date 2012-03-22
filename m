Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:59:04 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 6/6] powerpc/pseries: Cut down on enthusiastic use of
 defines in RAS code
Message-ID: <20120322125904.0f28b9ee@kryten>
In-Reply-To: <20120322125803.40bb5e34@kryten>
References: <20120322124707.3cd3037f@kryten> <20120322125343.63d77e82@kryten>
 <20120322125649.434c6f5e@kryten> <20120322125803.40bb5e34@kryten>
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


So many defines for such a little file. Most of them can go.

Also remove the single entry changelog, we have git for that.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:44:13.306570733 +1100
+++ linux-build/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:44:24.798779279 +1100
@@ -16,39 +16,15 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-/* Change Activity:
- * 2001/09/21 : engebret : Created with minimal EPOW and HW exception support.
- * End Change Activity
- */
-
-#include <linux/errno.h>
-#include <linux/threads.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
 #include <linux/sched.h>
-#include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/random.h>
-#include <linux/sysrq.h>
-#include <linux/bitops.h>
+#include <linux/of.h>
 #include <linux/fs.h>
 #include <linux/reboot.h>
 
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <asm/cache.h>
-#include <asm/prom.h>
-#include <asm/ptrace.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
-#include <asm/udbg.h>
 #include <asm/firmware.h>
 
 #include "pseries.h"
