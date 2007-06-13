Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 12/13] Don't store a command line in the Holly device tree
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045300.C2FC9DDF12@ozlabs.org>
Date: Wed, 13 Jun 2007 14:53:00 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the Holly device tree includes a bootargs property in
/chosen, which gives a commandline.  This is somewhat inconvenient,
because it means an alternative default command line can't be given in
the kernel config - the value obtained from the dts via the
bootwrapper will always override CONFIG_CMDLINE.

This patch removes the command line from the dts, and instead puts the
same command line as a default in holly_defconfig.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/dts/holly.dts      |    1 -
 arch/powerpc/configs/holly_defconfig |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: working-2.6/arch/powerpc/boot/dts/holly.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2007-05-08 14:58:06.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/holly.dts	2007-05-24 13:55:38.000000000 +1000
@@ -193,6 +193,5 @@
 
 	chosen {
 		linux,stdout-path = "/tsi109@c0000000/serial@7808";
-		bootargs = "console=ttyS0,115200";
 	};
 };
Index: working-2.6/arch/powerpc/configs/holly_defconfig
===================================================================
--- working-2.6.orig/arch/powerpc/configs/holly_defconfig	2007-05-24 13:55:53.000000000 +1000
+++ working-2.6/arch/powerpc/configs/holly_defconfig	2007-05-24 13:56:16.000000000 +1000
@@ -182,7 +182,8 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
 # CONFIG_WANT_DEVICE_TREE is not set
