Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwQXH4d5HzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:35:27 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id i5so7580563pag.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:35:27 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: robh+dt@kernel.org, frowand.list@gmail.com, grant.likely@linaro.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/2] drivers/of: Add check for null property in
 of_remove_property()
Date: Thu, 28 Apr 2016 15:34:54 +1000
Message-Id: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The validity of the property input argument to of_remove_property() is
never checked within the function and thus it is possible to pass a null
value. It happens that this will be picked up in __of_remove_property()
as no matching property of the device node will be found and thus an
error will be returned, however once again there is no explicit check
for a null value. By the time this is detected 2 locks have already been
acquired which is completely unnecessary if the property to remove is
null.

Add an explicit check in the function of_remove_property() for a null
property value and return -ENODEV in this case, this is consistent with
what the previous return value would have been when the null value was
not detected and passed to __of_remove_property().

By moving an explicit check for the property paramenter into the
of_remove_property() function, this will remove the need to perform this
check in calling code before invocation of the of_remove_property()
function.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b299de2..64018eb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1777,6 +1777,9 @@ int of_remove_property(struct device_node *np, struct property *prop)
 	unsigned long flags;
 	int rc;
 
+	if (!prop)
+		return -ENODEV;
+
 	mutex_lock(&of_mutex);
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
-- 
2.5.0
