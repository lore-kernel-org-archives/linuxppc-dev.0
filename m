Return-Path: <geliangtang@163.com>
Received: from m50-138.163.com (m50-138.163.com [123.125.50.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 00E381A0907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 02:47:03 +1100 (AEDT)
From: Geliang Tang <geliangtang@163.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geliang Tang <geliangtang@163.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] misc: cxl: use kobj_to_dev()
Date: Wed, 13 Jan 2016 23:30:09 +0800
Message-Id: <6e8fbf9983f218aa373b870aa842f028a7bbc144.1452698603.git.geliangtang@163.com>
In-Reply-To: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
In-Reply-To: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use kobj_to_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/misc/cxl/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 02006f71..038af5d 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -386,8 +386,7 @@ static ssize_t afu_eb_read(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
 {
-	struct cxl_afu *afu = to_cxl_afu(container_of(kobj,
-						      struct device, kobj));
+	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj));
 
 	return cxl_afu_read_err_buffer(afu, buf, off, count);
 }
@@ -467,7 +466,7 @@ static ssize_t afu_read_config(struct file *filp, struct kobject *kobj,
 			       loff_t off, size_t count)
 {
 	struct afu_config_record *cr = to_cr(kobj);
-	struct cxl_afu *afu = to_cxl_afu(container_of(kobj->parent, struct device, kobj));
+	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj->parent));
 
 	u64 i, j, val;
 
-- 
2.5.0
