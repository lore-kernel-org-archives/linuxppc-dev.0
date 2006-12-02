Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EE14667B77
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  3 Dec 2006 01:34:36 +1100 (EST)
Message-ID: <45718F55.4080903@ru.mvista.com>
Date: Sat, 02 Dec 2006 17:36:05 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: u-boot-users@lists.sourceforge.net
Subject: U-Boot allocating PCI I/O space from 0 (Was: pata_sl82c105 can not
	reserve IO region)
References: <20061130165202.GA23205@aepfle.de>	
	<20061130171049.7b80a40c@localhost.localdomain>	
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de>	
	<45707CF8.3090106@ru.mvista.com>	
	<1165010029.22108.10.camel@localhost.localdomain>	
	<20061201221525.7a741062@localhost.localdomain>
	<1165011583.22108.17.camel@localhost.localdomain>
In-Reply-To: <1165011583.22108.17.camel@localhost.localdomain>
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

Hello.

Benjamin Herrenschmidt wrote:

>>I don't think that is the problem. pci_request_regions() handles all
>>this internally. It is incorrect for me to not request BAR 5
>>if present as nobody else should use that resource with my driver loaded.

>>The underlying problem appears to be that PPC64 isn't setting up the
>>resources properly (at least as viewed by the pci core code). If a
>>resource is not set up then pci_request_resource() correctly handles
>>it .. except on PPC64. You have a resource at zero with a length and
>>type. PPC64 is not reporting to the upper layers that the resource was
>>not allocated. It is reporting that the resource *was* allocated, and at a
>>bogus address of zero.

>>If you trust the firmware that is fine, but you need to report the truth,
>>at which point pci_request_resources() will work correctly.

> We don't have a choice but to trust the firmware on those machines. We
> can't assign things ourselves on most of them for various reasons (in
> many cases, the hypervisor won't let us).

> So you suggest that I clear resource->flags in that case ?

> I think part of the problem is a firmware bug in that the firmware data
> actually decodes to BAR 5 is assigned to address 0 ... I suppose we can
> consider that address 0 is never valid on those machines and consider
> that as unassigned but it's a bit dodgy.. Or maybe a PCI quirk in the
> pSeries code would be best.

    Well, I'm having a very related issue with the U-Boot on MPC85xx: recently 
I've noticed that it started allocating PCI I/O space from 0 (while the older 
versions started from 0x1000). The IDE core can't tolerate this, giving me 
such messages on bootup:

PDC20269: inconsistent baseregs (BIOS) for port 0, skipping

when I have Promise Ultra133TX2 card inserted into PCI alone. I've looked thru 
the U-Boot sources and commit history but failed to locate the change that led 
to this...

WBR, Sergei
