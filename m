Message-ID: <396A5162.411F49EF@embeddededge.com>
Date: Mon, 10 Jul 2000 18:42:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: daniel.marmier@lightning.ch
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com> <396969E1.A7256E4A@lightning.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Marmier wrote:

> IIRC, I have sent you a patch that did the right thing for 16-byte
> cache lines at time of 2.3.99-pre5.

Now I remember :-).  I see too much code from too many places every
day!

> ...... Of course, if there are caches with 64 or
> 128 byte lines, some more work needs to be done.

Lots more :-).

> What gives me trouble is the fact that dcbz instruction in function
> arch/ppc/lib/string.S:__copy_tofrom_user does not seem to work for me.

These are becoming a pain in the ass instructions.  Has anyone ever
done some performance analysis to see what we really gain here in
real life?  Sure, locally and logically you can make an intuitive
argument, but we are sure fetching lots of instructions just to get
this aligned, and further to actually move the data.

These instructions certainly don't work on uncached memory space,
causing the alignment exception and probably horrible performance without
people knowing.  These instructions used to cause the exception on
the early MPC8xx processors when copyback cache wasn't enabled.  Today,
the newer silicon doesn't fault at all regardless of cache mode.  I
guess I need to determine what is really happening.  Nothing would
be fine, but it appears _something_ (usually incorrect) happens.

> But the function works fine if I remove that instruction.

I'm still a C code fan:
	for(i=0; i<count; i++)
		*d++ = *s++;

...and let the compiler guys make it go fast :-).

You know, we could make this even faster by using the Altivec and the
new cache streaming modes on the 7400 processors :-).  I've tested this
in applications.  It really works.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
