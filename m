Return-Path: <toshi.kani@hp.com>
Received: from g6t0187.atlanta.hp.com (g6t0187.atlanta.hp.com [15.193.32.64])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B33CF2C0C73
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:05:38 +1100 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org
Subject: [RFC PATCH v2 11/12] cpu: Update sysfs cpu/online for hotplug
 framework
Date: Thu, 10 Jan 2013 16:40:29 -0700
Message-Id: <1357861230-29549-12-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-mm@kvack.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changed store_online() to request a cpu online or offline
operation by calling shp_submit_req().  It sets a target cpu
device information with shp_add_dev_info() for the request.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/base/cpu.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 05534ad..cd1cbdc 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -41,27 +41,43 @@ static ssize_t __ref store_online(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	ssize_t ret;
+	struct shp_request *shp_req;
+	struct shp_device *shp_dev;
+	enum shp_operation operation;
+	ssize_t ret = count;
 
-	cpu_hotplug_driver_lock();
 	switch (buf[0]) {
 	case '0':
-		ret = cpu_down(cpu->dev.id);
-		if (!ret)
-			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+		operation = SHP_ONLINE_DEL;
 		break;
 	case '1':
-		ret = cpu_up(cpu->dev.id);
-		if (!ret)
-			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+		operation = SHP_ONLINE_ADD;
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
+	}
+
+	shp_req = shp_alloc_request(operation);
+	if (!shp_req)
+		return -ENOMEM;
+
+	shp_dev = kzalloc(sizeof(*shp_dev), GFP_KERNEL);
+	if (!shp_dev) {
+		kfree(shp_req);
+		return -ENOMEM;
+	}
+
+	shp_dev->device = dev;
+	shp_dev->class = SHP_CLS_CPU;
+	shp_dev->info.cpu.cpu_id = cpu->dev.id;
+	shp_add_dev_info(shp_req, shp_dev);
+
+	if (shp_submit_req(shp_req)) {
+		kfree(shp_dev);
+		kfree(shp_req);
+		return -EINVAL;
 	}
-	cpu_hotplug_driver_unlock();
 
-	if (ret >= 0)
-		ret = count;
 	return ret;
 }
 static DEVICE_ATTR(online, 0644, show_online, store_online);
