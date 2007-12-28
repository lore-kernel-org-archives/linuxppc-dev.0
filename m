Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0BC6ADDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 02:19:52 +1100 (EST)
Date: Fri, 28 Dec 2007 09:27:29 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Distribute interrupts evenly across cpus
Message-ID: <20071228152729.GA2989@lixom.net>
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

[POWERPC] pasemi: Distribute interrupts evenly across cpus
    
By default the OpenPIC on PWRficient will bias to one core (since that
will improve changes of the other core being able to stay idle/powered
down). However, this conflicts with most irq load balancing schemes,
since setting an interrupt to be delivered to either core doesn't really
result in the load being shared. It also doesn't work well with the
soft irq disable feature of PPC, since EE will stay on until the first
interrupt is taken while soft disabled, but the PIC doesn't know that
when choosing the target.
    
There's a conf0 bit to specify that deliveries should be evenly spread
(round robin) between the cores. Running in that mode makes more sense
for Linux.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 932b2ec..6c37457 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -224,7 +224,7 @@ static __init void pas_init_IRQ(void)
 	openpic_addr = of_read_number(opprop, naddr);
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
-	mpic_flags = MPIC_PRIMARY | MPIC_LARGE_VECTORS;
+	mpic_flags = MPIC_PRIMARY | MPIC_LARGE_VECTORS | MPIC_NO_BIAS;
 
 	nmiprop = of_get_property(mpic_node, "nmi-source", NULL);
 	if (nmiprop)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 5a9d8c1..f88ff09 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1279,6 +1279,11 @@ void __init mpic_init(struct mpic *mpic)
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
 
+	if (mpic->flags & MPIC_NO_BIAS)
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
+			| MPIC_GREG_GCONF_NO_BIAS);
+
 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index e7ac810..943c5a3 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -22,6 +22,7 @@
 #define MPIC_GREG_GLOBAL_CONF_0		0x00020
 #define		MPIC_GREG_GCONF_RESET			0x80000000
 #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
+#define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
 #define		MPIC_GREG_GCONF_MCK			0x08000000
 #define MPIC_GREG_GLOBAL_CONF_1		0x00030
@@ -350,6 +351,8 @@ struct mpic
 #define MPIC_LARGE_VECTORS		0x00000100
 /* Enable delivery of prio 15 interrupts as MCK instead of EE */
 #define MPIC_ENABLE_MCK			0x00000200
+/* Disable bias among target selection, spread interrupts evenly */
+#define MPIC_NO_BIAS			0x00000400
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
