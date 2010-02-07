Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 09:28:01 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Only print clockevent settings once
Message-ID: <20100207222801.GE32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The clockevent multiplier and shift is useful information, but we
only need to print it once.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/time.c	2010-02-05 14:57:48.839716602 +1100
+++ powerpc.git/arch/powerpc/kernel/time.c	2010-02-05 14:57:53.057212067 +1100
@@ -930,13 +930,17 @@ static void __init setup_clockevent_mult
 
 static void register_decrementer_clockevent(int cpu)
 {
+	static int printed = 0;
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
 
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);
 
-	printk(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
-	       dec->name, dec->mult, dec->shift, cpu);
+	if (!printed) {
+		printed = 1;
+		printk(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
+		       dec->name, dec->mult, dec->shift, cpu);
+	}
 
 	clockevents_register_device(dec);
 }
