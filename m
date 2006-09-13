Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc: allow PHBs anywhere in the
	device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200609130039.22193.arnd@arndb.de>
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
	<17671.12953.147098.637600@cargo.ozlabs.ibm.com>
	<200609130039.22193.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 11:46:27 +1000
Message-Id: <1158111987.3337.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For the cell blade, we have two bridge chips that are directly
> connected to one of the CPUs each and are in separate address spaces.
> Besides the PCI host bridges on them (between 1 and 3 per chip,
> depending on the model), there are other devices on each bridge chip
> that I would like to represent there as well. To make things
> worse, they are behind logical bridges on the chip itself, something
> like
> 
> /bridge@1/interrupt-controller
>          /plb5/pcie
>               /plb4/pci
>                    /ethernet
>                    /serial
> /bridge@2/plb5/pcie
>               /plb4/pci
> 
> each of axon, plb5, plb4 and the pci buses has their own ranges
> property to map addresses.
> While we could probably put all the phbs at the root, i'd much
> prefer having the real topology reflected in the device tree.

There's one more thing I think your patch isn't fixing and that will
need fixing, is pci_process_OF_bridge_ranges() which currently parses
the PHB's "ranges" property assuming that the addresses it gets for the
"parent" bus are system bus physical addresses. It needs instead to get
those translated all the way up the tree (which isn't hard btw).

As soon as I'm over this TG3 data corruption problem, I'll finally
finish setting up SIMICS here and will look into making that stuff work.

Ben.
