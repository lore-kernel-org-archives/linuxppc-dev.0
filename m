Return-Path: <dgibson@ozlabs.org>
Date: Thu, 24 May 2007 15:59:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070524055909.GG20078@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 23, 2007 at 11:22:34PM -0500, Kumar Gala wrote:
> 
> On May 23, 2007, at 11:16 PM, David Gibson wrote:
> 
> > This patch fixes some problems with the way the Ethernet PHYs are
> > represented in the device tree for the Holly board.  This means
> > changes to the dts itself, and to the code with instantiates the
> > tsi108 ethernet platform devices based on the device tree.
> >
> > 	- First, and most importantly, the PHYs are given with an
> > identical 'reg' property.  This reg currently encodes the accessible
> > register used to initiate mdio interaction with the PHYs, rather than
> > a meaningful address on the parent bus (mdio in this case), which is
> > incorrect.  Instead we give the address of these registers as 'reg' in
> > the mdio node itself, and encode the ID of each phy in their 'reg'
> > propertys.  The PHY's unit name addresses are updated to match.
> > 	- Second, the PHYs give only "bcm54xx" as a compatible
> > property.  This is unfortunate, because there are many bcm54xx PHY
> > models, and they have differences which can matter.  We add a more
> > precise compatible string, giving the precise PHY model (bcm5461A in
> > this case).
> 
> Is the compatible really need here?  We are able to provide and bind  
> drivers based on MII_PHYSID1/2.  I don't see what putting the  
> compatible proper gets us.

That's a good point (except that having a node without compatible is
kind of odd).  At the moment the code which instantiates the platform
device looks at compatible to enable a workaround.  But actually that
workaround is holly specific, rather than related to the PHY model,
and so should be encoded differently.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
