Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Feb 2007 13:25:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Message-ID: <20070220022538.GH17818@localhost.localdomain>
References: <45D7A914.4040000@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D7A914.4040000@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
> platforms which have entry points in the vector table.  This implements
> SMP entry via the system reset vector.

I really don't like having always-included code take over the absolute
start of the zImage's address space.  The whole idea in my entry
cleanup patch is that the platform code gets control of the "head.S"
area, so we can potentially support platforms with conflicting
hard-wired requirements for things at specific offsets.

I think this belongs in a ps3.o, which will define _zimage_start to be
identical to the reset vector.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
