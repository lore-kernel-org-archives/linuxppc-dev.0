Date: Tue, 5 Dec 2000 19:04:13 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: alex@cosmo.allay.net
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012051221430.22364-100000@macachu.ex-pressnet.com>
Message-ID: <Pine.LNX.4.10.10012051837160.24871-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > pass [4] int: 25 string: somestring
> > Speicherschutzverletzung (core dumped)
> >
> > is what I get. On Intel, that is. gcc version is egcs-2.91.66. Seems
> > something's wrong with your code in general.
>
> well, thats the thing. there isnt, i dont think, wrong with my code (apart
> from what you said earlier (later? i get this as being 15 minutes
> "new"er). it doesnt segfault at all here. i get some screwed up variables,

It does segfault for me, on an Intel Redhat system. So far I haven't
noticed unexplained breakage compiling other programs on Intel machines,
though there's been a number of obscure programming errors that show only
occasional segfaults. The fact that it doesn't segfault for you does not
constiute proof that it's correct code.

Anyway, this is what happens on PPC:

pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
pass [1] somestring
pass [2] (null)
pass [3] (null)
pass [4] (null)
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
dual-run pass [1][vsn] int: 25 string: somestring
dual-run pass [1][v] int: 25 string: somestring
dual-run pass [2][vsn] int: 25 string: somestring
dual-run pass [2][v] int: 25 string: somestring
dual-run pass [3][vsn] int: 25 string: somestring
dual-run pass [3][v] int: 25 string: somestring
dual-run pass [4][vsn] int: 25 string: somestring
dual-run pass [4][v] int: 25 string: somestring
buffer [a] pass [1]: int: 25 string: somestring
buffer [b] pass [1]: int: 2147480592 string:
buffer [a] pass [2]: int: 25 string: somestring
buffer [b] pass [2]: int: 2147480592 string:
buffer [a] pass [3]: int: 25 string: somestring
buffer [b] pass [3]: int: 2147480592 string:
buffer [a] pass [4]: int: 25 string: somestring
buffer [b] pass [4]: int: 2147480592 string:

No segfault. Just garbage if you use vsnprintf (which completely exhausts
the va_list so there are no unprocessed arguments left after the call)
twice without restoring ap in between.
Now what exactly did you expect to happen in that case? Garbage (or
segfaults due to what precisely was left on the stack from previous
operations) is all you will get if you call vsnprintf with a va_list
argument that has its internal pointers to the next arguments set to
beyond what was allocated on stack for the arguments.
Please see the definitions of the va_list type, and the va_arg macro, in
va-ppc.h.

I don't care what the maintainers of opennap claim about 'it can't run on
Mac because Mac is broken anyway'. Writing portable code may be tough in
this special neck of the woods, but it's possible. I've seen maintainers
of other free software packages act reasonably about this very issue. Send
them a patch, and explain why the patch is required.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
