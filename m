Return-Path: <minyard@acm.org>
Received: from vms173011pub.verizon.net (vms173011pub.verizon.net
	[206.46.173.11]) by ozlabs.org (Postfix) with ESMTP id A8AD5B7D43
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 06:38:08 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173011.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX600FG2H6YN4C2@vms173011.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 01 Feb 2010 13:37:46 -0600 (CST)
Received: from i2 (i2.minyard.local [192.168.27.126])
	by wf-rch.minyard.local (Postfix) with ESMTP id 090511F826	for
	<linuxppc-dev@ozlabs.org>; Mon, 01 Feb 2010 13:37:46 -0600 (CST)
Date: Mon, 01 Feb 2010 13:37:46 -0600
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Set the port device in the mpsc serial driver
Message-id: <20100201193745.GB10863@minyard.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Corey Minyard <cminyard@mvista.com>

The mpsc serial driver needx to set the port's device tree element
to register properly.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

Index: linux-2.6/drivers/serial/mpsc.c
===================================================================
--- linux-2.6.orig/drivers/serial/mpsc.c
+++ linux-2.6/drivers/serial/mpsc.c
@@ -2070,6 +2070,7 @@ static int mpsc_drv_probe(struct platfor
 
 		if (!(rc = mpsc_drv_map_regs(pi, dev))) {
 			mpsc_drv_get_platform_data(pi, dev, dev->id);
+			pi->port.dev = &dev->dev;
 
 			if (!(rc = mpsc_make_ready(pi))) {
 				spin_lock_init(&pi->tx_lock);
