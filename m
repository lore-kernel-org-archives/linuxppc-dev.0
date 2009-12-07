Return-Path: <anton@ozlabs.org>
Date: Mon, 7 Dec 2009 14:45:09 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/4] powerpc: Reduce 64bit vmlinux by making acenic and
	cramfs modules
Message-ID: <20091207034509.GA3421@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Machines with acenic adapters are rare these days, so we may as well make it
a module. Cramfs is also very rarely used so we can make it a module.

Together this saves 143kB on a 64bit compile:

   text	   data	    bss	    dec	    hex	filename
8247176	1729404	1221988	11198568	 aae068	vmlinux~
8134997	1727588	1188836	11051421	 a8a19d	vmlinux

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/g5_defconfig	2009-11-25 12:47:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/g5_defconfig	2009-11-25 12:47:41.000000000 +1100
@@ -757,7 +757,7 @@ CONFIG_SUNGEM=y
 # CONFIG_B44 is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
-CONFIG_ACENIC=y
+CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
Index: linux.trees.git/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/ppc64_defconfig	2009-11-25 12:47:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/ppc64_defconfig	2009-11-25 12:47:41.000000000 +1100
@@ -980,7 +980,7 @@ CONFIG_E100=y
 # CONFIG_SC92031 is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
-CONFIG_ACENIC=y
+CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
@@ -1863,7 +1863,7 @@ CONFIG_HFSPLUS_FS=m
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_CRAMFS=y
+CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
Index: linux.trees.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/pseries_defconfig	2009-11-25 12:47:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/pseries_defconfig	2009-11-25 12:47:41.000000000 +1100
@@ -796,7 +796,7 @@ CONFIG_E100=y
 # CONFIG_NET_POCKET is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
-CONFIG_ACENIC=y
+CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
@@ -1494,7 +1494,7 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_CRAMFS=y
+CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
