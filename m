Message-ID: <3A6283A7.C4327446@primenet.com>
Date: Sun, 14 Jan 2001 21:59:19 -0700
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: GCC PPC Inline Assembly Help
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have an embedded platform (MPC8240) that requires flash memory
be programmed 64-bits at a time.  I believe that a floating-point
store is the only way to generate this 64-bit write.  I also
understand that floating-point usage is prohibited in the kernel
because the floating-point context is not saved.

I'm attempting to create a out64() function that will save 'fr0',
do a 64-bit write using 'fr0', and restore 'fr0'.  See below:

inline void out64(uint64 *addr, uint32 hi, uint32 lo) {
  uint64 fr0save;
  volatile uint32 mem[2];
  mem[0] = hi;
  mem[1] = lo;
  asm volatile (
    "stfd%U0%X0 0,%0\n\t"
    "lfd%U3%X3 0,%3\n\t"
    "stfd%U1%X1 0,%1\n\t"
    "lfd%U2%X2 0,%2\n\t"
    "sync"
    : "=m" (fr0save), "=m" (*addr)
    : "m" (fr0save), "m" (mem[0]), "m" (mem[1])
    : "memory", "fr0");
}

How close am I?  I've looked at the asm and it looks OK but I've
been bitten before by code with wrong constrants that worked most
of the time...  I also found out by accident that the 'volatile'
seems to make the code better.

I noticed a 'z' constraint ("`FPMEM' stack memory for FPR-GPR
transfers") in the gcc info pages but have no clue how to use it.
Any pointers?

I also noticed that 32-bit shifts (concatinating 2 32-bit values to
one 64-bit 'unsigned long long' seems to generate rather poor code.
(That's why the code above has 2 32-bit values).  Am I doing
something wrong?

I'm using gcc 2.95.2

Thanks for any help.

Bob

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
