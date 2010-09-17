Return-Path: <tie-fei.zang@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 93F25B6F07
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 17:39:38 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 3/3 v4] P4080/mtd: Fix the freescale lbc issue with 36bit mode
Date: Fri, 17 Sep 2010 15:01:09 +0800
Message-ID: <1284706869-12555-3-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1284706869-12555-2-git-send-email-tie-fei.zang@freescale.com>
References: <1284706869-12555-1-git-send-email-tie-fei.zang@freescale.com>
	<1284706869-12555-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, B11780@freescale.com
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
Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 arch/powerpc/include/asm/fsl_lbc.h |    1 +
 arch/powerpc/sysdev/fsl_lbc.c      |   23 ++++++++++++++++++++++-
 drivers/mtd/nand/fsl_elbc_nand.c   |    2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index db94698..ad663e8 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -246,6 +246,7 @@ struct fsl_upm {
 	int width;
 };
 
+extern u32 fsl_lbc_addr(phys_addr_t addr_base);
 extern int fsl_lbc_find(phys_addr_t addr_base);
 extern int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm);
 
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 4920cd3..32c2120 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -34,6 +34,27 @@ struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
 EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
 
 /**
+ * fsl_lbc_addr - convert the base address
+ * @addr_base:	base address of the memory bank
+ *
+ * This function converts a base address of lbc into the right format for the
+ * BR register. If the SOC has eLBC then it returns 32bit physical address
+ * else it convers a 34bit local bus physical address to correct format of
+ * 32bit address for BR register (Example: MPC8641).
+ */
+u32 fsl_lbc_addr(phys_addr_t addr_base)
+{
+	struct device_node *np = fsl_lbc_ctrl_dev->dev->of_node;
+	u32 addr = addr_base & 0xffff8000;
+
+	if (of_device_is_compatible(np, "fsl,elbc"))
+		return addr;
+
+	return addr | ((addr_base & 0x300000000ull) >> 19);
+}
+EXPORT_SYMBOL(fsl_lbc_addr);
+
+/**
  * fsl_lbc_find - find Localbus bank
  * @addr_base:	base address of the memory bank
  *
@@ -55,7 +76,7 @@ int fsl_lbc_find(phys_addr_t addr_base)
 		__be32 br = in_be32(&lbc->bank[i].br);
 		__be32 or = in_be32(&lbc->bank[i].or);
 
-		if (br & BR_V && (br & or & BR_BA) == addr_base)
+		if (br & BR_V && (br & or & BR_BA) == fsl_lbc_addr(addr_base))
 			return i;
 	}
 
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 76ffd24..227618b 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -865,7 +865,7 @@ static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
 		    (in_be32(&lbc->bank[bank].br) & BR_MSEL) == BR_MS_FCM &&
 		    (in_be32(&lbc->bank[bank].br) &
 		     in_be32(&lbc->bank[bank].or) & BR_BA)
-		     == res.start)
+		     == fsl_lbc_addr(res.start))
 			break;
 
 	if (bank >= MAX_BANKS) {
-- 
1.5.6.5
