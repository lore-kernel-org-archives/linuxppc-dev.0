Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 565C5DDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 23:45:18 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ODjFXm025502
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:45:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ODjF0B213636
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:45:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ODjEYe001213
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:45:14 -0600
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 24 May 2007 08:44:20 -0500
Message-Id: <1180014260.3360.14.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 23:22 -0500, Kumar Gala wrote:
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

I think it's needed until the TSI driver switches to phylib.  Right now,
it assumes that a Marvell phy is used, which is what is present on the
Taiga MPC7448HPC2 board.  The Holly board uses the Broadcom phy and we
added the compatible code for that.

josh
