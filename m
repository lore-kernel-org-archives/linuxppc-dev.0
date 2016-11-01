Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7Zp41Kz4zDt4V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 02:26:36 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id p100so4603338lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 08:26:36 -0700 (PDT)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/4] ibmebus: fix further device reference leaks
Date: Tue,  1 Nov 2016 16:26:01 +0100
Message-Id: <1478013963-28871-2-git-send-email-johan@kernel.org>
In-Reply-To: <1478013963-28871-1-git-send-email-johan@kernel.org>
References: <1478013963-28871-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure to drop any reference taken by bus_find_device() when creating
devices during init and driver registration.

Fixes: 55347cc9962f ("[POWERPC] ibmebus: Add device creation...)
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/kernel/ibmebus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index c7d3ff7e101c..35f5244782d9 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -180,6 +180,7 @@ static int ibmebus_create_device(struct device_node *dn)
 static int ibmebus_create_devices(const struct of_device_id *matches)
 {
 	struct device_node *root, *child;
+	struct device *dev;
 	int ret = 0;
 
 	root = of_find_node_by_path("/");
@@ -188,9 +189,12 @@ static int ibmebus_create_devices(const struct of_device_id *matches)
 		if (!of_match_node(matches, child))
 			continue;
 
-		if (bus_find_device(&ibmebus_bus_type, NULL, child,
-				    ibmebus_match_node))
+		dev = bus_find_device(&ibmebus_bus_type, NULL, child,
+				      ibmebus_match_node);
+		if (dev) {
+			put_device(dev);
 			continue;
+		}
 
 		ret = ibmebus_create_device(child);
 		if (ret) {
-- 
2.7.3
