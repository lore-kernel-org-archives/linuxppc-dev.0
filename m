Message-ID: <3AAFF094.6137F71A@matrox.com>
Date: Wed, 14 Mar 2001 17:28:36 -0500
From: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: why XOR ext2_set_bit?
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just had a problem writing to a file on a ext2 filesystem with my port
of kernel 2.4 on powerpc (G4) running in little-endian.  When the
function ext2_set_bit was called by ext2_new_block, it returned
something so I got the warning :

"ext2_new_block bit already set for block 161"

and I was stuck in an infinite loop.  I found the definition for the
function in include/asm-ppc/bitops.h as follow:

#define ext2_set_bit(nr, addr)		test_and_set_bit((nr) ^ 0x18, addr)

Now my question:  Why is "nr" XORed with 0x18 ???  I tried to do this
function on paper and with this XOR, they were always trying to change
the wrong bit.  Now, since nobody's been reporting this problem before,
I guess this XOR is ok but I'd really like to understand it's utility to
correct things on my side (for now, I just removed it and everything
appears to be fine).

Could someone give me an explanation?

Thanks,

Sébastien Côté

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
