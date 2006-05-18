Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1F2BA67A00
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 18:05:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4I8PCtt014056
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:25:12 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4I85IFb000558
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 03:05:19 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C07EC@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 16:05:16 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> > The tsi108 serial port is not a sub node of "soc".  well, any way,
> > I can try soc!
> 
> What is it ? Where is it ? "soc" is a bit of a generic name for
> something in the device-tree in fact... we might want to 
> define a way to
> expose any bus via some kind of soc mecanism even if it's not a root
> bus.
> 
> 
Should I just use add_legacy_soc_port() instead of a new function
add_legacy_tsi_port()?
--- arch/powerpc/kernel/legacy_serial.c.orig	Thu May 18 15:35:19 2006
+++ arch/powerpc/kernel/legacy_serial.c	Thu May 18 15:50:38 2006
@@ -302,6 +302,17 @@ void __init find_legacy_serial_ports(voi
 		of_node_put(isa);
 	}
 
+	/* First fill our array with tsi-bridge ports */
+	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+		struct device_node *tsi = of_get_parent(np);
+		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
+			index = add_legacy_soc_port(np, np);
+			if (index >= 0 && np == stdout)
+				legacy_serial_console = index;
+		}
+		of_node_put(tsi);
+	}
+	
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) 
