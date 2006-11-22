Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9E44967D29
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:50:15 +1100 (EST)
Message-ID: <4563D000.7010802@am.sony.com>
Date: Tue, 21 Nov 2006 20:20:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/14] powerpc: add ps3 platform feature bits
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>

Adds the needed firmware feature bits for the PS3.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 include/asm-powerpc/firmware.h |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: cell--common--6/include/asm-powerpc/firmware.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/firmware.h
+++ cell--common--6/include/asm-powerpc/firmware.h
@@ -58,6 +58,8 @@
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
+	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR,
+	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR,
 	FW_FEATURE_POSSIBLE =
 #ifdef CONFIG_PPC_PSERIES
 		FW_FEATURE_PSERIES_POSSIBLE |
@@ -65,6 +67,9 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_POSSIBLE |
 #endif
+#ifdef CONFIG_PS3
+		FW_FEATURE_PS3_POSSIBLE |
+#endif
 		0,
 	FW_FEATURE_ALWAYS =
 #ifdef CONFIG_PPC_PSERIES
@@ -73,6 +78,9 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_ALWAYS &
 #endif
+#ifdef CONFIG_PS3
+		FW_FEATURE_PS3_ALWAYS &
+#endif
 		FW_FEATURE_POSSIBLE,
 
 #else /* CONFIG_PPC64 */
