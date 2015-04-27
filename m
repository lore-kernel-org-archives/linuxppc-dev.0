Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2641A1A075B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 22:49:03 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so127496780pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 05:49:01 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Constify irq_domain_ops
Date: Mon, 27 Apr 2015 21:48:47 +0900
Message-Id: <1430138927-3364-1-git-send-email-k.kozlowski.k@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/powerpc/sysdev/i8259.c            | 2 +-
 arch/powerpc/sysdev/ipic.c             | 2 +-
 arch/powerpc/sysdev/mpc8xx_pic.c       | 2 +-
 arch/powerpc/sysdev/mpic.c             | 2 +-
 arch/powerpc/sysdev/mv64x60_pic.c      | 2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c     | 2 +-
 arch/powerpc/sysdev/tsi108_pci.c       | 2 +-
 arch/powerpc/sysdev/uic.c              | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 arch/powerpc/sysdev/xilinx_intc.c      | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 45598da0b321..31c33475c7b7 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -204,7 +204,7 @@ static int i8259_host_xlate(struct irq_domain *h, struct device_node *ct,
 	return 0;
 }
 
-static struct irq_domain_ops i8259_host_ops = {
+static const struct irq_domain_ops i8259_host_ops = {
 	.match = i8259_host_match,
 	.map = i8259_host_map,
 	.xlate = i8259_host_xlate,
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index b28733727ed3..d78f1364b639 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -691,7 +691,7 @@ static int ipic_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops ipic_host_ops = {
+static const struct irq_domain_ops ipic_host_ops = {
 	.match	= ipic_host_match,
 	.map	= ipic_host_map,
 	.xlate	= irq_domain_xlate_onetwocell,
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index c4828c0be5bd..d93a78be4346 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -120,7 +120,7 @@ static int mpc8xx_pic_host_xlate(struct irq_domain *h, struct device_node *ct,
 }
 
 
-static struct irq_domain_ops mpc8xx_pic_host_ops = {
+static const struct irq_domain_ops mpc8xx_pic_host_ops = {
 	.map = mpc8xx_pic_host_map,
 	.xlate = mpc8xx_pic_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b2b8447a227a..c8e73332eaad 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1195,7 +1195,7 @@ static void mpic_cascade(unsigned int irq, struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static struct irq_domain_ops mpic_host_ops = {
+static const struct irq_domain_ops mpic_host_ops = {
 	.match = mpic_host_match,
 	.map = mpic_host_map,
 	.xlate = mpic_host_xlate,
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 8848e99a83f2..0f842dd16bcd 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -223,7 +223,7 @@ static int mv64x60_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops mv64x60_host_ops = {
+static const struct irq_domain_ops mv64x60_host_ops = {
 	.map   = mv64x60_host_map,
 };
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 543765e1ef14..6512cd8caa51 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -271,7 +271,7 @@ static int qe_ic_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops qe_ic_host_ops = {
+static const struct irq_domain_ops qe_ic_host_ops = {
 	.match = qe_ic_host_match,
 	.map = qe_ic_host_map,
 	.xlate = irq_domain_xlate_onetwocell,
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 188012c58f7f..57b54476e747 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -397,7 +397,7 @@ static int pci_irq_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops pci_irq_domain_ops = {
+static const struct irq_domain_ops pci_irq_domain_ops = {
 	.map = pci_irq_host_map,
 	.xlate = pci_irq_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 7c37157d4c24..1cd057f11725 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -189,7 +189,7 @@ static int uic_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops uic_host_ops = {
+static const struct irq_domain_ops uic_host_ops = {
 	.map	= uic_host_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 878a54036a25..5bc5889d4acc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -360,7 +360,7 @@ static int xics_host_xlate(struct irq_domain *h, struct device_node *ct,
 	return 0;
 }
 
-static struct irq_domain_ops xics_host_ops = {
+static const struct irq_domain_ops xics_host_ops = {
 	.match = xics_host_match,
 	.map = xics_host_map,
 	.xlate = xics_host_xlate,
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 56f0524e47a6..43b8b275bc5c 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -179,7 +179,7 @@ static int xilinx_intc_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops xilinx_intc_ops = {
+static const struct irq_domain_ops xilinx_intc_ops = {
 	.map = xilinx_intc_map,
 	.xlate = xilinx_intc_xlate,
 };
-- 
2.1.0
