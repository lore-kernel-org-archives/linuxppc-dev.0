Date: Mon, 2 Dec 2002 14:11:58 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
Message-ID: <20021202131158.GA2427@ibrium.se>
References: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es> <20021129160826.GA27950@ibrium.se> <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es> <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 02, 2002 at 12:17:42PM +0100, Franz Sirl wrote:
>
> At 18:49 29.11.2002, Samuel Rydh wrote:
> >> I see that your example involves local variables, does
> >> it also happen in the non-automatic case ?
> >
> >It happens in the non-automatic case too. I'll try the
> >latest gcc version later.
>
> Can you please post a compilable code fragment that still shows the bug for
> you? Or add -save-temps to the CFLAGS and send me the resulting
> preprocessed .i file. I seem to remember a platform independent bug in 3.1
> with memory constraints, but it maybe something totally different...
>
> Ah, and don't forget to tell me all the CFLAGS necessary to trigger the bug.
>

Sure, here is a stand alone program that triggers the problem:

----------------------------------------------------------------

#include <stdio.h>
typedef unsigned long ulong;

static __inline__ void st_le32( ulong volatile *addr, ulong val )
{
        __asm__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr)  );
}

int
main( int argc, char **argv )
{
        int b;
        st_le32( (ulong*)&b, 0 );
        testing( b );
        return 0;
}

int
testing( int x )
{
}

----------------------------------------------------------------

With CFLAGS='-O2', the assembly output becomes:

00000000 <main>:
   0:   94 21 ff f0     stwu    r1,-16(r1)
   4:   7c 08 02 a6     mflr    r0
   8:   80 61 00 08     lwz     r3,8(r1)
   c:   39 21 00 08     addi    r9,r1,8
  10:   90 01 00 14     stw     r0,20(r1)
  14:   38 00 00 00     li      r0,0
  18:   7c 00 4d 2c     stwbrx  r0,r0,r9
  1c:   4c c6 31 82     crclr   4*cr1+eq
  20:   48 00 00 01     bl      20 <main+0x20>
  24:   80 01 00 14     lwz     r0,20(r1)
  28:   38 60 00 00     li      r3,0
  2c:   38 21 00 10     addi    r1,r1,16
  30:   7c 08 03 a6     mtlr    r0
  34:   4e 80 00 20     blr

(unrelated: Does anyone understand why the compiler clears cr4.eq?)

The compiler does the right thing if -fno-strict-aliasing is used or
if 'int b' is replaced by 'ulong b'.

Adding volatile after asm also fixes things (but I did not see
this effect in the unsimplified example).

/Samuel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
