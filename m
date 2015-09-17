Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E15111A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 00:39:34 +1000 (AEST)
Date: Thu, 17 Sep 2015 16:38:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Scott Wood <scottwood@freescale.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
In-Reply-To: <20150917092931.56475b7d@gandalf.local.home>
Message-ID: <alpine.DEB.2.11.1509171630130.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
 <20150917092931.56475b7d@gandalf.local.home>
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

On Thu, 17 Sep 2015, Steven Rostedt wrote:

> On Thu, 17 Sep 2015 12:13:15 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Digging deeper. My assumption that it's a post powerpc merge failure
> > turned out to be wrong.
> 
> Does 4.2 have the problem?

No. Neither does 

4c92b5bb1422: Merge branch 'pcmcia' of git://ftp.arm.linux.org.uk/~rmk/linux-arm
 
> If it's a corruption of the mcount tables, it could be specific on what
> the compiler does. That is, the working of one kernel to the other, may
> only depend on how gcc compiled something. Have you tried different
> compilers? Maybe one version of gcc may work over another?

It just results in a different failure mode. Instead of silently
hanging I get:

[    2.248275] Oops: Exception in kernel mode, sig: 4 [#1]
[    2.253633] PREEMPT lite5200
[    2.256584] Modules linked in:
[    2.259723] CPU: 0 PID: 1 Comm: swapper Not tainted 4.3.0-rc1-51179-gae80a2f-dirty #75
[    2.267815] task: c383c000 ti: c383a000 task.ti: c383a000
[    2.273330] NIP: c00e1eec LR: c00df0f4 CTR: 00000000
[    2.278405] REGS: c383bcd0 TRAP: 0700   Not tainted  (4.3.0-rc1-51179-gae80a2f-dirty)
[    2.286396] MSR: 00089032 <EE,ME,IR,DR,RI>  CR: 44824028  XER: 00000000
[    2.293187] 
GPR00: c00def84 c383bd80 c383c000 c3084000 bffffff1 00677595 c383bdd8 00000000 
GPR08: 00000001 00000001 00000400 00000002 24828022 00000000 c0004254 84822042 
GPR16: 20000000 44822042 fffff000 c3086ffc c06ce248 c383a000 c3082000 c06d0000 
GPR24: c383a000 00000ffc 00677595 bffffff1 c3084000 c3015bfc 00000017 c3086000 
[    2.323656] NIP [c00e1eec] vm_normal_page+0x0/0xdc
[    2.328560] LR [c00df0f4] follow_page_mask+0x260/0x4fc
[    2.333807] Call Trace:
[    2.336321] [c383bd80] [c00def84] follow_page_mask+0xf0/0x4fc (unreliable)
[    2.343360] [c383bdd0] [c00df4a4] __get_user_pages.part.28+0x114/0x3e0
[    2.350050] [c383be30] [c010e788] copy_strings+0x16c/0x2c8
[    2.355668] [c383bea0] [c010e91c] copy_strings_kernel+0x38/0x50
[    2.361730] [c383bec0] [c011057c] do_execveat_common+0x440/0x658
[    2.367877] [c383bf10] [c01107cc] do_execve+0x38/0x48
[    2.373056] [c383bf20] [c00039f0] try_to_run_init_process+0x24/0x64
[    2.379469] [c383bf30] [c000430c] kernel_init+0xb8/0x10c
[    2.384924] [c383bf40] [c0010c40] ret_from_kernel_thread+0x5c/0x64
[    2.391242] --- interrupt: 0 at   (null)
[    2.391242]     LR =   (null)
[    2.398263] Instruction dump:
[    2.401297] 01000000 00037000 00000000 00000000 f0000000 00000001 0a641e09 acde4823 
[    2.409237] 000f0000 179a7b00 07de2900 03ef1480 <01f78a40> 0001c200 60000000 9421fff0 
[    2.417375] ---[ end trace 996fd312ce9c18ce ]---

Again, if I disable CONFIG_TRACER its gone.

Thanks,

	tglx
