Return-Path: <Paul.Gortmaker@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] sbc8560: Fix warm reboot with board specific reset function
Date: Fri, 14 Aug 2009 10:36:14 -0400
Message-Id: <1250260574-13747-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1456507C-E9F9-436B-9901-6F127A5FDD1F@kernel.crashing.org>
References: <1456507C-E9F9-436B-9901-6F127A5FDD1F@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liang Li <Liang.Li@windriver.com>

The existing fsl_rstcr_restart function is not applicable to the
mpc8560. The Global Utilities Block on this earlier CPU doesn't have
the control/reset register at 0xe00b0.  This implements a board
specific reset function that uses the RCR(Reset Control Register) of
the sbc8560's EPLD to do a reset.

Signed-off-by: Liang Li <Liang.Li@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

v2: update comment, change outb(x, inb(x)&0x7f) --> clrbits(x,0x80)

 arch/powerpc/platforms/85xx/sbc8560.c |   39 ++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index cc27807..a5ad1c7 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -267,6 +267,43 @@ arch_initcall(sbc8560_rtc_init);
 
 #endif	/* M48T59 */
 
+static __u8 __iomem *brstcr;
+
+static int __init sbc8560_bdrstcr_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+
+	np = of_find_compatible_node(NULL, NULL, "wrs,sbc8560-brstcr");
+	if (np == NULL) {
+		printk(KERN_WARNING "sbc8560: No board specific RSTCR in DTB.\n");
+		return -ENODEV;
+	}
+
+	of_address_to_resource(np, 0, &res);
+
+	printk(KERN_INFO "sbc8560: Found BRSTCR at i/o 0x%x\n", res.start);
+
+	brstcr = ioremap(res.start, res.end - res.start);
+	if(!brstcr)
+		printk(KERN_WARNING "sbc8560: ioremap of brstcr failed.\n");
+
+	of_node_put(np);
+
+	return 0;
+}
+
+arch_initcall(sbc8560_bdrstcr_init);
+
+void sbc8560_rstcr_restart(char * cmd)
+{
+	local_irq_disable();
+	if(brstcr)
+		clrbits8(brstcr, 0x80);
+
+	while(1);
+}
+
 define_machine(sbc8560) {
 	.name			= "SBC8560",
 	.probe			= sbc8560_probe,
@@ -274,7 +311,7 @@ define_machine(sbc8560) {
 	.init_IRQ		= sbc8560_pic_init,
 	.show_cpuinfo		= sbc8560_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
+	.restart		= sbc8560_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
-- 
1.6.3.3
