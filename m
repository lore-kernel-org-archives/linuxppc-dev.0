Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc: allow PHBs anywhere in the device
	tree
Date: Wed, 13 Sep 2006 00:39:21 +0200
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
	<17671.12953.147098.637600@cargo.ozlabs.ibm.com>
In-Reply-To: <17671.12953.147098.637600@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <200609130039.22193.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 September 2006 00:20, Paul Mackerras wrote:
> Ummm, how do you think we've managed on pSeries all this time?
>=20
> I could understand this if you said you needed to represent multiple
> north bridges, though that would be a rather peculiar system
> topology. =A0Having multiple PCI domains hanging off a single north
> bridge can be represented perfectly well with the host bridges being
> children of the root, because the root node represents the address
> space directly accessible to the processor(s), and it is the north
> bridge that implements that address space.
>=20
> What specifically do you want this for?

=46or the cell blade, we have two bridge chips that are directly
connected to one of the CPUs each and are in separate address spaces.
Besides the PCI host bridges on them (between 1 and 3 per chip,
depending on the model), there are other devices on each bridge chip
that I would like to represent there as well. To make things
worse, they are behind logical bridges on the chip itself, something
like

/bridge@1/interrupt-controller
         /plb5/pcie
              /plb4/pci
                   /ethernet
                   /serial
/bridge@2/plb5/pcie
              /plb4/pci

each of axon, plb5, plb4 and the pci buses has their own ranges
property to map addresses.
While we could probably put all the phbs at the root, i'd much
prefer having the real topology reflected in the device tree.

	Arnd <><
