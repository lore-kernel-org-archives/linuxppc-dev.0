Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id 0EA5867A77
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 17:29:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k527nocg002151
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 00:49:50 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k527TJn0012228
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 02:29:21 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673066CF5BE@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 2 Jun 2006 15:29:12 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +static void __init mpc7448_hpc2_map_io(void) {
> > +	/* PCI IO  mapping */
> > +	io_block_mapping(MPC7448_HPC2_PCI_IO_BASE_VIRT,
> > +			 MPC7448_HPC2_PCI_IO_BASE_PHYS, 
> 0x00800000, _PAGE_IO);
> > +	/* Tsi108 CSR mapping */
> > +	io_block_mapping(TSI108_CSR_ADDR_VIRT, TSI108_CSR_ADDR_PHYS,
> > +			 0x100000, _PAGE_IO);
> > +
> > +	/* PCI Config mapping */
> > +	io_block_mapping(MPC7448_HPC2_PCI_CFG_BASE_VIRT,
> > +			 MPC7448_HPC2_PCI_CFG_BASE_PHYS,
> > +			 MPC7448_HPC2_PCI_CFG_SIZE, _PAGE_IO);
> > +
> > +	tsi108_pci_cfg_base = MPC7448_HPC2_PCI_CFG_BASE_VIRT;
> > +	/* NVRAM mapping */
> > +	io_block_mapping(MPC7448_HPC2_NVRAM_BASE_ADDR,
> > +			 MPC7448_HPC2_NVRAM_BASE_ADDR, 
> MPC7448_HPC2_NVRAM_SIZE,
> > +			 _PAGE_IO);
> > +}
> 
> io_block_mapping is bad ! see endless discussions in the 
> archives of why ... Use ioremap.

If I really need to use bat0 or bat1( I see that the general mmu use bat2 and bat3, 
where should I set up them?

For tsi108 pci configuration access, I need to map 16Mbyte 
physical address.  If I do not use an extra bat, I can not get the correct 
virtual address use ioremap.
