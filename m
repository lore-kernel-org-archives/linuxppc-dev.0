Return-Path: <jiang.liu@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FE451A0037
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 18:07:35 +1000 (AEST)
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [Patch v3 24/36] powerpc,
 irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:33 +0800
Message-Id: <1433145945-789-25-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/kernel/irq.c           |    2 +-
 arch/powerpc/sysdev/xics/ics-opal.c |    2 +-
 arch/powerpc/sysdev/xics/ics-rtas.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 45096033d37b..290559df1e8b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -441,7 +441,7 @@ void migrate_irqs(void)
 
 		chip = irq_data_get_irq_chip(data);
 
-		cpumask_and(mask, data->affinity, map);
+		cpumask_and(mask, irq_data_get_affinity_mask(data), map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			pr_warn("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 68c7e5cc98e0..3996393c254d 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -54,7 +54,7 @@ static void ics_opal_unmask_irq(struct irq_data *d)
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 	server = ics_opal_mangle_server(server);
 
 	rc = opal_set_xive(hw_irq, server, DEFAULT_PRIORITY);
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index 0af97deb83f3..e2665a9dfc0f 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -47,7 +47,7 @@ static void ics_rtas_unmask_irq(struct irq_data *d)
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hw_irq, server,
 				DEFAULT_PRIORITY);
-- 
1.7.10.4
