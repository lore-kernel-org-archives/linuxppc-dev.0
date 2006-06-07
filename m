Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AB3067B26
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 12:01:41 +1000 (EST)
Subject: [PATCH] powerpc: Fix call to ibm,client-architecture-support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 12:01:32 +1000
Message-Id: <1149645693.27572.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code in prom_init.c calling the firmware
ibm,client-architecture-support on pSeries has a bug where it fails to
properly pass the instance handle of the firmware object when trying to
call a method. Result ranges from the call doing nothing to the firmware
crashing. (Found by Segher, thanks !)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-05-30 13:00:51.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_init.c	2006-06-06 11:59:20.000000000 +1000
@@ -822,6 +822,7 @@ static void __init prom_send_capabilitie
 		/* try calling the ibm,client-architecture-support method */
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
+				  root,
 				  ADDR(ibm_architecture_vec)) == 0) {
 			/* the call exists... */
 			if (ret)
