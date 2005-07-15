Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id 1553067C36
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2005 02:01:17 +1000 (EST)
Date: Fri, 15 Jul 2005 18:01:15 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050715160115.GA22990@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: bug in arch/ppc/kernel/misc.S: __ashrdi3?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't really grok the code but an operand seems to be missing and the
assembler makes something out of it I don't trust:

_GLOBAL(__ashrdi3)
	...
	rlwinm  r8,r7,0,32      # t3 = (count < 32) ? 32 : 0

Trying it out:

$ cat a.c
void f(void)
{
        __asm("rlwinm  8,7,0,32");
}
$ ppc_4xx-gcc -O2 -c a.c
$ ppc-linux-objdump -S a.o

a.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <f>:
f():
   0:   54 e8 06 b4     rlwinm  r8,r7,0,26,26
   4:   4e 80 00 20     blr

-- 
Frank
