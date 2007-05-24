Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A4F3DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 23:46:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ODkh6t000525
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:46:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ODkhwu209068
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:46:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ODkgIB026383
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:46:42 -0600
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070524041625.GD20078@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 May 2007 08:45:48 -0500
Message-Id: <1180014348.3360.17.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
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

On Thu, 2007-05-24 at 14:16 +1000, David Gibson wrote:
> This patch fixes some problems with the way the Ethernet PHYs are
> represented in the device tree for the Holly board.  This means
> changes to the dts itself, and to the code with instantiates the
> tsi108 ethernet platform devices based on the device tree.
> 
> 	- First, and most importantly, the PHYs are given with an
> identical 'reg' property.  This reg currently encodes the accessible
> register used to initiate mdio interaction with the PHYs, rather than
> a meaningful address on the parent bus (mdio in this case), which is
> incorrect.  Instead we give the address of these registers as 'reg' in
> the mdio node itself, and encode the ID of each phy in their 'reg'
> propertys.  The PHY's unit name addresses are updated to match.

You'll need to fixup the mpc7448hpc2 board's DTS with the same change
then, as it shares the same bridge and ethernet code.

> 	- Second, the PHYs give only "bcm54xx" as a compatible
> property.  This is unfortunate, because there are many bcm54xx PHY
> models, and they have differences which can matter.  We add a more
> precise compatible string, giving the precise PHY model (bcm5461A in
> this case).

This part is fine with me.

josh
