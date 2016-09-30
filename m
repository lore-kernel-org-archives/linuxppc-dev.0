Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slnyC6BHFzDvMd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 20:40:03 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/configs: Bump kernel ring buffer size on 64 bit
 configs
Date: Fri, 30 Sep 2016 20:39:51 +1000
Message-Id: <1475231993-20321-2-git-send-email-anton@ozlabs.org>
In-Reply-To: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
References: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

When we issue a system reset, every CPU in the box prints an Oops,
including a backtrace. Each of these can be quite large (over 4kB)
and we may end up wrapping the ring buffer and losing important
information.

Bump the base size from 128kB to 256kB and the per CPU size from
4kB to 8kB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 2 ++
 arch/powerpc/configs/ppc64_defconfig   | 2 ++
 arch/powerpc/configs/pseries_defconfig | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 3f6226b..95b52b4 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -15,6 +15,8 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
 CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 861471d..886b237 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -10,6 +10,8 @@ CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 670b8d5..2a5dac7 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -15,6 +15,8 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
 CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
 CONFIG_CGROUPS=y
-- 
2.7.4
