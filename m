Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C1762B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 09:01:21 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 391C7DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 09:01:20 +1000 (EST)
Date: Tue, 14 Jul 2009 18:45:41 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
In-Reply-To: <4A5C5D65.3030906@in.ibm.com>
Message-ID: <alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
References: <4A5C5D65.3030906@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 14 Jul 2009, Sachin Sant wrote:

> While enabling function_graph tracer on a Power6 box, machine
> crashed with following trace. Kernel version is 2.6.31-rc3.

Thanks,

I've seen issues with my PPC box and function graph, but the bugs were
also caused by other changes. I'll boot up my PPC64 box and see if
I see the same issues you have.

-- Steve

> 
> :/debug/tracing # echo function_graph > current_tracer :/debug/tracing # cat
> current_tracer function_graph
> :/debug/tracing # echo 1 > tracing_enabled
> 
> cpu 0x0: Vector: 300 (Data Access) at [c00000003eb86de0]
>    pc: c000000000008f30: .mod_return_to_handler+0x2c/0x64
>    lr: c000000000008f04: .mod_return_to_handler+0x0/0x64
>    sp: c00000003eb87060
>   msr: 8000000000009032
>   dar: 8
> dsisr: 40000000
>  current = 0xc00000003e83c080
>  paca    = 0xc000000000ff2400
>    pid   = 2700, comm = sshd
> enter ? for help
> [c00000003eb870d0] c000000000008f04 .mod_return_to_handler+0x0/0x64
> [c00000003eb871a0] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87290] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87330] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb873e0] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87470] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87500] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87640] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87730] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87830] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb878d0] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87a00] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87b30] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87cd0] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87d80] c000000000008ed0 .return_to_handler+0x0/0x34
> [c00000003eb87e30] c000000000008ed0 .return_to_handler+0x0/0x34
> --- Exception: c01 (System Call) at 00000fffb640a8f8
> SP (fffe5b9b960) is in userspace
> 0:mon> di c000000000008f04
> c000000000008f04  f881ffe0      std     r4,-32(r1)
> c000000000008f08  f861ffe8      std     r3,-24(r1)
> c000000000008f0c  f841fff0      std     r2,-16(r1)
> c000000000008f10  fbe1fff8      std     r31,-8(r1)
> c000000000008f14  7c3f0b78      mr      r31,r1
> c000000000008f18  f821ff91      stdu    r1,-112(r1)
> c000000000008f1c  3c800000      lis     r4,0
> c000000000008f20  60840000      ori     r4,r4,0
> c000000000008f24  788407c6      rldicr  r4,r4,32,31
> c000000000008f28  64840000      oris    r4,r4,0
> c000000000008f2c  60840000      ori     r4,r4,0
> c000000000008f30  e8440008      ld      r2,8(r4)  ^^^^^ PC points to this
> ^^^^^^^
> c000000000008f34  48123431      bl      c00000000012c364        #
> .ftrace_return_to_handler+0x0/0x110
> c000000000008f38  60000000      nop
> c000000000008f3c  7c6803a6      mtlr    r3
> c000000000008f40  e8210000      ld      r1,0(r1)
> 0:xmon> r
> R00 = c000000000008f04   R16 = 00000fffb741d6a0
> R01 = c00000003ea4b7e0   R17 = 00000fffb7406c38
> R02 = d0000000010bec80   R18 = c00000003de41838
> R03 = 0000000000000000   R19 = fffffffffffff000
> R04 = 0000000000000000   R20 = c00000003cfc8c80
> R05 = 0000000066000000   R21 = c00000003ea4bdf8
> R06 = 00000000000010bf   R22 = c00000003ea4bba8
> R07 = 0000000000000000   R23 = 00000fff8eb60000
> R08 = 0000000000000000   R24 = fffffffffffff000
> R09 = 800000010021c740   R25 = 8001000003000000
> R10 = 00000000000000ff   R26 = ffe0000000000000
> R11 = 800000010021c760   R27 = 0000000000000009
> R12 = 0000000000000002   R28 = c00000006f850000
> R13 = c000000000ff2400   R29 = 0000000000020000
> R14 = 0000000000000000   R30 = d0000000010bd9c8
> R15 = ffffffffeffdff68   R31 = c00000003ea4b850
> pc  = c000000000008f30 .mod_return_to_handler+0x2c/0x64
> lr  = c000000000008f04 .mod_return_to_handler+0x0/0x64
> msr = 8000000000009032   cr  = 24000442
> ctr = 80000000000f6d68   xer = 0000000000000020   trap =  300
> dar = 0000000000000008   dsisr = 40000000
> 0:xmon>
> 
> Following tracers are supported by the kernel.
> :/debug/tracing # cat available_tracers function_graph function sched_switch
> nop
> 
> Other tracers function and sched_switch work fine. Having problem
> only with function_graph.
> 
> Have attached the .config.
> 
> Thanks
> -Sachin
> 
> 
> -- 
> 
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
> 
> 
