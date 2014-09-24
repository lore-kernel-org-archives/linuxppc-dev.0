Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B26FC1A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:57:14 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: Don't build powernv for other platform defconfigs
Date: Wed, 24 Sep 2014 15:57:10 +1000
Message-Id: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because powernv arrived after these other platforms, the defconfigs
didn't have PPC_POWERNV disabled, and being default y it gets turned on.

If we're going to bother having defconfigs for the specific platforms
then they should only build the code required for those platforms.

The grab bag of everything config is ppc64_defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/cell_defconfig   | 1 +
 arch/powerpc/configs/celleb_defconfig | 1 +
 arch/powerpc/configs/g5_defconfig     | 1 +
 arch/powerpc/configs/maple_defconfig  | 1 +
 arch/powerpc/configs/pasemi_defconfig | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 45fd06cdc3e8..7a7b3c879f96 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -18,6 +18,7 @@ CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_PS3=y
diff --git a/arch/powerpc/configs/celleb_defconfig b/arch/powerpc/configs/celleb_defconfig
index 77d7bf3ca2ac..acccbfde8a50 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -15,6 +15,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_CELLEB=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 7594c5ac6481..6fab06f7f411 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -16,6 +16,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index c8b6a9ddb21b..fbd9e4163311 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -16,6 +16,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_MAPLE=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index e5e7838af008..3e72c8c06a0d 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -14,6 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_PASEMI=y
-- 
1.9.1
