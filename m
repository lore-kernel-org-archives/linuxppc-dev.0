Message-ID: <3ACAE9C5.6077A4E2@opensource.se>
Date: Wed, 04 Apr 2001 11:30:45 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: mlocke@mvista.com
Subject: runtime check of cacheline size.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Wouldn't it be nice with a glibc that works for all of us?

Idea:

Let's run-time check the cacheline-size of our cpu!

How?

First we need to make sure that the maximum cacheline size of
any PowerPC cpu is 128 bytes. (CACHELINE_MAX)
If it's anything else then it's easy to add that to the code.

Then if we should use the dcbz instruction we need at least
CACHELINE_MAX bytes aligned to a CACHELINE_MAX address. (buf)
Then we write:

address: data (32bit)

buf+16   16
buf+32   32
buf+64   64

Then we use the "dcbz" instruction on buf.

then we add together all data we've written above (sum):

32 bit data on address:

buf+64
buf+32
buf+16

then: cachelinesize = 128-sum

Easy, right?


I tried to implement it using assembler:

---- cut here ----

cachelinesize_detect:

#define CACHELINE_MAX 128

        /* use dcbz to figure out the size of a cacheline
         * on our system...
         * needs a CACHELINE_MAX bytes buffer in r3.
         * r3 should be aligned to CACHELINE_MAX too.
         */

        li      r4, 0x10        /* 16 bytes: mpc8xx, ibm4xx */
        stwx    r4, r4, r3
        li      r4, 0x20        /* 32 bytes */
        stwx    r4, r4, r3
        li      r4, 0x40        /* 64 bytes */
        stwx    r4, r4, r3
        dcbz    0, r3
        add     r5, r4, r4      /* 128 bytes */
        lwzx    r4, r4, r3
        sub     r5, r5, r4
        lwz     r4, 0x20(r3)
        sub     r5, r5, r4
        lwz     r4, 0x10(r3)
        sub     r5, r5, r4

/* now: r5 contains cacheline size */

---- cut here ----

The code is untested and I've probably use the "sub"
instruction the wrong way. You get the idea anyhow.

Who wants to adopt the idea for memset.S?

I don't really have time, sorry...

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
