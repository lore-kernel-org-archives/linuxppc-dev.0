Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204465E@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Gabriel Paubert'" <paubert@iram.es>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Wed, 9 May 2001 09:40:20 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Interesting, which compiler are you using? I've been experimenting with my
> own modifications to gcc, in case I hit a problem I often do objdump
> --disassemble vmlinux | less and search the instruction in which I'm
> interested. In your case it would be lwarx, but there are probably too
> many occurrences to make the hunt worthwhile.

I'm using gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo), from
MontaVista.
Your right, one of the first things I did was look at the generated assembly
code, that's how I noticed the one-bit difference between bne and bne-.
Here's a little snippet from one of the atomic ops.  It looks ok to me,
except for the fact that lwarx r11,0,r31 shows up as lwarx r11,r0,r31.
Objdump seems to do this everywhere, I'm not sure why.

static __inline__ void atomic_set(atomic_t *v, int a)
{
c004f9e8:       38 00 00 01     li      r0,1
        int t;

        __asm__ __volatile__("\n\
c004f9ec:       7d 60 f8 28     lwarx   r11,r0,r31
c004f9f0:       60 0b 00 00     ori     r11,r0,0
c004f9f4:       7d 60 f9 2d     stwcx.  r11,r0,r31
c004f9f8:       40 a2 ff f4     bne-    c004f9ec <d_alloc+0x90>

        atomic_set(&dentry->d_count, 1);


Regards,
Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
