Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFA2D1A2E34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 06:01:45 +1000 (AEST)
Date: Wed, 16 Sep 2015 22:01:06 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Scott Wood <scottwood@freescale.com>
cc: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
In-Reply-To: <1442420984.2909.179.camel@freescale.com>
Message-ID: <alpine.DEB.2.11.1509162159110.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Sep 2015, Scott Wood wrote:

> On Wed, 2015-09-16 at 18:23 +0200, Thomas Gleixner wrote:
> > With this commit applied, my MPC5200 board fails to boot 4.3-rc1. The
> > boot failure is silent.
> > 
> > Bisection pointed straight to this commit. Reverting it on top of
> > 4.3-rc1 works like a charm.
> 
> Yes, we've been iterating on a fix for this, and I think the patches posted 
> earlier today are ready to go in:
> 
> http://patchwork.ozlabs.org/patch/518321/
> http://patchwork.ozlabs.org/patch/518323/

Tested-by: Thomas Gleixner <tglx@linutronix.de>

So now I have to chase down that one:

[    0.230210] ftrace: allocating 16560 entries in 49 pages
[    0.273313] ------------[ cut here ]------------
[    0.278048] WARNING: at /home/tglx/work/kernel/tip/tip/kernel/trace/ftrace.c:1974
[    0.285653] Modules linked in:
[    0.288781] CPU: 0 PID: 0 Comm: swapper Not tainted 4.2.0-50528-gfac33bf-dirty #29
[    0.296485] task: c06563e0 ti: c06a2000 task.ti: c06a2000
[    0.301976] NIP: c008df9c LR: c008e440 CTR: 00000000
[    0.307027] REGS: c06a3e80 TRAP: 0700   Not tainted  (4.2.0-50528-gfac33bf-dirty)
[    0.314631] MSR: 00021032 <ME,IR,DR,RI>  CR: 22028022  XER: 00000000
[    0.321126]
GPR00: 00000001 c06a3f30 c06563e0 ffffffea c3888c88 00000004 c06a3ef8 764d9364
GPR08: 00407584 c069df92 00000000 00000001 22022028 ffffffff 03fb9000 007fff00
GPR16: c065debc 00009032 c06b8aa0 c0011184 00000000 c06a711c 00000bb6 c38021a0
GPR24: 00000000 00008c88 00000bb6 c06a7120 c3888c88 101d6120 c3888c88 c00e1f2c
[    0.351444] NIP [c008df9c] ftrace_bug+0xbc/0x2d4
[    0.356160] LR [c008e440] ftrace_process_locs+0x28c/0x6cc
[    0.361652] Call Trace:
[    0.364169] [c06a3f30] [c00971a0] buffer_ftrace_now.isra.50+0x28/0x64 (unreliable)
[    0.371888] [c06a3f60] [c008e440] ftrace_process_locs+0x28c/0x6cc
[    0.378119] [c06a3fb0] [c0610848] ftrace_init+0xac/0x14c
[    0.383559] [c06a3fc0] [c06051fc] start_kernel+0x390/0x3a8
[    0.389147] [c06a3ff0] [00003438] 0x3438
[    0.393136] Instruction dump:
[    0.396154] 483f9951 3c60c059 7fe4fb78 3863b768 7fe5fb78 483f993d 41b20214 48000144
[    0.404060] 3d20c06a 3929df92 88090002 68000001 <0f000000> 2f800000 409e01b4 3d20c06a
[    0.412203] ---[ end trace dc8fa200cb88537f ]---
[    0.416912] ftrace failed to modify [<c00e1f2c>] change_protection+0x8/0x2c
[    0.424015]  actual: 74:66:74:70
[    0.427324] ftrace record flags: 0
[    0.430785]  (0)   expected tramp: c0011198

Happens somewhere between the powerpc merge and rc1. System boots up
to userspace and then locks hard ....

Thanks,

	tglx
