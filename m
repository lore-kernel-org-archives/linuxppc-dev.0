Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 122DBDDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 03:51:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SHp2bX014563
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:51:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SHp2RO485760
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:51:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SHp29e003789
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:51:02 -0600
Date: Tue, 28 Aug 2007 12:51:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 1/1] Fix bus probe on Bamboo board
Message-ID: <20070828125100.31b0ab98@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 804ace8881d21 changed the behavior of how compatible nodes are found.
This highlighted a bug on the Bamboo board where it wasn't probing the bus
specified in the DTS file.  We fix it by being explicit about which bus to
probe.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/44x/bamboo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/platforms/44x/bamboo.c
+++ linux-2.6/arch/powerpc/platforms/44x/bamboo.c
@@ -23,7 +23,7 @@
 #include "44x.h"
 
 static struct of_device_id bamboo_of_bus[] = {
-	{ .compatible = "ibm,plb", },
+	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
 	{},
