Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BFA7A67C23
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 08:37:19 +1100 (EST)
Date: Mon, 6 Nov 2006 13:36:36 -0800
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 2.6.19-rc4-mm2 iseries net_device compile issue
Message-ID: <20061106213636.GA1339@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

2.6.19-rc4-mm2 has this error for 'powerpc' allmodconfig:

drivers/net/iseries_veth.c: In function 'veth_probe_one':
drivers/net/iseries_veth.c:1103: error: 'struct net_device' has no member named 'class_dev'

This patch fixes the error.

Signed-off-by: Judith Lebzelter <judith@osdl.org>
---
Files edited:
drivers/net/iseries_veth.c
---

Index: linux/drivers/net/iseries_veth.c
===================================================================
--- linux.orig/drivers/net/iseries_veth.c	2006-11-02 13:59:38.000000000 -0800
+++ linux/drivers/net/iseries_veth.c	2006-11-02 14:05:44.000000000 -0800
@@ -1100,7 +1100,7 @@
 	}
 
 	kobject_init(&port->kobject);
-	port->kobject.parent = &dev->class_dev.kobj;
+	port->kobject.parent = &dev->dev.kobj;
 	port->kobject.ktype  = &veth_port_ktype;
 	kobject_set_name(&port->kobject, "veth_port");
 	if (0 != kobject_add(&port->kobject))
