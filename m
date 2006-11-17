Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns8.sony.co.jp (NS8.Sony.CO.JP [137.153.0.33])
	by ozlabs.org (Postfix) with ESMTP id 0BBDF67BE8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:43:16 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAH3hEKL023131
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:43:14 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAH3hEcs023124
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:43:14 +0900 (JST)
Message-ID: <455D2FC6.5020506@am.sony.com>
Date: Thu, 16 Nov 2006 19:43:02 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/16] powerpc: add ps3 platform feature bits
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

Adds the needed firmware feature bits for ps3pf.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 include/asm-powerpc/firmware.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: cell--common--6/include/asm-powerpc/firmware.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/firmware.h
+++ cell--common--6/include/asm-powerpc/firmware.h
@@ -58,6 +58,8 @@
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
+	FW_FEATURE_PS3PF_POSSIBLE = FW_FEATURE_LPAR,
+	FW_FEATURE_PS3PF_ALWAYS = FW_FEATURE_LPAR,
 	FW_FEATURE_POSSIBLE =
 #ifdef CONFIG_PPC_PSERIES
 		FW_FEATURE_PSERIES_POSSIBLE |
@@ -65,6 +67,9 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_POSSIBLE |
 #endif
+#ifdef CONFIG_PS3PF
+		FW_FEATURE_PS3PF_POSSIBLE |
+#endif
 		0,
 	FW_FEATURE_ALWAYS =
 #ifdef CONFIG_PPC_PSERIES
@@ -73,6 +78,9 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_ALWAYS &
 #endif
+#ifdef CONFIG_PS3PF
+		FW_FEATURE_PS3PF_ALWAYS &
+#endif
 		FW_FEATURE_POSSIBLE,
 
 #else /* CONFIG_PPC64 */
