Return-Path: <Bruce_Leonard@selinc.com>
Received: from valiant.selinc.com (valiant.selinc.com [74.117.214.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qphl41nv1zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 07:54:54 +1000 (AEST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
 by valiant.selinc.com (8.16.0.11/8.16.0.11) with ESMTP id u3ILsqVB011083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:54:52 -0700
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Trouble with DMA on PPC linux question
Message-ID: <OFDB971D2B.A484FAC0-ON88257F99.0075C134-88257F99.00786154@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 18 Apr 2016 14:54:51 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Good afternoon everyone,

We're trying to get some performance gains in an older embedded design by 
adding DMA to our NAND driver.  The HW is an MPC8349 talking across a PCI 
bus to a NAND controller and we have 512Mb of RAM.  We're using the 3.18 
kernel and the Freescale "fsl,mpc8349-dma" driver.  I've verified using a 
bus analyzer that DMA transactions are occurring on the PCI bus correctly 
(correct addresses and the data I'm reading is coming across the bus to 
the processor correctly).  What's not happening is periodically the data 
being read doesn't make it to RAM.  I've narrowed this down to the 
dma_addr_t I get back from dma_map_single().

Now I'm not an expert on how memory management in the PPC linux kernel 
works, but based on some experimentation and stepping through some of the 
code, translating a kernel virtual address is essentially subtracting 
0xC0000000 from the virtual address.  I know the equations a bit more than 
that, I've dug into some of the macros, but many of the constants compile 
to zero on my setup, so the end result is just the subtraction.

On the DMA transactions that work, the virtual address I hand to 
dma_map_single() is something like 0xe0840000 and the dma_addr_t result is 
0x10840000 which is less than my 512Mb limit.  On the transactions that 
don't work, the virtual address is 0xd5390000 with the mapped result being 
0x25390000, which is past my upper bound on my RAM.  In fact it's not even 
in my memory map, there's a hole there.  (Evidently the MPC4349 DMA engine 
bypasses the TLBs, since I'm not getting an exception of any 
kind...learned something new today!)  So on the transactions that don't 
work, they fail because the physical address I give to the DMA engine 
doesn't exist.  The only error indication I get is when I get an ECC error 
because what's pointed to be the virtual address (where ever that may be) 
still contains zeros and it fails the ECC comparison check.

So my question is, where should I be looking or what config option should 
I be checking to try and figure out why the upper layers 
(MTD/UBI/UBIFS/user space) should be giving the NAND layer or my driver a 
virtual address that can't be translated into a physical address?  One 
thing I have noticed (though I don't know if it's relevant or not) is that 
when I get a "good" virtual address it's through a call to 
nand_subpage_read() and when I get a "bad" virtual address it's through a 
call to nand_read_page_swecc().

I'm not asking if someone can solve my problem for me, but any suggestions 
of what rocks I can turn over to look for clues would be greatly 
appreciated.

Thanks for you time and suggestions!

Bruce
