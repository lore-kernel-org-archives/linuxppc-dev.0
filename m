Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 11:19:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH] Remove overreaching semantic tests.
Message-ID: <20070514011915.GH6517@localhost.localdomain>
References: <20070511175553.GA14692@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070511175553.GA14692@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 12:55:54PM -0500, Scott Wood wrote:
> Now that there are more usage models than "complete device tree in the
> DTS" and "minimally device-tree aware u-boot that still needs zeroed out
> properties to fill in", many of the checks that dtc performs are no
> longer appropriate, since the nodes and properties in question can be
> added at runtime.
> 
> Note that -f is *not* an alternative, as that suppresses all checks.  I
> still want it to check for things that are present but wrong; I just
> don't want it complaining about things that aren't there at all.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> I wouldn't be opposed to keeping these tests around if there were a
> command line option that cleanly separates the errors/warnings into
> classes such as structural, semantic-missing, semantic-broken, etc.

Exactly - which is why I really don't want to simply tear out this
checking code.  I've never gotten around to reworking the
error/warning system so it can sensibly divide things into such
classes, and keep detecting further warnings after picking up some
non-fatal ones and so forth.

I'd much prefer you just disable these tests for now, either by
commenting code out, or removing calls to checking functions.  That
will make it easier to optionally reinstate later.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
