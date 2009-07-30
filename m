Return-Path: <nvbolhuis@aimvalley.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 66CEDB7B9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 01:52:41 +1000 (EST)
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by ozlabs.org (Postfix) with ESMTP id A2C14DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 01:52:40 +1000 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id n6UFkNr8082711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 17:46:24 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <4A71C04E.6060506@aimvalley.nl>
Date: Thu, 30 Jul 2009 17:46:22 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: can the kernel show user task stack backtrace ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Afaik the kernel only shows the stack backtrace of the kernel stack
(of a task).

I wonder if there would be anything wrong with letting it show
the user task stack backtrace in certain cases.

Read the rest to see what I mean.


If kernel.print-fatal-signals has been enabled a crashing
application makes the kernel show this:
ca2/943: potentially unexpected fatal signal 11.

NIP: 1000044c LR: 10000444 CTR: 00000000
REGS: ce73df50 TRAP: 0300   Not tainted  (2.6.28)
MSR: 0000d032 <EE,PR,ME,IR,DR>  CR: 22000422  XER: 20000000
DAR: d0000003, DSISR: 22000000
TASK = ceb7a3e0[943] 'ca2' THREAD: ce73c000

GPR00: 0000000e bf963b30 48025450 0000000a 0ff0ac2c 22000422 00000001 0ff5e6b0
GPR08: 00000001 d0000003 00001032 00000000 ffffffff 1001896c 0ffe9000 00000000
GPR16: 0ffca59c 00000000 1009b940 100a8b6a 100bf234 bfea22b8 100bf224 00000000
GPR24: 100bf008 1009b960 4801e858 4802dd34 4802e7e0 00000000 0ffec8d8 bf963b30
Call Trace:
Segmentation fault
#

It's a real pity the user task stack backtrace isn't shown.
We're dealing with some complex (3rd party) applications and I like to see a
user task stack backtrace.

(Of course the way to go here is to use a debugger (gdb) and
  do a backtrace (with the coredump file).
  However, debugging takes some time. Besides the info is there
  it only needs to be shown. Often just this info is enough to
  pinpoint the problem)

Obviously the arch/powerpc/kernel/process.c:show_stack function
isn't meant for doing this. It only shows the kernel stack.

Btw. this doesn't work in my case since validate_sp returns 0 (because
sp is assigned the user-space stack (bf963b30) while kernel stack starts at ce73c000).
Though if it would work it isn't very usefull I guess since the crashing app
not enters kernel-mode (via sys-calls).

If I change arch/powerpc/kernel/process.c:show_stack (of kernel 2.6.28) like this:

	do {
#if 0
		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
			return;
#endif
		 .
		 .
		 .
	} while ((count++ < kstack_depth_to_print) && (sp != 0));


the following is shown:

ca2/943: potentially unexpected fatal signal 11.

NIP: 1000044c LR: 10000444 CTR: c001fd7c

REGS: ce73df50 TRAP: 0300   Not tainted  (2.6.28)
MSR: 0000f932 <EE,PR,FP,ME,IR,DR>  CR: 22000422  XER: 20000000
DAR: d0000003, DSISR: 22000000
TASK = cf09b340[943] 'ca2' THREAD: ce73c000
GPR00: 0000000e bfd65b30 48025450 0000000a 0ff0ac2c 22000422 00000001 0ff5e6b0
GPR08: 00000001 d0000003 00001032 00000000 ffffffff 1001896c 0ffe9000 00000000
GPR16: 0ffca59c 00000000 1009b940 100a8b6a 100bf234 bfb532b8 100bf224 00000000
GPR24: 100bf008 1009b960 4801e858 4802dd34 4802e7e0 00000000 0ffec8d8 bfd65b30
Call Trace:
[bfd65b30] [10000444] 0x10000444 (unreliable)
[bfd65b60] [10000490] 0x10000490
[bfd65b90] [100004cc] 0x100004cc
[bfd65ba0] [0feb39c8] 0xfeb39c8
[bfd65dd0] [0feb3ad4] 0xfeb3ad4
[bfd65de0] [00000000] 0x000000
Segmentation fault
#

which is what I want.
