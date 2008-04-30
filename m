Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 304D5DDFD0
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 01:30:29 +1000 (EST)
Date: Wed, 30 Apr 2008 10:25:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] [POWERPC] Xilinx: Fix compile warnings
Message-ID: <Pine.LNX.4.64.0804301025270.19599@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="330304082-1539717417-1209569146=:19599"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--330304082-1539717417-1209569146=:19599
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

arch/powerpc/sysdev/xilinx_intc.c: In function ‘xilinx_intc_init’:
arch/powerpc/sysdev/xilinx_intc.c:111: warning: format ‘%08X’ expects type ‘unsigned int’, but argument 2 has type ‘resource_size_t’
drivers/char/xilinx_hwicap/xilinx_hwicap.c: In function ‘hwicap_setup’:
drivers/char/xilinx_hwicap/xilinx_hwicap.c:626: warning: cast to pointer from integer of different size
drivers/char/xilinx_hwicap/xilinx_hwicap.c:646: warning: format ‘%x’ expects type ‘unsigned int’, but argument 6 has type ‘resource_size_t’

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/xilinx_intc.c          |    2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index ba8eea2..b7aefd0 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -107,7 +107,7 @@ xilinx_intc_init(struct device_node *np)
 	}
 	regs = ioremap(res.start, 32);

-	printk(KERN_INFO "Xilinx intc at 0x%08X mapped to 0x%p\n",
+	printk(KERN_INFO "Xilinx intc at 0x%08LX mapped to 0x%p\n",
 		res.start, regs);

 	/* Setup interrupt controller */
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index dfe6907..3edf1fc 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -623,8 +623,8 @@ static int __devinit hwicap_setup(struct device *dev, int id,

 	if (!request_mem_region(drvdata->mem_start,
 					drvdata->mem_size, DRIVER_NAME)) {
-		dev_err(dev, "Couldn't lock memory region at %p\n",
-			(void *)regs_res->start);
+		dev_err(dev, "Couldn't lock memory region at %Lx\n",
+			regs_res->start);
 		retval = -EBUSY;
 		goto failed1;
 	}
@@ -643,7 +643,7 @@ static int __devinit hwicap_setup(struct device *dev, int id,
 	mutex_init(&drvdata->sem);
 	drvdata->is_open = 0;

-	dev_info(dev, "ioremap %lx to %p with size %x\n",
+	dev_info(dev, "ioremap %lx to %p with size %Lx\n",
 		 (unsigned long int)drvdata->mem_start,
 			drvdata->base_address, drvdata->mem_size);

-- 
1.5.4.1

--330304082-1539717417-1209569146=:19599--
