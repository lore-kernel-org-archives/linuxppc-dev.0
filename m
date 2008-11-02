Return-Path: <linuxppc-dev@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F17CDDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 02:19:16 +1100 (EST)
Date: Sun, 2 Nov 2008 16:19:02 +0100
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: "Introduce local (non-broadcast) forms of tlb invalidates" causes
	BUG()
Message-ID: <20081102151902.GA11120@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After I updated to 67d1128425 I get plenty of this:

| VFS: Mounted root (nfs filesystem) readonly.
| Freeing unused kernel memory: 148k init
| BUG: sleeping function called from invalid context at /home/bigeasy/git/linux-2.6-powerpc/mm/mmap.c:234
| in_atomic():1, irqs_disabled():0
| Call Trace:
| [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
| [df189e30] [c0029480] __might_sleep+0xf0/0x100
| [df189e40] [c0070ac0] remove_vma+0x28/0x98
| [df189e50] [c0070c1c] exit_mmap+0xec/0x128
| [df189e80] [c002d2f4] mmput+0x54/0xec
| [df189ea0] [c0030b6c] exit_mm+0x10c/0x120
| [df189ed0] [c003288c] do_exit+0x1ac/0x6e8
| [df189f20] [c0032e48] do_group_exit+0x80/0xac
| [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c
| BUG: scheduling while atomic: udevd/956/0x10000002
| Modules linked in:
| Call Trace:
| [df189df0] [c0007160] show_stack+0x48/0x148 (unreliable)
| [df189e30] [c002ac88] __schedule_bug+0x58/0x6c
| [df189e40] [c023e6cc] schedule+0xa8/0x4a8
| [df189e90] [c002ad6c] __cond_resched+0x38/0x64
| [df189ea0] [c023ebc8] _cond_resched+0x3c/0x58
| [df189eb0] [c0030e70] put_files_struct+0x90/0xec
| [df189ed0] [c00328a8] do_exit+0x1c8/0x6e8
| [df189f20] [c0032e48] do_group_exit+0x80/0xac
| [df189f40] [c000e9dc] ret_from_syscall+0x0/0x3c

on my 8544. This happans as soon as I hit userspace. A bisect leads to

|commit 0ba3418b8b1c85ee1771c63f1dd12041614e56ff
|Author: Kumar Gala <galak@kernel.crashing.org>
|Date:   Tue Jul 15 16:12:25 2008 -0500
|
|    powerpc: Introduce local (non-broadcast) forms of tlb invalidates
|    
|    Introduced a new set of low level tlb invalidate functions that do not
|    broadcast invalidates on the bus:
|    
|    _tlbil_all - invalidate all
|    _tlbil_pid - invalidate based on process id (or mm context)
|    _tlbil_va  - invalidate based on virtual address (ea + pid)
|    
|    On non-SMP configs _tlbil_all should be functionally equivalent to _tlbia and
|    _tlbil_va should be functionally equivalent to _tlbie.
|    
|    The intent of this change is to handle SMP based invalidates via IPIs instead
|    of broadcasts as the mechanism scales better for larger number of cores.
|    
|    On e500 (fsl-booke mmu) based cores move to using MMUCSR for invalidate alls
|    and tlbsx/tlbwe for invalidate virtual address.
|    
|    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
|
|:040000 040000 1b04e004e4d30e8654f9f4fd6095327bb3211ea0 317b8a3a3fba7b0184f9fbc83e3ee21adfc45b80 M      arch

A revert of this commit makes BUG() go away and evertything looks fine.
I guess this is a config thing on my MPC8544 and my .config is available
at [1].

[1] http://download.breakpoint.cc/dot.config.txt

Sebastian
