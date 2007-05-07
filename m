Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CFA3FDDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l47ITqCN018441
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:52 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l47ITpV0023777
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:51 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I84we022247
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:05 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CE6CEAEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:50 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITo4o026950
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:50 -0500
Date: Mon, 7 May 2007 13:29:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/13] Implement arch disable/enable irq hooks.
Message-ID: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These hooks ensure that a decrementer interrupt is not pending when
suspending; otherwise, problems may occur.  For example, with deep sleep
on the 831x, a pending decrementer will cause a system freeze because the
SoC thinks the decrementer interrupt would have woken the system, but the
core must have interrupts disabled due to the setup required for deep
sleep.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/time.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7cedef8..46546a3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -707,6 +707,29 @@ void wakeup_decrementer(void)
 	set_dec(ticks);
 }
 
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_disable_irqs(void)
+{
+	preempt_disable();
+
+	/* Disable the decrementer, so that it doesn't interfere
+	 * with suspending.
+	 */
+
+	set_dec(0x7fffffff);
+	local_irq_disable();
+	set_dec(0x7fffffff);
+}
+
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_enable_irqs(void)
+{
+	wakeup_decrementer();
+
+	local_irq_enable();
+	preempt_enable();
+}
+
 #ifdef CONFIG_SMP
 void __init smp_space_timers(unsigned int max_cpus)
 {
-- 
1.5.0.3
