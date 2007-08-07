Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 16:22:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Device tree aware EMAC driver
Message-ID: <20070807062231.GB8351@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on BenH's earlier work, this is a new version of the EMAC driver
for the built-in ethernet found on PowerPC 4xx embedded CPUs.  The
same ASIC is also found in the Axon bridge chip.  This new version is
designed to work in the arch/powerpc tree, using the device tree to
probe the device, rather than the old and ugly arch/ppc OCP layer.

This driver is designed to sit alongside the old driver (it lies in
drivers/net/ibm_emac and this one in drivers/net/ibm_newemac).  The
old driver is left in place to support arch/ppc until arch/ppc itself
reaches its final demise (not too long now, with luck).

This driver still has a number of things that could do with cleaning
up, but I think they can be fixed up after merging.  Specifically:
	- Should be adjusted to properly use the dma mapping API.
Axon needs this.
	- Probe logic needs reworking, in conjuction with the general
probing code for of_platform devices.  The dependencies here between
EMAC, MAL, ZMII etc. make this complicated.  At present, it usually
works, because we initialize and register the sub-drivers before the
EMAC driver itself, and (being in driver code) runs after the devices
themselves have been instantiated from the device tree.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Paul, I discussed with BenH, and although there are some problems with
the driver still, we think it's good enough to merge in 2.6.24, the
warts can be fixed up later.

Too big for the list, patch is at:
	http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070807.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
