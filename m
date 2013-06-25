Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB4B62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 09:47:00 +1000 (EST)
Date: Tue, 25 Jun 2013 18:46:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: BUG: no PCI/PCIe devices found in 85xx architecture
To: Stefani Seibold <stefani@seibold.net>
In-Reply-To: <1372185614.4726.12.camel@wall-e> (from stefani@seibold.net on
 Tue Jun 25 13:40:14 2013)
Message-ID: <1372203995.8183.26@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2013 01:40:14 PM, Stefani Seibold wrote:
> Hi,
>=20
> there is a bug in kernel 3.9 which the new fsl_pci platform driver. =20
> The
> pcibios_init in pci_32.c will be called before the platform driver =20
> probe
> will be invoked.
>=20
> The call order for a p2020 board with linux 3.9 is currently:
>=20
> fsl_pci_init
> pcibios_init
> fsl_pci_probe
> fsl_pci_probe
> fsl_pci_probe
>=20
> Therefore the PCI/PCIe bridge will be added after the PCI/PCIe busses
> was scanned for devices. So no PCI/PCIe devices are available.
>=20
> Everything works fine by reverting the fsl_pci.[ch] to the version in
> linux 3.4, because the PCI/PCIe bridges will be added in
> the ..._setup_arch() function, before the pcibios_init function is
> called.
>=20
> Any solution for this issue?

I can't reproduce this on p3041 -- pcibios_init gets called after =20
fsl_pci_probe, and its PCIe e1000 gets detected and used.

fsl_pci_probe should be called when of_platform_bus_probe is called, =20
which is in a machine_arch_initcall.  pcibios_init is a =20
subsys_initcall, which should happen later.

Which p2020 board are you using?  Could you check when it is calling =20
of_platform_bus_probe?

-Scott=
