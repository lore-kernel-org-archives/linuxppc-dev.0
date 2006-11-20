Return-Path: <arnd@arndb.de>
Message-Id: <20061120180520.418063000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:44:55 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I got a bug report that I believe might be fixed by this
patch. The problem seems to be that with soft-disabled
interrupts in power_save, we can still get external exceptions
on Cell, even if we are in pause(0) a.k.a. sleep state.

When the CPU really wakes up through the 0x100 (system reset)
vector, while we have already started processing the 0x500
(external) exception, we get a panic in unrecoverable_exception()
because of the lost state.

This occurred in Systemsim for Cell, but as far as I can see,
it can theoretically occur on any machine that uses the
system reset exception to get out of sleep state.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6/arch/powerpc/kernel/idle.c
@@ -66,13 +66,13 @@ void cpu_idle(void)
 				 * is ordered w.r.t. need_resched() test.
 				 */
 				smp_mb();
-				local_irq_disable();
+				hard_irq_disable();
 
 				/* check again after disabling irqs */
 				if (!need_resched() && !cpu_should_die())
 					ppc_md.power_save();
 
-				local_irq_enable();
+				hard_irq_enable();
 				set_thread_flag(TIF_POLLING_NRFLAG);
 
 			} else {

--
