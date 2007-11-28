Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 5DC18DDECB
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 01:35:21 +1100 (EST)
Message-Id: <20071128143438.613525000@pademelon.sonytel.be>
References: <20071128143142.580732000@pademelon.sonytel.be>
Date: Wed, 28 Nov 2007 15:31:48 +0100
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [patch 6/7] ps3: Refactor ps3_repository_find_device()
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3: Refactor ps3_repository_find_device() to use the existing
ps3_repository_read_bus_id()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
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
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
