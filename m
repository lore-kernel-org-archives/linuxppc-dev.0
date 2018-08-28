Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsJg6XtGzDrTH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:54:59 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so39681oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:54:59 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] misc: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:32 -0500
Message-Id: <20180828015252.28511-31-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/cxl/flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 43917898fb9a..4d6836f19489 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -92,8 +92,8 @@ static int update_property(struct device_node *dn, const char *name,
 
 	val = (u32 *)new_prop->value;
 	rc = cxl_update_properties(dn, new_prop);
-	pr_devel("%s: update property (%s, length: %i, value: %#x)\n",
-		  dn->name, name, vd, be32_to_cpu(*val));
+	pr_devel("%pOFn: update property (%s, length: %i, value: %#x)\n",
+		  dn, name, vd, be32_to_cpu(*val));
 
 	if (rc) {
 		kfree(new_prop->name);
-- 
2.17.1
