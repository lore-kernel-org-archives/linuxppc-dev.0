Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C942FDDF5B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170242.174446000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:05 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 32/35] Dont reset openpic on init
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Take out the MPIC_WANTS_RESET again, since it turns out it causes loss
of interrupt grant tokens during some circumstances on Ax.

Index: 2.6.21/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/setup.c
+++ 2.6.21/arch/powerpc/platforms/pasemi/setup.c
@@ -156,7 +156,7 @@ static __init void pas_init_IRQ(void)
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
 	mpic = mpic_alloc(mpic_node, openpic_addr,
-			  MPIC_PRIMARY|MPIC_LARGE_VECTORS|MPIC_WANTS_RESET,
+			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
 			  0, 0, " PAS-OPIC  ");
 	BUG_ON(!mpic);
 

--
