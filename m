Date: Mon, 2 Dec 2002 18:00:17 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
Message-ID: <20021202170017.GA8469@ibrium.se>
References: <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com> <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es> <20021129160826.GA27950@ibrium.se> <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es> <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com> <5.2.0.9.2.20021202155713.01d9b7e8@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.2.0.9.2.20021202155713.01d9b7e8@mail.lauterbach.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 02, 2002 at 04:12:27PM +0100, Franz Sirl wrote:
> >The compiler does the right thing if -fno-strict-aliasing is used or
> >if 'int b' is replaced by 'ulong b'.
>
> Well, the compiler was right before and as Andreas said, you are wrong. In
> C *(ulong*)&B and *&B are different unrelated objects and the compiler
> optimizes accordingly.

Indeed. A quick check of the ISO C99 standard revealed that the compiler is
allowed to distinguish between int and long even though they share the
same representation on a particular arch.

> Besides the fact that it's almost always right in low-level inline assembly
> to use __asm__ __volatile__ (because without the __volatile__ the __asm__
> maybe hoisted out of loops if the compiler thinks it's a loop invariant),

...which is desirable in this case. The st_le32 inline is just an efficient
way to flip the endian and is not supposted to have any undeclared
side effects (like touching hardware).

/Samuel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
