Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4704B6EEB
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 11:21:51 +1100 (EST)
Subject: Re: Freescale P2020 / 85xx PCIe and Advance Error Reporting (AER)
	service problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eran Liberty <liberty@extricom.com>
In-Reply-To: <4CADBD7B.3000506@extricom.com>
References: <4CADBD7B.3000506@extricom.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 11:19:23 +1100
Message-ID: <1286756363.2463.517.camel@pasglop>
Mime-Version: 1.0
Cc: Xianghua Xiao <x.xiao@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-pci@vger.kernel.org, Tony Li <tony.li@freescale.com>,
	Linas Vepstas <linas@austin.ibm.com>, ZHANG WEI <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  - pcie_portdrv_probe() will be called for every BRIDGE class PCI device. P2020 PCIe is a PCI-PCI BRIDGE class so no problem here. 
>  - The code will continue to check that we have PCI_CAP_ID_EXP capability, which we have and continue to pcie_port_device_register().
>  - Now ,the function pcie_port_device_register() will FAIL. It will fail because it will call assign_interrupt_mode(), return with PCIE_PORT_NO_IRQ, and giveup with a reasonable remark in the code
> "/*
>   * Don't use service devices that require interrupts if there is
>   * no way to generate them.
>   */"
> 
> So now the question is why calling assign_interrupt_mode() with the P2020 PCIe ROOT device return empty? Well...
>  - First assign_interrupt_mode() will test for PCIE_PORT_MSIX_MODE. Freescale PCIe does not support this...
>  - Second attampt is made to discover PCIE_PORT_MSI_MODE, which Freescale should support but the PCIe PCI_CAP_ID_MSI capability is published on the device side of the bridge and NOT on the PCIe ROOT device, which is the one probed and thus fails.
>  - Last it attempts to look at "dev->pin" in order to set PCIE_PORT_INTx_MODE. On top of being the less recommended way (the old way), The Freescale PCIE ROOT device pin is not set anywhere.
> 
> Failing all those the probe fails and the AER service is not activated for the PCIE device.

So the question boils down to how does the bridge generate the AER
interrupts. This should be documented in the FSL docs no ? The MSI in
the child/device should be unrelated (it's your device MSI) no ? So the
question is where's the missing interrupt.

If it's a SoC interrupt, coming from the device-tree, then perhaps the
generic AER code should be extended to recognize those.

Cheers,
Ben.
