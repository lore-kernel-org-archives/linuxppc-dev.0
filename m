Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B85072C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:13 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 15 Jan 2013 13:08:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5AD98E004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 13:09:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0F7d3hG3408274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 13:09:03 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0F7d3QU028277
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:05 +1100
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] irq: Set multiple MSI descriptor data for multiple IRQs
Date: Tue, 15 Jan 2013 15:38:54 +0800
Message-Id: <1358235536-32741-2-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, Mike Qiu <qiudayu@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Multiple MSI only requires the IRQ in msi_desc entry to be set as
the value of irq_base.

This patch implements the above mentioned technique.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 include/linux/irq.h |    2 ++
 kernel/irq/chip.c   |   40 ++++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fdf2c4a..60ef45b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -528,6 +528,8 @@ extern int irq_set_handler_data(unsigned int irq, void *data);
 extern int irq_set_chip_data(unsigned int irq, void *data);
 extern int irq_set_irq_type(unsigned int irq, unsigned int type);
 extern int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry);
+extern int irq_set_multiple_msi_desc(unsigned int irq_base, unsigned int nvec,
+					struct msi_desc *entry);
 extern struct irq_data *irq_get_irq_data(unsigned int irq);
 
 static inline struct irq_chip *irq_get_chip(unsigned int irq)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3aca9f2..c4c39d3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -90,6 +90,35 @@ int irq_set_handler_data(unsigned int irq, void *data)
 EXPORT_SYMBOL(irq_set_handler_data);
 
 /**
+ *	irq_set_multiple_msi_desc - set Multiple MSI descriptor data
+ *	for multiple IRQs
+ *	@irq_base:	Interrupt number base
+ *	@nvec:	The number of interrupts
+ *	@entry:	Pointer to MSI descriptor data
+ *
+ *	Set IRQ descriptors for multiple MSIs
+ */
+int irq_set_multiple_msi_desc(unsigned int irq_base, unsigned int nvec,
+				struct msi_desc *entry)
+{
+	unsigned long flags, i;
+	struct irq_desc *desc;
+
+	for (i = 0; i < nvec; i++) {
+		desc = irq_get_desc_lock(irq_base + i, &flags,
+					IRQ_GET_DESC_CHECK_GLOBAL);
+		if (!desc)
+			return -EINVAL;
+		desc->irq_data.msi_desc = entry;
+		if (i == 0 && entry)
+			entry->irq = irq_base;
+		irq_put_desc_unlock(desc, flags);
+	}
+
+	return 0;
+}
+
+/**
  *	irq_set_msi_desc - set MSI descriptor data for an irq
  *	@irq:	Interrupt number
  *	@entry:	Pointer to MSI descriptor data
@@ -98,16 +127,7 @@ EXPORT_SYMBOL(irq_set_handler_data);
  */
 int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_data.msi_desc = entry;
-	if (entry)
-		entry->irq = irq;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	return irq_set_multiple_msi_desc(irq, 1, entry);
 }
 
 /**
-- 
1.7.7.6
