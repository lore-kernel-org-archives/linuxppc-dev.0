Return-Path: <dgibson@ozlabs.org>
Date: Wed, 2 May 2007 11:19:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Message-ID: <20070502011957.GA12876@localhost.localdomain>
References: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 02, 2007 at 02:34:45AM +0200, Segher Boessenkool wrote:
> >> "name" = "memory-controller"
> >> "compatible" = "fsl,85xx-memory-controller"
> >> (or a more specific 85xx model if the controller
> >> isn't identical across those chips)
> >> No "device_type" at all, since there is no binding
> >> for this kind of device.
> >
> > Is "no device_type" really the approach that should be
> > taken?
> 
> Yes.
> 
> > booting-without-of.txt currently reads:
> >
> >    Every node which actually represents an actual device
> >    (that is, a node which isn't only a virtual "container"
> >    for more nodes, like "/cpus" is) is also required to
> >    have a "device_type" property indicating the type of
> >    node
> 
> That is wrong, IMNSHO.

I tend to agree. Device drivers should generally be searching on the
"compatible" property, not "device_type".  Defining new device_type
values isn't really of any use to the kernel, so we should just avoid
it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
