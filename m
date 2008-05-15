Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1D5CDE4D9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 00:44:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FEfasM032441
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 10:41:36 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FEih2e063150
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:44:44 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FEidot019719
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:44:40 -0600
Received: from zod.rchland.ibm.com (wecm-9-67-211-47.wecm.ibm.com
	[9.67.211.47])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4FEiX8Q019592
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:44:37 -0600
Date: Thu, 15 May 2008 09:41:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 4xx: Fix PCI mem in rainier DTS
Message-ID: <20080515094123.44974e84@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the PCI node in the Rainier to match the spec from AMCC.  A
similar fix was done for 440EPx, which shares the same values as 440GRx.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/dts/rainier.dts |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/dts/rainier.dts
+++ linux-2.6/arch/powerpc/boot/dts/rainier.dts
@@ -328,8 +328,9 @@
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 80000000 1 80000000 0 10000000
-				01000000 0 00000000 1 e8000000 0 00100000>;
+			ranges = <02000000 0 80000000 1 80000000 0 40000000
+				01000000 0 00000000 1 e8000000 0 00010000
+				01000000 0 00000000 1 e8800000 0 03800000>;
 
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <42000000 0 0 0 0 0 80000000>;
