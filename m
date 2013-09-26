Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/pseries: CONFIG_PSERIES_MSI should depend on
 PPC_PSERIES
Date: Thu, 26 Sep 2013 17:52:16 +1000
Message-Id: <1380181937-15156-1-git-send-email-michael@ellerman.id.au>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously PSERIES_MSI depended on PPC_PSERIES via EEH. However in
commit 317f06d "powerpc/eeh: Move common part to kernel directory" we
made CONFIG_EEH selectable on POWERNV. That leaves us with PSERIES_MSI
being live even when PSERIES=n. Fix it by making PSERIES_MSI depend
directly on PPC_PSERIES.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 62b4f80..e666432 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -34,7 +34,7 @@ config PPC_SPLPAR
 
 config PSERIES_MSI
        bool
-       depends on PCI_MSI && EEH
+       depends on PCI_MSI && PPC_PSERIES && EEH
        default y
 
 config PSERIES_ENERGY
-- 
1.8.1.2
