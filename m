Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7F3FEB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 15:24:27 +1000 (EST)
Message-ID: <4C85CCD6.3020504@windriver.com>
Date: Tue, 07 Sep 2010 13:25:42 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: pci_request_regions() failure
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
In-Reply-To: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Gupta wrote:
> Hi,
> 
> I am facing a problem while requesting pci resource. I have some data that I
> am hopeful will help address the issue.
> 
> I am currently running on a MPC837xERDB board(powerpc) with a 2.6.35 kernel.
> The problem is that whenever I insert the card (LatticeECP2M PCI Express
> Development Kit<http://www.latticesemi.com/products/developmenthardware/developmentkits/pciexpressdevkitecp2m/index.cfm>)
> in pci-express slot 0 and try to load my driver module, I get a
> pci_request_regions() failure(error -EBUSY). The interesting thing is the
> region that it fails for. According to /proc/iomem, slot0 has
> a8000000-b7ffffff as its memory ranges. However, the memory region requested
> by my device is a8000000-a803ffff and a8040000-a807ffff which falls in the
> slot0 range. But after boot up when I look at /proc/iomem, there is a
> already allocated resource range present there, which overlaps with the
> range refined in my device, hence the pci_request_regions() fails.
> 
> Output of lspci
> 0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c6 (rev
> 21)
> 0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c6
> (rev 21)
> 0001:02:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
> Unknown device e250  ---> My device
> 
> Contents of /pro/iomem file
> # cat /proc/iomem
> 80000000-8fffffff : /pci@e0008500
> 90000000-9fffffff : /pci@e0008500
> a8000000-b7ffffff : /pcie@e0009000
>   a8000000-a80fffff : PCI Bus 0001:02  ---> colprit range
> c8000000-d7ffffff : /pcie@e000a000
> e0004500-e0004507 : serial
> e0004600-e0004607 : serial
> e0023000-e0023fff : usb
> 
> Now my doubt is, who is allocating this range and why? It seem to me a

I think the kernel don't allocate the used PCI range to another PCI device. So
you can enable CONFIG_PCI_DEBUG then execute 'dmesg' to get more information.

Before you don't load your module the kernel still can probe the plugged PCI
device and allocate/reserve appropriate PCI range for your device. Then you can
acquire the proper PCI IO/MEM range from there when loading device module. This
process should be transparent for the PCI device driver so I think this is
correct by '/proc/iomem'.

You can refer the following example on one PPC target.

Boot without enabling the given PCI device, e1000e.
------
c00000000-c1fffffff : /pcie@ffe200000
  c00000000-c1fffffff : PCI Bus 0000:01
    c00000000-c0001ffff : 0000:01:00.0
    c00020000-c0003ffff : 0000:01:00.0

Boot with enable e1000e PCI device.
------
c00000000-c1fffffff : /pcie@ffe200000
  c00000000-c1fffffff : PCI Bus 0000:01
    c00000000-c0001ffff : 0000:01:00.0
      c00000000-c0001ffff : e1000e
    c00020000-c0003ffff : 0000:01:00.0
      c00020000-c0003ffff : e1000e

So I think you can build your driver into the kernel to try again, or maybe you
should check your driver codes. Especially I want to know how/where you get
these two range, a8000000-a803ffff and a8040000-a807ffff. You wired them firstly
on the driver or allocated by the kernel?

Best Regards
Tiejun

> kernel bug as I also tried my device on i386 machine(opensuse, linux 2.6.35
> i.e the same kernel version on powerpc board) and there everything works
> fine. I don't know where to start to fix it. Please suggest.
> 
> Output of lspci
> 
> scooby:~ # lspci
> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM
> Controller (rev 10)
> 00:01.0 PCI bridge: Intel Corporation 82G33/G31/P35/P31 Express PCI Express
> Root Port (rev 10)
> 00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
> Integrated Graphics Controller (rev 10)
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
> Audio Controller (rev 01)
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
> 1 (rev 01)
> 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
> 2 (rev 01)
> 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
> 3 (rev 01)
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #3 (rev 01)
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> Controller #4 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
> Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
> 00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface
> Bridge (rev 01)
> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
> (rev 01)
> 00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA
> IDE Controller (rev 01)
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev
> 01)
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B
> PCI Express Gigabit Ethernet controller (rev 01)
> 04:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
> Device e250    ----------> My device
> 05:06.0 Serial controller: Device 4348:3253 (rev 10)
> 
> Contents of /proc/iomem on i386 machine
> 
> cat /proc/iomem
> .
> .
> .
> fe900000-fe9fffff : PCI Bus 0000:04
>    fe900000-fe93ffff : 0000:04:00.0    ------------->My device
>    fe940000-fe97ffff : 0000:04:00.0    ------------->My device
> fea00000-feafffff : PCI Bus 0000:03
> fea00000-fea1ffff : 0000:03:00.0
> fea20000-fea20fff : 0000:03:00.0
> fea20000-fea20fff : r8169
> .
> .
> .
> 
> Regards,
> 
> Ravi
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
