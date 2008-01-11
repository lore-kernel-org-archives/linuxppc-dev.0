Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 104B6DE08E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 19:30:21 +1100 (EST)
Message-Id: <1B75C5A8-E512-40CB-A6F3-351640701D0D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: PCI Failed to allocate mem for PCI ROM
Date: Fri, 11 Jan 2008 02:29:28 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg,

I'm getting the following message from the kernel on an embedded ppc32  
system:

PCI: Failed to allocate mem resource #9:100000@e0000000 for 0000:00:00.0

The HW setup is a PCIe host controller and an e1000 NIC card.  It  
appears that pci_bus_assign_resources() is trying to call  
pci_assign_resource() for the ROM and the resource for the ROM is  
[100000:1fffff] where the PHB is [c0000000:dfffffff].

It seems like the resno that pci_assign_resource is getting called  
with is wrong and thus pci_update_resource() doesn't get called.

any ideas?

- k
