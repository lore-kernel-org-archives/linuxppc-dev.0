Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013824.719899000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:11 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 01/10] Add missing oops_enter/oops_exit
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add missing oops_enter/oops_exit, makes pause_on_oops boot parameter work.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-11 10:23:04.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-11 10:25:31.000000000 -0500
@@ -99,6 +99,8 @@
 	if (debugger(regs))
 		return 1;
 
+	oops_enter();
+
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
@@ -145,6 +147,7 @@
 	if (panic_on_oops)
 		panic("Fatal exception");
 
+	oops_exit();
 	do_exit(err);
 
 	return 0;

--
