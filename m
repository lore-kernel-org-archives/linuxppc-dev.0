Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AA7EDDECA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 06:54:30 +1000 (EST)
Message-Id: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: tracking of PCI address space
Date: Wed, 8 Apr 2009 15:53:55 -0500
Cc: linux-pci@vger.kernel.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was wondering if we have anything that tracks regions associated  
with the "inbound" side of a pci_bus.

What I mean is on embedded PPC we have window/mapping registers for  
both inbound (accessing memory on the SoC) and outbound (access PCI  
device MMIO, IO etc).  The combination of the inbound & outbound  
convey what exists in the PCI address space vs CPU physical address  
space (and how to map from one to the other).  Today in the PPC land  
we only attach outbound windows to the pci_bus.  So technically the  
inbound side information (like what subset of physical memory is  
visible on the PCI bus) seems to be lost.

- k
