Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0DB7467B83
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 01:33:10 +1100 (EST)
Message-ID: <457431FE.6040702@ru.mvista.com>
Date: Mon, 04 Dec 2006 17:34:38 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com>	<20061204132124.4f7c50a9@localhost.localdomain>	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
In-Reply-To: <20061204142201.68d9621f@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Alan wrote:

>>>Both PCI core and IDE interpret a zero length resource as unassigned.

>>   This is not about 0-length resource, this is about 0-address. Look at 
>>ide_hwif_confiure() in drivers/ide/setup-pci.c...

> The discussion I was having was about sl82cxx and handling unassigned
> resources. The zero address isn't relevant to that.

    You were following up to the particular error message emitted by the IDE 
core (which you've now deleted), so I corrected you on its reason, that's all.

>>    You should know that the IRQ assumption is *not* true even for x86 since 
>>IRQ0 is and has always been a perfectly valid IRQ (used by PIT).

> Please see previous million recyclings of that discussion and Linus
> answer.

    When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
this happens, I consider is just an opinion. Forcing every arch but x86 to 
remap IRQ0 is an example of the double standards.

>>>Stick a real IDE resource at zero

>> > and drivers/ide can't cope.

>>    Yeah, I've noticed. Unfortunately, a lot of PPC platforms (at least) are 
>>doing exactly this...

> The checks need pushing upwards and removing from their current place -
> the pci layer should check the resource length, the isa pnp should I
> believe check for zero address etc.

    So, it's OK to remove the base *address* check in ide_hwif_confiure() 
altogether?

> libata makes a similar assumption in ata_resources_present() as someone
> (GregKH ???) needs to define what the proper way to encode "resource not
> allocated" into the PCI resources should be.

> If someone on the PCI list (cc'd) or Greg can give a definitive answer then we can go fix the
> offenders now.

    Well, I thought that was IORESOURCE_UNSET...

> Alan

WBR, Sergei
