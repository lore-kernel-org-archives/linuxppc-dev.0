Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Abolish _typed() variants, add _cell() variants 
In-Reply-To: Your message of "Tue, 20 Nov 2007 13:35:46 +1100."
	<20071120023546.GA4356@localhost.localdomain>
References: <20071120023546.GA4356@localhost.localdomain> 
Date: Tue, 20 Nov 2007 09:06:46 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IuUgY-00021y-D2@jdl.com>
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
> In a number of places through libfdt and its tests, we have *_typed()
> macro variants on functions which use gcc's typeof and statement
> expression extensions to allow passing literals where the underlying
> function takes a buffer and size.
> 
> These seemed like a good idea at the time, but in fact they have some
> problems.  They use typeof and statement expressions, extensions I'd
> prefer to avoid for portability.  Plus, they have potential gotchas -
> although they'll deal with the size of the thing passed, they won't
> deal with other representation issues (like endianness) and results
> could be very strange if the type of the expression passed isn't what
> you think it is.
> 
> In fact, the only users of these _typed() macros were when the value
> passed is a single cell (32-bit integer).  Therefore, this patch
> removes all these _typed() macros and replaces them with explicit
> _cell() variants which handle a single 32-bit integer, and which also
> perform endian convesions as appropriate.
> 
> With this in place, it now becomes easy to use standardized big-endian
> representation for integer valued properties in the testcases,
> regardless of the platform we're running on.  We therefore do that,
> which has the additional advantage that all the example trees created
> during a test run are now byte-for-byte identical regardless of
> platform.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
