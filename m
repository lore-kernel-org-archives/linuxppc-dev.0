Return-Path: <platov@setdsp.ru>
Received: from mail.setdsp.ru (mail.setdsp.ru [213.24.86.2])
	by ozlabs.org (Postfix) with ESMTP id 4D2152BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 09:37:07 +1100 (EST)
Received: from NETLAB02 (unknown [192.168.0.169])
	by mail.setdsp.ru (Postfix) with ESMTP id CF86D57D3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 01:06:22 +0300 (MSK)
Date: Sat, 6 Nov 2004 01:06:39 +0300
From: Michael Platov <platov@setdsp.ru>
Message-ID: <226603527.20041106010639@setdsp.ru>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Xilinx ML310 PCI driver problem
Reply-To: Michael Platov <platov@setdsp.ru>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello linuxppc-embedded,

  I have xilinx ml310 based development system. It using ml310
  reference PCI design and MontaVista linux. Everything work OK I ever
  tried to work with several PCI cards and everything worked fine
  (memory and interrupts), but when I tried to write driver for my PCI
  board I faced strange (for me) problem. Reading and writing in I/O
  ports of PCI controller causes kernel oopsing with message kernel
  access of bad area error:

ops: kernel access of bad area, sig: 11
NIP: C9023980 XER: 00000000 LR: C9023950 SP: C7AE3EE0 REGS: c7ae3e30 TRAP: 0800
   Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: F7FC3D84, ESR: 00800000
TASK = c7ae2000[119] 'io_test3' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: F7FC3D84 C7AE3EE0 C7AE2000 00000101 C90247EC 00000008 C7AE3EEC 00000000
GPR08: 00000000 F7FB4000 00000555 C0280000 22000222 10019190 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 07AE3F40 00000000 C00048B4
GPR24: C0004620 0FFED7E8 C7AE3EE8 00000004 0000FD84 0000FD80 00000000 7FFFFD08
Call backtrace:
C9023704 C004FC8C C000467C 00000000 10000894 10000700 0FEB6D84
00000000

I examined sources of ethernet card that is working on this platform
(intel e100), but as I understand sources, this card is not working
with I/O (it stores value from BAR1 and never use it). Kernel
documenatation saids that PowerPC doesn't have special instructions
for accessing I/O (like Intel CPUs) and all devices are memory mapped.
So maybe I should call ioremap();

As I understand from different sources in internet, there is no need
calling ioremap() (but when I calling it kernel is not crashing, but
device still doesn doing what it should do) Does reading and writing
to I/O, using in*() and out*() should be sufficient? I realy in doubt.
Does PowerPC can work with IO regions? If it can, should I call
ioremap() beforehand? If I shouldn't why kernel oopsing? However, if I
should why reading from I/O register is not working (I'm sure that PCI
board is fine because everything is working in Windows)?


-- 
Best regards,
 Michael                          mailto:platov@setdsp.ru
