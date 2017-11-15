Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycX4x5QSRzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 04:51:59 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id j28so15210134pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 09:51:58 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-nvdimm@lists.01.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/3] libnvdimm: Add of_node to region and bus descriptors
Date: Thu, 16 Nov 2017 04:51:29 +1100
Message-Id: <20171115175131.23631-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to be able to cross reference the region and bus devices
with the device tree node that they were spawned from. libNVDIMM
handles creating the actual devices for these internally, so we
need to pass in a pointer to the relevant node in the descriptor.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 drivers/nvdimm/bus.c         | 1 +
 drivers/nvdimm/region_devs.c | 1 +
 include/linux/libnvdimm.h    | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 0a5e6cd758fe..d6f94303ae44 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -358,6 +358,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	nvdimm_bus->dev.release = nvdimm_bus_release;
 	nvdimm_bus->dev.groups = nd_desc->attr_groups;
 	nvdimm_bus->dev.bus = &nvdimm_bus_type;
+	nvdimm_bus->dev.of_node = nd_desc->of_node;
 	dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
 	rc = device_register(&nvdimm_bus->dev);
 	if (rc) {
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index abaf38c61220..4d756d8c8386 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -992,6 +992,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	dev->parent = &nvdimm_bus->dev;
 	dev->type = dev_type;
 	dev->groups = ndr_desc->attr_groups;
+	dev->of_node = ndr_desc->of_node;
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
 	nd_device_register(dev);
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index f8109ddb5ef1..fcd9f521e481 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -65,12 +65,14 @@ typedef int (*ndctl_fn)(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc);
 
+struct device_node;
 struct nvdimm_bus_descriptor {
 	const struct attribute_group **attr_groups;
 	unsigned long bus_dsm_mask;
 	unsigned long cmd_mask;
 	struct module *module;
 	char *provider_name;
+	struct device_node *of_node;
 	ndctl_fn ndctl;
 	int (*flush_probe)(struct nvdimm_bus_descriptor *nd_desc);
 	int (*clear_to_send)(struct nvdimm_bus_descriptor *nd_desc,
@@ -112,6 +114,7 @@ struct nd_region_desc {
 	int num_lanes;
 	int numa_node;
 	unsigned long flags;
+	struct device_node *of_node;
 };
 
 struct device;
-- 
2.9.5
