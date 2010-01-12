Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF82DB6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 19:29:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix decrementer setup on 1GHz boards
Date: Tue, 12 Jan 2010 09:28:54 +0100
Message-Id: <1263284934-14766-1-git-send-email-sr@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We noticed that recent kernels didn't boot on our 1GHz Canyonlands 460EX
boards anymore. As it seems, patch 8d165db1 [powerpc: Improve
decrementer accuracy] introduced this problem. The routine div_sc()
overflows with shift = 32 resulting in this incorrect setup:

time_init: decrementer frequency = 1000.000012 MHz
time_init: processor frequency   = 1000.000012 MHz
clocksource: timebase mult[400000] shift[22] registered
clockevent: decrementer mult[33] shift[32] cpu[0]

This patch now introduces a local div_dc64() version of this function
so that this overflow doesn't happen anymore.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Detlev Zundel <dzu@denx.de>
---

 arch/powerpc/kernel/time.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 92dc844..3ad729f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -882,12 +882,21 @@ static void decrementer_set_mode(enum clock_event_mode mode,
 		decrementer_set_next_event(DECREMENTER_MAX, dev);
 }
 
+static inline uint64_t div_sc64(unsigned long ticks, unsigned long nsec,
+				int shift)
+{
+	uint64_t tmp = ((uint64_t)ticks) << shift;
+
+	do_div(tmp, nsec);
+	return tmp;
+}
+
 static void __init setup_clockevent_multiplier(unsigned long hz)
 {
 	u64 mult, shift = 32;
 
 	while (1) {
-		mult = div_sc(hz, NSEC_PER_SEC, shift);
+		mult = div_sc64(hz, NSEC_PER_SEC, shift);
 		if (mult && (mult >> 32UL) == 0UL)
 			break;
 
-- 
1.6.4.4
