Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 594182C0232
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 09:43:28 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <stuart.yoder@freescale.com>
Subject: [PATCH 3/5 v10] iommu/fsl: Add the window permission flag as a
 parameter to iommu_window_enable API.
Date: Sat, 23 Mar 2013 04:04:59 +0530
Message-ID: <1363991700-21454-5-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1363991700-21454-1-git-send-email-Varun.Sethi@freescale.com>
References: <1363991700-21454-1-git-send-email-Varun.Sethi@freescale.com>
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

In case of PAMU each window can have its specific set of permissions.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
- no change in v10.

 drivers/iommu/iommu.c |    5 +++--
 include/linux/iommu.h |    7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 39106ec..c4d5265 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -853,12 +853,13 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
 
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-			       phys_addr_t paddr, u64 size)
+			       phys_addr_t paddr, u64 size, int prot)
 {
 	if (unlikely(domain->ops->domain_window_enable == NULL))
 		return -ENODEV;
 
-	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size);
+	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size,
+						 prot);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_window_enable);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 576cc19..02ac111 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -104,7 +104,7 @@ struct iommu_ops {
 
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
-				    phys_addr_t paddr, u64 size);
+				    phys_addr_t paddr, u64 size, int prot);
 	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
 	/* Set the numer of window per domain */
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
@@ -169,7 +169,8 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-				      phys_addr_t offset, u64 size);
+				      phys_addr_t offset, u64 size,
+				      int prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
@@ -255,7 +256,7 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
-					     u64 size)
+					     u64 size, int prot)
 {
 	return -ENODEV;
 }
-- 
1.7.4.1
