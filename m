Date: Mon, 3 Jun 2002 08:00:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] misc compiler warn/err fixes, typo fixes and aesthetic changes
Message-ID: <20020603150016.GH8193@opus.bloom.county>
References: <20020528183509.GI1295@opus.bloom.county> <23554.1022636535@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23554.1022636535@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 11:42:15AM +1000, Murray Jensen wrote:
>
> On Tue, 28 May 2002 11:35:09 -0700, Tom Rini <trini@kernel.crashing.org> writes:
> >> misc compiler warn/err fixes, typo fixes and aesthetic changes
> >
> >1) Why did you need to add in all of the 'volatile' keyword?  What
> >compiler are you using which is unhappy with this?  Part of why I ask is
> >I _think_ this was a problem with gcc-2.96/2.97 but not any actual
> >'release'.
>
> The volatiles for "cpmp" and "immr" fall into the "aesthetic changes" category.
> These pointers are volatile and should be declared as such, so there is never
> any confusion.

Okay.

> The volatiles in "include/asm-ppc/uaccess.h" worked around a compiler bug. I
> looked at it, and the pattern was that it had a lot of problems with inline
> functions calling inline functions - it messed up its register allocation and
> aborted.

Well, talk to the gcc people. :)  Or maybe some of these inlines should
be #defines or actual functions..  I think I heard Dan Malek question
why we have so many inlines recently anyhow..

> My compiler version is "gcc version 3.1 20011203 (experimental)". The problem
> may have been fixed by now (I pulled this gcc from CVS in December). Other than
> these two inlines, this compiler compiles the kernel fine (and it runs on our
> MPC8260 based Hymod board).

Well, gcc-3.1.1 should be out soonish, so please try a newer compiler.

> >2) Changes outside of arch/ppc and include/asm-ppc need to go onto
> >Marcelo (who will either take them or tell you to send them to the
> >appropriate maintainer).
>
> I didn't mean to include those two - anyone who tried to compile those modules
> would get the same errors - they are simply typos (missing include, missing
> commas). I expect they will be fixed in due course and will come through in the
> normal merges. Do you think I should submit them anyway? Cheers!

You certainly should send them.  They don't get fixed until someone
does. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
