Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 653B8B6EF2
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 23:25:44 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBECPeq7018144
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 05:25:40 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBECTwkL020151
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 06:29:59 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/mm: fix typo of cpumask_clear_cpu()
Date: Mon, 14 Dec 2009 21:01:49 +0800
Message-Id: <1260795709-16165-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function name of cpumask_clear_cpu was not correct.

Reported-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
This also implies that the CONFIG_HOTPLUG_CPU was never tested.
We are trying to add cpu hotplug for SMP suspend, but seeing the
following error(on 2.6.31 with context patches applied).
Any idea or suggestion?

------------[ cut here ]------------
Badness at c00161b0 [verbose debug info unavailable]
NIP: c00161b0 LR: c0016190 CTR: c0038f7c
REGS: eec61e10 TRAP: 0700   Not tainted  (2.6.31-00040-g7c92556-dirty)
MSR: 00021000 <ME,CE>  CR: 22280028  XER: 00000000
TASK = eec54980[0] 'swapper' THREAD: eec60000 CPU: 1
GPR00: 00000001 eec61ec0 eec54980 c0562ea0 eecad500 00000000 00000000 00000001
GPR08: 00eed000 00000000 00000001 eecad67c 00001ca8 00000000 00021000 eec60040
GPR16: eec54b0c c05208a0 c055fbe8 00000001 ffffffff c0560000 c0562ea0 00000004
GPR24: eec60000 00000001 00000000 c0562e80 eec60000 c05291f8 eecad500 c05291f8
NIP [c00161b0] switch_mmu_context+0x54/0x520
LR [c0016190] switch_mmu_context+0x34/0x520
Call Trace:
[eec61ec0] [c00709c8] tick_program_event+0x50/0x60 (unreliable)
[eec61f20] [c03beb54] schedule+0x2bc/0x7bc
[eec61fa0] [c0008a8c] cpu_idle+0x160/0x170
[eec61fc0] [c03c4be0] start_secondary+0x2d0/0x2e8
[eec61ff0] [c0001c9c] __secondary_start+0x30/0x84
Instruction dump:
543c0024 7ec3b378 833c0008 483ab1bd 813e0184 2f9d0000 39290001 913e0184
419e001c 813d0184 7d200034 5400d97e <0f000000> 3929ffff 913d0184 3d20c055
MMU: More active contexts than CPUs ! (3 vs 2)
MMU: More active contexts than CPUs ! (3 vs 2)


 arch/powerpc/mm/mmu_context_nohash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index be4f34c..1044a63 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -353,7 +353,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
 			if (p->mm)
-				cpu_mask_clear_cpu(cpu, mm_cpumask(p->mm));
+				cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
 		}
 		read_unlock(&tasklist_lock);
 	break;
-- 
1.6.6-rc1.GIT
