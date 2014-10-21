Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C53E1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 16:32:08 +1100 (AEDT)
Message-ID: <1413869527.32433.6.camel@ale.ozlabs.ibm.com>
Subject: [PATCH] powerpc: Enable NUMA balancing in pseries[_le]_defconfig
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Tue, 21 Oct 2014 16:32:07 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables NUMA balancing in pseries[_le]_defconfig.

NUMA balancing can do some nasty things with the low level mm code and
has been causing some issues with the cxl driver.  Also distros are
enabling it (eg Ubuntu), so it would be good to get some more test
coverage with it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
mpe: This might help us find some bugs in v3.18, but it's probably
     better suited for your next tree.

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/=
pseries_defconfig
index dd2a9ca..de51828 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -17,6 +17,8 @@ CONFIG_TASK_XACCT=3Dy
 CONFIG_TASK_IO_ACCOUNTING=3Dy
 CONFIG_IKCONFIG=3Dy
 CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_NUMA_BALANCING=3Dy
+CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
 CONFIG_CGROUPS=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/confi=
gs/pseries_le_defconfig
index 63392f4..db0b636 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -18,6 +18,8 @@ CONFIG_TASK_XACCT=3Dy
 CONFIG_TASK_IO_ACCOUNTING=3Dy
 CONFIG_IKCONFIG=3Dy
 CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_NUMA_BALANCING=3Dy
+CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
 CONFIG_CGROUPS=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
