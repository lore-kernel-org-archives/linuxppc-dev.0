Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4F31DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 15:06:59 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mA646pRd028605
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 22:06:51 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix synchronization bug w/local tlb
	invalidates
Date: Wed,  5 Nov 2008 22:06:51 -0600
Message-Id: <1225944411-5807-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The implemetation of _tlbil_pid() on Freescale Book-E cores needs
an msync & isync after we flash invalidate the TLBs.  This was causing
the following oops reported by Sebastian Andrzej Siewior:

  VFS: Mounted root (nfs filesystem) readonly.
  Freeing unused kernel memory: 148k init
  BUG: sleeping function called from invalid context at /home/bigeasy/git/linux-2.6-powerpc/mm/mmap.c:234
  in_atomic():1, irqs_disabled():0
  Call Trace:
  [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
  [df189e30] [c0029480] __might_sleep+0xf0/0x100
  [df189e40] [c0070ac0] remove_vma+0x28/0x98
  [df189e50] [c0070c1c] exit_mmap+0xec/0x128
  [df189e80] [c002d2f4] mmput+0x54/0xec
  [df189ea0] [c0030b6c] exit_mm+0x10c/0x120
  [df189ed0] [c003288c] do_exit+0x1ac/0x6e8
  [df189f20] [c0032e48] do_group_exit+0x80/0xac
  [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c
  BUG: scheduling while atomic: udevd/956/0x10000002
  Modules linked in:
  Call Trace:
  [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
  [df189e30] [c002ac88] __schedule_bug+0x58/0x6c
  [df189e40] [c023e6cc] schedule+0xa8/0x4a8
  [df189e90] [c002ad6c] __cond_resched+0x38/0x64
  [df189ea0] [c023ebc8] _cond_resched+0x3c/0x58
  [df189eb0] [c0030e70] put_files_struct+0x90/0xec
  [df189ed0] [c00328a8] do_exit+0x1c8/0x6e8
  [df189f20] [c0032e48] do_group_exit+0x80/0xac
  [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/misc_32.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 6a9b4bf..bdc8b0e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -470,6 +470,8 @@ _GLOBAL(_tlbil_pid)
 	mfspr	r3,SPRN_MMUCSR0
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
+	msync
+	isync
 	blr
 
 /*
@@ -486,6 +488,8 @@ _GLOBAL(_tlbil_va)
 	rlwinm	r4,r4,0,1,31
 	mtspr	SPRN_MAS1,r4
 	tlbwe
+	msync
+	isync
 	blr
 #endif /* CONFIG_FSL_BOOKE */
 
-- 
1.5.5.1
