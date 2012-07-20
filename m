Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5AEF72C039C
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2012 04:53:14 +1000 (EST)
Subject: Re: mpc8xxx PCIe hotplug needs fixing, some clues ..
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <OFDEF2A72A.01F68496-ONC1257A41.0025B7CE-C1257A41.0028192F@transmode.se>
Date: Fri, 20 Jul 2012 13:53:10 -0500
Message-Id: <EC6BFBB7-DF3B-402A-ACB6-51546C1B6CC9@kernel.crashing.org>
References: <OFDEF2A72A.01F68496-ONC1257A41.0025B7CE-C1257A41.0028192F@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 2:17 AM, Joakim Tjernlund wrote:

>=20
> Hi Guys
>=20
> I see that you have been hacking Freescale PCI before so I send this =
to you(and the list)
>=20
> We are using PCIe(as RC) on P2010(basically a mpc85xx) and have PCI =
device that
> started from user space (needs advance clock conf) so when linux boots =
there is
> no device at all.
> Trying to "hotplug" the device after it is enabled fails, no amount of =
recan/remove using
> either fake or real hotplug makes a difference.
>=20
> I found the cause eventually but I can't fix it properly as I known =
almost nothing about PCI.
> Cause:
> indirect_pci.c:indirect_read_config() tests for if =
(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
> and returns  PCIBIOS_DEVICE_NOT_FOUND
>=20
> PPC_INDIRECT_TYPE_NO_PCIE_LINK get set by fsl_pci.c (look for =
fsl_pcie_check_link) but is never cleared.
> Clearing it as appropriate makes a small difference. If you
> remove the RC and do a few of rescan's then the device appears.
>=20
> Hacking some more, like so:
>=20
> int fsl_pcie_check_link(struct pci_controller *hose)
> {
> 	u32 val;
>=20
> 	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> 	hose->indirect_type |=3D PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> 	if (val < PCIE_LTSSM_L0)
> 		return 1;
> 	hose->indirect_type &=3D ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> 	return 0;
> }
> and then using it carefully(it is easy to make linux hang) in =
indirect_read_config():
> indirect_read_config(struct pci_bus *bus, unsigned int devfn, int =
offset,
> 		     int len, u32 *val)
> {
> 	struct pci_controller *hose =3D pci_bus_to_host(bus);
> 	volatile void __iomem *cfg_data;
> 	u8 cfg_type =3D 0;
> 	u32 bus_no, reg;
>=20
> 	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> 		if (bus->number !=3D hose->first_busno ||
> 		    devfn !=3D 0) {
> 			fsl_pcie_check_link(hose);
> 			return PCIBIOS_DEVICE_NOT_FOUND;
> 		}
> 	}
>=20
> Now it works, just one rescan and the device appears!
> This is a hack, I don't known what other trouble it can cause, I hope =
you can
> sort this out.

How are you forcing the re-scan?  We can see if we can add a re-check of =
the link state in that flow somewhere.

Can you do a dump_stack() or something to get a call chain?

- k=
