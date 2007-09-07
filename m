Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:21:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070907002136.GC26079@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<3acb0846724373a8f9edcf4650cc5455@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3acb0846724373a8f9edcf4650cc5455@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 03:36:30PM +0200, Segher Boessenkool wrote:
[snip]
> >> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> >> PowerPC system bus.  So, it can not be mentioned in the "ranges"
> >> property, but the PHB registers used to access it should be shown
> >> in the "reg" property.  It could be a simple linear window (it
> >> sounds like it is here?), but it could for example also be implemented
> >> via an address/data register pair.
> > Yes, it is a simple linear address window. I'll remove its address 
> > range
> > from the reg property.
> 
> No, please remove it from the "ranges" property, instead.

No, don't.  Removing it from reg is just fine.

> >> The order of the "reg" entries depends on the exact model of PCI
> >> bridge, so a device binding for it has to be written.
> > Only the Pegasos I and the AmigaOne use this PCI bridge. I guess it 
> > should
> > be enough to check for the board type, but a compatible property 
> > doesn't
> > hurt.
> 
> Please always use "compatible" to probe any devices.

Do do that, though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
