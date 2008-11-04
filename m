Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 130FC474C3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 08:10:54 +1100 (EST)
Date: Tue, 4 Nov 2008 15:10:42 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Subject: Re: "Introduce local (non-broadcast) forms of tlb invalidates" causes
	BUG()
In-Reply-To: <20081102151902.GA11120@Chamillionaire.breakpoint.cc>
Message-ID: <Pine.LNX.4.64.0811041507320.8751@blarg.am.freescale.net>
References: <20081102151902.GA11120@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2 Nov 2008, Sebastian Andrzej Siewior wrote:

> After I updated to 67d1128425 I get plenty of this:
>
> | VFS: Mounted root (nfs filesystem) readonly.
> | Freeing unused kernel memory: 148k init
> | BUG: sleeping function called from invalid context at /home/bigeasy/git/linux-2.6-powerpc/mm/mmap.c:234
> | in_atomic():1, irqs_disabled():0
> | Call Trace:
> | [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
> | [df189e30] [c0029480] __might_sleep+0xf0/0x100
> | [df189e40] [c0070ac0] remove_vma+0x28/0x98
> | [df189e50] [c0070c1c] exit_mmap+0xec/0x128
> | [df189e80] [c002d2f4] mmput+0x54/0xec
> | [df189ea0] [c0030b6c] exit_mm+0x10c/0x120
> | [df189ed0] [c003288c] do_exit+0x1ac/0x6e8
> | [df189f20] [c0032e48] do_group_exit+0x80/0xac
> | [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c
> | BUG: scheduling while atomic: udevd/956/0x10000002
> | Modules linked in:
> | Call Trace:
> | [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
> | [df189e30] [c002ac88] __schedule_bug+0x58/0x6c
> | [df189e40] [c023e6cc] schedule+0xa8/0x4a8
> | [df189e90] [c002ad6c] __cond_resched+0x38/0x64
> | [df189ea0] [c023ebc8] _cond_resched+0x3c/0x58
> | [df189eb0] [c0030e70] put_files_struct+0x90/0xec
> | [df189ed0] [c00328a8] do_exit+0x1c8/0x6e8
> | [df189f20] [c0032e48] do_group_exit+0x80/0xac
> | [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c
>
> on my 8544. This happans as soon as I hit userspace. A bisect leads to

Can you try this fix and let me know if it works for you:

---
 arch/powerpc/kernel/misc_32.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 6a9b4bf..5953232 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -470,6 +470,7 @@ _GLOBAL(_tlbil_pid)
 	mfspr	r3,SPRN_MMUCSR0
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
+	msync
 	blr

 /*
-- 
1.5.5.1
