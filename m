Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 25 Feb 2002 14:29:39 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202252229.g1PMTdQ02395@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is an issue here where I'm trying to give you or whoever is interested
in this thread a test program to run that will demonstrate the problem.
I don't actually bang the SMC or CPM or whatever, I am trying to do
perfectly valid stuff with a user level program accessing io space of
pci devices. There is no kernel level code accessing the device I'm trying
to work with. It makes absolutely no difference where the mmap goes to, as
long as it is not normal system ram.

Since my hardware isn't the same as anyone else's, I just bang the IMM
in a harmless way. This demonstrates the problem just as well on my box.
So I assume since you've got 60x hardware with an IMM you can try the same
thing on your hardware and see the same failure I'm seeing.

When you say mmap() works, I agree it works, mostly. But if you do things
like in my program enough times, the system ends up being corrupted.
Various kernel threads like kupdated have a kernel panic. Stuff just starts
failing, like system memory is getting corrupted. All this is described in
detail in this thread.

There is a bug in linux PPC, and that's what I'm trying to resolve. Here
is the last part of the printout of the execution of that program:

---cut--- (this is kernel 2.4.17 btw)
 224,42040000
 225,42040000
 226,42040000
 227,42040000
 228,42040000
Oops: kernel access of bad area, sig: 11
NIP: C0011D80 XER: 00000000 LR: C0011CB0 SP: C2A9DEF0 REGS: c2a9de40 TRAP: 0300d
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: A3EBDA34, DSISR: 22000000
TASK = c2a9c000[108] 'mt' Last syscall: 2
last math 00000000 last altivec 00000000
GPR00: C2A780B0 C2A9DEF0 C2A9C000 00000001 C2A9C384 00000000 C2A78384 00000000
GPR08: C019E900 A3EBD980 C019E3B4 0000054C 24000242 10018940 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 02A9DF40 00000000 00000000
GPR24: C2A9DF50 7FFFFD10 00000152 00000011 C3E7D160 C2A780A8 C3E7D1A0 C2A78000
Call backtrace:
C0011C3C C0006A2C C0003D7C 10000698 0FEDA188 00000000
Segmentation fault
---cut---

The system is corrupted. If I try to do an 'ls', I get this:
---cut---
kernel BUG at memory.c:375!
Oops: Exception in kernel mode, sig: 4
NIP: C00220FC XER: 00000000 LR: C00220FC SP: C2A9DDE0 REGS: c2a9dd30 TRAP: 0700d
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c2a9c000[339] 'bash' Last syscall: 30583
last math 00000000 last altivec 00000000
GPR00: C00220FC C2A9DDE0 C2A9C000 0000001C 00001032 00000001 C02F6160 C01A112A
GPR08: 00000000 00000000 0000001F C2A9DD00 0000000D 100AC3EC 00000000 00000000
GPR16: 00000000 00000000 00000000 C01961C0 00000000 02A9DF40 00000000 C0003FB4
GPR24: C0003D20 100C2870 C3DAEB8C 00000000 00000000 00000000 C3E53000 C3DDC240
Call backtrace:
C00220FC C0025098 C0011020 C00165A8 C00082FC C0003FE8
Illegal instruction
---cut---

This is a very real bug in linux ppc, I'm convinced of that. The crucial
thing is
mmap some region of io space
read from a page
write to the same page
Repeat and rinse, something will corrupt the system.

reads alone are ok.
writes alone are ok.
write followed by any combination of reads or writes is ok
read followed by write = trouble

-Dave

>David Ashley wrote:
>
>
>> #define ADDR 0xf0010000
>> #define SIZE 0x00002000
>
>Oh, now I remember......I found it amusing someone could think they
>could just map the CPM memory and start reading and writing it.
>You can't do stuff like that and expect the system to keep running
>correctly.  The first 128 bytes of the DPRAM are initialized for
>the SMC (whether you use it or not).  You have to be really, really
>careful when you map anything like this, and you have to understand
>the interaction of everything else that may also have access to these
>memory spaces.  A common mistake is people map things like GPIO into
>application space, and then think they can atomically update the
>registers.  This doesnt' work because there may be drivers that
>also do the same thing.
>
>> The above program fails at about iteration 228 on linux 2.4.17. On 2.4.14
>> it fails at an unpredictable iteration, from maybe 180 to 350. The number
>> of other seemingly harmless shell comands executed, like "ls",
>
>How does it fail?  If you are actually using the SMC as a console device
>I'm surprised it runs that long.
>
>There isn't anything wrong with mmap()......
>
>
>        -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
