Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7F7E67A3A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 15:41:48 +1100 (EST)
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061204142201.68d9621f@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 15:41:19 +1100
Message-Id: <1165293679.29784.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-04 at 14:22 +0000, Alan wrote:

> The discussion I was having was about sl82cxx and handling unassigned
> resources. The zero address isn't relevant to that.

Well, actually, it's unclear to me wether the resource is unassigned or
has been assigned to 0 :-) And in the later case, why claim'ing it
fails.

Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
that PCI bus ?

I have the "gut" feeling that the firmware didn't assign it, but it does
explicitely has an assigned-address property for it with value "0" and a
valid size & set of flags... so it looks like maybe it -really- did
assign it to 0. Either that or it's buggy.

In any case, if we have to do a fixup here, it would be a pSeries
specific fixup and thus would have to sit in a PCI quirk in the pSeries
platform code.

> >     You should know that the IRQ assumption is *not* true even for x86 since 
> > IRQ0 is and has always been a perfectly valid IRQ (used by PIT).
> 
> Please see previous million recyclings of that discussion and Linus
> answer.

Besides, it does make thing easier in the kernel to consider IRQ 0 as
invalid. That's one of the reasons for which I generalized the IRQ
remapping layer in arch/powerpc. Among others, 0 is always invalid and
1...15 are always only ever assigned to a legacy 8259 if any, anything
else gets remapped.
 

> libata makes a similar assumption in ata_resources_present() as someone
> (GregKH ???) needs to define what the proper way to encode "resource not
> allocated" into the PCI resources should be. If someone on the PCI list
> (cc'd) or Greg can give a definitive answer then we can go fix the
> offenders now.

There is an UNSET flag isn't there ? Though nobody uses it ...

Ben.
