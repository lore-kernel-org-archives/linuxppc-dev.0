Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser. 
In-Reply-To: Your message of "Tue, 23 Oct 2007 12:54:12 +1000."
	<20071023025412.GI31839@localhost.localdomain>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
Date: Tue, 23 Oct 2007 09:24:52 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IkKge-00060g-2l@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> On Mon, Oct 22, 2007 at 04:13:54PM -0500, Jon Loeliger wrote:
> > Previously, there were a few shift/reduce and reduce/reduce
> > errors in the grammar that were being handled by the not-so-popular
> > GLR Parser technique.
> 
> I haven't actually heard anyone whinge about glr-parser...

I have. :-)

> > Flip a right-recursive stack-abusing rule into a left-recursive
> > stack-friendly rule and clear up three messes in one shot: No more
> > conflicts, no need for the GLR parser, and friendlier stackness.
> 
> Ouch.  I'm feeling a bit stupid now,

Absolutely no need for that.

> I really thought our conflicts
> were somewhere else.  Specifically I thought the problem was that we
> needed to look ahead more tokens that we were able to differentiate
> between property and subnode definitions, i.e. between:
> 	label propname =
> and
> 	label propname {

Yes, it was.  When you compute the closure of the propdef with
the rule as a right-recursive, that's when you get the conflict.


> Well, regardless of that, I have a few concerns.
> 
> First, a trivial one: I remember leaving this as a right-recursion,
> despite the stack-nastiness, because that way the properties end up in
> the same order as in the source.  I think that behaviour is worth
> preserving, but of course we can do it with left-recursion by changing
> chain_property() to add to the end of the list instead of the
> beginning.

Understood.  And I wrestled with that as well.  In fact, I even
wrote the reverse_properties() function, which I will include,
and used it initially.  However, several test failed.  So I
removed it, and it all started happily working again.

> Also, if we're going to avoid right-recursion here, we
> should do so for the 'subnodes' productions as well, which is
> completely analogous.

Well, isn't _that_ an interesting observation... :-)
I'll add it to the grand "DTC To Do" list.

> More significantly, I don't know that we want to burn our bridges with
> glr-parser.  glr-parser is a beautiful algorithm which means we can
> use essentially whatever form of grammar is the easiest to work with
> without having to fiddle about to ensure it's LALR(1).  This could
> still be useful if we encounter some less easily finessable grammar
> construct in future.

I'm not saying we can't use it in the future, as needed!  I'm just
saying it isn't strictly necessary now.

> And even without glr-parser, I'm still uncomfortable with the
> lexer<->parser execution ordering issues with the current
> /dts-version/ proposal.  It may now be true that the order is
> guaranteed to be correct, but it's still not exactly obvious.

I'm fine with it, and though I read your words, I'm not really
sure why you are not....  In the long term, maybe think of it
as a temporary hack then.  We'll convert the existing DTS files
over to the new version, and then deprecate the "dts-version 0"
files and support and it will all go away relatively soon.


> It seems to me that the version change introduces a lexical change to
> the input format, and should therefore be handled at the lexical
> level.  And I think there are other potential advantages to parsing
> the version identifier as a token, rather than as an integer (such as
> being able to define entirely different grammars for different
> versions, if we have to).

Version symbol or number, that's still not precluded, I don't think.

jdl
