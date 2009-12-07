Return-Path: <anton@ozlabs.org>
Date: Mon, 7 Dec 2009 14:48:33 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 4/4] powerpc: Set HZ=100 on pseries and ppc64 defconfigs
Message-ID: <20091207034833.GD3421@kryten>
References: <20091207034509.GA3421@kryten> <20091207034555.GB3421@kryten>
	<20091207034714.GC3421@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091207034714.GC3421@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we have high res timers there is less of a reason for a high HZ value.
Furthermore I think there a few reasons we should reduce HZ to 100:

- Timer interrupt overhead. While this overhead is small, there are
  applications that are very sensitive to jitter (eg some HPC apps).

- Issues with the timer wheel code. When coming out of NO_HZ idle we work our
  way through the timer code one tick at a time.  If we have been idle a long
  time, this adds up - I sometimes see milliseconds of time spent in that
  loop.

  Long term we should fix the timer wheel algorithm, but for now if we reduce
  HZ then we reduce the amount of work the timer code has to do when coming
  out of idle.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/ppc64_defconfig	2009-11-27 11:58:09.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/ppc64_defconfig	2009-11-27 11:58:43.000000000 +1100
@@ -306,11 +306,11 @@ CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
-# CONFIG_HZ_100 is not set
-CONFIG_HZ_250=y
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
-CONFIG_HZ=250
+CONFIG_HZ=100
 CONFIG_SCHED_HRTICK=y
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
Index: linux.trees.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/pseries_defconfig	2009-11-27 11:58:11.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/pseries_defconfig	2009-11-27 11:58:31.000000000 +1100
@@ -231,11 +231,11 @@ CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
-# CONFIG_HZ_100 is not set
-CONFIG_HZ_250=y
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
-CONFIG_HZ=250
+CONFIG_HZ=100
 CONFIG_SCHED_HRTICK=y
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
