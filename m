Return-Path: <jiang.liu@linux.intel.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anatolij Gustschin <agust@denx.de>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>,
 Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 Jiang Liu <jiang.liu@linux.intel.com>, Anton Blanchard <anton@samba.org>,
 Daniel Axtens <dja@axtens.net>, Alexander Graf <agraf@suse.de>,
 Grant Likely <grant.likely@linaro.org>,
 Hongtao Jia <hongtao.jia@freescale.com>,
 Arseny Solokha <asolokha@kb.kras.ru>
Subject: [RFC v1 16/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
Date: Wed, 20 May 2015 18:00:04 +0800
Message-Id: <1432116013-25902-17-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/include/asm/qe_ic.h                |   23 +++++++++--------------
 arch/powerpc/include/asm/tsi108_pci.h           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c  |    4 +++-
 arch/powerpc/platforms/52xx/media5200.c         |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c       |    2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
 arch/powerpc/platforms/85xx/common.c            |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c        |    2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    3 ++-
 arch/powerpc/platforms/86xx/pic.c               |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c         |    2 +-
 arch/powerpc/platforms/cell/axon_msi.c          |    2 +-
 arch/powerpc/platforms/cell/interrupt.c         |    3 ++-
 arch/powerpc/platforms/cell/spider-pic.c        |    2 +-
 arch/powerpc/platforms/chrp/setup.c             |    2 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c   |    2 +-
 arch/powerpc/platforms/pseries/setup.c          |    2 +-
 arch/powerpc/sysdev/ge/ge_pic.c                 |    2 +-
 arch/powerpc/sysdev/mpic.c                      |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c              |    4 ++--
 arch/powerpc/sysdev/tsi108_pci.c                |    2 +-
 arch/powerpc/sysdev/uic.c                       |    2 +-
 arch/powerpc/sysdev/xilinx_intc.c               |    2 +-
 23 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index 25784cc959a0..1e155ca6d33c 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -59,14 +59,14 @@ enum qe_ic_grp_id {
 
 #ifdef CONFIG_QUICC_ENGINE
 void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
-		void (*high_handler)(unsigned int irq, struct irq_desc *desc));
+		void (*low_handler)(struct irq_desc *desc),
+		void (*high_handler)(struct irq_desc *desc));
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
 #else
 static inline void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
-		void (*high_handler)(unsigned int irq, struct irq_desc *desc))
+		void (*low_handler)(struct irq_desc *desc),
+		void (*high_handler)(struct irq_desc *desc))
 {}
 static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 { return 0; }
@@ -78,8 +78,7 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_ipic(unsigned int irq,
-					  struct irq_desc *desc)
+static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -88,8 +87,7 @@ static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 		generic_handle_irq(cascade_irq);
 }
 
-static inline void qe_ic_cascade_high_ipic(unsigned int irq,
-					   struct irq_desc *desc)
+static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -98,8 +96,7 @@ static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 		generic_handle_irq(cascade_irq);
 }
 
-static inline void qe_ic_cascade_low_mpic(unsigned int irq,
-					  struct irq_desc *desc)
+static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -111,8 +108,7 @@ static inline void qe_ic_cascade_low_mpic(unsigned int irq,
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static inline void qe_ic_cascade_high_mpic(unsigned int irq,
-					   struct irq_desc *desc)
+static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -124,8 +120,7 @@ static inline void qe_ic_cascade_high_mpic(unsigned int irq,
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
-					    struct irq_desc *desc)
+static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq;
diff --git a/arch/powerpc/include/asm/tsi108_pci.h b/arch/powerpc/include/asm/tsi108_pci.h
index 5653d7cc3e24..ae59d5b672b0 100644
--- a/arch/powerpc/include/asm/tsi108_pci.h
+++ b/arch/powerpc/include/asm/tsi108_pci.h
@@ -39,7 +39,7 @@
 
 extern int tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary);
 extern void tsi108_pci_int_init(struct device_node *node);
-extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
+extern void tsi108_irq_cascade(struct irq_desc *desc);
 extern void tsi108_clear_pci_cfg_error(void);
 
 #endif				/*  _ASM_POWERPC_TSI108_PCI_H */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index ca3a062ed1b9..4dc8f4f3d5ac 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -105,8 +105,10 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 }
 
 static void
-cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
+cpld_pic_cascade(struct irq_desc *desc)
 {
+	unsigned int irq;
+
 	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
 	if (irq != NO_IRQ) {
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 32cae33c4266..0c64f63cc187 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -80,7 +80,7 @@ static struct irq_chip media5200_irq_chip = {
 	.irq_mask_ack = media5200_irq_mask,
 };
 
-void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
+void media5200_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int sub_virq, val;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 63016621aff8..1f5f4775930c 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -191,7 +191,7 @@ static struct irq_chip mpc52xx_gpt_irq_chip = {
 	.irq_set_type = mpc52xx_gpt_irq_set_type,
 };
 
-void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
+void mpc52xx_gpt_irq_cascade(struct irq_desc *desc)
 {
 	struct mpc52xx_gpt_priv *gpt = irq_desc_get_handler_data(desc);
 	int sub_virq;
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 74861a7fb807..60e89fc9c753 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -78,7 +78,7 @@ static struct irq_chip pq2ads_pci_ic = {
 	.irq_disable = pq2ads_pci_mask_irq
 };
 
-static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void pq2ads_pci_irq_demux(struct irq_desc *desc)
 {
 	struct pq2ads_pci_pic *priv = irq_desc_get_handler_data(desc);
 	u32 stat, mask, pend;
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 7bfb9b184dd4..23791de7b688 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -49,7 +49,7 @@ int __init mpc85xx_common_publish_devices(void)
 	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
 }
 #ifdef CONFIG_CPM2
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+static void cpm2_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index ffdf02121a7c..f858306dba6a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -46,7 +46,7 @@
 #endif
 
 #ifdef CONFIG_PPC_I8259
-static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 55a9682b9529..b074dae07183 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -91,8 +91,9 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 			(irq_hw_number_t)i);
 }
 
-void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
+void socrates_fpga_pic_cascade(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
 
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index d5b98c0f958a..845defa1fd19 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -17,7 +17,7 @@
 #include <asm/i8259.h>
 
 #ifdef CONFIG_PPC_I8259
-static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpc86xx_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index d3037747031d..c289fc77b4ba 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -214,7 +214,7 @@ void mpc8xx_restart(char *cmd)
 	panic("Restart failed\n");
 }
 
-static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
+static void cpm_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq = cpm_get_irq();
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 817d0e6747ea..677836a1b5e4 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -92,7 +92,7 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 	dcr_write(msic->dcr_host, dcr_n, val);
 }
 
-static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
+static void axon_msi_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct axon_msic *msic = irq_desc_get_handler_data(desc);
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 3af8324c122e..65ea856a583e 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -99,8 +99,9 @@ static void iic_ioexc_eoi(struct irq_data *d)
 {
 }
 
-static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
+static void iic_ioexc_cascade(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct cbe_iic_regs __iomem *node_iic =
 		(void __iomem *)irq_desc_get_handler_data(desc);
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 1f72f4ab6353..9d27de62dc62 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -199,7 +199,7 @@ static const struct irq_domain_ops spider_host_ops = {
 	.xlate = spider_host_xlate,
 };
 
-static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
+static void spider_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct spider_pic *pic = irq_desc_get_handler_data(desc);
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 15ebc4e8a151..987d1b8d68e3 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -363,7 +363,7 @@ void __init chrp_setup_arch(void)
 	if (ppc_md.progress) ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0x0);
 }
 
-static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void chrp_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 1613303177e6..8f65aa3747f5 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -42,7 +42,7 @@
 static phys_addr_t pci_membase;
 static u_char *restart;
 
-static void mvme5100_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void mvme5100_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a7041922b..642f5a49718b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -111,7 +111,7 @@ static void __init fwnmi_init(void)
 		fwnmi_active = 1;
 }
 
-static void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void pseries_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
diff --git a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
index 2bcb78bb3a15..bf52768a162e 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -91,7 +91,7 @@ static int gef_pic_cascade_irq;
  * should be masked out.
  */
 
-void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
+void gef_pic_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b2b8447a227a..caed5f221f03 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1180,7 +1180,7 @@ static int mpic_host_xlate(struct irq_domain *h, struct device_node *ct,
 }
 
 /* IRQ handler for a secondary MPIC cascaded from another IRQ controller */
-static void mpic_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpic_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mpic *mpic = irq_desc_get_handler_data(desc);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 543765e1ef14..50179099e728 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -310,8 +310,8 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 }
 
 void __init qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
-		void (*high_handler)(unsigned int irq, struct irq_desc *desc))
+		void (*low_handler)(struct irq_desc *desc),
+		void (*high_handler)(struct irq_desc *desc))
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 188012c58f7f..0b36e6a22d25 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -428,7 +428,7 @@ void __init tsi108_pci_int_init(struct device_node *node)
 	init_pci_source();
 }
 
-void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc)
+void tsi108_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = get_pci_source();
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index e763fe215cf5..902af049b492 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -194,7 +194,7 @@ static struct irq_domain_ops uic_host_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
+void uic_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_data *idata = irq_desc_get_irq_data(desc);
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 56f0524e47a6..78e0f1be1474 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -222,7 +222,7 @@ int xilinx_intc_get_irq(void)
 /*
  * Support code for cascading to 8259 interrupt controllers
  */
-static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void xilinx_i8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
-- 
1.7.10.4
