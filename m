Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D18E0DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 12:48:42 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4P398bE244696
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 13:09:08 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4P2qCIW157216
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 12:52:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4P2mdjc028517
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 12:48:40 +1000
Date: Fri, 25 May 2007 12:04:57 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070525020457.GB13575@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<1180014348.3360.17.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180014348.3360.17.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 24, 2007 at 08:45:48AM -0500, Josh Boyer wrote:
> On Thu, 2007-05-24 at 14:16 +1000, David Gibson wrote:
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
> 
> You'll need to fixup the mpc7448hpc2 board's DTS with the same change
> then, as it shares the same bridge and ethernet code.

Ah, yes.  Done.

> > 	- Second, the PHYs give only "bcm54xx" as a compatible
> > property.  This is unfortunate, because there are many bcm54xx PHY
> > models, and they have differences which can matter.  We add a more
> > precise compatible string, giving the precise PHY model (bcm5461A in
> > this case).
> 
> This part is fine with me.
> 
> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
