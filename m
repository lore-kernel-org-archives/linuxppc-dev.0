Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54C091A0CD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:37 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 6/7] powerpc: Enable various container features on pseries
 defconfigs.
Date: Tue, 20 Jan 2015 10:24:24 +1100
Message-Id: <1421709865-6368-6-git-send-email-anton@samba.org>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable config options required by lxc and docker.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/pseries_defconfig    | 12 ++++++++++++
 arch/powerpc/configs/pseries_le_defconfig | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index dbcef63..21c284e 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -20,6 +20,11 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_SWAP=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
@@ -70,6 +75,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -124,6 +130,7 @@ CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_THIN_PROVISIONING=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
@@ -132,8 +139,12 @@ CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_UEVENT=y
 CONFIG_BONDING=m
 CONFIG_DUMMY=m
+CONFIG_MACVLAN=m
+CONFIG_MACVTAP=m
+CONFIG_VXLAN=m
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
+CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
 CONFIG_VORTEX=y
@@ -166,6 +177,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 # CONFIG_SERIO_SERPORT is not set
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 14a7a7a..3805ade 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -21,6 +21,11 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_SWAP=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
@@ -71,6 +76,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -125,6 +131,7 @@ CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_THIN_PROVISIONING=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
@@ -133,8 +140,12 @@ CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_UEVENT=y
 CONFIG_BONDING=m
 CONFIG_DUMMY=m
+CONFIG_MACVLAN=m
+CONFIG_MACVTAP=m
+CONFIG_VXLAN=m
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
+CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
 CONFIG_VORTEX=y
@@ -167,6 +178,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 # CONFIG_SERIO_SERPORT is not set
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
-- 
2.1.0
