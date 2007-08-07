Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id 786FADDE39
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 02:03:01 +1000 (EST)
Subject: Linux with data2mem
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF56B29E3B.75AC018C-ON85257330.0055CDE0-85257330.0056CDD1@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Tue, 7 Aug 2007 11:48:07 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have created a Linux kernel and file system into an ELF file.  I have the
bit file from my Xilinx V4 FX12LC.  According to the documentation I have
read I should be able to use data2mem to create one bit file which I can
program the FPGA with.  I have not been able to get data2mem to work
correctly.  Has anybody been able to do this?  I started with my
system_bd.bmm file from implementation directory.  Executing the command:

data2mem -2m system_bd.bmm -bt system.bit -bd zImage.initrd.elf -o b
newsys.bit

yields:

ERROR:Data2MEM:33 - Matching ADDRESS_SPACE for code segment #0 not found in
'sys
tem_bd.bmm'.
    Code segment #0 occupies [0x00400000:0x0062AFFF]



This is my linux kernel I believe, but I cannot find any documentation I
what to do.  I think I need to modify my system_bd.bmm file:



///////////////////////////////////////////////////////////////////////////////
//
// Processor 'ppc405_0', ID 100, memory map.
//
///////////////////////////////////////////////////////////////////////////////

ADDRESS_MAP ppc405_0 PPC405 100



///////////////////////////////////////////////////////////////////////////////
    //
    // Processor 'ppc405_0' address space
'plb_bram_if_cntlr_1_bram_combined' 0xFFFFC000:0xFFFFFFFF (16 KB).
    //

///////////////////////////////////////////////////////////////////////////////

    ADDRESS_SPACE plb_bram_if_cntlr_1_bram_combined RAMB16
[0xFFFFC000:0xFFFFFFFF]
        BUS_BLOCK
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_0
[63:56] PLACED = X1Y9;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_1
[55:48] PLACED = X2Y10;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_2
[47:40] PLACED = X1Y10;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_3
[39:32] PLACED = X2Y9;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_4
[31:24] PLACED = X2Y13;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_5
[23:16] PLACED = X2Y8;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_6
[15:8] PLACED = X2Y12;
            plb_bram_if_cntlr_1_bram/plb_bram_if_cntlr_1_bram/ramb16_7
[7:0] PLACED = X2Y11;
        END_BUS_BLOCK;
    END_ADDRESS_SPACE;

END_ADDRESS_MAP;

Thanks for any help you can offer.

Glenn
