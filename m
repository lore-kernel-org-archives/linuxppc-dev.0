Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Feb 2007 14:47:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: libfdt: a fix but still broken
Message-ID: <20070223034734.GA18698@localhost.localdomain>
References: <45DD9A41.7060900@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DD9A41.7060900@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
> Hi Dave,
> 
> I have good news and bad news. ;-)  The good news is that the 
> incompatibility between libfdt and jdl's dtc is that libfdt has the name 
> offset and the length of the name switched.  booting_without_of.txt says 
> the length comes first, so libfdt is in the wrong.

Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
came from: I was looking at flat_dt.h from dtc, which also gets this
wrong (but the declaration in question is unused).  Of course, I also
wrote flat_dt.h ...

> The bad news is that, when I fix this, nearly all of the tests fail (but 
> they fail the same way for both tree.S and jdl's dtc).  I have not 
> started on that layer of the onion yet.

Found it, there was a direct use of the position of the length in
_fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
along with some other small fixes which I found while tracking this
one down.

Oh, incidentally, I applied your patch by eye rather than with
patch(1), which was handy, because it appears to have been whitespace
damaged.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
