Return-Path: <benh@kernel.crashing.org>
Subject: Re: Proposal to move PCI out of arch/powerpc and into drivers/of
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
References: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 28 Feb 2010 11:32:06 +1100
Message-ID: <1267317126.23523.1859.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-26 at 16:07 -0700, John Linn wrote:
> Hi all,
> 
> We are in the process of putting PCI/PCIe into the microblaze
> architecture.  
> 
> In order to not duplicate/fork the PCI code in Powerpc, we're proposing
> to move the PCI code from arch/powerpc into drivers/of such that it
> would be common code for Powerpc and MicroBlaze.
> 
> This would be the 1st part of a refactoring that would occur with the
> PCI code.
> 
> Ben H., would you mind if that happened (move arch/powerpc/kernel/pci*
> to drivers/of/*)?

I don't think we should move the whole thing. I know Grant plans to move
parts of it though. There's quite a few things in there that are still
quite powerpc specific (and even different between ppc32 and ppc64).

I wouldn't mind in the long run if we could make some of powerpc's PCI
implementation bits more generic, such as struct pci_controller, and the
MMIO/PIO remapping mechanisms, since many archs do more or less the same
thing and all in subtely different ways. But that would have to go to
drivers/pci.

Then there's the whole deal with matching OF nodes with PCI devices. A
lot of that is still different even between ppc32 and ppc64. I don't
think any of that is ready to be moved to drivers/of, it's not generic
enough by far.

Cheers,
Ben.
