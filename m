Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id E1084DDFD1
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 22:58:54 +1000 (EST)
Date: Fri, 25 Jul 2008 14:59:13 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: lockdep badness
Message-ID: <20080725145913.64904640@bull.net>
In-Reply-To: <20080724192300.GE9594@localdomain>
References: <20080724192300.GE9594@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Hi,

On Thu, 24 Jul 2008 14:23:00 -0500 Nathan Lynch <ntl@pobox.com> wrote:

> I'm seeing warnings from the lockdep code itself in recent kernels on
> a Power6 blade (v2.6.26 and benh's -next branch).
> 
> Something to do with powerpc's "lazy" interrupt-disabling, perhaps?
> 
> A couple of stack traces below, the first is from benh's tree, the
> second is from 2.6.26.  The lockdep self-tests all pass at boot.
> 
> RTAS daemon started
> RTAS: event: 295, Type: Dump Notification Event, Severity: 2
> ------------[ cut here ]------------
> Badness at kernel/lockdep.c:2719

<snip>

  I'm observing nearly the same thing (minus the ipr related badness) here with
Ben's powerpc.git (master) on a JS22 blade:

Freeing initrd memory: 2676k freed
RTAS daemon started
RTAS: event: 94, Type: Platform Information Event, Severity: 1
------------[ cut here ]------------
Badness at kernel/lockdep.c:2079
NIP: c0000000000846dc LR: c0000000000846c0 CTR: 0000000000000000
REGS: c0000001e353f9c0 TRAP: 0700   Not tainted  (2.6.26)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 24000042  XER: 20000010
TASK = c0000000efa58640[115] 'rtasd' THREAD: c0000001e353c000 CPU: 3
GPR00: 0000000000000000 c0000001e353fc40 c0000000004efe50 0000000000000001 
GPR04: 0000000000000001 c00000000003cc94 0000000000000001 636820202d203230 
GPR08: 3465303000000000 c0000000009627a8 c0000000efa58e88 0000000000000001 
GPR12: 3465303038200d0a c000000000525900 c000000000395ba0 4000000000c00000 
GPR16: c0000000003943c8 0000000000000000 000000000029d000 000000000101c920 
GPR20: 0000000000000000 0000000000000001 0000000000000744 0000000000000001 
GPR24: c000000000538cf0 c0000001e3e74000 c00000000041b48c c0000000004c0060 
GPR28: c0000000000847a4 c0000000efa58640 c0000000004b18d0 c0000001e353fc40 
NIP [c0000000000846dc] .trace_hardirqs_on_caller+0xc4/0x170
LR [c0000000000846c0] .trace_hardirqs_on_caller+0xa8/0x170
Call Trace:
[c0000001e353fcd0] [c0000000000847a4] .trace_hardirqs_on+0x1c/0x30
[c0000001e353fd50] [c0000000002df554] ._spin_unlock_irqrestore+0x68/0xb8
[c0000001e353fde0] [c00000000003cc94] .pSeries_log_error+0x3a4/0x400
[c0000001e353fef0] [c00000000003cf28] .rtasd+0x98/0x100
[c0000001e353ff90] [c0000000000295f8] .kernel_thread+0x4c/0x68
Instruction dump:
901d07ec 880d01ca 2fa00000 41be002c 481300a1 60000000 2fa30000 419e00a0 
e93e80f8 80090000 2f800000 409e0090 <0fe00000> 48000088 e92d01a0 8009082c 
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 15071
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)

 ...


  Sebastien.
