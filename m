Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C54DDDED3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 23:35:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4BDYvAi012725
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:34:57 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4BDYv2O554578
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:34:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4BDYvc1006771
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:34:57 -0400
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] simplify smp_space_timers
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Fri, 11 May 2007 08:34:16 -0500
Message-ID: <20070511133415.1627.71505.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


greatly simplify the function smp_space_timers.

The stolen time calculation (per comment within the code) doesnt need the
half-jiffy stagger any more.  There isnt an issue with bouncing off global
locks, so we really shouldnt need any sort of staggering at all.

However, the last_jiffy value still needs to be set.   This removes the
extra stagger logic, and just sets the values.

This change should benefit applications that rely on barrier
synchronization, and will help cut down OS jitter.

boot tested across the board (G5,power3,power4,power5,970mp blade).

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/kernel/time.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f6f0c6b..8baa1cb 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -711,30 +711,15 @@ void wakeup_decrementer(void)
 void __init smp_space_timers(unsigned int max_cpus)
 {
 	int i;
-	unsigned long half = tb_ticks_per_jiffy / 2;
-	unsigned long offset = tb_ticks_per_jiffy / max_cpus;
 	u64 previous_tb = per_cpu(last_jiffy, boot_cpuid);
 
 	/* make sure tb > per_cpu(last_jiffy, cpu) for all cpus always */
 	previous_tb -= tb_ticks_per_jiffy;
-	/*
-	 * The stolen time calculation for POWER5 shared-processor LPAR
-	 * systems works better if the two threads' timebase interrupts
-	 * are staggered by half a jiffy with respect to each other.
-	 */
+
 	for_each_possible_cpu(i) {
 		if (i == boot_cpuid)
 			continue;
-		if (i == (boot_cpuid ^ 1))
-			per_cpu(last_jiffy, i) =
-				per_cpu(last_jiffy, boot_cpuid) - half;
-		else if (i & 1)
-			per_cpu(last_jiffy, i) =
-				per_cpu(last_jiffy, i ^ 1) + half;
-		else {
-			previous_tb += offset;
-			per_cpu(last_jiffy, i) = previous_tb;
-		}
+		per_cpu(last_jiffy, i) = previous_tb;
 	}
 }
 #endif
