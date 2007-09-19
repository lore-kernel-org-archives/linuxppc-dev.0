Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id DCB03DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:51:34 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 19 Sep 2007 16:49:47 +1000
Subject: [PATCH 4/5] Include hrtimer.h in tick.h.
In-Reply-To: <1190184586.867449.381310088392.qpush@thor>
Message-Id: <20070919064947.F2FDB399913@thor>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

struct tick_shed uses struct hrtimer, explictly include the right header file.

preemtivly fixes the following warning
  CC      arch/powerpc/platforms/iseries/setup.o
In file included from arch/powerpc/platforms/iseries/setup.c:30:
include/linux/tick.h:45: error: field 'sched_timer' has incomplete type

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 include/linux/tick.h |    1 +
 1 file changed, 1 insertion(+)

Index: working/include/linux/tick.h
===================================================================
--- working.orig/include/linux/tick.h
+++ working/include/linux/tick.h
@@ -7,6 +7,7 @@
 #define _LINUX_TICK_H
 
 #include <linux/clockchips.h>
+#include <linux/hrtimer.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
