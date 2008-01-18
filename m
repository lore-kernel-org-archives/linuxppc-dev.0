Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail197-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24EEEDE011
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:13 +1100 (EST)
Message-ID: <47910CCA.8070602@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:10 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 07/16] PS3: Refactor ps3_repository_find_device()
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3: Refactor ps3_repository_find_device() to use the existing
ps3_repository_read_bus_id() routine.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/repository.c |   60 +++++++++++---------------------
 1 files changed, 22 insertions(+), 38 deletions(-)

--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -445,50 +445,34 @@ int __devinit ps3_repository_find_device
 
 	pr_debug(" -> %s:%d: find bus_type %u\n", __func__, __LINE__, bus_type);
 
-	for (repo.bus_index = 0; repo.bus_index < 10; repo.bus_index++) {
+	repo.bus_type = bus_type;
+	result = ps3_repository_find_bus(repo.bus_type, 0, &repo.bus_index);
+	if (result) {
+		pr_debug(" <- %s:%u: bus not found\n", __func__, __LINE__);
+		return result;
+	}
 
-		result = ps3_repository_read_bus_type(repo.bus_index,
-			&repo.bus_type);
+	result = ps3_repository_read_bus_id(repo.bus_index, &repo.bus_id);
+	if (result) {
+		pr_debug("%s:%d read_bus_id(%u) failed\n", __func__, __LINE__,
+			 repo.bus_index);
+		return result;
+	}
 
-		if (result) {
-			pr_debug("%s:%d read_bus_type(%u) failed\n",
-				__func__, __LINE__, repo.bus_index);
+	for (repo.dev_index = 0; ; repo.dev_index++) {
+		result = ps3_repository_find_device(&repo);
+		if (result == -ENODEV) {
+			result = 0;
+			break;
+		} else if (result)
 			break;
-		}
-
-		if (repo.bus_type != bus_type) {
-			pr_debug("%s:%d: skip, bus_type %u\n", __func__,
-				__LINE__, repo.bus_type);
-			continue;
-		}
-
-		result = ps3_repository_read_bus_id(repo.bus_index,
-			&repo.bus_id);
 
+		result = callback(&repo);
 		if (result) {
-			pr_debug("%s:%d read_bus_id(%u) failed\n",
-				__func__, __LINE__, repo.bus_index);
-			continue;
-		}
-
-		for (repo.dev_index = 0; ; repo.dev_index++) {
-			result = ps3_repository_find_device(&repo);
-
-			if (result == -ENODEV) {
-				result = 0;
-				break;
-			} else if (result)
-				break;
-
-			result = callback(&repo);
-
-			if (result) {
-				pr_debug("%s:%d: abort at callback\n", __func__,
-					__LINE__);
-				break;
-			}
+			pr_debug("%s:%d: abort at callback\n", __func__,
+				__LINE__);
+			break;
 		}
-		break;
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);

-- 
