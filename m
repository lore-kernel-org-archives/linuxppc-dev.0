Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9011A1DC9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:21:02 +1000 (AEST)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13B6D1402A9
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:21:02 +1000 (AEST)
Received: by pawu10 with SMTP id u10so77677266paw.1
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:21:00 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4/4] cxl: sparse: Silence iomem warning in debugfs file
 creation
Date: Fri,  7 Aug 2015 13:18:20 +1000
Message-Id: <1438917500-12100-4-git-send-email-dja@axtens.net>
In-Reply-To: <1438917500-12100-1-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An IO address, tagged with __iomem, is passed to debugfs_create_file
as private data. This requires that it be cast to void *. The cast
creates a sparse warning:
/scratch/dja/linux-capi/drivers/misc/cxl/debugfs.c:51:57: warning: cast removes address space of expression

The address space marker is added back in the file operations
(fops_io_u64).

Silence the warning with __force.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 825c412580bc..18df6f44af2a 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -48,7 +48,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get, debugfs_io_u64_set, "0x
 static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
 					    struct dentry *parent, u64 __iomem *value)
 {
-	return debugfs_create_file(name, mode, parent, (void *)value, &fops_io_x64);
+	return debugfs_create_file(name, mode, parent, (void __force *)value, &fops_io_x64);
 }
 
 int cxl_debugfs_adapter_add(struct cxl *adapter)
-- 
2.1.4
