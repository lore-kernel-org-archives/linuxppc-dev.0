Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06186DE06C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 06:53:38 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7VKrZKn030888
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:53:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7VKrZqg418144
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:53:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7VKrZKH016302
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:53:35 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l7VKrZlr016292
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:53:35 -0600
Message-Id: <20070831200642.866425000@linux.vnet.ibm.com>>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
Date: Fri, 31 Aug 2007 15:04:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/6] Fix bus probe on Bamboo board
In-Reply-To: <20070831200449.598781000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
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

-- 
