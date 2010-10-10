Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (unknown [212.235.17.194])
	by ozlabs.org (Postfix) with SMTP id D22D2B6F11
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Oct 2010 21:06:09 +1100 (EST)
Message-ID: <4CB18F44.6040003@extricom.com>
Date: Sun, 10 Oct 2010 12:02:44 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Freescale P2020 / 85xx PCIe and Advance Error Reporting (AER)
	service problem
References: <4CADBD7B.3000506@extricom.com>
	<948C4143-91C1-45AD-9E0A-82E3F394B181@kernel.crashing.org>
In-Reply-To: <948C4143-91C1-45AD-9E0A-82E3F394B181@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Oct 7, 2010, at 7:30 AM, Eran Liberty wrote:
>
>   
>> Dear Penguins,
>>
>> SHORT:
>> There is a BUG in the current code design / Freescale P2020/85xx PCIe design that prevent it from registering to the PCIe AER... or that I have missed something :) ..
>>
>> LESS SHORT:
>> I am in the process of a Freescale P2020 based board bring up. P2020 is basically two 85xx processors and their peripherals share most features.
>>
>> PCIe has a very extensive error reporting section and the Kernel already has a very nice looking Advanced Error Reporting driver.
>>
>> I encounter difficulties trying to connect the P2020/85xx PCIe device to this AER service driver.
>>
>> My technical findings follows:
>>
>> - pcie_portdrv_probe() will be called for every BRIDGE class PCI device. P2020 PCIe is a PCI-PCI BRIDGE class so no problem here. - The code will continue to check that we have PCI_CAP_ID_EXP capability, which we have and continue to pcie_port_device_register().
>> - Now ,the function pcie_port_device_register() will FAIL. It will fail because it will call assign_interrupt_mode(), return with PCIE_PORT_NO_IRQ, and giveup with a reasonable remark in the code
>> "/*
>> * Don't use service devices that require interrupts if there is
>> * no way to generate them.
>> */"
>>
>> So now the question is why calling assign_interrupt_mode() with the P2020 PCIe ROOT device return empty? Well...
>> - First assign_interrupt_mode() will test for PCIE_PORT_MSIX_MODE. Freescale PCIe does not support this...
>> - Second attampt is made to discover PCIE_PORT_MSI_MODE, which Freescale should support but the PCIe PCI_CAP_ID_MSI capability is published on the device side of the bridge and NOT on the PCIe ROOT device, which is the one probed and thus fails.
>> - Last it attempts to look at "dev->pin" in order to set PCIE_PORT_INTx_MODE. On top of being the less recommended way (the old way), The Freescale PCIE ROOT device pin is not set anywhere.
>>
>> Failing all those the probe fails and the AER service is not activated for the PCIE device.
>>
>> QUESTION:
>> 1. What am I missing?
>> 2. Has anyone enabled the AER PCIe service for P2020/MPC85xx?
>> 3. Should the PCIe ROOT end report MSI capabilities or should the device end report itself as bridge ???
>>
>> -- Liberty
>>     
>
> Do you have some code that enables AER on P2020.  If so it might be easier to see what's going on.
>
>
>   
> - k
>
>
The code that enables the AER is the problem. The kernel fails to probe 
my devices into the AER sevice. I can brutally hack my kernel to 
register the AER service. I copy the dev->irq and dev->pin from the 
child device to the bridge device. This will get the bridge device 
registered BUT it is not working and this hack is surly not a solution.

Here is a snap shot of my un-hacked devices, hopefully it will clarify 
the situation:

~ # ls -la /sys/bus/pci/devices/
drwxr-xr-x    2 root     root            0 Jan  3 17:25 .
drwxr-xr-x    5 root     root            0 Jan  3 17:25 ..
lrwxrwxrwx    1 root     root            0 Jan  3 17:25 0001:01:00.0 -> 
../../../devices/pci0001:01/0001:01:00.0
lrwxrwxrwx    1 root     root            0 Jan  3 17:25 0001:02:00.0 -> 
../../../devices/pci0001:01/0001:01:00.0/0001:02:00.0

