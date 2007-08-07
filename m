Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1456ADDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 22:15:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l77CFgD0026936
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 08:15:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77CFfrJ198298
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 06:15:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77CFfrH005764
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 06:15:41 -0600
Date: Tue, 7 Aug 2007 07:15:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070807071539.6dbb49a5@weaponx.rchland.ibm.com>
In-Reply-To: <20070807062231.GB8351@localhost.localdomain>
References: <20070807062231.GB8351@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 7 Aug 2007 16:22:31 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Based on BenH's earlier work, this is a new version of the EMAC driver
> for the built-in ethernet found on PowerPC 4xx embedded CPUs.  The
> same ASIC is also found in the Axon bridge chip.  This new version is
> designed to work in the arch/powerpc tree, using the device tree to
> probe the device, rather than the old and ugly arch/ppc OCP layer.
> 
> This driver is designed to sit alongside the old driver (it lies in
> drivers/net/ibm_emac and this one in drivers/net/ibm_newemac).  The
> old driver is left in place to support arch/ppc until arch/ppc itself
> reaches its final demise (not too long now, with luck).
> 
> This driver still has a number of things that could do with cleaning
> up, but I think they can be fixed up after merging.  Specifically:
> 	- Should be adjusted to properly use the dma mapping API.
> Axon needs this.
> 	- Probe logic needs reworking, in conjuction with the general
> probing code for of_platform devices.  The dependencies here between
> EMAC, MAL, ZMII etc. make this complicated.  At present, it usually
> works, because we initialize and register the sub-drivers before the
> EMAC driver itself, and (being in driver code) runs after the devices
> themselves have been instantiated from the device tree.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Hm.  Should this go through Jeff Garzik or Paul?  If it's the latter,
I'll pull this into my git tree soon.

josh
