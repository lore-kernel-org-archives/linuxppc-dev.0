Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/spufs: Remove MAX_USER_PRIO define
Message-Id: <1392098717.689604.970589769393.1.gpush@pablo>
To: Ingo Molnar <mingo@kernel.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 11 Feb 2014 14:05:17 +0800
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current ppc64_defconfig fails with:

 arch/powerpc/platforms/cell/spufs/sched.c:86:0: error: "MAX_USER_PRIO" redefined [-Werror]
 cc1: all warnings being treated as errors

6b6350f1 introduced a generic MAX_USER_PRIO macro to sched/prio.h, which
is causing the conflit. Use that one instead of our own.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
Ingo: 6b6350f1 is currently in tip; this fixes a build breakage for spufs

---
 arch/powerpc/platforms/cell/spufs/sched.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 4931838..4a0a64f 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -83,7 +83,6 @@ static struct timer_list spuloadavg_timer;
 #define MIN_SPU_TIMESLICE	max(5 * HZ / (1000 * SPUSCHED_TICK), 1)
 #define DEF_SPU_TIMESLICE	(100 * HZ / (1000 * SPUSCHED_TICK))
 
-#define MAX_USER_PRIO		(MAX_PRIO - MAX_RT_PRIO)
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_SPU_TIMESLICE)
 
