Message-ID: <003601c2f827$b0aa50c0$af85efcb@qhavm>
From: "Q-ha Park" <qhpark@jchyun.com>
To: "Q-ha Park" <qhpark@jchyun.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <dz3lcmje/linuxppc-embedded@lists.linuxppc.org/qhpark@jchyun.com>
Subject: does in_be32{twi, isync} cause a bus error?
Date: Tue, 1 Apr 2003 17:21:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that in_be32 in 2.4.21 has been changed from 2.4.17 kernel.
In io.h in 2.4.17,
extern inline unsigned in_be32(volatile unsigned *addr)
{
    unsigned ret;

    __asm__ __volatile__("lwz%U1%X1 %0,%1; eieio" : "=r" (ret) : "m" (*addr));
    return ret;
}

whereas io.h in 2.4.21 is,

extern inline unsigned in_be32(volatile unsigned *addr)
{
    unsigned ret;

    __asm__ __volatile__("lwz%U1%X1 %0,%1;\n"
                 "twi 0,%0,0;\n"
                 "isync" : "=r" (ret) : "m" (*addr));
    return ret;
}

and with this in_be32, I get "data machine check in kernel mode" and the kernel oops sending "SIGBUS" to the process.

Oops: machine check, sig: 7
NIP: C500A0A4 XER: 00000000 LR: C500A090 SP: C39B7EE0 REGS: c39b7e30 TRAP: 0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c39b6000[111] 'a.out' Last syscall: 3
last math 00000000 last altivec 00000000
PLB0: bear= 0x00000000 acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x40060000 besr0= 0x03c00000 besr1= 0x00000000

GPR00: C500A090 C39B7EE0 C39B6000 00000056 00001030 00000001 00000030 C0190000
GPR08: 000022DC C5010000 00000000 C500D000 48000868 10019824 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 039B7F40 00000000 C00049B0
GPR24: C0004720 10001240 3002A7CC 0FFEA818 7FFFFD28 00000004 7FFFFD28 05050505
Call backtrace:
C500A090 C500A1F0 C0038BAC C000477C 10000A38 100010F0 0FED5FDC
00000000

can someone explain me why this change was made and suggest me what I should do to work around this problem? ("don't use 'in_be32', just dereference the pointer and eieio"....)

any help would be GREATLY appreciated...

Q-ha Park

----- Original Message -----
From: "Q-ha Park" <qhpark@jchyun.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, March 21, 2003 12:48 PM
Subject: kernel oops when trying to read/write the ioremapped GPIO address.


>
> Hi,
> I have a 405 based custom board (STB04xxxx), and I've been using the 2.4.17-mvl21 kernel that came with mvista
> preview kit.
>
> I wrote a gpio driver that gives userland apps to control gpio ports. (no, i didn't use the IBM OCP gpio driver) It
> simply ioremaps the gpio's physical address and read and write registers by calling in_be32, out_be32. is this
> something i shouldn't do? anyways, it worked well with 2.4.17 kernel.
>
> however, with the kernel version 2.4.21-pre4, it oops on calling in_be32 or out_be32. the same once happened with
> the kernel 2.4.2 that also came with the monta vista preview kit.
>
> right before the kernel oops, it gives a message, "Data machine check in kernel mode", which i didn't see before.
> and NIP is at ">>NIP; c300a0a4 <[gpio_driver-dbg]__module_license+38/13c>" after examining the output of ksymoops. i
> don't know why it's at "__module_license"
>
> not only that this driver doens't work, also a couple of other drivers (not all) don't work (causing oops) anymore
> after the kernel is upgraded to 2.4.21-pre4 from 2.4.17. it's funny that other drivers that failed to be insmoded
> are  failed at __module_license..
>
> hmmm, i'm clueless as to why this happens.. can someone help me with this?
>
> your help would be greatly appreciated.
>
> thanks in advance.
>
>
> Q-ha Park
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
