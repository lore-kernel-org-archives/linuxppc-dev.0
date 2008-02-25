Return-Path: <dgibson@ozlabs.org>
Date: Mon, 25 Feb 2008 14:38:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080225033824.GC16071@localhost.localdomain>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080222053450.GH3064@localhost.localdomain>
	<47BF1089.8060204@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47BF1089.8060204@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 12:12:25PM -0600, Jon Loeliger wrote:
> David Gibson wrote:
> 
> >> node {
> >> 	prop = /incbin/("path/to/data");
> >> };
> >>
> >> node {
> >> 	prop = /incbin/("path/to/data", 8, 16);
> >> };
> >
> > I still dislike the syntax, but haven't thought of a better one yet.
> > There are some issues with the implementation too, but I've been a bit
> > too busy with ePAPR stuff to review properly.
> 
> I'm OK with the syntax, but whatever-ish.
> 
> Would these be better?:
> 
>     prop = /call/(incbin, "path/to/data", 17, 23);
>     prop = /call[incbin]/("path/to/data");
>     prop = /call incbin/("path/to/data", 12, 12+10);

Ugh, I like those even less.

> What is the aspect of the syntax that you don't like?

Well, when I first objected, I didn't really know why.  But
contemplating your discussion below has helped by crystallise why this
syntax is making my ugly sense tingle.

1) I've no problem with using /word/ for "reserved words".  It's what
we're already doing, and importantly it's lexically distinct in all
contexts, even in proximity to the lexically troublesome node and
property names.

2) I've no problem with <something>(arg, arg, arg) function syntax.
Functions are handy, and this is consistent with our "least suprise to
C programmers" design principle.

What I don't like is the combination of the two.  Using the /word/
form in (1) suggests that each /word/ is a lexically distinct symbol
with functions in different contexts: consider /dts-v1/, /include/,
/memreserve/ - they're all used only in their own distinct context.
Use of /word/s in (2) would suggest that each /word/ is just an
identifier for a different function, and should all be usable in a
similar grammtical context - which won't be true of /memreserve/,
/dts-v1/ and any other truly lexically distinct symbols we need to
add.

> I think we essentially need to stick in the /.../ realm
> to be consistent with the other non-standard names being
> used, like /include/.

So, with the thoughts about, I come to the conclusion that, yes, we
should stick to /.../ for things which really act like reserved words,
but binary includes aren't one of those things.

Unlike source includes, binary includes only make sense inside a
property *value* (or to put it another way, an a context suitable for
an expression).  Which means the possible lexical confusion with
node/property names that motivated the /foo/ form in the first place
disappears.


So, I see two good options for the binary include.  Once is to treat
binary includes as a new special operator.  That operator (as it's
own, lexically distinct symbol) can be represented by a /word/, but in
that case, using it shouldn't look like a general function call.

Or, we can treat binary includes as a built-in function, see below.

> I can see a generalized form that allows other pre-defined
> or user-defined "functions" to be introduced and called
> or used in a similar way:
> 
>     prop = <(22 + /fibonacci/(7)) 1000>;
> 
>     prop = /directoryof/("/path/to/some/file.doc");
> 
>     interrupt-map = /pci_int_map/(8000, 2, 14);
> 
> or whatever.  We can paint this bikeshed for a long time
> if we need to.  Or, we can get down to some serious issue
> if there are any.  Are there?

So, I like the notion of functions like this, but with identifiers
that aren't /word/s.  Re-invoking the "least surprise to C
programmers" principle, in general I think the identifiers should be
as C identifiers (i.e. [a-zA-Z_][a-zA-Z0-9_]*).  With one caveat, it's
not essential but it might be worthwhile to make built-in function
identifiers obviously distinct from user-defined ones (if we add those
in future).


PS. I do see one potential gotcha with C-like function syntax.  As we
add expression support, the obvious way to handle constructs like:
	prop = <0x1 0x2>, "string";
Is to treat ',' as a bytestring concatenation operator.  There's
potentialy ambiguity between that usage and it's use as a separator
for function arguments.  Of course the same issue exists in C with its
comma operator, so it's not a showstopper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
