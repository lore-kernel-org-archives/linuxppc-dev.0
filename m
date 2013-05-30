Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1B6E2C008F
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 02:25:01 +1000 (EST)
Date: Thu, 30 May 2013 11:24:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: can't access PCIe card under sbc8548
To: wolfking <wolfking2000@msn.com>
In-Reply-To: <1369918188379-71827.post@n7.nabble.com> (from
 wolfking2000@msn.com on Thu May 30 07:49:48 2013)
Message-ID: <1369931094.14679.6@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 07:49:48 AM, wolfking wrote:
> tiejun.chen wrote
> > On 05/30/2013 03:32 PM, wolfking wrote:
> >> (continued)
> >>    I traced the 8139too.c when it uses pci_iomap, the pci_iomap =20
> called
> >> the
> >> ioport_map. The difference between 8139 and my PCIe card lies in =20
> the
> >> "port" value :
> >> void __iomem *ioport_map(unsigned long port, unsigned int len)
> >> {
> >> 	return (void __iomem *) (port + _IO_BASE);
> >
> > _IO_BASE is equal to isa_io_base. So if this is not zero, I think =20
> there's
> > a isa
> > bridge in your platform. So you can access these I/O ports based on =20
> that
> > isa
> > bridge/bus with ioreadx/iowritex.
> >
> > I tried ioread8/iowriet8 after ioremap, it doesn't work
> >
> >> }
> >>    in 8139too.c, the "port" value is 0x1000; for my PCIe card, the =20
> "port"
> >> value
> >> is 0xfefff000. And the value is got from pci_resource_start. So =20
> you see,
> >> the
> >
> > But this means the port is as memory-mapped

Are you sure?  It could mean that it's on a non-primary bus and I/O for =20
this bus is mapped at a lower address than the primary.  Just because =20
the addition is wrapping around doesn't mean it's wrong.

> > so ioremap() should be workable in this case. Then out_bex/in_bex =20
> should be fine.

ioremap() and out_bex/in_bex are not appropriate for PCI I/O regions =20
(and presumably that's what it is, if pci_iomap is calling =20
ioport_map).  Big-endian is not appropriate for PCI in any case.

The whole point of pci_iomap() appears to be that the driver doesn't =20
need to care whether it's MMIO or PIO, and can use ioread/writeX on the =20
resulting cookie.  If PPC is messing this up it's not the driver's =20
fault.

-Scott=
