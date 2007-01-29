Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1CE12DE242
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:18:35 +1100 (EST)
Date: Sun, 28 Jan 2007 21:24:57 -0600
To: paulus@samba.org
Subject: [PATCH] [3/4] Introduce _SYSDEV_ATTR
Message-ID: <20070129032457.GF6412@lixom.net>
References: <20070129032143.GC6412@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070129032143.GC6412@lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Introduce _SYSDEV_ATTR(), to be used to just define the struct, and not a
named variable with the attribute. Useful for arrays of sysdev_attributes.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>                                              


Index: merge/include/linux/sysdev.h
===================================================================
--- merge.orig/include/linux/sysdev.h
+++ merge/include/linux/sysdev.h
@@ -98,12 +98,16 @@ struct sysdev_attribute { 
 };
 
 
-#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
-struct sysdev_attribute attr_##_name = { 			\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+#define _SYSDEV_ATTR(_name,_mode,_show,_store)			\
+{								\
+	.attr = { .name = __stringify(_name), .mode = _mode,	\
+		 .owner = THIS_MODULE },			\
 	.show	= _show,					\
 	.store	= _store,					\
-};
+}
+
+#define SYSDEV_ATTR(_name,_mode,_show,_store)		\
+struct sysdev_attribute attr_##_name = _SYSDEV_ATTR(_name,_mode,_show,_store);
 
 extern int sysdev_create_file(struct sys_device *, struct sysdev_attribute *);
 extern void sysdev_remove_file(struct sys_device *, struct sysdev_attribute *);
