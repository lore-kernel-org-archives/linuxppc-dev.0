Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-x229.google.com (mail-yh0-x229.google.com
 [IPv6:2607:f8b0:4002:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F1202C0A4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:33 +1000 (EST)
Received: by mail-yh0-f41.google.com with SMTP id i72so667558yha.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:30 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] iommu: Add a function to find an iommu group by id
Date: Mon,  6 May 2013 17:25:55 +1000
Message-Id: <1367825157-27231-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As IOMMU groups are exposed to the user space by their numbers,
the user space can use them in various kernel APIs so the kernel
might need an API to find a group by its ID.

As an example, QEMU VFIO on PPC64 platform needs it to associate
a logical bus number (LIOBN) with a specific IOMMU group in order
to support in-kernel handling of DMA map/unmap requests.

This adds the iommu_group_get_by_id(id) function which performs
this search.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 drivers/iommu/iommu.c |   29 +++++++++++++++++++++++++++++
 include/linux/iommu.h |    1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ddbdaca..5514dfa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -204,6 +204,35 @@ again:
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
+struct iommu_group *iommu_group_get_by_id(int id)
+{
+	struct kobject *group_kobj;
+	struct iommu_group *group;
+	const char *name;
+
+	if (!iommu_group_kset)
+		return NULL;
+
+	name = kasprintf(GFP_KERNEL, "%d", id);
+	if (!name)
+		return NULL;
+
+	group_kobj = kset_find_obj(iommu_group_kset, name);
+	kfree(name);
+
+	if (!group_kobj)
+		return NULL;
+
+	group = container_of(group_kobj, struct iommu_group, kobj);
+	BUG_ON(group->id != id);
+
+	kobject_get(group->devices_kobj);
+	kobject_put(&group->kobj);
+
+	return group;
+}
+EXPORT_SYMBOL_GPL(iommu_group_get_by_id);
+
 /**
  * iommu_group_get_iommudata - retrieve iommu_data registered for a group
  * @group: the group
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f3b99e1..00e5d7d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -113,6 +113,7 @@ struct iommu_ops {
 extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
+extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
-- 
1.7.10.4
