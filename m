Return-Path: <dgibson@ozlabs.org>
Date: Fri, 26 Oct 2007 16:17:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [0/2] A counter-proposal for the literals transition
Message-ID: <20071026061718.GA6136@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I've been doing some thinking and coding today on the dts-versioning
/ new-style literals issue.  Here's a set of two patches which need a
little polish, but I think demonstrate a better way to handle the
transition; and a start on some not-directly-related improvements to the
parser design.  Some rationales:

	- As I've been saying, I think *any* passing of data from the
parser back to the lexer to control its behaviour is asking for (at the
least) very confusing flow of control.

	- property/node names suck.  To cover the various existing
things in Apple/IBM firmwares, they have to allow all sorts of nasty
punctuation (e.g. +*?-) which could cause great trouble with expressions
later on.

	- therefore, I think I was thinking arse-backwards when I came
up with the lexer states for CELLDATA and MEMRESERVE.  Instead
recognizing sensible literals and sensible identifiers should be the
normal lexer behaviour, and recognizing the weird the prop/node names
should be the special lexer state.

	- I was always a bit dubious about the very-missible visual
difference between
		/memreserve/ 0x80000 0xf0000;
and
		/memreserve/ 0x80000-0xf0000;
Plus the "range" form doesn't seem to have been used by any in-kernel
dts files.  Therefore, rather than changing the range symbol, simply
drop support for the range form in the new version.

	- Rather than making lexer rules be narrow, so that only valid
symbols will be lexed, it's actually better to make the lexer rules
broad (not conflicting with other valid things, obviously), then verify
that the returned tokens are really valid further up the stack.  This
way we can generate a meaningful "bad symbol/identifier/name/literal"
message, instead of simply getting "syntax error" - or worse, splitting
the bogus token into multiple valid tokens which we manage to parse far
enough to get a thoroughly confusing state. (Imagine if a mistype like
<0xdeadgeef>, parsed as a 2-cell value, <0xdead> then <geef>, with geef
assumed to be a variable/identifier.  Or if <077877> was parsed as
octal 077 then 877 decimal.)


Some things that I know need polish in these patches:
	- Currently if we get badly formatted literals, we print an
error message with yyerror(), but parsing continues using I'm not sure
quite what crazy assumed value for the literal.
	- -Odts output is still v0.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
