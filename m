Return-Path: <anton@ozlabs.org>
Date: Sun, 14 Oct 2007 14:18:46 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Quieten clockevent printk
Message-ID: <20071014191846.GB26693@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The clockevent bootup message only needs to be KERN_INFO.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 9368da3..863a5d6 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -829,7 +829,7 @@ static void register_decrementer_clockevent(int cpu)
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of_cpu(cpu);
 
-	printk(KERN_ERR "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",
+	printk(KERN_INFO "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",
 	       dec->name, dec->mult, dec->shift, cpu);
 
 	clockevents_register_device(dec);
