Return-Path: <anton@ozlabs.org>
Date: Sun, 14 Oct 2007 14:15:36 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] enable SLUB
Message-ID: <20071014191536.GA26693@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

When checking out the new NO_HZ support in powerpc, I noticed we never
slept for more than 2 seconds. It turns out SLAB has a 2 second per cpu
timer that causes this.

After switching to SLUB I see some nice 4 second sleeps which is the
limit on this POWER6 box (the decrementer ticks at 512MHz):

slept 4.19 sec
slept 4.19 sec
slept 4.19 sec
slept 4.19 sec
slept 3.96 sec
slept 3.80 sec
slept 2.99 sec

Since SLUB is now the default and some powerpc defconfigs already enable
it, lets enable SLUB across the board for consistency. While doing this
I also noticed that the maple defconfig has SLAB debugging enabled which
is sure to make your box nice and slow. Fix that too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/configs/bamboo_defconfig b/arch/powerpc/configs/bamboo_defconfig
index b592dec..d22fed6 100644
--- a/arch/powerpc/configs/bamboo_defconfig
+++ b/arch/powerpc/configs/bamboo_defconfig
@@ -91,8 +91,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -695,7 +696,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/celleb_defconfig b/arch/powerpc/configs/celleb_defconfig
index b4ac498..2c59698 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -92,8 +92,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1218,7 +1219,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index c3977e3..6f27e57 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -92,8 +92,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1373,7 +1374,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/ebony_defconfig b/arch/powerpc/configs/ebony_defconfig
index 3a50467..35a95dd 100644
--- a/arch/powerpc/configs/ebony_defconfig
+++ b/arch/powerpc/configs/ebony_defconfig
@@ -90,8 +90,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -773,7 +774,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index a655d87..0a6fa1f 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -92,8 +92,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1580,7 +1581,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index 97d0202..1100918 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -88,8 +88,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -909,7 +910,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index 3fe1929..d78e3a6 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -93,8 +93,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1056,7 +1057,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/kilauea_defconfig b/arch/powerpc/configs/kilauea_defconfig
index 31790d3..fd1c530 100644
--- a/arch/powerpc/configs/kilauea_defconfig
+++ b/arch/powerpc/configs/kilauea_defconfig
@@ -91,8 +91,9 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -700,7 +701,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index a4e3ee0..401033a 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -89,8 +89,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1459,7 +1460,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/lite5200_defconfig b/arch/powerpc/configs/lite5200_defconfig
index d42e226..dd78ed9 100644
--- a/arch/powerpc/configs/lite5200_defconfig
+++ b/arch/powerpc/configs/lite5200_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -816,7 +817,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 96b538b..84b9ab4 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -90,8 +90,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1095,8 +1096,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-CONFIG_DEBUG_SLAB=y
-# CONFIG_DEBUG_SLAB_LEAK is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index 05814a3..87ae894 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 6b7951e..865a942 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -85,8 +85,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -867,7 +868,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8313_rdb_defconfig b/arch/powerpc/configs/mpc8313_rdb_defconfig
index f387dac..259d40d 100644
--- a/arch/powerpc/configs/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/mpc8313_rdb_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1272,7 +1273,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/mpc832x_mds_defconfig
index fc66953..dd68d18 100644
--- a/arch/powerpc/configs/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc832x_rdb_defconfig b/arch/powerpc/configs/mpc832x_rdb_defconfig
index 6d1c3e8..4f39102 100644
--- a/arch/powerpc/configs/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc832x_rdb_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index ddafa6b..eb28dd8 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/mpc834x_itxgp_defconfig
index 8241c69..22b9546 100644
--- a/arch/powerpc/configs/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/mpc834x_itxgp_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
index 06233b1..e59a88e 100644
--- a/arch/powerpc/configs/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/mpc836x_mds_defconfig
index 3045749..7565752 100644
--- a/arch/powerpc/configs/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/mpc8540_ads_defconfig b/arch/powerpc/configs/mpc8540_ads_defconfig
index b282c35..b953b2c 100644
--- a/arch/powerpc/configs/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/mpc8540_ads_defconfig
@@ -90,8 +90,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -704,7 +705,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8544_ds_defconfig b/arch/powerpc/configs/mpc8544_ds_defconfig
index 150221f..9a3e08b 100644
--- a/arch/powerpc/configs/mpc8544_ds_defconfig
+++ b/arch/powerpc/configs/mpc8544_ds_defconfig
@@ -93,8 +93,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1427,7 +1428,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8560_ads_defconfig b/arch/powerpc/configs/mpc8560_ads_defconfig
index 3d68c65..0211e6b 100644
--- a/arch/powerpc/configs/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/mpc8560_ads_defconfig
@@ -94,8 +94,9 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -791,7 +792,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8568mds_defconfig b/arch/powerpc/configs/mpc8568mds_defconfig
index 0307fe7..883d8af 100644
--- a/arch/powerpc/configs/mpc8568mds_defconfig
+++ b/arch/powerpc/configs/mpc8568mds_defconfig
@@ -88,8 +88,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -949,7 +950,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8572_ds_defconfig b/arch/powerpc/configs/mpc8572_ds_defconfig
index 7f1a3e9..4e85b2e 100644
--- a/arch/powerpc/configs/mpc8572_ds_defconfig
+++ b/arch/powerpc/configs/mpc8572_ds_defconfig
@@ -93,8 +93,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1427,7 +1428,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc85xx_cds_defconfig b/arch/powerpc/configs/mpc85xx_cds_defconfig
index e6850c6..a4f33d1 100644
--- a/arch/powerpc/configs/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/mpc85xx_cds_defconfig
@@ -90,8 +90,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -832,7 +833,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index de19b78..0483211 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -88,8 +88,9 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -993,7 +994,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/mpc8641_hpcn_defconfig
index b2f389d..ed214fc 100644
--- a/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -94,8 +94,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1432,7 +1433,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 143a0cd..070b0a5 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -83,8 +83,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 2952070..1ccf3ed 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -90,8 +90,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1588,7 +1589,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index cfc9c65..95b823b 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -91,8 +91,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1829,7 +1830,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 5f6224a..76e3fab 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -96,8 +96,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1750,7 +1751,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index a51fc39..9191f55 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -86,8 +86,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -930,7 +931,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index cce3d3d..3e87faf 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -89,8 +89,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index ca7a197..3566c44 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -91,8 +91,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1059,7 +1060,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 0f274e5..2362474 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -96,8 +96,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -1504,7 +1505,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/sequoia_defconfig b/arch/powerpc/configs/sequoia_defconfig
index bc7f508..45a4ca0 100644
--- a/arch/powerpc/configs/sequoia_defconfig
+++ b/arch/powerpc/configs/sequoia_defconfig
@@ -91,8 +91,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -781,7 +782,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
diff --git a/arch/powerpc/configs/walnut_defconfig b/arch/powerpc/configs/walnut_defconfig
index 766bf84..7724292 100644
--- a/arch/powerpc/configs/walnut_defconfig
+++ b/arch/powerpc/configs/walnut_defconfig
@@ -87,8 +87,9 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -706,7 +707,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
