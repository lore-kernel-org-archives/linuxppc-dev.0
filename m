Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKn4lYxzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:13 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a14so17948666pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/11] powerpc: allow soft-NMI watchdog to cover timer
 interrupts with large decrementers
Date: Sat,  5 May 2018 03:19:32 +1000
Message-Id: <20180504171935.25410-9-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Large decrementers (e.g., POWER9) can take a very long time to wrap,
so when the timer iterrupt handler sets the decrementer to max so as
to avoid taking another decrementer interrupt when hard enabling
interrupts before running timers, it effectively disables the soft
NMI coverage for timer interrupts.

Fix this by using the traditional 31-bit value instead, which wraps
after a few seconds. masked interrupt code does the same thing, and
in normal operation neither of these paths would ever wrap even the
31 bit value.

Note: the SMP watchdog should catch timer interrupt lockups, but it
is preferable for the local soft-NMI to catch them, mainly to avoid
the IPI.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/time.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index ad876906f847..5862a3611795 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -578,22 +578,29 @@ void timer_interrupt(struct pt_regs *regs)
 	struct pt_regs *old_regs;
 	u64 now;
 
-	/* Ensure a positive value is written to the decrementer, or else
-	 * some CPUs will continue to take decrementer exceptions.
-	 */
-	set_dec(decrementer_max);
-
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
 	 * decrementers_next_tb as MAX to make sure __check_irq_replay
 	 * don't replay timer interrupt when return, otherwise we'll trap
 	 * here infinitely :(
 	 */
-	if (!cpu_online(smp_processor_id())) {
+	if (unlikely(!cpu_online(smp_processor_id()))) {
 		*next_tb = ~(u64)0;
+		set_dec(decrementer_max);
 		return;
 	}
 
+	/* Ensure a positive value is written to the decrementer, or else
+	 * some CPUs will continue to take decrementer exceptions. When the
+	 * PPC_WATCHDOG (decrementer based) is configured, keep this at most
+	 * 31 bits, which is about 4 seconds on most systems, which gives
+	 * the watchdog a chance of catching timer interrupt hard lockups.
+	 */
+	if (IS_ENABLED(CONFIG_PPC_WATCHDOG))
+		set_dec(0x7fffffff);
+	else
+		set_dec(decrementer_max);
+
 	/* Conditionally hard-enable interrupts now that the DEC has been
 	 * bumped to its maximum value
 	 */
-- 
2.17.0
