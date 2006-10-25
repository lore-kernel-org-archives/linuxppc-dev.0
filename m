Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDFBC67B22
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 14:35:17 +1000 (EST)
In-Reply-To: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
References: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E2847437-6C75-4963-B9DB-BAC050015C88@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8343: PCI resource allocation questions
Date: Tue, 24 Oct 2006 23:35:18 -0500
To: "Luong Ngo" <luong.ngo@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 24, 2006, at 10:49 PM, Luong Ngo wrote:

> Hello,
> I am trying to bring up linux kernel 2.6.14 on a system using MPC  
> 8343E and am having issues with the PCI resource allocation in the  
> kernel. I saw these messages:
> .............
> PCI: Cannot allocate resource region 0 of device 0000:00: 00.0
> PCI: Cannot allocate resource region 2 of device 0000:00:00.0
> PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0

You can ignore these, they can usually be handled by adding a  
pci_exclude call back to ignore the host controller itself.

something like:

int mpc83xx_exclude_device(u_char bus, u_char devfn)
{
         if (bus == 0 && PCI_SLOT(devfn) == 0)
                 return PCIBIOS_DEVICE_NOT_FOUND;
         return PCIBIOS_SUCCESSFUL;
}

> After digging into the codes, I realize that the PCI subsystem scan  
> the bus and reading the BARs in the CPU PCI controller, which give  
> the region 1 from 0x0 to 0x000FFFFF and region 2 from 0x0 to  
> 0x7FFFFFFF. And the values I assign to the bridge resource in  
> calling pci_init_resource during setup hose is 0x80000000 -  
> 0x9FFFFFFF (I got this values from the mpc834x_sys.h).  So I just  
> extend the bridge resource to 0x70000000 - 0xFFFFFFFF to cover all  
> 2 regions in the 2 BAR and this seems to get rid of the above  
> messages. However this would cause other platform devices to fail  
> to claim its resources,
>
> fsl-gianfar.1: failed to claim resource 0
> unable to register device 0
> fsl-gianfar.2: failed to claim resource 0
> unable to register device 1
> fsl-i2c.1: failed to claim resource 0
> unable to register device 2

You are not leaving any memory space for any of the onchip devices,  
the error messages are because the regions of memory that the devices  
are expected to be at are already occupied by the PCI space.

> Could anyone tell me how these PCI resource work and how to resolve  
> this conflict?

The PCI resources are used for any PCI devices that need memory  
mapped space allocated to them.  What devices are you connecting over  
PCI?

> And my other questions are  why is the region 2 in the mpc8343E  
> such huge and what is it used for?

The region was large since the reference board has general purpose  
PCI slots for any number of various cards.  We provide a large space  
to allow for those cards to be allocated into.  Depending on your  
application you can adjust this as you need.

> Also Why the kernel looks into the CPU PCI controller? because as I  
> understand, in the hose setup step in platform initialization, the  
> host bridge is skipped while other PCI devices would be probed and  
> have their BARs assigned the address range to use ( in function  
> pciauto_bus_scan in arch/ppc/syslib/pci_auto.c )

This is because when the kernel code scan's for devices the host  
bridge responses as a device.  You can use the exclude function as a  
way to override the scanning code and have it ignore the host bridge.

> One more question, are these BARs in the PCI controller related  
> with the PCI inbound and outbound mapping of the PCI interface? Do  
> the regions in BAR need to match/derive from the inbound/outbound  
> address mapping?

Yes, but you should only need to setup the inbound/outbound address  
mapping registers.  The actually PCI BARs are only important if you  
are using the MPC8343 as a PCI agent, it sounds like you are using it  
as a host.

- kumar
