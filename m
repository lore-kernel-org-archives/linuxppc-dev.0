Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXlql4NrgzDqdM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:26:59 +1000 (AEST)
Message-Id: <20170524081548.331016542@linutronix.de>
Date: Wed, 24 May 2017 10:15:27 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch V3 16/32] powerpc/powernv: Use stop_machine_cpuslocked()
References: <20170524081511.203800767@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

set_subcores_per_core() holds get_online_cpus() while invoking stop_machine().

stop_machine() invokes get_online_cpus() as well. This is correct, but
prevents the conversion of the hotplug locking to a percpu rwsem.

Use stop_machine_cpuslocked() to avoid the nested call. Convert
*_online_cpus() to the new interfaces while at it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/platforms/powernv/subcore.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -348,7 +348,7 @@ static int set_subcores_per_core(int new
 		state->master = 0;
 	}
 
-	get_online_cpus();
+	cpus_read_lock();
 
 	/* This cpu will update the globals before exiting stop machine */
 	this_cpu_ptr(&split_state)->master = 1;
@@ -356,9 +356,10 @@ static int set_subcores_per_core(int new
 	/* Ensure state is consistent before we call the other cpus */
 	mb();
 
-	stop_machine(cpu_update_split_mode, &new_mode, cpu_online_mask);
+	stop_machine_cpuslocked(cpu_update_split_mode, &new_mode,
+				cpu_online_mask);
 
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 }
