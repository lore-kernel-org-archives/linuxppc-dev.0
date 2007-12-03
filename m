Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Dec 2007 11:48:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx EDK BSP generation of device trees for microblaze and
	PowerPC
Message-ID: <20071203004851.GA26919@localhost.localdomain>
References: <20071120194411.E183B100060@mail17-sin.bigfish.com>
	<20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
	<fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
	<20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
Cc: Jon Loeliger <jdl@jdl.com>, microblaze-uclinux@itee.uq.edu.au,
	Michal Simek <simekm2@fel.cvut.cz>, linuxppc-dev@ozlabs.org,
	git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 01:44:02PM -0800, Stephen Neuendorffer wrote:
[snip]
> > >                                  reg = < 81c00000 40 >;
> > 
> > If these registers are addressable, then the parent needs a 
> > 'ranges' property.
> 
> I thought ranges weren't necessary in a 1:1 mapping?

You were misinformed.  If there is no ranges property, the child nodes
are not directly addressable from the bus above.  If the ranges
property is present, but empty, then there is an identity mapping
between parent and child bus addresses.  So you probably want to add
	ranges;
to the parent node.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
