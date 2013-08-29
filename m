Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 856542C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 17:25:40 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T7PZLd011969
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 02:25:36 -0500
Message-ID: <1377761135.4028.30.camel@pasglop>
Subject: [PATCH] powerpc/scom: Use "devspec" rather than "path" in debugfs
 entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 17:25:35 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is the traditional name for device-tree path, used in sysfs,
do the same for the XSCOM debugfs files.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/scom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index cb20d54..3963d99 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -180,7 +180,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 
 	debugfs_create_file("addr", 0600, dir, ent, &scom_addr_fops);
 	debugfs_create_file("value", 0600, dir, ent, &scom_val_fops);
-	debugfs_create_blob("path", 0400, dir, &ent->blob);
+	debugfs_create_blob("devspec", 0400, dir, &ent->blob);
 
 	return 0;
 }
