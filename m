Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC4E52C0097
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 02:29:31 +1000 (EST)
Date: Thu, 30 May 2013 11:29:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: can't access PCIe card under sbc8548
To: wolfking <wolfking2000@msn.com>
References: <1369885321567-71775.post@n7.nabble.com>
In-Reply-To: <1369885321567-71775.post@n7.nabble.com> (from
 wolfking2000@msn.com on Wed May 29 22:42:01 2013)
Message-ID: <1369931365.14679.7@snotra>
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

On 05/29/2013 10:42:01 PM, wolfking wrote:
> hi, all
>   I'm doing some developing on the windriver's sbc8548 board. The =20
> kernel I
> use
> is 3.6.10 and the u-boot version is 2012-10. I changed the board's
> configuration:
> the board now boot from the 64MB SODIMM Flash (not the default 8MB =20
> on-board
> Flash
> memory), and the PCI clock rate is changed to 33MHZ.
>   Now the trouble I am in is that: the PCI card (a NIC card rtl8139) =20
> can be
> accessed OK, while the PCIe card can't work, that is, the kernel can't
> access
> its internal register. The kernel can correctly probe the PCIe card. =20
> its
> BAR0
> is a I/O mapped register, I use ioport_map to map the BAR0 to kernel's
> address
> space, then use ioread8/iowrite8 to access its internal register, it =20
> doesn't
> work.

In what specific way does it not work?

> I analyse the ioport_map function and find it just add the input =20
> parameter
> to
> a fixed _IO_BASE value, below is the function:
> void __iomem *ioport_map(unsigned long port, unsigned int len)
> {
> 	return (void __iomem *) (port + _IO_BASE);
> }
> the _IO_BASE value under sbc8548 is 0xfd7fd000, the value of =20
> ioport_map
> paramenter
> "port" is 0xfefff000. Obviously the add overflows, so the follow-up
> operations
> can't succeed.

Why can't it succeed?  Is there nothing mapped at 0xfc7fc000?

> The value of "port" is got from the function
> pci_resource_start.
> So I guess the kernel allocate a bad address to this PCIe card. How =20
> can I
> fix this?
>   I also plug this PCIe card into a freescale's board mpc8641-hpcn, =20
> try the
> same driver,
> I noticed ioport_map also meet overflow, but it does work fine.

So don't focus on the overflow, but rather on the actual breakage.

-Scott=
