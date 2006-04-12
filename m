Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:26:00 -0500
To: paulus@ozlabs.org
Subject: [7/10]: Lack of ISA interrupts on XICS isn't dangerous
Message-ID: <20060412202559.GN19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This isn't really a dangerous thing any more; most systems lack
ISA interrupt controllers.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ 2.6/arch/powerpc/platforms/pseries/xics.c
@@ -522,7 +522,7 @@ nextnode:
 
 	np = of_find_node_by_type(NULL, "interrupt-controller");
 	if (!np) {
-		printk(KERN_WARNING "xics: no ISA interrupt controller\n");
+		printk(KERN_DEBUG "xics: no ISA interrupt controller\n");
 		xics_irq_8259_cascade_real = -1;
 		xics_irq_8259_cascade = -1;
 	} else {
