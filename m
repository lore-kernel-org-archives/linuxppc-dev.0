Return-Path: <jiang.liu@linux.intel.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Anatolij Gustschin <agust@denx.de>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC v1 04/25] powerpc,
 irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 17:59:52 +0800
Message-Id: <1432116013-25902-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |    2 +-
 arch/powerpc/platforms/cell/axon_msi.c        |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |    2 +-
 arch/powerpc/sysdev/uic.c                     |    2 +-
 arch/powerpc/sysdev/xics/xics-common.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index c949ca055712..63016621aff8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -193,7 +193,7 @@ static struct irq_chip mpc52xx_gpt_irq_chip = {
 
 void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
-	struct mpc52xx_gpt_priv *gpt = irq_get_handler_data(virq);
+	struct mpc52xx_gpt_priv *gpt = irq_desc_get_handler_data(desc);
 	int sub_virq;
 	u32 status;
 
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 623bd961465a..817d0e6747ea 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -95,7 +95,7 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct axon_msic *msic = irq_get_handler_data(irq);
+	struct axon_msic *msic = irq_desc_get_handler_data(desc);
 	u32 write_offset, msi;
 	int idx;
 	int retry = 0;
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index c269caee58f9..9dd154d6f89a 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -124,7 +124,7 @@ static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 				      struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_domain *irq_domain = irq_get_handler_data(cascade_virq);
+	struct irq_domain *irq_domain = irq_desc_get_handler_data(desc);
 	unsigned int virq;
 
 	raw_spin_lock(&desc->lock);
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 7c37157d4c24..e763fe215cf5 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -198,7 +198,7 @@ void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_data *idata = irq_desc_get_irq_data(desc);
-	struct uic *uic = irq_get_handler_data(virq);
+	struct uic *uic = irq_desc_get_handler_data(desc);
 	u32 msr;
 	int src;
 	int subvirq;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 878a54036a25..76be7b00dd80 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -227,7 +227,7 @@ void xics_migrate_irqs_away(void)
 
 		/* Locate interrupt server */
 		server = -1;
-		ics = irq_get_chip_data(virq);
+		ics = irq_desc_get_chip_data(desc);
 		if (ics)
 			server = ics->get_server(ics, irq);
 		if (server < 0) {
-- 
1.7.10.4
