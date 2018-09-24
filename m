Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jpgr1Xb7zF3F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:55:20 +1000 (AEST)
Message-Id: <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 1/9] timer: fix circular header dependency
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org
Date: Mon, 24 Sep 2018 15:52:21 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
has to be included in asm/smp.h for the following change, in order
to avoid uncomplete definition of task_struct:

-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (current->cpu)

But this generates the following compilation error, due to circular
header dependency.

  CC      kernel/time/alarmtimer.o
In file included from ./arch/powerpc/include/asm/smp.h:31,
                 from ./include/linux/smp.h:64,
                 from ./include/linux/percpu.h:7,
                 from ./include/linux/hrtimer.h:22,
                 from kernel/time/alarmtimer.c:19:
./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
  struct hrtimer   dl_timer;
                   ^~~~~~~~
./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
  struct hrtimer inactive_timer;
                 ^~~~~~~~~~~~~~
make[1]: *** [kernel/time/alarmtimer.o] Error 1
make: *** [kernel/time/alarmtimer.o] Error 2

  CC      fs/timerfd.o
In file included from ./arch/powerpc/include/asm/smp.h:31,
                 from ./include/linux/smp.h:64,
                 from ./include/linux/percpu.h:7,
                 from ./include/linux/hrtimer.h:22,
                 from ./include/linux/alarmtimer.h:6,
                 from fs/timerfd.c:12:
./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
  struct hrtimer   dl_timer;
                   ^~~~~~~~
./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
  struct hrtimer inactive_timer;
                 ^~~~~~~~~~~~~~
make[1]: *** [fs/timerfd.o] Error 1
make: *** [fs/timerfd.o] Error 2

This patch fixes it by including linux/hrtimer.h after linux/sched.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Should it be fixed in powerpc instead ? In that case, how ? Any idea ?

 fs/timerfd.c             | 2 +-
 kernel/time/alarmtimer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index d69ad801eb80..0fc01b241382 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -9,12 +9,12 @@
  *
  */
 
-#include <linux/alarmtimer.h>
 #include <linux/file.h>
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <linux/alarmtimer.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/list.h>
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index fa5de5e8de61..5fb75c9b3f06 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -16,11 +16,11 @@
  * published by the Free Software Foundation.
  */
 #include <linux/time.h>
-#include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
 #include <linux/rtc.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/hrtimer.h>
 #include <linux/alarmtimer.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-- 
2.13.3
