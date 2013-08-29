Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4D0D2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 16:55:15 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T6t7pL011068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 01:55:09 -0500
Message-ID: <1377759307.4028.23.camel@pasglop>
Subject: [PATCH] powerpc: Enable /dev/port when isa_io_special is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 16:55:07 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

isa_io_special is set when the platform provides a "special"
implementation of inX/outX via some FW interface for example.

Such a platform doesn't need an ISA bridge on PCI, and so /dev/port
should be made available even if one isn't present.

This makes the LPC bus IOs accessible via /dev/port on PowerNV Power8

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5a64757..edcc209 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -21,7 +21,7 @@ extern struct pci_dev *isa_bridge_pcidev;
 /*
  * has legacy ISA devices ?
  */
-#define arch_has_dev_port()	(isa_bridge_pcidev != NULL)
+#define arch_has_dev_port()	(isa_bridge_pcidev != NULL || isa_io_special)
 #endif
 
 #include <linux/device.h>
