Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E9A82C1CB2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:59:44 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>, <joro@8bytes.org>,
 <stuart.yoder@freescale.com>
Subject: [PATCH 4/6] iommu/fsl: Add window permission flags for
 iommu_domain_window_enable API.
Date: Mon, 18 Feb 2013 18:22:17 +0530
Message-ID: <1361191939-21260-5-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each iommu window can have access permissions associated with it. Extended the
window_enable API to incorporate window access permissions.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 drivers/iommu/iommu.c |    5 +++--
 include/linux/iommu.h |    7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b972d43..1a2564d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -854,12 +854,13 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
 
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-			       phys_addr_t paddr, u64 size)
+			       phys_addr_t paddr, u64 size, int iommu_prot)
 {
 	if (unlikely(domain->ops->domain_window_enable == NULL))
 		return -ENODEV;
 
-	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size);
+	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size,
+						 iommu_prot);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_window_enable);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba3b8a9..529987c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -105,7 +105,7 @@ struct iommu_ops {
 
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
-				    phys_addr_t paddr, u64 size);
+				    phys_addr_t paddr, u64 size, int iommu_prot);
 	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
 	/* Set the numer of window per domain */
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
@@ -171,7 +171,8 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-				      phys_addr_t offset, u64 size);
+				      phys_addr_t offset, u64 size,
+				      int iommu_prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
@@ -257,7 +258,7 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
-					     u64 size)
+					     u64 size, int iommu_prot)
 {
 	return -ENODEV;
 }
-- 
1.7.4.1
