Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 04C00DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 13:11:54 +1100 (EST)
Date: Mon, 5 Nov 2007 20:21:03 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Don't reset mpic at boot
Message-ID: <20071106022103.GA2382@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Don't reset mpic at boot
    
Due to an erratum, we don't want to reset the mpic at boot time. It can
sometimes cause problems with lost interrupts later on while running.
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 857d238..bd85853 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -214,7 +214,7 @@ static __init void pas_init_IRQ(void)
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
 	mpic = mpic_alloc(mpic_node, openpic_addr,
-			  MPIC_PRIMARY|MPIC_LARGE_VECTORS|MPIC_WANTS_RESET,
+			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
 			  0, 0, " PAS-OPIC  ");
 	BUG_ON(!mpic);
 
