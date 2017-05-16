Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wS65q62YlzDqZY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 04:53:03 +1000 (AEST)
Message-Id: <20170516184735.359536998@linutronix.de>
Date: Tue, 16 May 2017 20:42:37 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [patch V2 06/17] powerpc: Adjust system_state check
References: <20170516184231.564888231@linutronix.de>
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

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in smp_generic_cpu_bootable() to handle the
extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -97,7 +97,7 @@ int smp_generic_cpu_bootable(unsigned in
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
