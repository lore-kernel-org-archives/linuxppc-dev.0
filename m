Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: nbasker@india.tejasnetworks.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: data address causing machine check exception
Message-ID: <1032445842.3d89df925ac65@pop-mail.india.tejasnetworks.com>
Date: Thu, 19 Sep 2002 20:00:42 +0600 (IST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

I am using linux 2.2.14 on mpc860T.
In my driver module, there is an invalid memory access
that causes a machine check exception.

I am trying to print the srr0, srr1, dar and dsisr in the
exception handling routine which are as shown below:
srr0 = c0017f70 srr1 = 00001032 dar = 00000000 dsisr = 00000000

Since the exception is caused due to load/store related
error, I was expecting the dar register to hold the Effective
Address of the data, but I find zero.

Can somebody help in getting the EA of data that causes
the exception?. I have attached the kernel panic output below.

Thanks for your time,
Nicholas.


Machine check in kernel mode.
Caused by (from msr): regs c46bb4c0 Unknown values in msr
NIP: CC050014 XER: 40001F7F LR: CC0542FC REGS: c46bb4c0 TRAP: 0200
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c46ba000[529] 'test' mm->pgd c59ca000 Last syscall: 54
last math 00000000
GPR00: CC0512DC C46BB570 C46BA000 FD040000 00000000 00000000 C46BBDFC 00000000
GPR08: 00000000 00000000 00000000 C000B794 30026438 1001BA08 100C4490 00000000
GPR16: 100A9A10 7FFFDBC8 10014F45 00000000 00009032 046BBE80 00000000 C000253C
GPR24: C000227C 00000000 C4796960 C49F7360 7FFFFD00 CC0E5398 C47A8380 40086A02
Call backtrace:
CC0E5398 CC0512DC CC0E5158 C0034640 C00022D0 1000080C 10001AC8
10000C28 0FE334F8 00000000
Kernel panic: machine check

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
