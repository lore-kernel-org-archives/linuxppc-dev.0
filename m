Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F14B2C029B
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 11:34:04 +1000 (EST)
Message-ID: <51A7FE17.2040803@windriver.com>
Date: Fri, 31 May 2013 09:34:15 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: can't access PCIe card under sbc8548
References: <1369931094.14679.6@snotra>
In-Reply-To: <1369931094.14679.6@snotra>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: wolfking <wolfking2000@msn.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2013 12:24 AM, Scott Wood wrote:
> On 05/30/2013 07:49:48 AM, wolfking wrote:
>> tiejun.chen wrote
>> > On 05/30/2013 03:32 PM, wolfking wrote:
>> >> (continued)
>> >>    I traced the 8139too.c when it uses pci_iomap, the pci_iomap called
>> >> the
>> >> ioport_map. The difference between 8139 and my PCIe card lies in the
>> >> "port" value :
>> >> void __iomem *ioport_map(unsigned long port, unsigned int len)
>> >> {
>> >>     return (void __iomem *) (port + _IO_BASE);
>> >
>> > _IO_BASE is equal to isa_io_base. So if this is not zero, I think there's
>> > a isa
>> > bridge in your platform. So you can access these I/O ports based on that
>> > isa
>> > bridge/bus with ioreadx/iowritex.
>> >
>> > I tried ioread8/iowriet8 after ioremap, it doesn't work
>> >
>> >> }
>> >>    in 8139too.c, the "port" value is 0x1000; for my PCIe card, the "port"
>> >> value
>> >> is 0xfefff000. And the value is got from pci_resource_start. So you see,
>> >> the
>> >
>> > But this means the port is as memory-mapped
>
> Are you sure?  It could mean that it's on a non-primary bus and I/O for this bus

We can take a further look at '/proc/ioports', '/proc/iomem' and other message.

> is mapped at a lower address than the primary.  Just because the addition is
> wrapping around doesn't mean it's wrong.
>
>> > so ioremap() should be workable in this case. Then out_bex/in_bex should be
>> fine.
>
> ioremap() and out_bex/in_bex are not appropriate for PCI I/O regions (and
> presumably that's what it is, if pci_iomap is calling ioport_map).  Big-endian
> is not appropriate for PCI in any case.

Yes, I should correct that PCI interprets all accesses as little-endian.

Tiejun
