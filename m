Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrjzy5hh2zDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 14:58:06 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: Frederic Barrat <frederic.barrat@fr.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, andrew.donnellan@au1.ibm.com
Subject: [PATCH 1/2] cxl: Keep IRQ mappings on context teardown
Date: Fri, 22 Apr 2016 14:57:48 +1000
Message-Id: <1461301069-12331-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Keep IRQ mappings on context teardown.  This won't leak IRQs as if we
allocate the mapping again, the generic code will give the same
mapping used last time.

Doing this works around a race in the generic code. Masking the
interrupt introduces a race which can crash the kernel or result in
IRQ that is never EOIed. The lost of EOI results in all subsequent
mappings to the same HW IRQ never receiving an interrupt.

We've seen this race with cxl test cases which are doing heavy context
startup and teardown at the same time as heavy interrupt load.

A fix to the generic code is being investigated also.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org # 3.8
---
 drivers/misc/cxl/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index be646dc..8def455 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -203,7 +203,6 @@ unsigned int cxl_map_irq(struct cxl *adapter, irq_hw_number_t hwirq,
 void cxl_unmap_irq(unsigned int virq, void *cookie)
 {
 	free_irq(virq, cookie);
-	irq_dispose_mapping(virq);
 }
 
 int cxl_register_one_irq(struct cxl *adapter,
-- 
2.5.0
