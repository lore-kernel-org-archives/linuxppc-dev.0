Message-Id: <5.2.0.9.2.20021202155713.01d9b7e8@mail.lauterbach.com>
Date: Mon, 02 Dec 2002 16:12:27 +0100
To: Samuel Rydh <samuel@ibrium.se>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021202131158.GA2427@ibrium.se>
References: <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
 <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
 <20021129160826.GA27950@ibrium.se>
 <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
 <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:11 02.12.2002, Samuel Rydh wrote:
>(unrelated: Does anyone understand why the compiler clears cr4.eq?)

Because you didn't give a prototype for TESTING.

>The compiler does the right thing if -fno-strict-aliasing is used or
>if 'int b' is replaced by 'ulong b'.

Well, the compiler was right before and as Andreas said, you are wrong. In
C *(ulong*)&B and *&B are different unrelated objects and the compiler
optimizes accordingly.

>Adding volatile after asm also fixes things (but I did not see
>this effect in the unsimplified example).

Besides the fact that it's almost always right in low-level inline assembly
to use __asm__ __volatile__ (because without the __volatile__ the __asm__
maybe hoisted out of loops if the compiler thinks it's a loop invariant),
you are just lucky that the __volatile__ fixes it.

So either fixup your code (with unions or char pointers) to be C compliant
or accept the performance penalty of -fno-strict-aliasing.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
