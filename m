Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C6FA6DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Dec 2006 07:53:51 +1100 (EST)
Message-ID: <45918BCE.1010209@ru.mvista.com>
Date: Tue, 26 Dec 2006 23:53:34 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] U-Boot allocating PCI I/O space from 0 (Was:
	pata_sl82c105 can not	reserve IO region)
References: <20061130165202.GA23205@aepfle.de>		<20061130171049.7b80a40c@localhost.localdomain>		<20061130184748.GA24071@aepfle.de>	<20061201183355.GA9701@aepfle.de>		<45707CF8.3090106@ru.mvista.com>		<1165010029.22108.10.camel@localhost.localdomain>		<20061201221525.7a741062@localhost.localdomain>	<1165011583.22108.17.camel@localhost.localdomain>	<45718F55.4080903@ru.mvista.com>
	<4571AAE1.1020609@ru.mvista.com>
In-Reply-To: <4571AAE1.1020609@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>    Well, I'm having a very related issue with the U-Boot on MPC85xx: recently 
>>I've noticed that it started allocating PCI I/O space from 0 (while the older 
>>versions started from 0x1000). The IDE core can't tolerate this, giving me 
>>such messages on bootup:

>>PDC20269: inconsistent baseregs (BIOS) for port 0, skipping

    This is due to U-Boot assigning the PCI resources fram address 0 (which is 
BTW illegal according to PCI 2.1).  I have a patch for drivers/pci_auto.c 
which I'm going to post tomorrow...

>>when I have Promise Ultra133TX2 card inserted into PCI alone. I've looked thru 
>>the U-Boot sources and commit history but failed to locate the change that led 
>>to this...

>     It's actually much worse than just that. When I also plug in some other 
> PCI card so Ultra133TX2 doesn't get the zero addresses anymore, I'm getting this:

> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> eth3: Invalid EEPROM checksum 0xfffe, check settings before activating this
> device!
> eth3: OEM i82557/i82558 10/100 Ethernet, 00:00:00:00:FF:FF, IRQ 52.
> [...]
> PDC20269: 100% native mode on irq 51
>      ide2: BM-DMA at 0x0060-0x0067, BIOS settings: hde:pio, hdf:pio
> PDC20269: simplex device: DMA disabled
> ide3: PDC20269 Bus-Master DMA disabled (BIOS)

>     I've just verified that both these cards are working OK in x86 box
> As for the simplex message, I've encountered this some months ago and it was 
> caused by invalid programming of the MPC85xx bridge PCI/X outbound translation 
> address register for the I/O space

    No, the programming was valid. I've finally found the ultimate reason of 
breakage -- it lies in board/*/init.S files.  The patch tomorrow...

> or at least by the non-zero value of the 
> bus I/O address in the "ranges" property of the bridge device node in the 
> device tree...

    It was the real reason -- the arch/powerpc/ kernel just ignores ranges 
with non-zero I/O port address.

> I'm somewhat confused now since I know that the relevant U-Boot
> code has been fixed but it looks like that made it only worse -- I was using 
> the custom patched version of U-Boot before which missed that fix:

> http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=commitdiff;h=97074ed9655309b64231bc2cee69fe85399f8055

    It was actually the following patch that broke PCI:

http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=commit;h=52c7a68b8d587ebcf5a6b051b58b3d3ffa377ddc

    There were other places relying on CFG_PCI1_IO_BASE and those weren't 
changed... sigh. :-/

WBR, Sergei
