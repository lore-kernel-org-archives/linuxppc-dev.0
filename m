Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464J1PMQzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:36 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 01/15] Revert "iommu: Add a function to find an iommu
 group by id"
Date: Wed,  3 Aug 2016 18:40:42 +1000
Message-Id: <1470213656-1042-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit aa16bea929ae
("iommu: Add a function to find an iommu group by id")
as the iommu_group_get_by_id() helper has never been used
and it is unlikely it will in foreseeable future. Dead code
is broken code.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/iommu/iommu.c | 29 -----------------------------
 include/linux/iommu.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b06d935..d2f5efe 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -217,35 +217,6 @@ struct iommu_group *iommu_group_alloc(void)
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
-struct iommu_group *iommu_group_get_by_id(int id)
-{
-	struct kobject *group_kobj;
-	struct iommu_group *group;
-	const char *name;
-
-	if (!iommu_group_kset)
-		return NULL;
-
-	name = kasprintf(GFP_KERNEL, "%d", id);
-	if (!name)
-		return NULL;
-
-	group_kobj = kset_find_obj(iommu_group_kset, name);
-	kfree(name);
-
-	if (!group_kobj)
-		return NULL;
-
-	group = container_of(group_kobj, struct iommu_group, kobj);
-	BUG_ON(group->id != id);
-
-	kobject_get(group->devices_kobj);
-	kobject_put(&group->kobj);
-
-	return group;
-}
-EXPORT_SYMBOL_GPL(iommu_group_get_by_id);
-
 /**
  * iommu_group_get_iommudata - retrieve iommu_data registered for a group
  * @group: the group
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a35fb8b..93c69fa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -215,7 +215,6 @@ extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
-extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
-- 
2.5.0.rc3
