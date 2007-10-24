Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 11:11:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser.
Message-ID: <20071024011159.GI10595@localhost.localdomain>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IkKge-00060g-2l@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 09:24:52AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > On Mon, Oct 22, 2007 at 04:13:54PM -0500, Jon Loeliger wrote:
[snip]
> > I really thought our conflicts
> > were somewhere else.  Specifically I thought the problem was that we
> > needed to look ahead more tokens that we were able to differentiate
> > between property and subnode definitions, i.e. between:
> > 	label propname =
> > and
> > 	label propname {
> 
> Yes, it was.  When you compute the closure of the propdef with
> the rule as a right-recursive, that's when you get the conflict.

Ah, right.  Been too long since studied LR parsers, obviously.

[snip]
> > More significantly, I don't know that we want to burn our bridges with
> > glr-parser.  glr-parser is a beautiful algorithm which means we can
> > use essentially whatever form of grammar is the easiest to work with
> > without having to fiddle about to ensure it's LALR(1).  This could
> > still be useful if we encounter some less easily finessable grammar
> > construct in future.
> 
> I'm not saying we can't use it in the future, as needed!  I'm just
> saying it isn't strictly necessary now.

Sure.  Sorry, I was unclear; I wasn't saying we shouldn't remove the
glr-parser option now: certainly we should remove that
right-recursion, and then we don't need it.  I'm saying we shouldn't
do other things which would preclude bringing it back.

> > And even without glr-parser, I'm still uncomfortable with the
> > lexer<->parser execution ordering issues with the current
> > /dts-version/ proposal.  It may now be true that the order is
> > guaranteed to be correct, but it's still not exactly obvious.
> 
> I'm fine with it, and though I read your words, I'm not really
> sure why you are not....  In the long term, maybe think of it
> as a temporary hack then.  We'll convert the existing DTS files
> over to the new version, and then deprecate the "dts-version 0"
> files and support and it will all go away relatively soon.

I just think that putting the version number into the token is
simpler, clearer and has no disadvantage compared to a version
integer.  And will remain so if we have to bump the version again.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
