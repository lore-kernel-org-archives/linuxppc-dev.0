Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 020C4DDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 18:55:59 +1100 (EST)
Date: Sat, 12 Jan 2008 00:27:05 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI Failed to allocate mem for PCI ROM
Message-ID: <20080112072705.GB7234@colo.lackof.org>
References: <1B75C5A8-E512-40CB-A6F3-351640701D0D@kernel.crashing.org>
	<20080111175039.GB7916@kroah.com>
	<E1025115-6BE2-46B6-8416-A5ADD506E2ED@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1025115-6BE2-46B6-8416-A5ADD506E2ED@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2008 at 02:27:16PM -0600, Kumar Gala wrote:
>>> I'm getting the following message from the kernel on an embedded ppc32
>>> system:
>>>
>>> PCI: Failed to allocate mem resource #9:100000@e0000000 for 0000:00:00.0
>>>
>>> The HW setup is a PCIe host controller and an e1000 NIC card.
...
> I'm happy to debug, is the fact that the resno == 9 ok or does that seem 
> wrong?

That is fine for the Bridge. See include/linux/pci.h :
#define PCI_ROM_RESOURCE        6
#define PCI_BRIDGE_RESOURCES    7
#define PCI_NUM_RESOURCES       11

IIRC, Bridges may have two 32-bit or one 64-bit BAR, Expansion ROM BAR and
three "range" registers: IO Port, MMIO (Prefetchable and non-prefetchable).
The BRIDGE_RESOURCES (7-10) are what failed to be assigned for some reason.

Looking at setup-bus.c:pci_bridge_check_ranges(), I'm concluding that:
[7] is IO Range.
[8] is MMIO
[9] is Prefetchable MMIO
[10] no clue...maybe used by host PCI bus controllers.

0x100000 is 1MB and would be the minimum MMIO range that can be allocated.
So that looks right too. Probably need to find out what is allocating
0xe0000000 instead.

hth,
grant
