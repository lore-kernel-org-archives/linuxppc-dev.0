Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id BE2FFDE00A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193912.848566969@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:43 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 05/10] add check for initialized driver data to pmi driver
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>
This patch adds a check for the private driver data to be initialized.
The bug showed up, as the caller found a pmi device by it's type.
Whereas the pmi driver probes for the type and the name.
Since the name was not as the driver expected, it did not initialize.
A more relaxed probing will be supplied with an extra patch, too.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/sysdev/pmi.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/pmi.c
+++ linux-2.6/arch/powerpc/sysdev/pmi.c
@@ -279,6 +279,9 @@ void pmi_register_handler(struct of_devi
 	struct pmi_data *data;
 	data = device->dev.driver_data;
 
+	if (!data)
+		return;
+
 	spin_lock(&data->handler_spinlock);
 	list_add_tail(&handler->node, &data->handler);
 	spin_unlock(&data->handler_spinlock);
@@ -289,10 +292,12 @@ void pmi_unregister_handler(struct of_de
 			    struct pmi_handler *handler)
 {
 	struct pmi_data *data;
+	data = device->dev.driver_data;
 
-	pr_debug("pmi: unregistering handler %p\n", handler);
+	if (!data)
+		return;
 
-	data = device->dev.driver_data;
+	pr_debug("pmi: unregistering handler %p\n", handler);
 
 	spin_lock(&data->handler_spinlock);
 	list_del(&handler->node);

--
