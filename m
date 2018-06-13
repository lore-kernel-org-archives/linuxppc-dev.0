Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415RyT3VK0zDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:13:20 +1000 (AEST)
Date: Wed, 13 Jun 2018 08:13:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patchV2 2/2] pci/shpchp: no claim on pcie port device
Message-ID: <20180613131317.GA201807@bhelgaas-glaptop.roam.corp.google.com>
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
 <1528871397-17917-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528871397-17917-3-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 02:29:57PM +0800, Pingfan Liu wrote:
> The Linux Device Driver Model allows a physical device to be handled
> by only a single driver. But at present, both shpchp and portdrv_pci
> claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset when the drivers are
> loaded. This causes a few problems, one is the wrong shutdown seq of
> devices, owing to the broken devices_kset. This patch keeps shpchp away
> from pcie port device, using the extra matching method.

As Christoph pointed out, something seems wrong if we add to
devices_kset even when the probe fails.  We will call shpc_probe() for
the device below, but there's no SHPC capability, so the probe should
fail when shpc_init() fails.

I do think the current structure where portdrv and shpchp are both
"drivers" that claim bridges is broken.  This has caused problems
before, e.g., some PCIe switches have performance counters, and a
driver for those switches ought to be able to claim the device and use
the counters, but portdrv is in the way.

I think it would be better if portdrv (and maybe shpchp; not sure
about that) were integrated into the PCIe core and did not register as
a driver.  But this is a big project, far beyond the scope of this
current issue.

> Note:
> I hit this bug on a Power9 machine, when "kexec -e", and see a ata-disk
> behind a bridge can not write back buffer in flight due to the former
> shutdown of the bridge which clears the BusMaster bit.
> 
> the device involved:
> 0004:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         NUMA node: 0
>         Bus: primary=00, secondary=01, subordinate=12, sec-latency=0
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: 80000000-ffefffff
>         Prefetchable memory behind bridge: 0006024000000000-0006027f7fffffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [48] Express (v2) Root Port (Slot-), MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 256 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd+
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
>                          EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP+ FCP- CmpltTO+ CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC+ UnsupReq- ACSViol-
>                 UESvrt: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
>         Capabilities: [148 v1] #19
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/pci/hotplug/shpchp_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index 1f0f969..85b4665 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -336,6 +336,18 @@ static void shpc_remove(struct pci_dev *dev)
>  	kfree(ctrl);
>  }
>  
> +static int shpc_extra_match(struct pci_dev *pdev)
> +{
> +	/* do not claim pcie port device */
> +	if (pci_is_pcie(pdev) &&
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM ||
> +	     pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  static const struct pci_device_id shpcd_pci_tbl[] = {
>  	{PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0)},
>  	{ /* end: all zeroes */ }
> @@ -345,6 +357,7 @@ MODULE_DEVICE_TABLE(pci, shpcd_pci_tbl);
>  static struct pci_driver shpc_driver = {
>  	.name =		SHPC_MODULE_NAME,
>  	.id_table =	shpcd_pci_tbl,
> +	.extra_match =	shpc_extra_match,
>  	.probe =	shpc_probe,
>  	.remove =	shpc_remove,
>  };
> -- 
> 2.7.4
> 
