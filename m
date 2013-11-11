Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24DDF2C03A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:35:58 +1100 (EST)
Received: by mail-ob0-f182.google.com with SMTP id wp18so3911695obc.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Nov 2013 21:35:52 -0800 (PST)
From: Rob Herring <robherring2@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: add explicit OF includes for ppc4xx
Date: Sun, 10 Nov 2013 23:35:43 -0600
Message-Id: <1384148143-14335-1-git-send-email-robherring2@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vinod.koul@intel.com>,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, Tejun Heo <tj@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <rob.herring@calxeda.com>

Commit b5b4bb3f6a11f9 (of: only include prom.h on sparc) removed implicit
includes of of_*.h headers by powerpc's prom.h. Some PPC4xx components
were missed in initial clean-up patch, so add the necessary includes
to fix ppc4xx builds.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-ide@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
---
I intend to send this patch to Linus with the rest of the DT clean-up
series.

Rob

 arch/powerpc/sysdev/ppc4xx_ocm.c     | 1 +
 arch/powerpc/sysdev/xilinx_intc.c    | 1 +
 drivers/ata/sata_dwc_460ex.c         | 2 ++
 drivers/char/hw_random/ppc4xx-rng.c  | 1 +
 drivers/crypto/amcc/crypto4xx_core.c | 3 +++
 drivers/dma/ppc4xx/adma.c            | 2 ++
 6 files changed, 10 insertions(+)

diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4xx_ocm.c
index 1b15f93..b7c4345 100644
--- a/arch/powerpc/sysdev/ppc4xx_ocm.c
+++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <asm/rheap.h>
 #include <asm/ppc4xx_ocm.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index f4fdc94..83f943a 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/i8259.h>
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2e39173..523524b 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -31,6 +31,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
diff --git a/drivers/char/hw_random/ppc4xx-rng.c b/drivers/char/hw_random/ppc4xx-rng.c
index 732c330..521f76b 100644
--- a/drivers/char/hw_random/ppc4xx-rng.c
+++ b/drivers/char/hw_random/ppc4xx-rng.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/delay.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <asm/io.h>
 
diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index f88e3d8..efaf630 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -27,6 +27,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <asm/dcr.h>
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 370ff82..e24b5ef 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -42,6 +42,8 @@
 #include <linux/uaccess.h>
 #include <linux/proc_fs.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/dcr.h>
 #include <asm/dcr-regs.h>
-- 
1.8.1.2
