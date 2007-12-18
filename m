Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D810DDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:04 +1100 (EST)
Message-Id: <20071218175103.585043000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:53 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 01/18] perfmon2: make pm_interval register read/write
Cc: linuxppc-dev@ozlabs.org, Kevin Corry <kevcorry@us.ibm.com>,
	Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pm_interval register in the Cell PMU is read/write, but was implemented in
the kernel as write-only. Previously, the written value was saved in a "shadow"
copy so calls to cbe_read_pm() could return the value.

Perfmon2 needs to be able to read the current values of pm_interval, so change
cbe_read_pm() to read the actual register instead of the "shadow" copy. There
is currently no code in the kernel that tries to read the pm_interval register
with cbe_read_pm() (expecting to receive the "shadow" value), so this should
not break any existing code.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/pmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/pmu.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/pmu.c
@@ -213,7 +213,7 @@ u32 cbe_read_pm(u32 cpu, enum pm_reg_nam
 		break;
 
 	case pm_interval:
-		READ_SHADOW_REG(val, pm_interval);
+		READ_MMIO_UPPER32(val, pm_interval);
 		break;
 
 	case pm_start_stop:

-- 
