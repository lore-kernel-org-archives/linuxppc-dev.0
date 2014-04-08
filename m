Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 12818140115
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 14:21:14 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/4xx: Fix section mismatch in ppc4xx_pci.c
Date: Tue,  8 Apr 2014 14:20:19 +1000
Message-Id: <1396930819-13173-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes this section mismatch:

WARNING: vmlinux.o(.text+0x1efc4): Section mismatch in reference from
the function apm821xx_pciex_init_port_hw() to the function
.init.text:ppc4xx_pciex_wait_on_sdr.isra.9()

The function apm821xx_pciex_init_port_hw() references the function
__init ppc4xx_pciex_wait_on_sdr.isra.9().  This is often because
apm821xx_pciex_init_port_hw lacks a __init annotation or the
annotation of ppc4xx_pciex_wait_on_sdr.isra.9 is wrong.

apm821xx_pciex_init_port_hw is only referenced by a struct in
__initdata, so it should be safe to add __init to
apm821xx_pciex_init_port_hw.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/sysdev/ppc4xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 64603a1..4914fd3 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1058,7 +1058,7 @@ static int __init apm821xx_pciex_core_init(struct device_node *np)
 	return 1;
 }
 
-static int apm821xx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init apm821xx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	u32 val;
 
-- 
1.8.3.2
