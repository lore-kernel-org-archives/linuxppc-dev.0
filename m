Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.032005145@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:39 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 04/11] powerpc/spufs: add atomic busy_spus counter to struct
	cbe_spu_info
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As nr_active counter includes also spus waiting for syscalls to return
we need a seperate counter that only counts spus that are currently running
on spu side. This counter shall be used by a cpufreq governor that targets
a frequency dependent from the number of running spus.

From: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Christian Krafft <krafft@de.ibm.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c |    6 ++++++
 include/asm-powerpc/spu.h                 |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index e929e70..be77910 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -993,6 +993,7 @@ void spuctx_switch_state(struct spu_context *ctx,
 	struct timespec ts;
 	struct spu *spu;
 	enum spu_utilization_state old_state;
+	int node;
 
 	ktime_get_ts(&ts);
 	curtime = timespec_to_ns(&ts);
@@ -1014,6 +1015,11 @@ void spuctx_switch_state(struct spu_context *ctx,
 		spu->stats.times[old_state] += delta;
 		spu->stats.util_state = new_state;
 		spu->stats.tstamp = curtime;
+		node = spu->node;
+		if (old_state == SPU_UTIL_USER)
+			atomic_dec(&cbe_spu_info[node].busy_spus);
+		if (new_state == SPU_UTIL_USER);
+			atomic_inc(&cbe_spu_info[node].busy_spus);
 	}
 }
 
diff --git a/include/asm-powerpc/spu.h b/include/asm-powerpc/spu.h
index 99348c1..8b2eb04 100644
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -191,6 +191,7 @@ struct cbe_spu_info {
 	struct list_head spus;
 	int n_spus;
 	int nr_active;
+	atomic_t busy_spus;
 	atomic_t reserved_spus;
 };
 
-- 
1.5.4.3

-- 
