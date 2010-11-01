Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id AC4E21007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 03:05:59 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 07130-07 for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Nov 2010 15:59:13 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PowerQUICC II PCIe dma
Date: Mon, 1 Nov 2010 15:58:37 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AB8C@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to get a ppc 831x to do PCIe dma transfers, PIO transfers
work ok but are somewhat lethargic (partially due to the slave).

I've done the following:
- All reads/writes (including the dma descriptors) are byteswapped.
- Enabled the dma in PEX_CSB_CTRL (value 0x3f)
- Used the kernel physical addresses for all addresses.
  For memory from virt_to_phys(), pci from pci_resource_start().
  (virt_to_phys() gives invalid values for the pci area).
- I'm setting both 'snoop' bits to 1 (as per the device errata)
  So the descriptor 'ctrl' has value (len >> 2) << 12 | 0xff9,
  and the dma 'ctrl' 0x401.
- I've put a 'sync' instruction (iosync()) just before the
  write to start the dma.

On the first request after hard reset, the dma status register
REX_RDMA_STAT gets set to 4. On subsequent requests it stays zero.
Nothing else appears to happen at all (except the 'start' bit
always reads back zero).
The 'CSB status register' at 0x81c stays zero - so I don't think
it is stuck waiting for the PCIe slave.

I'm not at all sure of the word ordering for the dma descriptor!
Page 14-113 doesn't say! However I've written the values so that
it doesn't matter - once I get a status written back I'll know...

I've probably forgotten something very silly!
Anyone who has got this working any ideas ??

	David
