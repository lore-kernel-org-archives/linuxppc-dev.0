Return-Path: <dvhltc@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDC4F1007DB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:29:08 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o754JG8m011610
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:19:16 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o754T6fG150700
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o754T5X9011112
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:05 -0600
From: Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc-enable-preemption-before-cpu_die
Date: Wed,  4 Aug 2010 21:28:33 -0700
Message-Id: <1280982515-18231-2-git-send-email-dvhltc@us.ibm.com>
In-Reply-To: <1280982515-18231-1-git-send-email-dvhltc@us.ibm.com>
References: <1280982515-18231-1-git-send-email-dvhltc@us.ibm.com>
Cc: dvhltc@us.ibm.com, brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	will_schmidt@vnet.ibm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

start_secondary() is called shortly after _start and also via

cpu_idle()->cpu_die()->pseries_mach_cpu_die()

start_secondary() expects a preempt_count() of 0. pseries_mach_cpu_die() is
called via the cpu_idle() routine with preemption disabled, resulting in the
following repeating message during rapid cpu offline/online tests
with CONFIG_PREEMPT=y:

BUG: scheduling while atomic: swapper/0/0x00000002
Modules linked in: autofs4 binfmt_misc dm_mirror dm_region_hash dm_log [last unloaded: scsi_wait_scan]
Call Trace:
[c00000010e7079c0] [c0000000000133ec] .show_stack+0xd8/0x218 (unreliable)
[c00000010e707aa0] [c0000000006a47f0] .dump_stack+0x28/0x3c
[c00000010e707b20] [c00000000006e7a4] .__schedule_bug+0x7c/0x9c
[c00000010e707bb0] [c000000000699d9c] .schedule+0x104/0x800
[c00000010e707cd0] [c000000000015b24] .cpu_idle+0x1c4/0x1d8
[c00000010e707d70] [c0000000006aa1b4] .start_secondary+0x398/0x3d4
[c00000010e707e30] [c000000000008278] .start_secondary_resume+0x10/0x14

Move the cpu_die() call inside the existing preemption enabled block of
cpu_idle(). This is safe as the idle task is affined to a single CPU so the
debug_smp_processor_id() tests (from cpu_should_die()) won't trigger as we are
in a "migration disabled" region.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Fontenot <nfont@austin.ibm.com>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 049dda6..39a2baa 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -94,9 +94,9 @@ void cpu_idle(void)
 		HMT_medium();
 		ppc64_runlatch_on();
 		tick_nohz_restart_sched_tick();
+		preempt_enable_no_resched();
 		if (cpu_should_die())
 			cpu_die();
-		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
 	}
-- 
1.7.0.4
