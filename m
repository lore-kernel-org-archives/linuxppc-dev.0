Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 676352C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 20:42:02 +1100 (EST)
Date: Tue, 11 Feb 2014 10:41:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] powerpc/spufs: Fix duplicate definition of MAX_USER_PRIO
Message-ID: <20140211094106.GM27965@twins.programming.kicks-ass.net>
References: <52f92761.nu9w3QblrTnGpeYg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52f92761.nu9w3QblrTnGpeYg%fengguang.wu@intel.com>
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 11, 2014 at 03:24:17AM +0800, kbuild test robot wrote:
> >> arch/powerpc/platforms/cell/spufs/sched.c:86:0: warning: "MAX_USER_PRIO" redefined [enabled by default]
>     #define MAX_USER_PRIO  (MAX_PRIO - MAX_RT_PRIO)
>     ^
>    In file included from include/linux/sched.h:6:0,
>                     from arch/powerpc/platforms/cell/spufs/sched.c:26:
>    include/linux/sched/prio.h:39:0: note: this is the location of the previous definition
>     #define MAX_USER_PRIO  (USER_PRIO(MAX_PRIO))
>     ^

Since USER_PRIO(p) is ((p)-MAX_RT_PRIO) the above two definitions are
the same and we can simply remove the spufs one.

Fixes: 6b6350f155af ("sched: Expose some macros related to priority")
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 49318385d4fa..4a0a64fe25df 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -83,7 +83,6 @@ static struct timer_list spuloadavg_timer;
 #define MIN_SPU_TIMESLICE	max(5 * HZ / (1000 * SPUSCHED_TICK), 1)
 #define DEF_SPU_TIMESLICE	(100 * HZ / (1000 * SPUSCHED_TICK))
 
-#define MAX_USER_PRIO		(MAX_PRIO - MAX_RT_PRIO)
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_SPU_TIMESLICE)
 
