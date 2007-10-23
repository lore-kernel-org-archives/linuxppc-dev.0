Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 09:41:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser.
Message-ID: <20071023234146.GC10595@localhost.localdomain>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com>
	<cace68e0fe3e4e257b7c63d18c805f18@kernel.crashing.org>
	<E1IkL49-0006W4-8X@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IkL49-0006W4-8X@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 09:49:09AM -0500, Jon Loeliger wrote:
> So, like, the other day Segher Boessenkool mumbled:
> > 
> > >> And even without glr-parser, I'm still uncomfortable with the
> > >> lexer<->parser execution ordering issues with the current
> > >> /dts-version/ proposal.  It may now be true that the order is
> > >> guaranteed to be correct, but it's still not exactly obvious.
> > 
> > If you require /dts-version/ (and similar global dtc-control stmts)
> > to be at the start of the file, can't you avoid this ordering problem
> > by starting to parse the file with a simple (hand-written) parser
> > (which would handle these statements) and only when you cannot parse
> > any more switch to the "normal" parser (which won't handle them)?
> > Or is this a stupid suggestion :-)
> 
> My concern here is that I think we are attempting to make
> this significantly more complex than it needs to be.
> We have a pretty good KISS opportunity here, and I've shown
> it to be working so far.  Longer term, all this cruft will
> go away and it will become a moot point anyway.

Well, so am I.  And I think my alternative suggestion (use
'/dts-version-1/') is even simpler: it's recognized in the lexer, so
it's trivial and clear how it can affect both lexical processing and
parsing.  Using a different token here means the "version" can affect
the whole structure of the grammar, without hard to follow
interactions between global variables and parsing behavior (for
instance we can fairly easily grammatically ban the /memreserve/ a-b
form in v1 files).

And I don't see *any* advantage to parsing the version as an integer
rather than a token.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
