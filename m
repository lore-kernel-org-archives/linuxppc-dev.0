Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:51:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070323235153.GG4459@localhost.localdomain>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
	<20070323033158.GG28006@localhost.localdomain>
	<20070323150517.GB6060@ld0162-tx32.am.freescale.net>
	<1174665793.32390.73.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174665793.32390.73.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 11:03:13AM -0500, Jon Loeliger wrote:
> On Fri, 2007-03-23 at 10:05, Scott Wood wrote:
> > On Fri, Mar 23, 2007 at 02:31:58PM +1100, David Gibson wrote:
> > > I'm not 100% comfortable with this patch; I'd like for dtc to have the
> > > facility to do more-or-less complete tree validation.
> > 
> > That'd be nice as long as it's optional; it should be possible to do a
> > low level dts->dtb transformation without the tool assuming that the
> > output is intended to be a final, valid tree with the specific bindings
> > that dtc knowns about (or even an OF-ish tree at all).
> > 
> > -Scott
> 
> So, how about adding a "--complete" or "--final"
> sort of flag an having it:
> 
>     - Enforce presence of /chosen
>     - Disallowing the proposed [ ? ? ? ? ] indicators
>     - Uh, other stricter checking...

I was thinking of having three basic levels of checking:

	- syntactic structure
Checks on the structure of the flat tree: duplicate property / node
names, invalid characters in names and other such basic errors.  This
would be on, and fatal by default.

	- semantic structure
Checks on the content of nodes: linux,phandle #a and #s properties
have the right size, reg properties match the corresponding #a and #s
nodes, properties which reference phandles contain a valid phandle,
properties supposed to contain strings actually do.  This would be on
by default.  It would be fatal by default when generating a dtb or asm
from dts, but not in the other direction.

	- kernel requirements
Checks this is a complete tree with all the bits that the kernel
needs: /chosen is present, /memory is present and valid, cpu nodes
have the required cache size information etc.  This would only be on
if requested.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
