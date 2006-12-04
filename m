Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0942867BC5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 01:18:45 +1100 (EST)
Date: Mon, 4 Dec 2006 14:22:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: What is the correct way to indicate an unassigned PCI resource ?
Message-ID: <20061204142201.68d9621f@localhost.localdomain>
In-Reply-To: <45742253.1000807@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, greg@kroah.com,
	linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 04 Dec 2006 16:27:47 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> > Both PCI core and IDE interpret a zero length resource as unassigned.
> 
>    This is not about 0-length resource, this is about 0-address. Look at 
> ide_hwif_confiure() in drivers/ide/setup-pci.c...

The discussion I was having was about sl82cxx and handling unassigned
resources. The zero address isn't relevant to that.
 
>     You should know that the IRQ assumption is *not* true even for x86 since 
> IRQ0 is and has always been a perfectly valid IRQ (used by PIT).

Please see previous million recyclings of that discussion and Linus
answer.
 
> > Stick a real IDE resource at zero
>  > and drivers/ide can't cope.
> 
>     Yeah, I've noticed. Unfortunately, a lot of PPC platforms (at least) are 
> doing exactly this...

The checks need pushing upwards and removing from their current place -
the pci layer should check the resource length, the isa pnp should I
believe check for zero address etc.

libata makes a similar assumption in ata_resources_present() as someone
(GregKH ???) needs to define what the proper way to encode "resource not
allocated" into the PCI resources should be. If someone on the PCI list
(cc'd) or Greg can give a definitive answer then we can go fix the
offenders now.

Alan
