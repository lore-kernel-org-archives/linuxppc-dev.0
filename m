Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 81568DDF34
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:10:36 +1000 (EST)
Date: Mon, 16 Apr 2007 01:28:38 -0500
To: paulus@samba.org
Subject: [PATCH] [3/5] pasemi: reset mpic on boot
Message-ID: <20070416062838.GA20319@lixom.net>
References: <20070416062634.GB20196@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416062634.GB20196@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reset MPIC on boot to clear some timer state that firmware might
leave configured.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/setup.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/setup.c
@@ -147,7 +147,7 @@ static __init void pas_init_IRQ(void)
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
 	mpic = mpic_alloc(mpic_node, openpic_addr,
-			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
+			  MPIC_PRIMARY|MPIC_LARGE_VECTORS|MPIC_WANTS_RESET,
 			  0, 0, " PAS-OPIC  ");
 	BUG_ON(!mpic);
 
