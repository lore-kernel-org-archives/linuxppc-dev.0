Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Allow multipart property values 
In-Reply-To: Your message of "Wed, 07 Feb 2007 14:23:43 +1100."
	<20070207032343.GD23870@localhost.localdomain>
References: <20070207032343.GD23870@localhost.localdomain> 
Date: Wed, 07 Feb 2007 08:35:25 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HEntO-0006gi-0w@jdl.com>
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
> At present each property definition in a dts file must give as the
> value either a string ("abc..."), a bytestring ([12abcd...]) or a cell
> list (<1 2 3 ...>).  This patch allows a property value to be given as
> several of these, comma-separated.  The final property value is just
> the components appended together.  So a property could have a list of
> cells followed by a string, or a bytestring followed by some cells.
> Cells are always aligned, so if cells are given following a string or
> bytestring which is not a multiple of 4 bytes long, zero bytes are
> inserted to align the following cells.
> 
> The primary motivation for this feature, however, is to allow defining
> a property as a list of several strings.  This is what's needed for
> defining OF 'compatible' properties, and is less ugly and fiddly than
> using embedded \0s in the strings.

David,

I'd like a bit of clarification on the issue of null-padding.
I'm not sure how it is supposed to work for OF originally,
but I'm not sure the null-padding to mod 4 will be the same
(or usable) semantics.

In OF's original definition would "ab\0de" yield something
different than a similar "ab", [0], "de" with your proposal?
I could see that we might have:

	OF   : a b \0 d e
	Yours: a b \0 \0 \0 d e

Or does the OF spec say that it will also pad to mod 4?
Or do all strings always start on mod 4 address?

Thanks,
jdl
