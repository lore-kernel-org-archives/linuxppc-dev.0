Return-Path: <lagrange@fr.oleane.com>
Received: from relay02s.clb.oleane.net (relay02s.clb.oleane.net
	[213.56.31.143]) by ozlabs.org (Postfix) with ESMTP id D8C5767A81
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 01:42:01 +1100 (EST)
Received: from smtp8.clb.oleane.net (smtp8.clb.oleane.net [213.56.31.28])
	by relay02s.clb.oleane.net with ESMTP id j0SEf2Ir030678
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Jan 2005 15:41:58 +0100
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp8.clb.oleane.net with ESMTP id j0SEPo4U003061
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Jan 2005 15:25:53 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 28 Jan 2005 15:29:48 +0100
Message-ID: <001901c50545$d4b17890$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 8021q and change_mtu problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I have tried to use the "change_mtu" function with a 8021q network device.
I have compare this function with an other one define for ethernet devices
in /drivers/net/net_init.c.

These functions always return -EINVAL when the new mtu value is invalid.
But for a valid mtu value the first one returns the new value and the second
one returns 0.

I use a linux 2.6.9 kernel from kernel.org.

I have tried this very simple patch and the function works fine.

--- net/8021q/vlan_dev.c    Fri Jan 28 15:07:58 2005
+++ net/8021q/vlan_dev.c  Fri Jan 28 15:12:12 2005
@@ -527,7 +527,7 @@

    dev->mtu = new_mtu;

-   return new_mtu;
+   return 0;

Laurent
