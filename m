Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A9D57DE4FA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:14:13 +1100 (EST)
Date: Thu, 25 Jan 2007 02:20:02 -0600
To: paulus@samba.org, gregkh@suse.de
Subject: [PATCH] [3/4] PMC-related cleanups
Message-ID: <20070125082002.GD10716@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
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


Index: powerpc/include/linux/sysdev.h
===================================================================
--- powerpc.orig/include/linux/sysdev.h
+++ powerpc/include/linux/sysdev.h
@@ -98,12 +98,15 @@ struct sysdev_attribute { 
 };
 
 
-#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
-struct sysdev_attribute attr_##_name = { 			\
+#define _SYSDEV_ATTR(_name,_mode,_show,_store)			\
+{								\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
-};
+}
+
+#define SYSDEV_ATTR(_name,_mode,_show,_store)		\
+struct sysdev_attribute attr_##_name = _SYSDEV_ATTR(_name,_mode,_show,_store);
 
 extern int sysdev_create_file(struct sys_device *, struct sysdev_attribute *);
 extern void sysdev_remove_file(struct sys_device *, struct sysdev_attribute *);
