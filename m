Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CBB492C007A
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 14:00:41 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UhtkX-0000DT-OK
 for linuxppc-dev@ozlabs.org; Wed, 29 May 2013 20:42:01 -0700
Date: Wed, 29 May 2013 20:42:01 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369885321567-71775.post@n7.nabble.com>
Subject: can't access PCIe card under sbc8548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi, all
  I'm doing some developing on the windriver's sbc8548 board. The kernel I
use
is 3.6.10 and the u-boot version is 2012-10. I changed the board's
configuration:
the board now boot from the 64MB SODIMM Flash (not the default 8MB on-board
Flash
memory), and the PCI clock rate is changed to 33MHZ.
  Now the trouble I am in is that: the PCI card (a NIC card rtl8139) can be 
accessed OK, while the PCIe card can't work, that is, the kernel can't
access
its internal register. The kernel can correctly probe the PCIe card. its
BAR0 
is a I/O mapped register, I use ioport_map to map the BAR0 to kernel's
address
space, then use ioread8/iowrite8 to access its internal register, it doesn't
work.
I analyse the ioport_map function and find it just add the input parameter
to
a fixed _IO_BASE value, below is the function:
void __iomem *ioport_map(unsigned long port, unsigned int len)
{
	return (void __iomem *) (port + _IO_BASE);
}
the _IO_BASE value under sbc8548 is 0xfd7fd000, the value of ioport_map
paramenter 
"port" is 0xfefff000. Obviously the add overflows, so the follow-up
operations 
can't succeed. The value of "port" is got from the function
pci_resource_start.
So I guess the kernel allocate a bad address to this PCIe card. How can I
fix this?
  I also plug this PCIe card into a freescale's board mpc8641-hpcn, try the
same driver,
I noticed ioport_map also meet overflow, but it does work fine. So I'm
messed, :<



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
