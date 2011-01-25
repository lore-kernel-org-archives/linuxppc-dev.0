Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 1C15F1007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2011 20:05:03 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 29294-09 for <linuxppc-dev@ozlabs.org>;
	Tue, 25 Jan 2011 08:58:18 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FSL DMA engine transfer to PCI memory
Date: Tue, 25 Jan 2011 08:56:09 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC25@saturn3.aculab.com>
In-Reply-To: <4D3DF36A.5050609@embedded-sol.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I'm trying to use FSL DMA engine to perform DMA transfer from
> memory buffer obtained by kmalloc() to PCI memory. This is on
> custom board based on P2020 running linux-2.6.35. The PCI
> device is Altera FPGA, connected directly to SoC PCI-E controller.

You'll need to use the dma engine that is part of the PCIe
interface in order to get large PCIe transfers.
I think everything else will still generate single 32bit PCIe
transfers - which are (if your measurements match mine)
exceptionally lethargic - the ISA bus is faster!

That does work provided you remember to give the dma controller
physical addresses and byteswap absolutely everything.
(Oh, and I didn't get single word transfers to work - they locked
the dma controller - not a problem since they are faster by PIO.)

Note that the PPC Linux (Linux in general??) doesn't have a
'virtual to physical' function that works for all addresses,
you'll need to remember the physical address of the PCIe slave
and use malloc'ed memory for the descriptors (on which
virt_to_phys() actually works).

I don't think there is a standard device driver for the PCIe dma,
I couldn't even find any header files that were vaugely relevent
except in the uboot sources.
I certainly wrote some code that just assumes it is on the right
hardware!

These are the relevant bits of code ....

Global initialisation:
    /* Enable the read/write dma controllers */
    csb_ctrl =3D  in_le32(&pex->pex_csb_ctrl);
    csb_ctrl |=3D PEX_CSB_CTRL_WDMAE | PEX_CSB_CTRL_RDMAE;
    out_le32(&pex->pex_csb_ctrl, csb_ctrl);

    /* We don't rely on the dma polling the descriptor, I have NFI
     * whether the default of 0 means 'never poll' or 'poll very
quickly'.
     * Set a large slow value for sanity. */
    out_le32(&pex->pex_dms_dstmr, ~0u);

Transfer setup:
    /* We only support aligned writes - caller must verify */
    dma_ctrl =3D PDMAD_CTRL_VALID;
    dma_ctrl |=3D PDMAD_CTRL_SNOOP_CSB;
    dma_ctrl |=3D PDMAD_CTRL_1ST_BYTES | PDMAD_CTRL_LAST_BYTES;
    dma_ctrl |=3D PDMAD_CTRL_NEXT_VALID;
    dma_ctrl |=3D len << (PDMAD_CTRL_LEN_SHIFT - 2);

    /* Fill in DMA descriptor */
    st_le32(&desc->pdmad_ctrl, dma_ctrl);
    /* We MUST clear the status - otherwise the xfer will be skipped */
    st_le32(&desc->pdmad_stat, 0);
    st_le32(&desc->pdmad_src_address, src_phys);
    st_le32(&desc->pdmad_dst_address, dst_phys);
    st_le32(&desc->pdmad_next_desc, 0);

    /* Clear old status */
    st_le32(&pex_dma->pex_dma_stat, in_le32(&pex_dma->pex_dma_stat));

    /* Give descriptor address to dma engine */
    st_le32(&pex_dma->pex_dma_addr, virt_to_phys(desc));

    /* Wait for all above memory cycles, then start xfer */
    iosync();
    st_le32(&pex_dma->pex_dma_ctrl, PEX_DMA_CTRL_START |
PEX_DMA_CTRL_SNOOP);

Poll for completion:
    /* Wait for transfer to complete/fail */
    do {
        desc_stat =3D ld_le32(&desc->pdmad_stat);
    } while (!(desc_stat & PDMAD_STAT_DONE));

    status =3D ld_le32(&pex_dma->pex_dma_stat);

    if (status =3D=3D (PEX_DMA_STAT_DSCPL | PEX_DMA_STAT_CHCPL)
            && desc_stat =3D=3D PDMAD_STAT_DONE)
        /* Transfer ok */
        return 0;
    /* Transfer failed */

Oh, since I couldn't find it in the documentation, the first
word of the dma descriptor is 'ctrl' and the last 'next_desc'.

    David
