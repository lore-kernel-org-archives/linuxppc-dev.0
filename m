Message-ID: <396AB595.DC926132@lightning.ch>
Date: Tue, 11 Jul 2000 07:50:13 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com> <396969E1.A7256E4A@lightning.ch> <396A5162.411F49EF@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> These are becoming a pain in the ass instructions.  Has anyone ever
> done some performance analysis to see what we really gain here in
> real life?  Sure, locally and logically you can make an intuitive
> argument, but we are sure fetching lots of instructions just to get
> this aligned, and further to actually move the data.
>
> These instructions certainly don't work on uncached memory space,
> causing the alignment exception and probably horrible performance without
> people knowing.  These instructions used to cause the exception on
> the early MPC8xx processors when copyback cache wasn't enabled.  Today,
> the newer silicon doesn't fault at all regardless of cache mode.  I
> guess I need to determine what is really happening.  Nothing would
> be fine, but it appears _something_ (usually incorrect) happens.

I have seen this happen on cacheable memory with copyback enabled.
The dcbz-memcpy caused the destination to be zeroed, IIRC.

> > But the function works fine if I remove that instruction.
>
> I'm still a C code fan:
>         for(i=0; i<count; i++)
>                 *d++ = *s++;
>
> ...and let the compiler guys make it go fast :-).

That would be cool, but I am sure the asm funcs perform much better.
I'll try to do some benchmarking if I have time.


				Daniel M.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
