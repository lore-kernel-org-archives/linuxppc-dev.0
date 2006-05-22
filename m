Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AC44679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 02:41:17 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3BFF7EFF0
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 18:41:12 +0200 (CEST)
Date: Mon, 22 May 2006 18:41:11 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: pseries softreset on cpus in 32bit mode
Message-ID: <20060522164111.GA14462@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Consider a simple app like this, which is placed as '/init' in an initrd
cpio archive:

hello32.c

#include <stdio.h>                                                                                                              
int main(void) {
        printf("foobar\n");
        asm("li 31,0; b .\n");
        return 0;
}

It will keep one cpu busy, and in 32bit mode. If a soft-reset is
triggered, this cpu remains in 32bit mode (I think) when
system_reset_fwnmi() is invoked. Then bad_stack is called via
STD_EXCEPTION_COMMON() and EXCEPTION_PROLOG_COMMON() because the 32bit
stackpointer is  > 0 and the cpu was in usermode. Finally panic is
called, which doesnt make much sense in this context.
machine_check_fwnmi has likely the same issue.

One bug is that something trashes regs->nip, it gets 0x3200 or similar.

I'm not really sure what is supposed to happen. Clearly a softreset
should not panic with bad stack pointer.

This is on a JS20, but a large p550 dies the same way.

Linux version 2.6.17-rc4-g353b28ba (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #2 SMP Mon May 22 18:37:06 CEST 2006
[boot]0012 Setup Arch
Top of RAM: 0x1e000000, Total RAM: 0x1e000000
Memory hole size: 0MB
PPC64 nvram contains 16384 bytes
Using default idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line:  root=/dev/hda2  xmon=on quiet panic=1
foobar
Bad kernel stack pointer ffa57ac0 at 3200
Oops: Bad kernel stack pointer, sig: 6 [#1]
SMP NR_CPUS=128 NUMA
Modules linked in:
NIP: 0000000000003200 LR: 0000000010000338 CTR: 0000000000032DDC
REGS: c000000007a5ed40 TRAP: c000000007a5ef10   Not tainted  (2.6.17-rc4-g353b28ba)
MSR: 0000000040001032 <ME,IR,DR>  CR: 20000042  XER: 200FFFFF
TASK = c00000001dfdb7e0[1] 'init' THREAD: c00000000ffcc000 CPU: 1
GPR00: 0000000010000338 00000000FFA57AC0 000000001009B470 0000000007ACEFF8
GPR04: 000000001002487C 0000000040000042 0000000000004000 000000001000B0E0
GPR08: 000000000000F932 0000000000000000 0000000000000000 0000000000000000
GPR12: 00000000200FFFFF C00000000052D100 C000000000442820 4000000002010000
GPR16: C000000000440ED8 0000000000000000 00000000000413DB 00000000004FA998
GPR20: 000000000250AC08 00000000004FAC08 000000000183FE00 00000000004420C0
GPR24: 000000000052CF00 0000000010000C70 0000000010000BF0 0000000000000000
GPR28: 0000000000000000 0000000010090000 00000000005123D8 0000000000000000
NIP [0000000000003200] 0x3200
LR [0000000010000338] 0x10000338
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
