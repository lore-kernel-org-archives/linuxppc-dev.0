Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EB162C0114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2013 14:01:26 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v1][PATCH 1/1] ppc64: max next_tb to prevent from replaying timer
 interrupt
Date: Wed, 16 Jan 2013 11:01:19 +0800
Message-ID: <1358305279-19068-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With lazy interrupt, we always call __check_irq_replaysome with
decrementers_next_tb to check if we need to replay timer interrupt.
So in hotplug case we also need to set decrementers_next_tb as MAX
to make sure __check_irq_replay don't replay timer interrupt
when return as we expect, otherwise we'll trap here infinitely.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
v1:

* In hotplug case we max decrementers_next_tb to prevent from
replaying timer interrupt for any offline CPU.

 arch/powerpc/kernel/time.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6f6b1cc..127361e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -494,10 +494,15 @@ void timer_interrupt(struct pt_regs * regs)
 	set_dec(DECREMENTER_MAX);
 
 	/* Some implementations of hotplug will get timer interrupts while
-	 * offline, just ignore these
+	 * offline, just ignore these and we also need to set
+	 * decrementers_next_tb as MAX to make sure __check_irq_replay
+	 * don't replay timer interrupt when return, otherwise we'll trap
+	 * here infinitely :(
 	 */
-	if (!cpu_online(smp_processor_id()))
+	if (!cpu_online(smp_processor_id())) {
+		*next_tb = ~(u64)0;
 		return;
+	}
 
 	/* Conditionally hard-enable interrupts now that the DEC has been
 	 * bumped to its maximum value
-- 
1.7.9.5
