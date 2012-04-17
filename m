Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27B3FB700D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 13:42:35 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <bharatb.yadav@gmail.com>
Subject: [PATCH v3]KVM: PPC: Use clockevent multiplier and shifter for
 decrementer
Date: Tue, 17 Apr 2012 09:25:09 +0530
Message-ID: <1334634909-9066-1-git-send-email-bharat.bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Time for which the hrtimer is started for decrementer emulation is calculated using tb_ticks_per_usec. While hrtimer uses the clockevent for DEC reprogramming (if needed) and which calculate timebase ticks using the multiplier and shifter mechanism implemented within clockevent layer. It was observed that this conversion (timebase->time->timebase) are not correct because the mechanism are not consistent. In our setup it adds 2% jitter.

With this patch clockevent multiplier and shifter mechanism are used when starting hrtimer for decrementer emulation. Now the jitter is < 0.5%.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v3:
 - decrementer_clockevent symbol exported.

 arch/powerpc/include/asm/time.h |    1 +
 arch/powerpc/kernel/time.c      |    3 ++-
 arch/powerpc/kvm/emulate.c      |    5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 7eb10fb..b3c7959 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,6 +28,7 @@
 extern unsigned long tb_ticks_per_jiffy;
 extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
+extern struct clock_event_device decrementer_clockevent;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 567dd7c..4f7a285 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -105,7 +105,7 @@ static int decrementer_set_next_event(unsigned long evt,
 static void decrementer_set_mode(enum clock_event_mode mode,
 				 struct clock_event_device *dev);
 
-static struct clock_event_device decrementer_clockevent = {
+struct clock_event_device decrementer_clockevent = {
 	.name           = "decrementer",
 	.rating         = 200,
 	.irq            = 0,
@@ -113,6 +113,7 @@ static struct clock_event_device decrementer_clockevent = {
 	.set_mode       = decrementer_set_mode,
 	.features       = CLOCK_EVT_FEAT_ONESHOT,
 };
+EXPORT_SYMBOL(decrementer_clockevent);
 
 DEFINE_PER_CPU(u64, decrementers_next_tb);
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index afc9154..c8b5206 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kvm_host.h>
+#include <linux/clockchips.h>
 
 #include <asm/reg.h>
 #include <asm/time.h>
@@ -104,8 +105,8 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 	 */
 
 	dec_time = vcpu->arch.dec;
-	dec_time *= 1000;
-	do_div(dec_time, tb_ticks_per_usec);
+	dec_time = dec_time << decrementer_clockevent.shift;
+	do_div(dec_time, decrementer_clockevent.mult);
 	dec_nsec = do_div(dec_time, NSEC_PER_SEC);
 	hrtimer_start(&vcpu->arch.dec_timer,
 		ktime_set(dec_time, dec_nsec), HRTIMER_MODE_REL);
-- 
1.7.0.4
