Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS7Xq4fgDzDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 20:58:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/configs: Re-enable HARD/SOFT lockup detectors
Date: Wed,  9 Aug 2017 20:57:55 +1000
Message-Id: <1502276275-13639-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 05a4a9527931 ("kernel/watchdog: split up config options"),
CONFIG_LOCKUP_DETECTOR was split into two separate config options,
CONFIG_HARDLOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR.

Our defconfigs still have CONFIG_LOCKUP_DETECTOR=y, but that is no longer
user selectable, and we don't mention the new options, so we end up with
none of them enabled.

So update the defconfigs to turn on the new SOFT and HARD options, the
end result being the same as what we had previously.

Fixes: 05a4a9527931 ("kernel/watchdog: split up config options")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/powernv_defconfig | 3 ++-
 arch/powerpc/configs/ppc64_defconfig   | 3 ++-
 arch/powerpc/configs/pseries_defconfig | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0695ce047d56..34fc9bbfca9e 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -293,7 +293,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_LOCKUP_DETECTOR=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 5175028c56ce..c5246d29f385 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -324,7 +324,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_LOCKUP_DETECTOR=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 1a61aa20dfba..fd5d98a0b95c 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -291,7 +291,8 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_LOCKUP_DETECTOR=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
-- 
2.7.4
