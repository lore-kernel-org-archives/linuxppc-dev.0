Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 1E2302C0B49
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:06:52 +1000 (EST)
Message-ID: <500904AC.7000305@cn.fujitsu.com>
Date: Fri, 20 Jul 2012 15:11:40 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 5/8] memory-hotplug: call acpi_bus_remove() to remove
 memory device
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

The memory device has been ejected and powoffed, so we can call
acpi_bus_remove() to remove the memory device from acpi bus.

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
 drivers/acpi/acpi_memhotplug.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 58e4e63..431a17c 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -402,8 +402,9 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 			printk(KERN_ERR PREFIX
 				    "Disable memory device\n");
 		/*
-		 * TBD: Invoke acpi_bus_remove to cleanup data structures
+		 * Invoke acpi_bus_remove() to remove memory device
 		 */
+		acpi_bus_remove(device, 1);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-- 
1.7.1
