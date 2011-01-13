Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 826A9B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Jan 2011 16:57:12 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p0D5v6kH032671
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jan 2011 23:57:07 -0600
Subject: [PATCH] powerpc: Fix accumulate_stolen_time() vs. CONFIG_PREEMPT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Jan 2011 16:57:05 +1100
Message-ID: <1294898225.4811.4.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function accumulate_stolen_time() is called on pSeries to scan
the hypervisor event log every now and then. This happens very early
during the exception entry process, while the PACA soft/hard_enabled
fields don't properly reflect the state of the system, which is
basically hard irq disabled.

This causes various debug checks to trigger when CONFIG_PREEMPT is
enabled which can themselves cause the machine to crash due to the
unexpected context they are called from.

We fix that by temporarily setting the PACA fields to reflect the
hard disabled state in accumulate_stolen_time(). This keeps the
overhead to that function, hopefully called rarely and only on
those pSeries machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0104069..714685c 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -265,11 +265,26 @@ void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
 
-	sst = scan_dispatch_log(get_paca()->starttime_user);
-	ust = scan_dispatch_log(get_paca()->starttime);
-	get_paca()->system_time -= sst;
-	get_paca()->user_time -= ust;
-	get_paca()->stolen_time += ust + sst;
+	u8 save_soft_enabled = local_paca->soft_enabled;
+	u8 save_hard_enabled = local_paca->hard_enabled;
+
+	/* We are called early in the exception entry, before
+	 * soft/hard_enabled are sync'ed to the expected state
+	 * for the exception. We are hard disabled but the PACA
+	 * needs to reflect that so various debug stuff doesn't
+	 * complain
+	 */
+	local_paca->soft_enabled = 0;
+	local_paca->hard_enabled = 0;
+
+	sst = scan_dispatch_log(local_paca->starttime_user);
+	ust = scan_dispatch_log(local_paca->starttime);
+	local_paca->system_time -= sst;
+	local_paca->user_time -= ust;
+	local_paca->stolen_time += ust + sst;
+
+	local_paca->soft_enabled = save_soft_enabled;
+	local_paca->hard_enabled = save_hard_enabled;
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
