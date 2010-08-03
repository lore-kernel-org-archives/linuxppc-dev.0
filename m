Return-Path: <tie-fei.zang@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 875361008C8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 15:15:40 +1000 (EST)
Received: from mail129-tx2 (localhost.localdomain [127.0.0.1])	by
	mail129-tx2-R.bigfish.com (Postfix) with ESMTP id 424E813980EA	for
	<linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 05:00:31 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.251])	by
	mail129-tx2.bigfish.com (Postfix) with ESMTP id CE53FCC0046	for
	<linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 05:00:30 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7350Tfi011752	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 22:00:29 -0700 (MST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] P4080/mtd: Fix the freescale lbc issue with 36bit mode
Date: Tue, 3 Aug 2010 12:45:14 +0800
Message-ID: <1280810714-30639-3-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1280810714-30639-2-git-send-email-tie-fei.zang@freescale.com>
References: <1280810714-30639-1-git-send-email-tie-fei.zang@freescale.com>
	<1280810714-30639-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B25806@freescale.com, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lan Chunhe-B25806 <b25806@freescale.com>

When system uses 36bit physical address, res.start is 36bit
physical address. But the function of in_be32 returns 32bit
physical address. Then both of them compared each other is
wrong. So by converting the address of res.start into
the right format fixes this issue.

Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/include/asm/fsl_lbc.h |    1 +
 arch/powerpc/sysdev/fsl_lbc.c      |   33 ++++++++++++++++++++++++++++++++-
 drivers/mtd/nand/fsl_elbc_nand.c   |    2 +-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 9b95eab..28dcf63 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -249,6 +249,7 @@ struct fsl_upm {
 	int width;
 };
 
+extern unsigned int convert_lbc_address(phys_addr_t addr_base);
 extern int fsl_lbc_find(phys_addr_t addr_base);
 extern int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm);
 
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 9c9e44f..08f98d8 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -31,6 +31,36 @@ struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
 EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
 
 /**
+ * convert_lbc_address - convert the base address
+ * @addr_base:	base address of the memory bank
+ *
+ * This function converts a base address of lbc into the right format for the BR
+ * registers. If the SOC has eLBC then it returns 32bit physical address else
+ * it returns 34bit physical address for local bus(Example: MPC8641).
+ */
+unsigned int convert_lbc_address(phys_addr_t addr_base)
+{
+	void *dev;
+	int compatible;
+
+	dev = of_find_node_by_name(NULL, "localbus");
+	if (!dev) {
+		printk(KERN_INFO "fsl-lbc: can't find localbus node\n");
+		of_node_put(dev);
+		return 0;
+	}
+
+	compatible = of_device_is_compatible(dev, "fsl,elbc");
+	of_node_put(dev);
+	if (compatible)
+		return addr_base & 0xffff8000;
+	else
+		return (addr_base & 0x0ffff8000ull) \
+			| ((addr_base & 0x300000000ull) >> 19);
+}
+EXPORT_SYMBOL(convert_lbc_address);
+
+/**
  * fsl_lbc_find - find Localbus bank
  * @addr_base:	base address of the memory bank
  *
@@ -50,7 +80,8 @@ int fsl_lbc_find(phys_addr_t addr_base)
 		__be32 br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].br);
 		__be32 or = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].or);
 
-		if (br & BR_V && (br & or & BR_BA) == addr_base)
+		if (br & BR_V && (br & or & BR_BA) \
+				== convert_lbc_address(addr_base))
 			return i;
 	}
 
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 7bbcb3f..0e8dc40 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -838,7 +838,7 @@ static int __devinit fsl_elbc_nand_probe(struct of_device *dev,
 		    (in_be32(&lbc->bank[bank].br) & BR_MSEL) == BR_MS_FCM &&
 		    (in_be32(&lbc->bank[bank].br) &
 		     in_be32(&lbc->bank[bank].or) & BR_BA)
-		     == res.start)
+		     == convert_lbc_address(res.start))
 			break;
 
 	if (bank >= MAX_BANKS) {
-- 
1.5.6.5
