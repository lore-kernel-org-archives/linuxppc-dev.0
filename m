Date: Mon, 22 Mar 2004 08:48:33 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Cc: Jeff Angielski <jeff@theptrgroup.com>
Subject: Re: PCI Memory mapping
Message-ID: <20040322074833.GY7133@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain>
Mime-Version: 1.0
In-Reply-To: <1079455175.4184.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Check your PPC documentation for the configuration of the PITARx,
> PIBARx, and PICMRx. Once you read about these it should all make
> sense. Then look at your bootloader source code (hopefully you are
> using u-boot) to see how these registers are being configured.

Tnx for the info.

I am working on a solution, so instead of just posing a question on
the list, maybe the current working solution is a good contribution to
the lesser divine kernel hackers on the list :)

pci_map_single(driver_data.dev,driver_data.device[i]->\
    pciaddress,PCI_TRANSFER_SIZE,PCI_DMA_TODEVICE)

and

pci_unmap_single(driver_data.dev,driver_data.device[i]->\
    bus_addr,PCI_TRANSFER_SIZE,PCI_DMA_TODEVICE);

The data is transferred in blocks of 2k and first copied into a kernel
buffer from user space and then mapped on the PCI address range. Ideally
the user-space buffer would be mapped onto PCI (don't know if this is
possible, I did a quick, negative, test, but I suspect that I should
check the addresses again). However, this would put some logic at user
level, which is currently (in the transformation process) not desired.

The bus address (result of pci_map_single) is transferred to the DSP,
which it uses to fetch the data.

  +------+       +--------+     +------------+
  | user |------>| kernel |---->| pci-mapped |
  +------+       +--------+     +------------+

In the current kernel code (2.4.17 mvl2.1), pci_sync_single does not
seem to be implemented. In the code I checked, the successive mapping
and unmapping of the buffers does result in the same addresses.

I would assume that pci_sync_single would allow me to pass the mapped
address only once to the DSP, awaking it with an appropriate interrupt
when new data is available. Due to the absence of pci_sync_single, the
pci-mapped address needs to be passed to the DSP each time.

The observation based question is: to what degree can I be certain that
in a streaming data application, the successive mapping and unmapping of
the pci mapped addresses will result in the same bus addresses?

--
  Marc Leeman                                          Hardware R&D Engineer
  Barco Controlrooms Division                Noordlaan 5, B-8520 Kuurne (BE)
  Tel. +32 56 368 428 http://www.barcocontrolrooms.com marc.leeman@barco.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
