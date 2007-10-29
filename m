Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18213.19066.134475.220466@cargo.ozlabs.ibm.com>
Date: Mon, 29 Oct 2007 13:50:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] Fix duplicate time accounting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, process user and system times are advancing twice as fast
as they should because they are being accounted in two places - in the
generic code and in timer_interrupt.  This fixes it by removing the
call to account_process_time in timer_interrupt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 9eb3284..5e253d6 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -599,16 +599,6 @@ void timer_interrupt(struct pt_regs * regs)
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	/*
-	 * We cannot disable the decrementer, so in the period
-	 * between this cpu's being marked offline in cpu_online_map
-	 * and calling stop-self, it is taking timer interrupts.
-	 * Avoid calling into the scheduler rebalancing code if this
-	 * is the case.
-	 */
-	if (!cpu_is_offline(cpu))
-		account_process_time(regs);
-
 	if (evt->event_handler)
 		evt->event_handler(evt);
 	else
