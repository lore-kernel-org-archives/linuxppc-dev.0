Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABAFB2C033A
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2012 17:18:04 +1000 (EST)
Subject: mpc8xxx PCIe hotplug needs fixing, some clues ..
To: galak@kernel.crashing.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org
Message-ID: <OFDEF2A72A.01F68496-ONC1257A41.0025B7CE-C1257A41.0028192F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 20 Jul 2012 09:17:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Guys

I see that you have been hacking Freescale PCI before so I send this to you(and the list)

We are using PCIe(as RC) on P2010(basically a mpc85xx) and have PCI device that
started from user space (needs advance clock conf) so when linux boots there is
no device at all.
Trying to "hotplug" the device after it is enabled fails, no amount of recan/remove using
either fake or real hotplug makes a difference.

I found the cause eventually but I can't fix it properly as I known almost nothing about PCI.
Cause:
indirect_pci.c:indirect_read_config() tests for if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
and returns  PCIBIOS_DEVICE_NOT_FOUND

PPC_INDIRECT_TYPE_NO_PCIE_LINK get set by fsl_pci.c (look for fsl_pcie_check_link) but is never cleared.
Clearing it as appropriate makes a small difference. If you
remove the RC and do a few of rescan's then the device appears.

Hacking some more, like so:

int fsl_pcie_check_link(struct pci_controller *hose)
{
	u32 val;

	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
	hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
	if (val < PCIE_LTSSM_L0)
		return 1;
	hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
	return 0;
}
and then using it carefully(it is easy to make linux hang) in indirect_read_config():
indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
		     int len, u32 *val)
{
	struct pci_controller *hose = pci_bus_to_host(bus);
	volatile void __iomem *cfg_data;
	u8 cfg_type = 0;
	u32 bus_no, reg;

	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
		if (bus->number != hose->first_busno ||
		    devfn != 0) {
			fsl_pcie_check_link(hose);
			return PCIBIOS_DEVICE_NOT_FOUND;
		}
	}

Now it works, just one rescan and the device appears!
This is a hack, I don't known what other trouble it can cause, I hope you can
sort this out.

BTW,

  I see that the controller has some support for hot plug, by setting a bit or two in
  PEX_CONFIG, out_be32(&pci->pex_config, 0x02), I see slot caps in lspci:
	Capabilities: [4c] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
			Slot #0, PowerLimit 15.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-

That would be good to enable I think(real hotplug needs them), don't know if this bit is
common for all PCIe controllers from Freescale?

 Jocke
