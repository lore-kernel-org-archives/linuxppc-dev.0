Reply-To: "Todd Inglett" <tinglett@vnet.ibm.com>
Message-Id: <3A1A6E42.43E8663D@vnet.ibm.com>
Date: Tue, 21 Nov 2000 06:44:50 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
Mime-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: bitops porting question
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

I'm working on the 64bit PPC port of linux and need some advice on the
bitops (asm-ppc/bitops.h & arch/ppc/kernel/bitops.c).  I understand that
they are supposed to be "generic" ops, but see a problem with big endian
and word size.

Anyway, the gist of the problem is that when sizeof(int) != sizeof(long)
the operations break down for one reason:  there is no test_bit()
function. Instead, C code is written to test a bit.  For example, in
fs.h we find this macro:

  #define __buffer_state(bh, state)
	(((bh)->b_state & (1UL << BH_##state)) != 0)

Thus, the operations in bitops.c must be written such that this C test
on the bits is valid.  But this is not possible using big endian words
when the length of the bitset is not known.  And little endian is not
the solution because the generated C code does not do little endian
operations, of course.

Consider that b_state in the above example is 64 bits (it is an unsigned
long).  For testing for a lock (BH_Lock == 2) we test bit number 2.
Remember bits are numbered like this (defined by the C usage above) and
stored like this (big endian):

             |61...........0|

So bit #2 will be in the 8th byte of the doubleword.  But the current
set_bit() views 32 bit words like this:

             |31...0|63...32|

So set_bit(2, &b_state) will set a bit in the 4th byte of the virtual
doubleword.  Not good.  A simple fix seems to be to change the
set_bit(), etc, functions to 64 bit.  In general I think this is the
best approach, but consider what will happen with the following:

    int flags;		/* 32 bits */

    set_bit(2, &flags);  /* bad memory ref! */

On a little endian machine this won't happen since the low order bytes
come first.

I probably should take this to the linux kernel list, but thought I
should bring it up here since you guys are no doubt well aware of these
kinds of problems.  It seems the tactical thing to do is to change the
set_bit(), etc, functions to 64 bit but this adds a new restriction that
a bit set must be a multiple of 64 bits in size.  It will become a
requirement that C code tests work only with long values and I'm sure
some drivers will be broken.

A better solution appears to be the addition of a test_bit
function/macro.  Then I can replace it with something that matches the
other functions if necessary.  But then I need to get all the kernel to
use it.  Sigh.

Any advice? :)
--
-todd

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
