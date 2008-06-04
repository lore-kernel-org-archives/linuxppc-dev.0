Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Jun 2008 14:13:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080604041304.GD29085@yookeroo.seuss>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
	<48404D83.4070108@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48404D83.4070108@freescale.com>
Cc: jdl@jdl.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 01:54:59PM -0500, Scott Wood wrote:
> David Gibson wrote:
>> What I don't like is the combination of the two.  Using the /word/
>> form in (1) suggests that each /word/ is a lexically distinct symbol
>> with functions in different contexts: consider /dts-v1/, /include/,
>> /memreserve/ - they're all used only in their own distinct context.
>> Use of /word/s in (2) would suggest that each /word/ is just an
>> identifier for a different function, and should all be usable in a
>> similar grammtical context - which won't be true of /memreserve/,
>> /dts-v1/ and any other truly lexically distinct symbols we need to
>> add.
>
> I don't understand this conclusion -- I wouldn't expect to be able to  
> use "for" or "while" at file scope of C code, just because I can use  
> "struct", "int", or "sizeof" there.  The slashes are simply a way of  
> creating reserved words, some of which happen to be function-like.

Heh, when I started revisiting this after my long hiatus doing other
things, I was thinking the same way.  I still have a few misgivings,
but then the nice thing about the slash-delimited reserved word thing
is that even if we come up with a new, nicer syntax it's not going to
hurt to keep the slash-form around for compatibility.

sizeof is an interesting example.  As you point out it's an example of
a function-like reserved word, which given our existing approach to
reserved words supports your syntax.  On the other hand, we may well
want a sizeof operator in dtc itself as part of our expression
support, and in that case, the "be like C" principle suggests it
should be rendered as "sizeof" rather than "/sizeof/".

But as I said that can be dealt with in the future without breaking
compatibility.  Objection withdrawn.

Sorry it's taken this long :(.

>> So, I like the notion of functions like this, but with identifiers
>> that aren't /word/s.  Re-invoking the "least surprise to C
>> programmers" principle, in general I think the identifiers should be
>> as C identifiers (i.e. [a-zA-Z_][a-zA-Z0-9_]*).
>
> That would make it difficult to have function-like syntax outside of  
> properties.

Not really.  The only thing such identifiers are ambiguous with is
node and property names, and we've already headed down the path of
making lexical contexts in which node/property names are recognized be
the exception.

My plan for the future here was to have { } always be the thing that
introduces a node/property name context.  That's roughly right for the
existing node syntax - obviously there's a bit more complexity there,
since we switch back to normal/expression context after a node/prop
name, then back to node/prop name context after ';'.  Then for any
expression operators that take node/prop names, I suggest we also use
{ }, so if 'foo' is a node expression, then maybe 'foo{reg}' to
extract the 'reg' property from the node represented by foo.

I'll need a little finessing, but I think using a lexer context stack
it shouldn't be too hard to handle.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
