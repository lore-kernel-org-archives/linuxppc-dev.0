Return-Path: <arnd@arndb.de>
Message-Id: <20081222214108.168571344@arndb.de>
References: <20081222213424.234398861@arndb.de>
In-Reply-To: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
Date: Mon, 22 Dec 2008 22:34:25 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 1/2] powerpc/cell: fix build breakage with CONFIG_SPUFS
	disabled
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CBE_THERM and OPROFILE_CELL both cannot be built without
SPU_FS disabled, so make the dependency explicit.

Reported-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index c14d7d8..617f845 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -102,7 +102,7 @@ config PPC_IBM_CELL_POWERBUTTON
 config CBE_THERM
 	tristate "CBE thermal support"
 	default m
-	depends on CBE_RAS
+	depends on CBE_RAS && SPU_BASE
 
 config CBE_CPUFREQ
 	tristate "CBE frequency scaling"
@@ -136,5 +136,5 @@ endmenu
 
 config OPROFILE_CELL
 	def_bool y
-	depends on PPC_CELL_NATIVE && (OPROFILE = m || OPROFILE = y)
+	depends on PPC_CELL_NATIVE && (OPROFILE = m || OPROFILE = y) && SPU_BASE
 
-- 
1.5.6.3

-- 
