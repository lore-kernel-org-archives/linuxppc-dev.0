Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<1171488643.20192.177.camel@localhost.localdomain>
	<7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 11:53:02 +1100
Message-Id: <1171500782.20192.204.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Having it set to 0 provides the necessary definition so that the "right
> > hand" members of an interrupt map don't need a unit address in their
> > unit interrupt specifier.
> 
> And a missing #address-cells property means 0 for the
> purpose of interrupt mapping.  Here, have some quotes
> from the spec:
> 
> 
> > For nodes that represent devices, the number of cells to represent a 
> > unit interrupt specifier  is the  sum of the "#address-cells"  and 
> > "#interrupt-cells"  properties; for nodes that do  not represent 
> > devices, there is no relevant "#address-cells"  value, so that the 
> > number of cells  is solely determined by the "#interrupt-cells" value. 
> >  The latter case exists due to the nature of representing interrupt 
> > mapping outside the context of the normal device tree.
> 
> 
> > Note that the "open-pic" node does not have a "#address-cells" 
> > property, so that  the number of cells for the parent unit interrupt 
> > specifiers is 2 (which is the value of its "#interrupt-cells" 
> > property).
> 
> 
> > if present( "#address-cells", parent-node )
> > 	#cells = valueof( "#address-cells", parent-node )
> > else #cells = 0   then

Yes, "missing" is equivalent to 0, but the common practice has always
been to specify it explicitely. Check existing Apple and IBM
device-trees for example.

Ben.
