Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 Feb 2007 03:40:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [dtc] Allow multipart property values
Message-ID: <20070207164043.GA29556@localhost.localdomain>
References: <20070207032343.GD23870@localhost.localdomain>
	<E1HEntO-0006gi-0w@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1HEntO-0006gi-0w@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 08:35:25AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > At present each property definition in a dts file must give as the
> > value either a string ("abc..."), a bytestring ([12abcd...]) or a cell
> > list (<1 2 3 ...>).  This patch allows a property value to be given as
> > several of these, comma-separated.  The final property value is just
> > the components appended together.  So a property could have a list of
> > cells followed by a string, or a bytestring followed by some cells.
> > Cells are always aligned, so if cells are given following a string or
> > bytestring which is not a multiple of 4 bytes long, zero bytes are
> > inserted to align the following cells.
> > 
> > The primary motivation for this feature, however, is to allow defining
> > a property as a list of several strings.  This is what's needed for
> > defining OF 'compatible' properties, and is less ugly and fiddly than
> > using embedded \0s in the strings.
> 
> David,
> 
> I'd like a bit of clarification on the issue of null-padding.
> I'm not sure how it is supposed to work for OF originally,

I don't see how OF is relevant - the notation used for property values
in dts is my own invention, not an OF specification.

> but I'm not sure the null-padding to mod 4 will be the same
> (or usable) semantics.
> 
> In OF's original definition would "ab\0de" yield something
> different than a similar "ab", [0], "de" with your proposal?
> I could see that we might have:
> 
> 	OF   : a b \0 d e
> 	Yours: a b \0 \0 \0 d e
> 
> Or does the OF spec say that it will also pad to mod 4?
> Or do all strings always start on mod 4 address?

No, it's only the "cell" format that's padded for alignment.  Actually
the example you give (with [0]) is invalid in any case, since
bytestring notation must have a multiple of 2 digits.

	"ab", [00], "de"
is equivalent to
	"ab\0\0de"
or to
	[61620000646500]
There are two zero bytes in the middle, the first is the terminator
for "ab", the second is the explicit [00].

With cell notation, however, alignement padding gives us:

	"abc", <deadbeef>
is equivalent to
	[61626300deadbeef]

but
	"a", <deadbeef>
is equivalent to
	[61000000deadbeef]

I can't think of any good reason you'd want to define a property with
a cell portion following a non-cell portion, and doing so is probably
a bad idea.  However, it falls naturally out of the most obvious way
to allow list-of-strings notation for compatible properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
