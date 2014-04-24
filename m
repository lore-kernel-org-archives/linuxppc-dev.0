Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E00BE1401B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:37 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4EE372BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dTtG36634756
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:30 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80WqS023587
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 24/25] PCI: Fix return value from pci_user_{read,
 write}_config_*()
Date: Thu, 24 Apr 2014 18:00:30 +1000
Message-Id: <1398326431-24305-25-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI accessors from user space pci_user_{read,write}_config_*()
return negative error number, which was introduced by commit
34e32072 ("PCI: handle positive error codes"). That patch coverts
all positive error numbers from platform specific PCI config
accessors to -EINVAL. The upper layer calling to those PCI config
accessors hardly know the specific cause from the return value
when hitting failures.

The patch fixes the issue by doing the conversion (from positive
to negative) using existing function pcibios_err_to_errno().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/access.c | 12 ++++--------
 include/linux/pci.h  |  6 ++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 7f8b78c..8c148f3 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -148,7 +148,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
-	int ret = 0;							\
+	int ret = PCIBIOS_SUCCESSFUL;					\
 	u32 data = -1;							\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
@@ -159,9 +159,7 @@ int pci_user_read_config_##size						\
 					pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);				\
 	*val = (type)data;						\
-	if (ret > 0)							\
-		ret = -EINVAL;						\
-	return ret;							\
+	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
 
@@ -170,7 +168,7 @@ EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
 int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
-	int ret = -EIO;							\
+	int ret = PCIBIOS_SUCCESSFUL;					\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
 	raw_spin_lock_irq(&pci_lock);				\
@@ -179,9 +177,7 @@ int pci_user_write_config_##size					\
 	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
 					pos, sizeof(type), val);	\
 	raw_spin_unlock_irq(&pci_lock);				\
-	if (ret > 0)							\
-		ret = -EINVAL;						\
-	return ret;							\
+	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aab57b4..1682cb1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -518,7 +518,7 @@ static inline int pcibios_err_to_errno(int err)
 	case PCIBIOS_FUNC_NOT_SUPPORTED:
 		return -ENOENT;
 	case PCIBIOS_BAD_VENDOR_ID:
-		return -EINVAL;
+		return -ENOTTY;
 	case PCIBIOS_DEVICE_NOT_FOUND:
 		return -ENODEV;
 	case PCIBIOS_BAD_REGISTER_NUMBER:
@@ -527,9 +527,11 @@ static inline int pcibios_err_to_errno(int err)
 		return -EIO;
 	case PCIBIOS_BUFFER_TOO_SMALL:
 		return -ENOSPC;
+	default:
+		return -err;
 	}
 
-	return -ENOTTY;
+	return -ERANGE;
 }
 
 /* Low-level architecture-dependent routines */
-- 
1.8.3.2
