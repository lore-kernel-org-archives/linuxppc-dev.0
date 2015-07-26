Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF5C91A0709
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 07:26:02 +1000 (AEST)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH 1/8] misc: cxl: clean up afu_read_config()
Date: Mon, 27 Jul 2015 00:18:46 +0300
Message-Id: <1437945533-27996-1-git-send-email-vz@mleia.com>
In-Reply-To: <1437945502-27944-1-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sanity checks for overflow are not needed, because this is done on
caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/sysfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 31f38bc..87cd747 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -443,12 +443,7 @@ static ssize_t afu_read_config(struct file *filp, struct kobject *kobj,
 	struct afu_config_record *cr = to_cr(kobj);
 	struct cxl_afu *afu = to_cxl_afu(container_of(kobj->parent, struct device, kobj));
 
-	u64 i, j, val, size = afu->crs_len;
-
-	if (off > size)
-		return 0;
-	if (off + count > size)
-		count = size - off;
+	u64 i, j, val;
 
 	for (i = 0; i < count;) {
 		val = cxl_afu_cr_read64(afu, cr->cr, off & ~0x7);
-- 
2.1.4
