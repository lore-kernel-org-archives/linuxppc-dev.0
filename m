Return-Path: <SRS0+a60785a1dbbd8c6271ac+804+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 100556868F
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 04:54:29 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 17:54:22 +0000
Message-Id: <1131213262.10031.250.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix i8259 cascade IRQ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

setup_irq() aborts immediately if there's no handler for the IRQ in
question. So i8259_init() should set up its handlers before trying to
set up the cascade on IRQ 2.

With this and the patch I sent a few days ago to fix initrd on ppc32, my
Pegasos now runs the arch/powerpc kernel.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 90bce6e..b7ac32f 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -207,6 +207,9 @@ void __init i8259_init(unsigned long int
 
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
+	for (i = 0; i < NUM_ISA_INTERRUPTS; ++i)
+		irq_desc[offset + i].handler = &i8259_pic;
+
 	/* reserve our resources */
 	setup_irq(offset + 2, &i8259_irqaction);
 	request_resource(&ioport_resource, &pic1_iores);
@@ -216,6 +219,4 @@ void __init i8259_init(unsigned long int
 	if (intack_addr != 0)
 		pci_intack = ioremap(intack_addr, 1);
 
-	for (i = 0; i < NUM_ISA_INTERRUPTS; ++i)
-		irq_desc[offset + i].handler = &i8259_pic;
 }

-- 
dwmw2
