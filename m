Date: Fri, 8 Feb 2002 18:46:10 -0700
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix heartbeat
Message-ID: <20020208184610.E28166@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The heartbeat function will not execute properly on Gemini without
this patch. (Check for cpu 0 removed from gemini_heartbeat.)

-VAL

diff -Nru a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	Fri Feb  8 15:12:57 2002
+++ b/arch/ppc/kernel/time.c	Fri Feb  8 15:12:57 2002
@@ -208,7 +208,8 @@
 	smp_local_timer_interrupt(regs);
 #endif /* CONFIG_SMP */

-	if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
+	if (ppc_md.heartbeat && !smp_processor_id() &&
+	    !ppc_md.heartbeat_count--)
 		ppc_md.heartbeat();

 	hardirq_exit(cpu);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
