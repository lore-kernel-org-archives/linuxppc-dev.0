To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] misc compiler warn/err fixes, typo fixes and aesthetic changes 
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org>
   of "Tue, 28 May 2002 11:35:09 MST." <20020528183509.GI1295@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 May 2002 11:42:15 +1000
Message-ID: <23554.1022636535@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 28 May 2002 11:35:09 -0700, Tom Rini <trini@kernel.crashing.org> writes:
>> misc compiler warn/err fixes, typo fixes and aesthetic changes
>
>1) Why did you need to add in all of the 'volatile' keyword?  What
>compiler are you using which is unhappy with this?  Part of why I ask is
>I _think_ this was a problem with gcc-2.96/2.97 but not any actual
>'release'.

The volatiles for "cpmp" and "immr" fall into the "aesthetic changes" category.
These pointers are volatile and should be declared as such, so there is never
any confusion.

The volatiles in "include/asm-ppc/uaccess.h" worked around a compiler bug. I
looked at it, and the pattern was that it had a lot of problems with inline
functions calling inline functions - it messed up its register allocation and
aborted.

My compiler version is "gcc version 3.1 20011203 (experimental)". The problem
may have been fixed by now (I pulled this gcc from CVS in December). Other than
these two inlines, this compiler compiles the kernel fine (and it runs on our
MPC8260 based Hymod board).

>2) Changes outside of arch/ppc and include/asm-ppc need to go onto
>Marcelo (who will either take them or tell you to send them to the
>appropriate maintainer).

I didn't mean to include those two - anyone who tried to compile those modules
would get the same errors - they are simply typos (missing include, missing
commas). I expect they will be fixed in due course and will come through in the
normal merges. Do you think I should submit them anyway? Cheers!
								Murray...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
