Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id C2217DE00C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193912.986404391@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:44 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 06/10] pmi probe device by device-type
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
At the moment the pmi device driver is probing for devices with
a given type and a given name. As there may be devices of
the same type but with a different name, probing should be
done also for device type only.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/sysdev/pmi.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/pmi.c
+++ linux-2.6/arch/powerpc/sysdev/pmi.c
@@ -118,6 +118,7 @@ out:
 
 static struct of_device_id pmi_match[] = {
 	{ .type = "ibm,pmi", .name = "ibm,pmi" },
+	{ .type = "ibm,pmi" },
 	{},
 };
 

--
