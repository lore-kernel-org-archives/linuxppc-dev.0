Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 16:21:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Device Tree updates for xilinx.
Message-ID: <20071217052101.GC3477@localhost.localdomain>
References: <20071204012811.AD70CEF004D@mail134-dub.bigfish.com>
	<20071213233945.E8FFAA6007C@mail180-sin.bigfish.com>
	<20071216070404.GK21311@localhost.localdomain>
	<20071217045726.DD1881298046@mail127-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071217045726.DD1881298046@mail127-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 16, 2007 at 08:58:18PM -0800, Stephen Neuendorffer wrote:
> 
> Since there don't seem to be any examples of this in the tree: do
> you have a format preference?  For the rest of the compatible lists,
> I'm using something like: xlnx,ipname-version.  So for the
> microblaze, I'd prefer something like:
> 
> xlnx,microblaze-6.00.b

Sounds reasonable.

> For the powerpc, either ibm,ppc405 or ibm.ppc-405 would seem to be
> more in character than PowerPC,405.

Well, we could list both forms, but PowerPC,405 should be included
since it's an established name.  There's some history behind this:
before the generic names convention, the node name was used to encode
the most specific register interface for the device, and "compatible"
was used to describe any other interfaces it was also compatible with.

With the generic names convention, the name came to represent the
general type of device, and "compatible" alone was used to describe
the programming interface(s).  In Apple and IBM device trees, while
most things reflect the generic names convention, it seems the cpu
nodes were left using the old convention - which is why that approach
was copied and is currently used in all the dts files.  So when
converting nodes to the generic names convention, the old content of
the node name should go into "compatible" verbatim as the first entry.

In practice of course, I don't think anything looks at either the name
or the compatible property for cpu nodes (nor do I think they should)
- they'll just use the PVR.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
