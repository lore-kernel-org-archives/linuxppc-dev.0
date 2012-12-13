Return-Path: <anton@samba.org>
Date: Thu, 13 Dec 2012 11:34:53 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/3] powerpc: Enable devtmpfs, EFI partition support and
 tmpfs ACLs on pseries, ppc64 and ppc64e defconfig
Message-ID: <20121213113453.7fcd6d6b@kryten>
In-Reply-To: <20121213113240.12d0386c@kryten>
References: <20121213113240.12d0386c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We need devtmpfs enabled to boot on recent versions of Fedora. EFI
partitions will be useful for large block devices. tmpfs ACL support
is used by some distros for managing access to devices.

Signed-off-by: Anton Blanchard <anton@samba.org>
--- 

Index: b/arch/powerpc/configs/pseries_defconfig
===================================================================
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -32,6 +32,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_EFI_PARTITION=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
@@ -118,6 +120,8 @@ CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
@@ -283,6 +287,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_CRAMFS=m
 CONFIG_SQUASHFS=m
Index: b/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -25,6 +25,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_EFI_PARTITION=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
@@ -146,6 +147,8 @@ CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_FD=y
 CONFIG_BLK_DEV_LOOP=y
@@ -354,6 +357,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
Index: b/arch/powerpc/configs/ppc64e_defconfig
===================================================================
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -22,6 +22,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_EFI_PARTITION=y
 CONFIG_P5020_DS=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
@@ -119,6 +120,8 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_FD=y
 CONFIG_BLK_DEV_LOOP=y
@@ -277,6 +280,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_CRAMFS=y
