Return-Path: <anna-maria@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdncx73N9zDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 20:03:45 +1000 (AEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pmac/smp: Add missing FROZEN hotplug notifier
 transitions
Date: Mon,  4 Apr 2016 11:30:01 +0200
Message-Id: <1459762201-183136-1-git-send-email-anna-maria@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The FROZEN transitions are used when a CPU suspends/resumes. In case
of a suspend/resume, only the up prepare (CPU_UP_PREPARE_FROZEN) is
handled. The error handling transition CPU_UP_CANCELED_FROZEN as well
as the CPU_ONLINE_FROZEN transition are not handled.

Masking the switch case action argument with ~CPU_TASKS_FROZEN, to
handle all FROZEN tasks the same way than the corresponding non frozen
tasks.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/powerpc/platforms/powermac/smp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -857,9 +857,8 @@ static int smp_core99_cpu_notify(struct
 {
 	int rc;
 
-	switch(action) {
+	switch(action & ~CPU_TASKS_FROZEN) {
 	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
 		/* Open i2c bus if it was used for tb sync */
 		if (pmac_tb_clock_chip_host) {
 			rc = pmac_i2c_open(pmac_tb_clock_chip_host, 1);
