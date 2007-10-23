Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 12:54:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC:  Remove the need for the GLR Parser.
Message-ID: <20071023025412.GI31839@localhost.localdomain>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Ik4aw-0007ud-Lu@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 04:13:54PM -0500, Jon Loeliger wrote:
> Previously, there were a few shift/reduce and reduce/reduce
> errors in the grammar that were being handled by the not-so-popular
> GLR Parser technique.

I haven't actually heard anyone whinge about glr-parser...

> Flip a right-recursive stack-abusing rule into a left-recursive
> stack-friendly rule and clear up three messes in one shot: No more
> conflicts, no need for the GLR parser, and friendlier stackness.

Ouch.  I'm feeling a bit stupid now, I really thought our conflicts
were somewhere else.  Specifically I thought the problem was that we
needed to look ahead more tokens that we were able to differentiate
between property and subnode definitions, i.e. between:
	label propname =
and
	label propname {

Except... I'm almost certain the conflicts first appeared when I added
labels, and I can't see how that would affect this.  Well, colour me
baffled.

Especially since the comments and content of commit
4102d840d993e7cce7d5c5aea8ef696dc81236fc (second commit in the entire
history!) appear to back up my memory of this.  I used to have a
lookahead hack in the lexer to remove the conflict.

But this patch certainly seems to make the conflicts go away, so I'm
confused.


Well, regardless of that, I have a few concerns.

First, a trivial one: I remember leaving this as a right-recursion,
despite the stack-nastiness, because that way the properties end up in
the same order as in the source.  I think that behaviour is worth
preserving, but of course we can do it with left-recursion by changing
chain_property() to add to the end of the list instead of the
beginning.  Also, if we're going to avoid right-recursion here, we
should do so for the 'subnodes' productions as well, which is
completely analogous.

More significantly, I don't know that we want to burn our bridges with
glr-parser.  glr-parser is a beautiful algorithm which means we can
use essentially whatever form of grammar is the easiest to work with
without having to fiddle about to ensure it's LALR(1).  This could
still be useful if we encounter some less easily finessable grammar
construct in future.

And even without glr-parser, I'm still uncomfortable with the
lexer<->parser execution ordering issues with the current
/dts-version/ proposal.  It may now be true that the order is
guaranteed to be correct, but it's still not exactly obvious.

It seems to me that the version change introduces a lexical change to
the input format, and should therefore be handled at the lexical
level.  And I think there are other potential advantages to parsing
the version identifier as a token, rather than as an integer (such as
being able to define entirely different grammars for different
versions, if we have to).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
