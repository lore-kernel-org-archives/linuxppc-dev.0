Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id F03D9DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 08:14:44 +1000 (EST)
Date: Wed, 8 Apr 2009 14:49:32 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: tracking of PCI address space
Message-ID: <20090408214932.GA31970@ovro.caltech.edu>
References: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 03:53:55PM -0500, Kumar Gala wrote:
> I was wondering if we have anything that tracks regions associated with 
> the "inbound" side of a pci_bus.
>
> What I mean is on embedded PPC we have window/mapping registers for both 
> inbound (accessing memory on the SoC) and outbound (access PCI device 
> MMIO, IO etc).  The combination of the inbound & outbound convey what 
> exists in the PCI address space vs CPU physical address space (and how to 
> map from one to the other).  Today in the PPC land we only attach 
> outbound windows to the pci_bus.  So technically the inbound side 
> information (like what subset of physical memory is visible on the PCI 
> bus) seems to be lost.
>

To the best of my knowledge there is no API to set inbound windows in
Linux. I've been implementing a virtio-over-PCI driver which needs the
inbound windows. I set them up myself during driver probe, using
get_immrbase() to get the IMMR registers. This board is a PCI Slave /
Agent, it doesn't even have PCI support compiled into the kernel.

Ira
