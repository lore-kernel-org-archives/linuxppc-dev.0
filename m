Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 699F5DDF4E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170238.347478000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:51 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 18/35] Spread IRQs among cpus by default
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Spread IRQs between the two cores on our openpic. Without this,
they get delivered to cpu 0 as long as it's available.

This needs a bit more cleanup -- it needs a flag so it can coexist
with other implementations.

Index: 2.6.21/arch/powerpc/sysdev/mpic.c
===================================================================
--- 2.6.21.orig/arch/powerpc/sysdev/mpic.c
+++ 2.6.21/arch/powerpc/sysdev/mpic.c
@@ -1191,6 +1191,11 @@ void __init mpic_init(struct mpic *mpic)
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
 
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+		   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
+		   | 0x10000000);
+
+
 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 }

--
