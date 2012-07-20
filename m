Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 0CF942C03F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:04:27 +1000 (EST)
Message-ID: <5009041D.3060909@cn.fujitsu.com>
Date: Fri, 20 Jul 2012 15:09:17 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 1/8] memory-hotplug: store the node id in
 acpi_memory_device
References: <5009038A.4090001@cn.fujitsu.com>
In-Reply-To: <5009038A.4090001@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: len.brown@intel.com, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>,
 paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 rientjes@google.com, cl@linux.com, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The memory device has only one node id. Store the node id when
enabling the memory device, and we can reuse it when removing the
memory device.

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 5cafd6b..db8de39 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -84,6 +84,7 @@ struct acpi_memory_info {
 struct acpi_memory_device {
 	struct acpi_device * device;
 	unsigned int state;	/* State of the memory device */
+	int nid;
 	struct list_head res_list;
 };
 
@@ -257,6 +258,9 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		info->enabled = 1;
 		num_enabled++;
 	}
+
+	mem_device->nid = node;
+
 	if (!num_enabled) {
 		printk(KERN_ERR PREFIX "add_memory failed\n");
 		mem_device->state = MEMORY_INVALID_STATE;
@@ -463,7 +467,7 @@ static int acpi_memory_device_remove(struct acpi_device *device, int type)
 
 	mem_device = acpi_driver_data(device);
 
-	node = acpi_get_node(mem_device->device->handle);
+	node = mem_device->nid;
 	list_for_each_entry_safe(info, tmp, &mem_device->res_list, list) {
 		if (!info->enabled)
 			continue;
@@ -473,8 +477,6 @@ static int acpi_memory_device_remove(struct acpi_device *device, int type)
 			if (result)
 				return result;
 		}
-		if (node < 0)
-			node = memory_add_physaddr_to_nid(info->start_addr);
 
 		result = remove_memory(node, info->start_addr, info->length);
 		if (result)
-- 
1.7.1
