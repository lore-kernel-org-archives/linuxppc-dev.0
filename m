Return-Path: <hollisb@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75ADDDDD07
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 06:45:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EKj4vR006055
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 16:45:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EKj4fr688720
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 16:45:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EKj4hX019596
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 16:45:04 -0400
Subject: [PATCH] fix xmon input on 440
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 15:44:47 -0500
Message-Id: <1189802687.20625.74.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement udbg_getc() for 440, which fixes xmon input.
Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -206,11 +206,22 @@ static void udbg_44x_as1_putc(char c)
        }
 }
 
+static int udbg_44x_as1_getc(void)
+{
+       if (udbg_comport) {
+               while ((as1_readb(&udbg_comport->lsr) & LSR_DR) == 0)
+                       /* wait for char */;
+               return as1_readb(&udbg_comport->rbr);
+       }
+       return -1;
+}
+
 void __init udbg_init_44x_as1(void)
 {
        udbg_comport =
                (volatile struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
 
        udbg_putc = udbg_44x_as1_putc;
+       udbg_getc = udbg_44x_as1_getc;
 }
 #endif /* CONFIG_PPC_EARLY_DEBUG_44x */

-- 
Hollis Blanchard
IBM Linux Technology Center
