Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406XR21KTzzF1vm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 03:38:05 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MGUGL3036643
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:38:03 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvfhwj2my-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:38:02 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 16:38:00 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH] cxl: disable the lazy approach for irqs in POWERVM
 environment.
Date: Thu, 22 Mar 2018 17:37:54 +0100
Message-Id: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxl driver cannot disable the interrupt at the device level and has
to use disable_irq[_nosync] instead.
To avoid the implementation of the lazy optimisation (the interrupt is
marked disabled, but the hardware is left unmasked), we can disable it,
for a particular irq line, by calling
'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/guest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index f58b4b6c..dc476e1 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -389,6 +389,7 @@ static void disable_afu_irqs(struct cxl_context *ctx)
 		hwirq = ctx->irqs.offset[r];
 		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
 			virq = irq_find_mapping(NULL, hwirq);
+			irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
 			disable_irq(virq);
 		}
 	}
-- 
2.7.4
