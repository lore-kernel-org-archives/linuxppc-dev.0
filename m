Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (unknown [212.235.17.194])
	by ozlabs.org (Postfix) with SMTP id 8F9B1B6F11
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 23:40:35 +1100 (EST)
Message-ID: <4CADBD7B.3000506@extricom.com>
Date: Thu, 07 Oct 2010 14:30:51 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Xianghua Xiao <x.xiao@freescale.com>, ZHANG WEI <wei.zhang@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>, Tony Li <tony.li@freescale.com>,
	Linas Vepstas <linas@austin.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Freescale P2020 / 85xx PCIe and Advance Error Reporting (AER) service
	problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Penguins,

SHORT:
There is a BUG in the current code design / Freescale P2020/85xx PCIe design that prevent it from registering to the PCIe AER... or that I have missed something :) ..

LESS SHORT:
I am in the process of a Freescale P2020 based board bring up. P2020 is basically two 85xx processors and their peripherals share most features.

PCIe has a very extensive error reporting section and the Kernel already has a very nice looking Advanced Error Reporting driver.

I encounter difficulties trying to connect the P2020/85xx PCIe device to this AER service driver.

My technical findings follows:

 - pcie_portdrv_probe() will be called for every BRIDGE class PCI device. P2020 PCIe is a PCI-PCI BRIDGE class so no problem here. 
 - The code will continue to check that we have PCI_CAP_ID_EXP capability, which we have and continue to pcie_port_device_register().
 - Now ,the function pcie_port_device_register() will FAIL. It will fail because it will call assign_interrupt_mode(), return with PCIE_PORT_NO_IRQ, and giveup with a reasonable remark in the code
"/*
  * Don't use service devices that require interrupts if there is
  * no way to generate them.
  */"

So now the question is why calling assign_interrupt_mode() with the P2020 PCIe ROOT device return empty? Well...
 - First assign_interrupt_mode() will test for PCIE_PORT_MSIX_MODE. Freescale PCIe does not support this...
 - Second attampt is made to discover PCIE_PORT_MSI_MODE, which Freescale should support but the PCIe PCI_CAP_ID_MSI capability is published on the device side of the bridge and NOT on the PCIe ROOT device, which is the one probed and thus fails.
 - Last it attempts to look at "dev->pin" in order to set PCIE_PORT_INTx_MODE. On top of being the less recommended way (the old way), The Freescale PCIE ROOT device pin is not set anywhere.

Failing all those the probe fails and the AER service is not activated for the PCIE device.

QUESTION:
1. What am I missing?
2. Has anyone enabled the AER PCIe service for P2020/MPC85xx?
3. Should the PCIe ROOT end report MSI capabilities or should the device end report itself as bridge ???

-- Liberty
