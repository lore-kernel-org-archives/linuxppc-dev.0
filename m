Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (cumulus.netspace.net.au [203.10.110.72])
	by ozlabs.org (Postfix) with ESMTP id 5A0102BF16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 12:25:27 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id CB5A671929
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 12:25:18 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: <wd@denx.de>
Date: Tue, 14 Dec 2004 12:25:20 +1100
Message-ID: <003001c4e17b$c6d45e10$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20041214003301.2CC13C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday, 14 December 2004 11:33 AM, wd@denx.de wrote:

> Dear Andrew,
>=20
> in message <002a01c4e16e$34451010$4000a8c0@CAT> you wrote:
>>=20
>> I posted a question on cardbus with the 5200 a few weeks ago but got
>> no reply. I think the reason is that cardbus / pcmcia support may
>> not have been considered when the 5200 PCI memory map was laid out,
>> but I would love to be contradicted!
>=20
> I think I can confirm that this was not considered, but I'm not  sure
> that this is an issue here.

Hi Wolfgang,

It's a problem for PCMCIA, but probably not for cardbus. The PCMCIA =
16bit
I/O space can't be mapped above 0x1000 in the PCI address space. The CPU
physical address doesn't matter.

The PCMCIA memory space can be mapped to any 16MiB boundary so this =
isn't
a problem

>=20
>> I also have a few outstanding issues that I haven't resolved yet,
>> hence I haven't posted a full patch, but I can now load and
>> configure a wireless ethernet card. Loading cardbus drivers
>> currently fails when accessing PCI configuration space on the
>> cardbus bus, and I haven't sorted this out yet.=20
>=20
> I'd like to see your patch (even if preliminary).

I'll work on bundling it up in the next day or two. There are lots of
changes, including partial support for IRQ0 being a valid interrupt...
sigh. The setup of the BAT for MBAR also doesn't seem correct to me, but
I'm now using io_block_mapping() in my platform support.

Another problem I noticed is pcibios trashing the 5200 bridge setup. =
I've
hacked around this for now. Not a problem for PCMCIA but would have =
broken
bus mastering for cardbus / PCI.

While looking at PCI I noticed that the icecube platform (which I =
copied:)
compiles in pci_auto and indirect_pci but they aren't used. Is this work
in progress or a "cut-n-paste" error?

> Unfortunately I don't have any hardware yet with  a  working  cardbus
> interface. But this might change soon...

Good to hear:)
