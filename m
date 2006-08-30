Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81238679E2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 09:03:38 +1000 (EST)
Subject: Re: PCIe enhanced configuration mechanism support on ppc arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <7cc604637892c0a00a5e3e38192494d7@bga.com>
References: <7cc604637892c0a00a5e3e38192494d7@bga.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 09:03:13 +1000
Message-Id: <1156978993.12526.97.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-30 at 11:30 -0500, Milton Miller wrote:
> On Fri Aug 18 05:01:48 EST 2006, Shawn Jin wrote:
> > I'm trying to find out if the current PCI subsystem supports the PCIe
> > enhanced configuration mechanism, in particular, on the ppc/powerpc
> > arch, which is basically a MMIO access with the address containing all
> > bus, device, function, and offset info.
> 
> If what you are really trying to find is the 4k extended config space,
> then there are some platforms that support that on some slots.
> 
> If you are trying to find the mmio address for your adapter, then the
> answer is I am not aware of any PowerPC platforms that provide that,
> although I am not familiar with the embedded processor platforms nor
> the pci express Apple boxes.
> 
> > Could someone here give an authoritative answer? Or point me to
> > somewhere I can look for it by myself, such as which file or directory
> > in the kernel tree. I searched at arch/ppc/kernel,
> > arch/powerpc/kernel, and drivers/pci but couldn't find an answer. :(
> 
> The config access support is in arch/powerpc/kernel/rtas_pci.c,
> the setting of pci_ext_config_space is at arch/powerpc/kernel/pci_dn.c.

Actually, that only sets the variable used by the RTAS PCI accessors.
Other platforms might do differently. The PCI probe code uses the
generic pci_cfg_space_size() function to determine wether extended
config space is supported for a given device.

An example of platform not using RTAS and that does support extended
config space is the PCI Express link out of the U4 northbridge on
PowerMac (though not the other PCIe slots connected to the HT<->PCIe
tunnel, at least not for now).

It's basically just a matter of having your low level config access
routines supporting those >=256 offsets. The generic code tests that by
doing a dummy access and checks for an error return.

Ben.
