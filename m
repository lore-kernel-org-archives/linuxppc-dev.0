Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5733A68533
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 15:10:28 +1100 (EST)
Date: Tue, 21 Nov 2006 15:10:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: [POWERPC] iSeries: fix time.c for combined build
Message-Id: <20061121151020.96683080.sfr@canb.auug.org.au>
In-Reply-To: <20061113144736.beb61f98.sfr@canb.auug.org.au>
References: <20061113144736.beb61f98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/time.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

This version will build on 32bit.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a1b5e4b..bd86e93 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -631,7 +631,8 @@ void timer_interrupt(struct pt_regs * re
 	calculate_steal_time();
 
 #ifdef CONFIG_PPC_ISERIES
-	get_lppaca()->int_dword.fields.decr_int = 0;
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
 	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
@@ -674,7 +675,7 @@ void timer_interrupt(struct pt_regs * re
 	set_dec(next_dec);
 
 #ifdef CONFIG_PPC_ISERIES
-	if (hvlpevent_is_pending())
+	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
 		process_hvlpevents();
 #endif
 
@@ -774,7 +775,7 @@ int do_settimeofday(struct timespec *tv)
 	 * settimeofday to perform this operation.
 	 */
 #ifdef CONFIG_PPC_ISERIES
-	if (first_settimeofday) {
+	if (firmware_has_feature(FW_FEATURE_ISERIES) && first_settimeofday) {
 		iSeries_tb_recal();
 		first_settimeofday = 0;
 	}
-- 
1.4.3.5
