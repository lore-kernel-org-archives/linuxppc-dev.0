Message-ID: <38041087.62AB190@primenet.com>
Date: Wed, 13 Oct 1999 04:54:31 +0000
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PowerPC function returning long long
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was playing with the inline assembler and the ppc
timebase facility and created the following function -

unsigned long long get_timebase(void) {
        unsigned long tbu;
        unsigned long tbl;
        unsigned long junk;
        __asm__ __volatile__ ("
1:      mftbu   %2
        mftb    %1
        mftbu   %0
        cmpw    %0,%2
        bne     1b"
        : "=r" (tbu), "=r" (tbl), "=r" (junk));
        return ((unsigned long long)tbu << 32) | tbl;
}

This function compiles to (gcc 2.95.1) :

get_timebase:
1:      mftbu   5 
        mftb    6
        mftbu   0   
        cmpw    0,5 
        bne     1b
        mr 10,0
        li 9,0   
        mr 7,10
        mr 12,6
        li 8,0
        li 11,0
        or 3,7,11 
        or 4,8,12
        blr

As one can see, most of this is a bunch of register thrashing.
I expected it to generate something along this:

1:      mftbu   5 
        mftb    4
        mftbu   3   
        cmpw    3,4
        bne     1b
	blr 

I assume it is because gcc is struggling with the code
in the return statement.

Is there a better way to write the return statement?

Is there a register constraint for a long long register
(like the "A" constraint for the x86 which returns the
64 bit data in edx:eax)?

Any ideas?

Yes I know that there is a similar function in
arch/ppc/kernel/apus_setup.c which isn't quite
what I want.

Bob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