"0001:01:00.0" is the PCIe PCI-PCI bridge side (Freescale's side)
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/vendor
0x1957 (PCI_VENDOR_ID_FREESCALE)
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/device
0x0071 (PCI_DEVICE_ID_P2020)
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/class
0x060400 (PCI_CLASS_BRIDGE_PCI)
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/enable
1
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/irq
0
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/msi_bus
1
~ # cat /sys/bus/pci/devices/0001\:01\:00.0/resource
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x000000000000ffff 0x0000000000000100
0x00000000c0000000 0x00000000dfffffff 0x0000000000000200
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
~ # hexdump  /sys/bus/pci/devices/0001\:01\:00.0/config
0000000 5719 7100 0601 1000 1000 200b 0800 0100 (PCI Compatible 
Configuration Headers)
0000010 0000 f0ff 0000 0000 0002 0200 0000 0000
0000020 00c0 f0df f1ff 0100 0000 0000 0000 0000
0000030 0000 0000 4400 0000 0000 0000 0000 0000
0000040 0000 0000 014c 02fe 0000 0000 1000 4100 (Power Mgmt 
Capabilities) , (0x4C: PCI Express Capabilities)
0000050 0100 0000 3e58 0000 41d4 0300 0800 4100
0000060 c007 0000 c003 4000 0000 0000 0000 0000
0000070 0000 0000 0000 0000 0000 0000 0000 0000
*
0000100 0100 0100 0000 0000 0000 0000 1020 0600 (Advanced Error 
Reporting Capability)
0000110 0000 0000 0000 0000 a000 0000 0000 0000
0000120 0000 0000 0000 0000 0000 0000 0000 0000
*
0000400 0000 0000 1600 0000 e204 0000 0000 0000 (PCI Express Controller 
Internal CSRs)
0000410 0800 0000 0000 0000 0000 0000 4040 0000
0000420 0000 0000 0000 0000 0000 0000 0000 0000
0000430 0000 0000 0000 0000 8300 6300 9ba0 0900
0000440 1000 0000 0000 0000 0000 0000 0000 0000
0000450 ced7 1400 201e fc01 0000 0000 5c0c 0000
0000460 0000 0000 0000 0000 0000 0000 0000 0000
0000470 5719 7100 1000 200b 0000 0000 0100 0000
0000480 443d 0000 0000 0000 f007 0000 0000 0000
0000490 c007 0000 0000 0000 0000 0000 0000 0000
00004a0 0000 0000 0000 0000 0000 0000 0000 0000
00004b0 0000 0000 0000 0000 2804 0180 8520 0000
00004c0 ff00 0000 0000 0000 0000 0000 1100 0000
00004d0 0000 0000 0000 0000 0000 0000 0000 0000
00004e0 0000 0000 0101 0000 0101 0000 0000 0000
00004f0 4a00 0001 0200 0004 0000 0000 0800 0000
0000500 0000 0000 0000 0000 0000 0000 0000 0000
0000510 0000 0000 0000 0000 8300 0000 0000 0000
0000520 0000 0000 0000 0000 0000 0000 0000 0000
*
0000540 0000 0000 0001 0202 0000 0000 0500 0000
0000550 0000 0000 0000 0000 0000 0000 0000 0000
*
0000590 d0cf 3200 0000 0000 0000 0000 0000 0000
00005a0 3f00 0000 0000 0000 0000 0000 0000 0000
00005b0 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000

Now here is the other side of the tunnel, "0001:02:00.0" (our device)
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/vendor
0x1234 (Just a number i picked up and told the HW dudes to put into the 
device... don't look it up :) )
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/device
0x0002
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/class
0xff0000
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/enable
0
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/irq
16
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/msi_bus
~ # cat /sys/bus/pci/devices/0001\:02\:00.0/resource
0x00000000c0000000 0x00000000c007ffff 0x0000000000020200
0x00000000c0080000 0x00000000c00fffff 0x0000000000020200
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
~ # hexdump /sys/bus/pci/devices/0001\:02\:00.0/config
0000000 3412 0200 0600 1000 0100 00ff 0800 0000
0000010 0000 00c0 0000 08c0 0000 0000 0000 0000
0000020 0000 0000 0000 0000 0000 0000 3412 0200
0000030 0000 0000 5000 0000 0000 0000 0001 0000
0000040 0000 0000 6061 0002 0000 0000 0000 0000
0000050 0578 8400 0000 0000 0000 0000 0000 0000
0000060 0000 0000 0000 0000 1178 0000 0000 0000
0000070 0000 0000 0000 0000 0180 0300 0800 0000
0000080 1000 0100 0180 3c00 3058 0000 41f4 0301
0000090 0000 4110 0000 0400 c003 0000 0000 0000
00000a0 0000 0000 0000 0000 0000 0000 0000 0000
00000b0 0100 0100 0000 0000 0000 0000 0000 0000
00000c0 0000 0000 0000 0000 0000 0000 0000 0000
*
0000100 0200 0180 0000 0000 0000 0000 0000 0000
0000110 0000 0000 ff00 0080 0000 0000 0000 0000
0000120 0000 0000 0000 0000 0000 0000 0000 0000
*
0000800 0100 0100 0000 0000 0000 0000 3120 0600
0000810 0000 0000 0020 0000 0000 0000 0000 0000
0000820 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000

NOW... As it is, under "/sys/bus/pci_express/devices/" you will find no 
devices. Debug prints which I have stuffed into pcie_portdrv_probe() 
shows that: "0001:01:00" is probed and fails to register for lacking a 
suitable interrupt mechanism as described by the previous mail, and 
"0001:02:00" fails to probe since it is not a PCI ROOT port.
As said, if I hack and slash and mainly cheat I can persuade the Kernel 
not to fail the probe and then I get these:

~ # ls -la /sys/bus/pci_express/devices/
drwxr-xr-x    2 root     root            0 Jan  3 17:49 .
drwxr-xr-x    4 root     root            0 Jan  3 17:49 ..
lrwxrwxrwx    1 root     root            0 Jan  3 17:49 
0001:01:00.0:pcie01 -> 
../../../devices/pci0001:01/0001:01:00.0/0001:01:00.0:pcie01
lrwxrwxrwx    1 root     root            0 Jan  3 17:49 
0001:01:00.0:pcie02 -> 
../../../devices/pci0001:01/0001:01:00.0/0001:01:00.0:pcie02

This is NOT functional as I have crippled the kernel on the way but I 
think this is  what I am missing and maybe my goal.

-- Liberty
