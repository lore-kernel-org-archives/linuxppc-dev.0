Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E2B60DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:16 +1100 (EST)
Message-Id: <20070202045507.589087000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:49 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [1/9] pasemi: Default root device
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Set up default root device on the pasemi platform.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -35,6 +35,8 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
+#include <linux/root_dev.h>
+
 
 #include "pasemi.h"
 
@@ -82,6 +84,14 @@ void __init pas_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
+	if (ROOT_DEV == 0) {
+#ifdef  CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_SDA1;
+#endif
+	}
+
 	printk(KERN_DEBUG "Using default idle loop\n");
 }
 

--
