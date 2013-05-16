Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA3E02C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:30:23 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
Date: Thu, 16 May 2013 14:29:45 +0800
Message-ID: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All these boards use the same configuration file p1_p2_rdb_pc.h in
u-boot. So they have the same pci bus address set by the u-boot.
But in some of these boards the bus address set in dtb don't match
the one used by u-boot. And this will trigger a kernel bug in 32bit
kernel and cause the pci device malfunction. For example, on a
p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
and cpu address for one pci controller and then assign bus address
such as 0xa00004000 to some pci device. But in the kernel, the dtb
set the bus address to 0xe0000000 and the cpu address to 0xa0000000.
The kernel assumes mistakenly the assigned bus address 0xa0004000
in pci device is correct and keep it unchanged. This will definitely
cause the pci device malfunction. I have made two patches to fix
this in the pci subsystem.
http://patchwork.ozlabs.org/patch/243702/
http://patchwork.ozlabs.org/patch/243703/

But I still think it makes sense to set these bus address to match
with the u-boot. This issue can't be reproduced on 36bit kernel.
But I also tweak the 36bit dtb for the above reason.

The cpu address for the pci controller seems also not right in
p1025rdb_32b/36b.dts. So fix it at the same time.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
I just tested this on a p2020rdb-pca board. All others just passed build test.

 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts | 4 ++--
 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts | 4 ++--
 arch/powerpc/boot/dts/p1020utm-pc_32b.dts | 4 ++--
 arch/powerpc/boot/dts/p1020utm-pc_36b.dts | 4 ++--
 arch/powerpc/boot/dts/p1024rdb_32b.dts    | 4 ++--
 arch/powerpc/boot/dts/p1024rdb_36b.dts    | 4 ++--
 arch/powerpc/boot/dts/p1025rdb_32b.dts    | 4 ++--
 arch/powerpc/boot/dts/p1025rdb_36b.dts    | 4 ++--
 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts | 4 ++--
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts b/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
index ab8f076..042bda5 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
+++ b/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
@@ -56,7 +56,7 @@
 
 	pci0: pcie@ffe09000 {
 		reg = <0x0 0xffe09000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0xa0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -71,7 +71,7 @@
 
 	pci1: pcie@ffe0a000 {
 		reg = <0x0 0xffe0a000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0x80000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
index 9e9f401..3afbd1f 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
@@ -56,7 +56,7 @@
 
 	pci0: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -71,7 +71,7 @@
 
 	pci1: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p1020utm-pc_32b.dts b/arch/powerpc/boot/dts/p1020utm-pc_32b.dts
index 4bfdd89..27576eb 100644
--- a/arch/powerpc/boot/dts/p1020utm-pc_32b.dts
+++ b/arch/powerpc/boot/dts/p1020utm-pc_32b.dts
@@ -56,7 +56,7 @@
 
 	pci0: pcie@ffe09000 {
 		reg = <0x0 0xffe09000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0xa0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -71,7 +71,7 @@
 
 	pci1: pcie@ffe0a000 {
 		reg = <0x0 0xffe0a000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0x80000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p1020utm-pc_36b.dts b/arch/powerpc/boot/dts/p1020utm-pc_36b.dts
index abec535..52eabf9c 100644
--- a/arch/powerpc/boot/dts/p1020utm-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p1020utm-pc_36b.dts
@@ -56,7 +56,7 @@
 
 	pci0: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0x0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -71,7 +71,7 @@
 
 	pci1: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p1024rdb_32b.dts b/arch/powerpc/boot/dts/p1024rdb_32b.dts
index 90e803e..ede1af6 100644
--- a/arch/powerpc/boot/dts/p1024rdb_32b.dts
+++ b/arch/powerpc/boot/dts/p1024rdb_32b.dts
@@ -53,7 +53,7 @@
 
 	pci0: pcie@ffe09000 {
 		reg = <0x0 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0xa0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -68,7 +68,7 @@
 
 	pci1: pcie@ffe0a000 {
 		reg = <0x0 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0x0 0x80000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
diff --git a/arch/powerpc/boot/dts/p1024rdb_36b.dts b/arch/powerpc/boot/dts/p1024rdb_36b.dts
index 3656825..7642783 100644
--- a/arch/powerpc/boot/dts/p1024rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1024rdb_36b.dts
@@ -53,7 +53,7 @@
 
 	pci0: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -68,7 +68,7 @@
 
 	pci1: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
diff --git a/arch/powerpc/boot/dts/p1025rdb_32b.dts b/arch/powerpc/boot/dts/p1025rdb_32b.dts
index ac5729c..6ba7ddd 100644
--- a/arch/powerpc/boot/dts/p1025rdb_32b.dts
+++ b/arch/powerpc/boot/dts/p1025rdb_32b.dts
@@ -54,7 +54,7 @@
 	};
 
 	pci0: pcie@ffe09000 {
-		ranges = <0x2000000 0x0 0xe0000000 0 0xe0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		reg = <0 0xffe09000 0 0x1000>;
 		pcie@0 {
@@ -70,7 +70,7 @@
 
 	pci1: pcie@ffe0a000 {
 		reg = <0 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0 0xe0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/p1025rdb_36b.dts
index 06deb6f..4659e2d 100644
--- a/arch/powerpc/boot/dts/p1025rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1025rdb_36b.dts
@@ -55,7 +55,7 @@
 
 	pci0: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xe 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -70,7 +70,7 @@
 
 	pci1: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts b/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
index 57573bd..4ab21f8 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
@@ -63,7 +63,7 @@
 
 	pci1: pcie@ffe09000 {
 		reg = <0 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0 0xa0000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -78,7 +78,7 @@
 
 	pci0: pcie@ffe0a000 {
 		reg = <0 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0 0x80000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
index 470247e..488f1ad 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
@@ -63,7 +63,7 @@
 
 	pci1: pcie@fffe09000 {
 		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
@@ -78,7 +78,7 @@
 
 	pci0: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		pcie@0 {
 			ranges = <0x2000000 0x0 0xe0000000
-- 
1.8.1.4
