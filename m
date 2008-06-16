Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78FF3DDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 14:50:52 +1000 (EST)
Subject: Re: BUG() in current git, __dma_alloc_coherent, Beige G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joseph Fannin <jfannin@gmail.com>
In-Reply-To: <20080616014615.GA8960@nineveh.local>
References: <20080616014615.GA8960@nineveh.local>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 14:50:38 +1000
Message-Id: <1213591838.8129.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-06-15 at 21:46 -0400, Joseph Fannin wrote:
> Hello!
> 
> I'm reproducably hitting a BUG() in Linus' git (current as of about
> noon, Sunday 15, GMT -0500) on my Beige PowerMac G3 (32bit, natch).
> The line indicted in the (hand-copied) traceback that follows is:
> 
>     BUG_ON(!pte_none(*pte));
> 
> ...in __dma_alloc_coherent().

 .../...

> [   261.043131] ------------[ cut here ]------------
> [   261.044194] kernel BUG at arch/powerpc/lib/dma-noncoherent.c:209!

I wonder how you end up hitting code in dma-noncoherent.c in the first
place ! PowerMac kernels should not have that code compiled in at all...

Ben.

> [   261.045605] Oops: Exception in kernel mode, sig: 5 [#1]
> [   261.046804] PREEMPT SMP NR_CPUS=2 PowerMac
> [   261.047834] Modules linked in:
> [   261.048584] NIP: c001db58 LR: c001db18 CTR: 00000000
> [   261.049730] REGS: df82bbf0 TRAP: 0700   Not Tainted  (2.6.26-rc6-2008061501)
> [   261.051344] MSR: 00029032 <EE,ME,IR,DR>  CR: 22008084  XER: 20000100
> [   261.053111] TASK = df830000[1] 'swapper' THREAD: df82a000 CPU: 0
> [   261.054528] GPR00: fe5575a9 df82bca0 df830000 c1ce21b8 00000001 ffffffff c001da6c c047fbec
> [   261.056831] GPR08: c0420000 00000001 ff102000 fe5575a8 22008028 00c570a8 00000000 00000000
> [   261.059133] GPR16: 00000000 00000000 c0370000 c03f0000 c0470408 c0420000 c0420000 c03f0000
> [   261.061438] GPR24: c1ce2170 dddae4e0 c03f70a8 00000001 00002000 cfefe400 c1ce2170 df82bca0
> [   261.179520] NIP [c001db58] __dma_alloc_coherent+0x214/0x300
> [   261.238707] LP [c001db18] __dma_alloc_coherent+0x1d4/0x300
> [   261.297574] Call Trace:
> [   261.355523] [df82bca0] [c001daf8] __dma_alloc_coherent+0x1b4/0x300 (unreliable)
> [   261.415029] [df82bce0] [c02ee33c] pmac_ide_init_dma+0x64/0xb4
> [   261.474513] [df82bd00] [c021d5do] ide_device_add_all+0x13c/0x5f8
> [   261.534160] [df82bd40] [c021db00] ide_device_add+0x74/0x98
> [   261.593301] [df82bd60] [c02ee044] pmac_ide_setup_device+0x230/0x4c4
> [   261.652385] [df82bdc0] [c02ee6c0] pmac_ide_macio_attach+0x138/0x260
> [   261.710810] [df82be30] [c020afc4] macio_device_probe+0x60/0x8c
> [   261.769060] [df82be50] [c0202fbc] driver_probe_device+0xbc/0x1f8
> [   261.827081] [df82be70] [c0203184] __driver_attach+0x8c/0x90
> [   261.885331] [df82be90] [c02023ac] bus_for_each_dev+0x60/0xa0
> [   261.943311] [df82bec0] [c0202da0] driver_attach+0x2c/0x44
> [   262.000900] [df81bed0] [c0202a8c] bus_add_driver+0x1e8/0x260
> [   262.115012] [df82bf20] [c020ae4c] macio_register_driver+0x30/0x48
> [   262.171573] [df82bf30] [c03e03ac] pmac_ide_probe+0x70c/0x90
> [   262.227458] [df82bf50] [c03b238c] kernel_init+0x160/0x35c
> [   262.283239] [df82bff0] [c001583c] kernel_thread+0x44/0x60
> [   262.339020] Instruction dump:
> [   262.393886] 61298e39 7c00c050 7c001670 7c0049d6 812b523c 54006026 7c004a14 90140000
> [   262.450107] 001d0000 540007fa 3160ffff 7d2b0110 <0f090000> 38000400 7d60f028 7d6b0378
> [   262.511341] ---[ end trace 2d8bb0493664c3b8 ]---
> [   262.566638] Kernel panic - not syncing: Attempted to kill init!
> 
> 
> This is 100% reproducable.  I can't really recall the last kernel I
> built and booted successfully on this box -- the best I can say is
> that the 2.6.24-ish kernel Ubuntu ships works.
> 
> I should probably mention that I've been having a little trouble with
> the IDE drive in this machine -- but the drive isn't the problem:
> 
>     * This is 100% reproducible with the current git kernel, and
>           doesn't happen w/the Ubuntu kernel
>     * The traceback and dump does not vary between boots
>     * The kernel BUGs out well before the disks are detected (and it's
>           a _drive_ problem)
> 
> ... etc.  :-)  I don't want to send anyone on a wild goose chase, but
> yeah, it's not the hardware.  ;-)
> 
> So, what can I do to help find the problem here?  Git says no one's
> touched that file in a while, and tracing through this problem is
> above my skill level here.  I'll attach my .config, and put the
> vmlinux up:
> 
> http://jfannin.oxyhost.com/vmlinux
> 
> I can try to get more of the kernel messages, if that's likely to
> help.  Bisecting will take some time, but if that's what's necessary,
> let me know.
> 
> Thanks for any help.
> 
> --
> Joseph Fannin
> jfannin@gmail.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
