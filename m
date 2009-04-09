Return-Path: <grundler@lackof.org>
Received: from complete.lackof.org (complete.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65C77DDF94
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 17:04:50 +1000 (EST)
Date: Thu, 9 Apr 2009 00:55:53 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: tracking of PCI address space
Message-ID: <20090409065553.GA14780@lackof.org>
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
> map from one to the other).

Most PCI Host bus controllers will negatively decode the outbound ranges
for inbound traffic.

PARISC and IA64 have extra registers to play some games with that. But
routing between PCI bus controllers to make them look like a single PCI
segment was the main intent of that. I've not found any other uses
to subvert that.

>  Today in the PPC land we only attach 
> outbound windows to the pci_bus.  So technically the inbound side 
> information (like what subset of physical memory is visible on the PCI 
> bus) seems to be lost.

What did you need inbound "routing map" for?

thanks,
grant
