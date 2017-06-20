Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wshgW2wV5zDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:03:35 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so18478701pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:03:35 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 3/4] of: be consistent in form of file mode
Date: Tue, 20 Jun 2017 15:02:51 -0700
Message-Id: <1497996172-821-4-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frank Rowand <frank.rowand@sony.com>

checkpatch whined about using S_IRUGO instead of octal equivalent
when adding phandle sysfs code, so used octal in that patch.
Change other instances of the S_* constants in the same file to
the octal form.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 941c9a03471d..a4e2159c8671 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -168,7 +168,7 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
 
 	sysfs_bin_attr_init(&pp->attr);
 	pp->attr.attr.name = safe_name(&np->kobj, pp->name);
-	pp->attr.attr.mode = secure ? S_IRUSR : S_IRUGO;
+	pp->attr.attr.mode = secure ? 0400 : 0444;
 	pp->attr.size = secure ? 0 : pp->length;
 	pp->attr.read = of_node_property_read;
 
-- 
Frank Rowand <frank.rowand@sony.com>
