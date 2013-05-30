Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F23B2C0082
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 15:56:31 +1000 (EST)
Message-ID: <51A6EA1D.7080100@windriver.com>
Date: Thu, 30 May 2013 13:56:45 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: wolfking <wolfking2000@msn.com>
Subject: Re: can't access PCIe card under sbc8548
References: <1369885321567-71775.post@n7.nabble.com>
In-Reply-To: <1369885321567-71775.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 11:42 AM, wolfking wrote:
> hi, all
>    I'm doing some developing on the windriver's sbc8548 board. The kernel I
> use
> is 3.6.10 and the u-boot version is 2012-10. I changed the board's
> configuration:
> the board now boot from the 64MB SODIMM Flash (not the default 8MB on-board
> Flash
> memory), and the PCI clock rate is changed to 33MHZ.
>    Now the trouble I am in is that: the PCI card (a NIC card rtl8139) can be
> accessed OK, while the PCIe card can't work, that is, the kernel can't
> access
> its internal register. The kernel can correctly probe the PCIe card. its
> BAR0
> is a I/O mapped register, I use ioport_map to map the BAR0 to kernel's
> address
> space, then use ioread8/iowrite8 to access its internal register, it doesn't
> work.
> I analyse the ioport_map function and find it just add the input parameter
> to
> a fixed _IO_BASE value, below is the function:
> void __iomem *ioport_map(unsigned long port, unsigned int len)
> {
> 	return (void __iomem *) (port + _IO_BASE);
> }
> the _IO_BASE value under sbc8548 is 0xfd7fd000, the value of ioport_map
> paramenter
> "port" is 0xfefff000. Obviously the add overflows, so the follow-up
> operations
> can't succeed. The value of "port" is got from the function
> pci_resource_start.

In PPC case I/O is memory-mapped, so you should use ioremap() instead of 
ioport_map()..

Tiejun
