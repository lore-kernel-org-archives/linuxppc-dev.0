Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w51m368zczDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 03:31:31 +1000 (AEST)
Message-Id: <20170415171652.331526644@linutronix.de>
Date: Sat, 15 Apr 2017 19:01:20 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch 13/20] powerpc/powernv: Use stop_machine_locked()
References: <20170415170107.643253702@linutronix.de>
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

set_subcores_per_core() holds get_online_cpus() while invoking stop_machine().

stop_machine() invokes get_online_cpus() as well. This is correct, but
prevents the conversion of the hotplug locking to a percpu rwsem.

Use stop_machine_locked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/platforms/powernv/subcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -356,7 +356,7 @@ static int set_subcores_per_core(int new
 	/* Ensure state is consistent before we call the other cpus */
 	mb();
 
-	stop_machine(cpu_update_split_mode, &new_mode, cpu_online_mask);
+	stop_machine_locked(cpu_update_split_mode, &new_mode, cpu_online_mask);
 
 	put_online_cpus();
 
