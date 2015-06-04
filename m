Return-Path: <jiang.liu@linux.intel.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Anatolij Gustschin <agust@denx.de>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org
Subject: [RFT v2 26/48] powerpc,
 irq: Prepare for killing the first parameter 'irq' of
 irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:36 +0800
Message-Id: <1433391238-19471-27-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c  |    4 +++-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    2 +-
 arch/powerpc/platforms/cell/interrupt.c         |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index ca3a062ed1b9..4411ed51803e 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -105,8 +105,10 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 }
 
 static void
-cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
+cpld_pic_cascade(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
+
 	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
 	if (irq != NO_IRQ) {
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 55a9682b9529..5153e58654f7 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -100,7 +100,7 @@ void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 	 * See if we actually have an interrupt, call generic handling code if
 	 * we do.
 	 */
-	cascade_irq = socrates_fpga_pic_get_irq(irq);
+	cascade_irq = socrates_fpga_pic_get_irq(irq_desc_get_irq(desc));
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 3af8324c122e..e2dd6c9d3a78 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -99,8 +99,9 @@ static void iic_ioexc_eoi(struct irq_data *d)
 {
 }
 
-static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
+static void iic_ioexc_cascade(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct cbe_iic_regs __iomem *node_iic =
 		(void __iomem *)irq_desc_get_handler_data(desc);
-- 
1.7.10.4
