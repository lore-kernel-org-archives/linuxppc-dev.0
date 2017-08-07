Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xQq5R4v12zDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:33:31 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 1/5] iommu: Add capabilities to a group
Date: Mon,  7 Aug 2017 17:25:44 +1000
Message-Id: <20170807072548.3023-2-aik@ozlabs.ru>
In-Reply-To: <20170807072548.3023-1-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This introduces capabilities to IOMMU groups. The first defined
capability is IOMMU_GROUP_CAP_ISOLATE_MSIX which tells the IOMMU
group users that a particular IOMMU group is capable of MSIX message
filtering; this is useful when deciding whether or not to allow mapping
of MSIX table to the userspace. Various architectures will enable it
when they decide that it is safe to do so.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/iommu.h | 20 ++++++++++++++++++++
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..6b6f3c2f4904 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -155,6 +155,9 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
+/* IOMMU group capabilities */
+#define IOMMU_GROUP_CAP_ISOLATE_MSIX		(1U)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -312,6 +315,11 @@ extern void *iommu_group_get_iommudata(struct iommu_group *group);
 extern void iommu_group_set_iommudata(struct iommu_group *group,
 				      void *iommu_data,
 				      void (*release)(void *iommu_data));
+extern void iommu_group_set_caps(struct iommu_group *group,
+				 unsigned long clearcaps,
+				 unsigned long setcaps);
+extern bool iommu_group_is_capable(struct iommu_group *group,
+				   unsigned long cap);
 extern int iommu_group_set_name(struct iommu_group *group, const char *name);
 extern int iommu_group_add_device(struct iommu_group *group,
 				  struct device *dev);
@@ -513,6 +521,18 @@ static inline void iommu_group_set_iommudata(struct iommu_group *group,
 {
 }
 
+static inline void iommu_group_set_caps(struct iommu_group *group,
+					unsigned long clearcaps,
+					unsigned long setcaps)
+{
+}
+
+static inline bool iommu_group_is_capable(struct iommu_group *group,
+					  unsigned long cap)
+{
+	return false;
+}
+
 static inline int iommu_group_set_name(struct iommu_group *group,
 				       const char *name)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..6b2c34fe2c3d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -52,6 +52,7 @@ struct iommu_group {
 	void (*iommu_data_release)(void *iommu_data);
 	char *name;
 	int id;
+	unsigned long caps;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 };
@@ -447,6 +448,33 @@ void iommu_group_set_iommudata(struct iommu_group *group, void *iommu_data,
 EXPORT_SYMBOL_GPL(iommu_group_set_iommudata);
 
 /**
+ * iommu_group_set_caps - Change the group capabilities
+ * @group: the group
+ * @clearcaps: capabilities mask to remove
+ * @setcaps: capabilities mask to add
+ *
+ * IOMMU groups can be capable of various features which device drivers
+ * may read and adjust the behavior.
+ */
+void iommu_group_set_caps(struct iommu_group *group,
+		unsigned long clearcaps, unsigned long setcaps)
+{
+	group->caps &= ~clearcaps;
+	group->caps |= setcaps;
+}
+EXPORT_SYMBOL_GPL(iommu_group_set_caps);
+
+/**
+ * iommu_group_is_capable - Returns if a group capability is present
+ * @group: the group
+ */
+bool iommu_group_is_capable(struct iommu_group *group, unsigned long cap)
+{
+	return !!(group->caps & cap);
+}
+EXPORT_SYMBOL_GPL(iommu_group_is_capable);
+
+/**
  * iommu_group_set_name - set name for a group
  * @group: the group
  * @name: name
-- 
2.11.0
