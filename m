Message-ID: <B162270C965FD511AB9600B0D0B0AB4206461D@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: About tlbia MACRO,
Date: Fri, 20 Jul 2001 12:13:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


when reading source codes, got a question. Wish get some help. Thanks in
advance.

File: ./arch/ppc/kernel/ppc_asm.h
--------------------------------------------------------
#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
#define tlbia					\
	li	r4,1024;			\
	mtctr	r4;				\
	lis	r4,KERNELBASE@h;		\
0:	tlbie	r4;				\
	addi	r4,r4,0x1000;			\
	bdnz	0b
#endif
--------------------------------------------------------

As we know, if with 4xx CPU, tlbia instruction is **implemented and is used
to invalidate ALL tlb entries.
For 6xx CPUs, we will use the above defined macro to use tlbie to one by one
invalidate tlb entries.

My question is:

>From the above codes, I can only see that ONLY 4M virtual memories starting
from 0xC0000000 to 0xC0400000 got invalidated. (1024*4k). Thus, I am
confusing: How can we say this above macro will invalidate ALL tlb
entries???

With the above macro, we only promise: If and ONLY if any entry containing
the kernel image addresses from 0xC0000000 to 0xC0400000, it will be
invalidated. For the rest, it won't and still stay in TLB buffer. For
example, if there **happen** to have an TLB entry containing virtual address
0x00001000. This will not be able to get invalidated.

Am I right? Thanks,

Mike

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
